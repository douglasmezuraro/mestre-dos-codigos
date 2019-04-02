unit Form.Crud;

interface

uses
  Collections.API,
  Collections.DynamicArray,
  Helper.Vcl,
  System.Actions,
  System.Classes,
  System.Generics.Collections,
  System.RegularExpressions,
  System.SysUtils,
  Util.Messages,
  Vcl.ActnList,
  Vcl.Buttons,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Grids,
  Vcl.StdCtrls;

type
  TGridState = (gsBrowse, gsInsert, gsEdit);

  TCrud = class abstract(TForm)
    ActionList: TActionList;
    ActionClear: TAction;
    ActionRemove: TAction;
    ButtonClear: TSpeedButton;
    ButtonSave: TSpeedButton;
    ButtonRemove: TSpeedButton;
    PanelButtons: TPanel;
    StatusBarStatus: TStatusBar;
    PageControlLayout: TPageControl;
    TabSheetList: TTabSheet;
    Grid: TStringGrid;
    TabSheetData: TTabSheet;
    ButtonNew: TSpeedButton;
    ActionNew: TAction;
    ActionSave: TAction;
    procedure ActionClearExecute(Sender: TObject);
    procedure ActionRemoveExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActionNewExecute(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure ActionSaveExecute(Sender: TObject);
  private
    FRequired: TDictionary<TWinControl, string>;
    FState: TGridState;
    FModel: TObject;
    FArray: ICollection<TObject>;

    { Define Methods }
    procedure SetRequiredControls;

    { Other }
    function Validate(out Control: TWinControl): Boolean;
    function GetCaption(Control: TWinControl): string;
    procedure SetCaption(Control: TWinControl);
    function GetLinkedLabel(Control: TWinControl): TCustomLabel;
  protected
    { Main actions }
    procedure New;
    procedure Remove;
    procedure Save;
    procedure Edit;

    { Form initialization and finalization }
    procedure Initialize; virtual;

    { Abstract useful methods }
    procedure ViewToModel; virtual; abstract;
    procedure ModelToView; virtual; abstract;
    function ModelToArray: TArray<string>; virtual; abstract;

    { Required components }
    function DefineRequiredControls: TArray<TWinControl>; virtual; abstract;

    { Other useful methods }
    procedure ControlView(const State: TGridState; const Tab: TTabSheet);
    procedure RegExValidate(Component: TObject; const Pattern: string);

    { Model methods }
    function CreateModel: TObject; virtual; abstract;
    function GetModel: TObject; virtual;
    function GetCurrentModel(const Row: Integer): TObject;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}

{ TCrud }

constructor TCrud.Create(Owner: TComponent);
begin
  inherited Create(Owner);

  FArray    := TDynamicArray<TObject>.Create;
  FRequired := TDictionary<TWinControl, string>.Create;
  FState    := gsBrowse;
end;

destructor TCrud.Destroy;
begin
  FRequired.Free;

  if FState = gsInsert then
    FModel.Free;

  inherited Destroy;
end;

procedure TCrud.ActionClearExecute(Sender: TObject);
begin
  Self.Clear;
end;

procedure TCrud.ActionNewExecute(Sender: TObject);
begin
  New;
end;

procedure TCrud.New;
begin
  if FState = gsEdit then
  begin
    if not TMessage.Confirmation('Deseja cancelar a edição do registro?') then
      Exit;
  end;

  FModel := CreateModel;
  Clear;
  ControlView(gsInsert, TabSheetData);
end;

procedure TCrud.ActionRemoveExecute(Sender: TObject);
begin
  Remove;
end;

procedure TCrud.Remove;
begin
  if FArray.Remove(GetCurrentModel(Grid.Row)) then
  begin
    Grid.Remove;
    Clear;
    ControlView(gsBrowse, TabSheetList);
  end;
end;

procedure TCrud.ActionSaveExecute(Sender: TObject);
begin
  Save;
end;

procedure TCrud.Save;
var
  Control: TWinControl;
begin
  if not Validate(Control) then
  begin
    Control.TrySetFocus;
    TMessage.Information('O campo %s é obrigatório.', [FRequired.Items[Control]]);
    Exit;
  end;

  ViewToModel;

  case FState of
    gsInsert:
      begin
        Grid.Add(ModelToArray);
        FArray.Add(GetModel);
      end;
    gsEdit:
      begin
        Grid.Update(ModelToArray);
      end;
  end;

  ControlView(gsBrowse, TabSheetList);

  TMessage.Information('Salvo com sucesso!');
  Clear;
end;

procedure TCrud.ControlView(const State: TGridState; const Tab: TTabSheet);
begin
  FState := State;
  PageControlLayout.ActivePage := Tab;

  ActionNew.Enabled    := FState <> gsInsert;
  ActionSave.Enabled   := FState in [gsInsert, gsEdit];
  ActionRemove.Enabled := (FState <> gsInsert) and Assigned(FModel);

  TabSheetData.Enabled := FState in [gsInsert, gsEdit];
end;

function TCrud.GetCaption(Control: TWinControl): string;
var
  Index: Integer;
begin
  if Control is TRadioGroup then
  begin
    Exit((Control as TRadioGroup).Caption);
  end;

  if TArray.BinarySearch<TClass>([TEdit, TLabeledEdit, TDateTimePicker], Control.ClassType, Index) then
  begin
    Exit(GetLinkedLabel(Control).Caption);
  end;
end;

function TCrud.GetLinkedLabel(Control: TWinControl): TCustomLabel;
var
  Component: TComponent;
begin
  for Component in ComponentsArray do
  begin
    if (Component is TLabel) and (Control = (Component as TLabel).FocusControl) then
    begin
      Exit(Component as TCustomLabel);
    end;
  end;

  raise Exception.CreateFmt('Não foi encontrado label vínculado ao componente "%s"', [Control]);
end;

function TCrud.GetCurrentModel(const Row: Integer): TObject;
begin
  Result := FArray.Item[Pred(Row)];
end;

function TCrud.GetModel: TObject;
begin
  Result := FModel;
end;

procedure TCrud.GridDblClick(Sender: TObject);
begin
  Edit;
end;

procedure TCrud.FormShow(Sender: TObject);
begin
  Initialize;
end;

procedure TCrud.Initialize;
begin
  SetRequiredControls;
  ControlView(gsBrowse, TabSheetList);
  StatusBarStatus.SimpleText := Format('%s: campos obrigatórios.', [RequiredChar]);
end;

procedure TCrud.SetCaption(Control: TWinControl);
var
  Index: Integer;
  LinkedLabel: TCustomLabel;
begin
  if Control is TRadioGroup then
  begin
    (Control as TRadioGroup).Caption := (Control as TRadioGroup).Caption + RequiredChar;
    Exit;
  end;

  if TArray.BinarySearch<TClass>([TEdit, TLabeledEdit, TDateTimePicker], Control.ClassType, Index) then
  begin
    LinkedLabel := GetLinkedLabel(Control);
    LinkedLabel.Caption := LinkedLabel.Caption + RequiredChar;
  end;
end;

procedure TCrud.SetRequiredControls;
var
  Control: TWinControl;
begin
  for Control in DefineRequiredControls do
  begin
    Control.Required := True;
    FRequired.Add(Control, GetCaption(Control));
    SetCaption(Control);
  end;
end;

procedure TCrud.Edit;
begin
  if FState = gsInsert then
  begin
    if not TMessage.Confirmation('Deseja cancelar a inserção do registro?') then
      Exit;
    FModel.Free;
  end;

  FModel := GetCurrentModel(Grid.Row);

  if not Assigned(FModel) then
    Exit;

  ModelToView;

  ControlView(gsEdit, TabSheetData);
end;

procedure TCrud.RegExValidate(Component: TObject; const Pattern: string);
var
  Edit: TCustomEdit;
  RegEx: TRegEx;
  Caption: string;
begin
  if not (Component is TCustomEdit) then
    Exit;
  
  Edit := Component as TCustomEdit;

  if Edit.IsEmpty then
    Exit;

  RegEx := TRegEx.Create(Pattern, [roIgnoreCase]);
  if not RegEx.IsMatch(Edit.Text) then
  begin
    Caption := FRequired.Items[Component as TWinControl];
    TMessage.Information('O valor "%s" não é válido para "%s".', [Edit.Text, Caption]);
    Edit.TrySetFocus;
  end;
end;

function TCrud.Validate(out Control: TWinControl): Boolean;
var
  Component: TWinControl;
begin
  Result := True;
  for Component in FRequired.Keys do
  begin
    if Component.IsEmpty then
    begin
      Control := Component;
      Exit(False);
    end;
  end;
end;

end.

