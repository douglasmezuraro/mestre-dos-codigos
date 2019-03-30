unit Form.Crud;

interface

uses
  Collections.API,
  Collections.DynamicArray,
  Helper.DateTime,
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
  Vcl.Helpers,
  Vcl.StdCtrls;

type
  TState = (sBrowse, sInsert, sUpdate);

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
    procedure GridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GridDblClick(Sender: TObject);
    procedure ActionSaveExecute(Sender: TObject);
  private
    FRequiredControls: TDictionary<TWinControl, string>;
    FState: TState;
    { Define Methods }
    procedure SetRequiredControls;

    { Other }
    function Validate(out Control: TWinControl): Boolean;
    function GetCaption(Control: TWinControl): string;
    function GetLinkedLabel(Control: TWinControl): TCustomLabel;
  protected
    FPrevRow: Byte;
    FModel: TObject;
    FArray: ICollection<TObject>;

    { Main actions }
    procedure New;
    procedure Remove; virtual;
    function Save: Boolean; virtual;

    { Form initialization and finalization }
    procedure Initialize; virtual;

    {}
    procedure ViewToModel; virtual; abstract;
    procedure ModelToView; virtual; abstract;
    function ModelToArray: TArray<string>; virtual; abstract;

    { Required components }
    function DefineRequiredControls: TArray<TWinControl>; virtual; abstract;
    function DefineInitialFocus: TWinControl; virtual; abstract;

    { Other useful methods }
    procedure ControlActions;
    procedure RegExValidate(Component: TObject; const Pattern: string);

    {}
    function CreateModel: TObject; virtual; abstract;
    function GetModel: TObject; overload; virtual;
    function GetModel(const Row: Integer): TObject; overload; virtual; abstract;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}

{ TCrud }

procedure TCrud.ControlActions;
begin
  ActionNew.Enabled := FState <> sInsert;
  ActionSave.Enabled := FState in [sInsert, sUpdate];
  ActionRemove.Enabled := (FState <> sInsert) and (FPrevRow <> Grid.HeaderIndex);
  TabSheetData.Enabled := FState in [sInsert, sUpdate];
end;

constructor TCrud.Create(Owner: TComponent);
begin
  inherited Create(Owner);

  FArray            := TDynamicArray<TObject>.Create;
  FRequiredControls := TDictionary<TWinControl, string>.Create;
  FPrevRow          := Grid.Row;
  FState            := sBrowse;
end;

destructor TCrud.Destroy;
begin
  FRequiredControls.Free;
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

procedure TCrud.ActionRemoveExecute(Sender: TObject);
begin
  Remove;
end;

procedure TCrud.ActionSaveExecute(Sender: TObject);
begin
  Save;
end;

procedure TCrud.SetRequiredControls;
var
  Control: TWinControl;
begin
  for Control in DefineRequiredControls do
  begin
    Control.Required := True;
    FRequiredControls.Add(Control, GetCaption(Control));
  end;
end;

function TCrud.GetCaption(Control: TWinControl): string;
var
  LinkedLabel: TCustomLabel;
  Index: Integer;
begin
  if Control is TRadioGroup then
  begin
    Result := (Control as TRadioGroup).Caption;
    TRadioGroup(Control).Caption := Result + RequiredChar;
    Exit;
  end;

  if TArray.BinarySearch<TClass>([TEdit, TLabeledEdit, TDateTimePicker], Control.ClassType, Index) then
  begin
    LinkedLabel := GetLinkedLabel(Control);

    if not Assigned(LinkedLabel) then
      raise Exception.CreateFmt('N�o foi encontrado label v�nculado ao componente "%s"', [Control]);

    Result := LinkedLabel.Caption;
    LinkedLabel.Caption := Result + RequiredChar;
  end;
end;

function TCrud.GetLinkedLabel(Control: TWinControl): TCustomLabel;
var
  Component: TComponent;
begin
  Result := nil;
  for Component in ComponentsArray do
  begin
    if (Component is TLabel) and (Control = (Component as TLabel).FocusControl) then
    begin
      Result := Component as TLabel;
      Break;
    end;
  end;
end;

function TCrud.GetModel: TObject;
begin
  Result := FModel;
end;

procedure TCrud.GridDblClick(Sender: TObject);
begin
  PageControlLayout.ActivePage := TabSheetData;

  if GetModel(Grid.Row) = nil then
    Exit;

  FState := sUpdate;
  ControlActions;
end;

procedure TCrud.GridSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if ARow = FPrevRow then
    Exit;

  (Sender as TStringGrid).OnSelectCell := nil;
  try
    FModel := GetModel(ARow);
    ModelToView;
    FPrevRow := ARow;
    ControlActions;
  finally
    (Sender as TStringGrid).OnSelectCell := GridSelectCell;
  end;
end;

procedure TCrud.FormShow(Sender: TObject);
begin
  Initialize;
end;

procedure TCrud.Initialize;
begin
  SetRequiredControls;
  ControlActions;
  StatusBarStatus.SimpleText := Format('%s: campos obrigat�rios.', [RequiredChar]);
  DefineInitialFocus.TrySetFocus;
end;

procedure TCrud.New;
begin
  FModel := CreateModel;
  FState := sInsert;
  PageControlLayout.ActivePage := TabSheetData;

  ControlActions;
end;

procedure TCrud.Remove;
begin
  if FArray.Remove(GetModel(Grid.Row)) then
  begin
    Grid.Remove;
    Clear;
    ControlActions
  end;
end;

function TCrud.Save: Boolean;
var
  Control: TWinControl;
begin
  Result := Validate(Control);

  if not Result then
  begin
    Control.TrySetFocus;
    TMessage.Information('O campo %s � obrigat�rio.', [FRequiredControls.Items[Control]]);
    Exit;
  end;

  ViewToModel;

  case FState of
    sInsert:
      begin
        Grid.Add(ModelToArray);
        FArray.Add(GetModel);
      end;
    sUpdate:
      begin
        Grid.Update(ModelToArray);
      end;
  end;

  FState := sBrowse;
  ControlActions;

  TMessage.Information('Salvo com sucesso!');
  Clear;
end;

procedure TCrud.RegExValidate(Component: TObject; const Pattern: string);
var
  Control: TWinControl;
  RegEx: TRegEx;
  Caption: string;
begin
  Control := Component as TWinControl;

  if Control.IsEmpty then
    Exit;

  RegEx := TRegEx.Create(Pattern, [roIgnoreCase]);
  if not RegEx.IsMatch(Control.ToString) then
  begin
    Caption := FRequiredControls.Items[Component as TWinControl];
    TMessage.Information('O valor "%s" n�o � v�lido para "%s".', [Control.ToString.ToLower, Caption]);
    Control.TrySetFocus;
  end;
end;

function TCrud.Validate(out Control: TWinControl): Boolean;
var
  Component: TWinControl;
begin
  for Component in FRequiredControls.Keys do
  begin
    if Component.IsEmpty then
    begin
      Control := Component;
      Exit(False);
    end;
  end;
  Result := True;
end;

end.

