unit Form.Crud;

interface

uses
  Helper.DateTime,
  Vcl.Helpers,
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
    ButtonClear: TSpeedButton;
    ActionClear: TAction;
    procedure ActionInsertExecute(Sender: TObject);
    procedure ActionEditExecute(Sender: TObject);
    procedure ActionRemoveExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActionClearExecute(Sender: TObject);
  private
    FRequiredComponents: TDictionary<TWinControl, string>;

    { Define Methods }
    procedure DefineInitialFocus;
    procedure DefineRequiredComponents;

    { Other }
    function Validate(out Control: TWinControl): Boolean;
    function GetCaption(Control: TWinControl): string;
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
    function GetRequiredComponents: TArray<TWinControl>; virtual;
    function GetInitialFocus: TWinControl; virtual;

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
      (Component as TCustomEdit).Text := string.Empty;
      Continue;
    end;

    if Component is TDateTimePicker then
    begin
      (Component as TDateTimePicker).DateTime := TDateTime.Null;
      Continue;
    end;

    if Component is TRadioGroup then
    begin
      (Component as TRadioGroup).ItemIndex := OutOfBoundIndex;
      Continue;
    end;
  end;
end;

constructor TCrud.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FRequiredComponents := TDictionary<TWinControl, string>.Create;
end;

destructor TCrud.Destroy;
begin
  FRequiredComponents.Free;
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
  ControlActions;
end;

procedure TCrud.DefineRequiredComponents;
var
  Control: TWinControl;
  Caption: string;
begin
  for Control in GetRequiredComponents do
  begin
    Caption := GetCaption(Control);
    Control.Required := True;
    FRequiredComponents.Add(Control, Caption);
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

  function GetLinkedLabel: TCustomLabel;
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
        Exit(Component as TLabel);
      end;

      if (Component is TLabeledEdit) and (Control = Component) then
      begin
        Exit((Component as TLabeledEdit).EditLabel);
      end;


    end;
  end;

var
  LinkedLabel: TCustomLabel;
  Index: Integer;
begin
  if Control is TRadioGroup then
  begin
    Result := (Control as TRadioGroup).Caption;
    (Control as TRadioGroup).Caption := Result + RequiredChar;
  end;

  if TArray.BinarySearch<TClass>([TLabeledEdit, TDateTimePicker], Control.ClassType, Index) then
  begin
    LinkedLabel := GetLinkedLabel;
    if not Assigned(LinkedLabel) then
      raise Exception.Create('Error Message');
    Result := LinkedLabel.Caption;
    LinkedLabel.Caption := Result + RequiredChar;
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

function TCrud.GetInitialFocus: TWinControl;
begin
  Result := nil;
end;

function TCrud.GetRequiredComponents: TArray<TWinControl>;
begin
  Result := [];
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

function TCrud.Insert: Boolean;
var
  Control: TWinControl;
begin
  Result := Validate(Control);
  if not Result then
  begin
    TMessage.Information('O campo %s é obrigatório.', [FRequiredComponents.Items[Control]]);
    Control.TrySetFocus;
  end;
end;

procedure TCrud.Remove;
begin
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
    Caption := FRequiredComponents.Items[Component as TWinControl];
    TMessage.Information('O valor "%s" não é válido para %s.', [Control.ToString, Caption]);
    Control.TrySetFocus;
  end;
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

    if Component is TRadioGroup then
      Result := (Component as TRadioGroup).ItemIndex > OutOfBoundIndex;

    if not Result then
    begin
      Control := Component;
      Break;
    end;
  end;
end;

end.

