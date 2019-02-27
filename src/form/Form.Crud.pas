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
    procedure ActionClearExecute(Sender: TObject);
    procedure ActionEditExecute(Sender: TObject);
    procedure ActionInsertExecute(Sender: TObject);
    procedure ActionRemoveExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    FRequiredControls: TDictionary<TWinControl, string>;

    { Define Methods }
    procedure DefineRequiredControls;

    { Other }
    function Validate(out Control: TWinControl): Boolean;
    function GetCaption(Control: TWinControl): string;
    function GetLinkedLabel(Control: TWinControl): TCustomLabel;
  protected
    { Main actions }
    function Insert: Boolean; virtual;
    procedure Edit; virtual;
    procedure Remove; virtual;
    procedure Clear; virtual;

    { Form initialization and finalization }
    procedure Initialize; virtual;
    procedure Finalize; virtual;

    { Required components }
    function GetRequiredControls: TArray<TWinControl>; virtual; abstract;
    function GetInitialFocus: TWinControl; virtual; abstract;

    { Other useful methods }
    procedure ControlActions; virtual; abstract;
    procedure RegExValidate(Component: TObject; const Pattern: string);
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}

{ TCrud }

procedure TCrud.Clear;
var
  Index: Integer;
  Component: TComponent;
begin
  for Index := 0 to Pred(ComponentCount) do
  begin
    Component := Components[Index];

    if Component is TCustomEdit then
    begin
      (Component as TCustomEdit).Clear;
      Continue;
    end;

    if Component is TDateTimePicker then
    begin
      (Component as TDateTimePicker).DateTime := TDateTime.Null;
      Continue;
    end;

    if Component is TRadioGroup then
    begin
      (Component as TRadioGroup).ItemIndex := TRadioGroup.OutOfBoundIndex;
      Continue;
    end;
  end;
end;

constructor TCrud.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FRequiredControls := TDictionary<TWinControl, string>.Create;
end;

destructor TCrud.Destroy;
begin
  FRequiredControls.Free;
  inherited Destroy;
end;

procedure TCrud.ActionClearExecute(Sender: TObject);
begin
  Clear;
end;

procedure TCrud.ActionEditExecute(Sender: TObject);
begin
  Edit;
end;

procedure TCrud.ActionInsertExecute(Sender: TObject);
begin
  if Insert then
  begin
    TMessage.Information('Inserido com sucesso!');
    ControlActions;
  end;
end;

procedure TCrud.ActionRemoveExecute(Sender: TObject);
begin
  Remove;
end;

procedure TCrud.DefineRequiredControls;
var
  Control: TWinControl;
  Caption: string;
begin
  for Control in GetRequiredControls do
  begin
    Caption := GetCaption(Control);
    Control.Required := True;
    FRequiredControls.Add(Control, Caption);
  end;
end;

procedure TCrud.Edit;
begin
  Exit;
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
    (Control as TRadioGroup).Caption := Result + RequiredChar;
  end;

  if TArray.BinarySearch<TClass>([TEdit, TLabeledEdit, TDateTimePicker], Control.ClassType, Index) then
  begin
    LinkedLabel := GetLinkedLabel(Control);

    if not Assigned(LinkedLabel) then
      raise Exception.CreateFmt('Não foi encontrado label vínculado ao componente "%s"', [Control]);

    Result := LinkedLabel.Caption;
    LinkedLabel.Caption := Result + RequiredChar;
  end;
end;

function TCrud.GetLinkedLabel(Control: TWinControl): TCustomLabel;
var
  Index: Integer;
  Component: TComponent;
begin
  Result := nil;
  for Index := 0 to Pred(ComponentCount) do
  begin
    Component := Components[Index];
    if (Component is TLabel) and (Control = (Component as TLabel).FocusControl) then
    begin
      Result := Component as TLabel;
      Break;
    end;
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
  StatusBarStatus.SimpleText := Format('%s: campos obrigatórios.', [RequiredChar]);
  GetInitialFocus.TrySetFocus;
end;

function TCrud.Insert: Boolean;
var
  Control: TWinControl;
begin
  Result := Validate(Control);
  if not Result then
  begin
    TMessage.Information('O campo %s é obrigatório.', [FRequiredControls.Items[Control]]);
    Control.TrySetFocus;
  end;
end;

procedure TCrud.Remove;
begin
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
    TMessage.Information('O valor "%s" não é válido para "%s".', [Control.ToString.ToLower, Caption]);
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
      Break;
    end;
  end;
  Result := True;
end;

end.

