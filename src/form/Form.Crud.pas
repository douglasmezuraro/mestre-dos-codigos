unit Form.Crud;

interface

uses
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
  Vcl.Helpers,
  Vcl.StdCtrls, Vcl.Grids;

type
  TGridState = (gsNone, gsBrowse, gsInsert, gsEdit, gsRemove);

  TCrud = class abstract(TForm)
    ActionList: TActionList;
    ActionClear: TAction;
    ActionEdit: TAction;
    ActionInsert: TAction;
    ActionRemove: TAction;
    ButtonClear: TSpeedButton;
    ButtonEdit: TSpeedButton;
    ButtonInsert: TSpeedButton;
    ButtonRemove: TSpeedButton;
    PanelButtons: TPanel;
    StatusBarStatus: TStatusBar;
    PageControlLayout: TPageControl;
    TabSheetList: TTabSheet;
    Grid: TStringGrid;
    TabSheetData: TTabSheet;
    ButtonNew: TSpeedButton;
    ActionNew: TAction;
    procedure ActionClearExecute(Sender: TObject);
    procedure ActionEditExecute(Sender: TObject);
    procedure ActionInsertExecute(Sender: TObject);
    procedure ActionRemoveExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ActionNewExecute(Sender: TObject);
    procedure GridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GridDblClick(Sender: TObject);
  private
    FRequiredControls: TDictionary<TWinControl, string>;
    FState: TGridState;

    { Define Methods }
    procedure DefineRequiredControls;

    { Other }
    function Validate(out Control: TWinControl): Boolean;
    function GetCaption(Control: TWinControl): string;
    function GetLinkedLabel(Control: TWinControl): TCustomLabel;
  protected
    FPrevRow: Byte;
    FModel: TObject;

    { Main actions }
    function Insert: Boolean; virtual;
    procedure Edit;
    procedure Remove; virtual;

    { Form initialization and finalization }
    procedure Initialize; virtual;
    procedure Finalize; virtual;

    {}
    procedure ViewToModel; virtual; abstract;
    procedure ModelToView; virtual; abstract;
    function ModelToArray: TArray<string>; virtual; abstract;

    { Required components }
    function GetRequiredControls: TArray<TWinControl>; virtual; abstract;
    function GetInitialFocus: TWinControl; virtual; abstract;

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
  ActionNew.Enabled := FState <> TGridState.gsInsert;
  ActionInsert.Enabled := FState = TGridState.gsInsert;
  ActionEdit.Enabled := (FState <> TGridState.gsInsert) and (FPrevRow <> Grid.HeaderIndex);
  ActionRemove.Enabled := (FState <> TGridState.gsInsert) and (FPrevRow <> Grid.HeaderIndex);

  TabSheetData.Enabled := FState in [gsEdit, gsInsert];
end;

constructor TCrud.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FRequiredControls := TDictionary<TWinControl, string>.Create;
  FPrevRow := Grid.Row;
  FState := TGridState.gsNone;
  TabSheetData.Enabled := False;
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

procedure TCrud.ActionEditExecute(Sender: TObject);
begin
  Edit;
end;

procedure TCrud.ActionInsertExecute(Sender: TObject);
begin
  Insert;
end;

procedure TCrud.ActionNewExecute(Sender: TObject);
begin
  FState := TGridState.gsInsert;
  ControlActions;
  PageControlLayout.ActivePage := TabSheetData;
end;

procedure TCrud.ActionRemoveExecute(Sender: TObject);
begin
  Remove;
end;

procedure TCrud.DefineRequiredControls;
var
  Control: TWinControl;
begin
  for Control in GetRequiredControls do
  begin
    Control.Required := True;
    FRequiredControls.Add(Control, GetCaption(Control));
  end;
end;

procedure TCrud.Edit;
begin
  ViewToModel;
  Grid.Update(ModelToArray);
end;

procedure TCrud.Finalize;
begin
  Exit;
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

procedure TCrud.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Finalize;
end;

procedure TCrud.FormShow(Sender: TObject);
begin
  Initialize;
end;

procedure TCrud.Initialize;
begin
  DefineRequiredControls;
  ControlActions;
  StatusBarStatus.SimpleText := Format('%s: campos obrigat�rios.', [RequiredChar]);
  GetInitialFocus.TrySetFocus;
end;

function TCrud.Insert: Boolean;
var
  Control: TWinControl;
begin
  Result := Validate(Control);
  try
    if not Result then
    begin
      Control.TrySetFocus;
      TMessage.Information('O campo %s � obrigat�rio.', [FRequiredControls.Items[Control]]);
      Exit;
    end;

    FModel := CreateModel;
    ViewToModel;
    Grid.Add(ModelToArray);

    FState := gsBrowse;
    TMessage.Information('Inserido com sucesso!');
    Clear;
  finally
    ControlActions;
  end;
end;

procedure TCrud.Remove;
begin
  Grid.Remove;
  Clear;
  ControlActions
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

