unit Form.Crud;

interface

uses
  Helper.WinControl,
  System.Actions,
  System.Classes,
  System.Generics.Collections,
  System.SysUtils,
  Util.Messages,
  Vcl.ActnList,
  Vcl.Buttons,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Forms,
  System.RegularExpressions;

type
  TCrud = class abstract(TForm)
    PanelButtons: TPanel;
    ActionListActions: TActionList;
    ActionInsert: TAction;
    ActionEdit: TAction;
    ActionRemove: TAction;
    ButtonInsert: TSpeedButton;
    ButtonEdit: TSpeedButton;
    ButtonRemove: TSpeedButton;
    StatusBarStatus: TStatusBar;
    procedure ActionInsertExecute(Sender: TObject);
    procedure ActionEditExecute(Sender: TObject);
    procedure ActionRemoveExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FRequiredComponents: TDictionary<TWinControl, TCustomLabel>;
    function GetLabel(Control: TControl): TCustomLabel;
    procedure DefineInitialFocus;
    function Validate(out Control: TWinControl): Boolean; overload;
  protected
    { Crud actions }
    function Insert: Boolean; virtual;
    procedure Edit; virtual;
    procedure Remove; virtual;
    { Form initialization and finalization }
    procedure Initialize; virtual;
    procedure Finalize; virtual;
    { Required components }
    procedure DefineRequiredComponents(Components: TArray<TWinControl>); overload;
    procedure DefineRequiredComponents; overload; virtual; abstract;
    { Other useful methods }
    procedure Clear; virtual; abstract;
    procedure ControlActions; virtual; abstract;
    function GetInitialFocus: TWinControl; virtual;
    procedure Validate(Component: TObject; const Pattern: string); overload;
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
  FRequiredComponents := TDictionary<TWinControl, TCustomLabel>.Create;
end;

destructor TCrud.Destroy;
begin
  FRequiredComponents.Free;
  inherited Destroy;
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
  ControlActions;
end;

procedure TCrud.DefineRequiredComponents(Components: TArray<TWinControl>);
var
  Control: TWinControl;
  CustomLabel: TCustomLabel;
begin
  for Control in Components do
  begin
    Control.Required := True;
    CustomLabel := GetLabel(Control);

    if not Assigned(CustomLabel) then
      raise Exception.CreateFmt('O componente obrigat�rio %s n�o possui label relacionado.', [Control.Name]);

    CustomLabel.Caption := CustomLabel.Caption + RequiredChar;
    FRequiredComponents.Add(Control, CustomLabel);
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

procedure TCrud.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Finalize;
end;

procedure TCrud.FormShow(Sender: TObject);
begin
  Initialize;
end;

function TCrud.GetInitialFocus: TWinControl;
begin
  Result := nil;
end;

function TCrud.GetLabel(Control: TControl): TCustomLabel;
var
  Index: Integer;
  Component: TComponent;
begin
  Result := nil;
  for Index := 0 to Pred(ComponentCount) do
  begin
    Component := Components[Index];

    if Component is TLabel then
    begin
      if Control = (Component as TLabel).FocusControl then
        Exit(Component as TLabel);
    end;

    if Component is TLabeledEdit then
    begin
      if Control = Component then
        Exit((Component as TLabeledEdit).EditLabel);
    end;
  end;
end;

procedure TCrud.DefineInitialFocus;
var
  Component: TWinControl;
begin
  Component := GetInitialFocus;
  if Assigned(Component) then
    Component.TrySetFocus;
end;

procedure TCrud.Initialize;
begin
  DefineRequiredComponents;
  DefineInitialFocus;
  ControlActions;
  StatusBarStatus.SimpleText := Format('%s: campos obrigat�rios.', [RequiredChar]);
end;

function TCrud.Insert: Boolean;
var
  Control: TWinControl;
  Caption: string;
begin
  Result := Validate(Control);

  if Result then
    Exit;

  Caption := FRequiredComponents.Items[Control].Caption;
  Caption := Caption.Replace(RequiredChar, string.Empty).QuotedString;
  TMessage.Information('O campo %s � obrigat�rio.', [Caption]);
  Control.TrySetFocus;
end;

procedure TCrud.Remove;
begin
  Clear;
end;

procedure TCrud.Validate(Component: TObject; const Pattern: string);
var
  Control: TWinControl;
  RegEx: TRegEx;
  Caption: string;
begin
  Control := Component as TWinControl;

  if Control.IsEmpty then
    Exit;

  RegEx := TRegEx.Create(Pattern, [roIgnoreCase]);

  if RegEx.IsMatch(Control.ToString) then
    Exit;

  Caption := GetLabel(Control).Caption;
  Caption := Caption.Replace(RequiredChar, string.Empty).QuotedString;
  TMessage.Information('O valor "%s" n�o � v�lido para %s.', [Control.ToString, Caption]);
  Control.TrySetFocus;
end;

function TCrud.Validate(out Control: TWinControl): Boolean;
var
  Component: TWinControl;
begin
  Result := True;
  for Component in FRequiredComponents.Keys do
  begin
    if Component is TCustomEdit then
      Result := not (Component as TCustomEdit).IsEmpty;

    if Component is TDateTimePicker then
      Result := not (Component as TDateTimePicker).IsEmpty;

    if not Result then
    begin
      Control := Component;
      Break;
    end;
  end;
end;

end.

