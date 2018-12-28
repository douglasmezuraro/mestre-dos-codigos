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
  Vcl.Forms;

type
  TCrud = class(TForm)
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
    function ValidateRequiredComponents(out Control: TWinControl): Boolean;
  protected
    { Crud actions }
    procedure Insert; virtual;
    procedure Edit; virtual;
    procedure Remove; virtual;
    { Form initialization and finalization }
    procedure Initialize;
    procedure Finalize;
    { Required components }
    procedure DefineRequiredComponents(Components: TArray<TWinControl>); overload;
    procedure DefineRequiredComponents; overload; virtual; abstract;
    { Other useful methods }
    procedure Clear; virtual; abstract;
    procedure ControlActions; virtual; abstract;
    function GetInitialFocus: TWinControl; virtual;
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
var
  Control: TWinControl;
  Caption: string;
begin
  if ValidateRequiredComponents(Control) then
  begin
    Insert;
    ControlActions;
    Exit;
  end;

  Caption := FRequiredComponents.Items[Control].Caption;
  Caption := Caption.Replace(RequiredChar, string.Empty).QuotedString;
  TMessage.Information('O campo %s é obrigatório.', [Caption]);
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
    begin
      TMessage.Error('O componente obrigatório %s não possui label relacionado.', [Control.Name]);
      Continue;
    end;

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
  Index: Cardinal;
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
  StatusBarStatus.SimpleText := Format('%s: campos obrigatórios.', [RequiredChar]);
end;

procedure TCrud.Insert;
begin
  TMessage.Information('Inserido com sucesso!');
end;

procedure TCrud.Remove;
begin
  Clear;
end;

function TCrud.ValidateRequiredComponents(out Control: TWinControl): Boolean;
var
  Component: TWinControl;
begin
  Result := True;
  for Component in FRequiredComponents.Keys do
  begin
    if Component is TCustomEdit then
      Result := not (Component as TCustomEdit).IsEmpty
    else if Component is TDateTimePicker then
      Result := not (Component as TDateTimePicker).IsEmpty;

    if not Result then
    begin
      Control := Component;
      Break;
    end;
  end;
end;

end.

