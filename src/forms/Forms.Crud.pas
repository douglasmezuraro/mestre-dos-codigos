unit Forms.Crud;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.StdCtrls,
  Vcl.Dialogs,
  System.Actions,
  Vcl.ActnList,
  Vcl.ExtCtrls,
  Vcl.Buttons,
  Utils.Messages;

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
    procedure ActionInsertExecute(Sender: TObject);
    procedure ActionEditExecute(Sender: TObject);
    procedure ActionRemoveExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    function GetComponentLabel(Component: TComponent): string;
    function ValidateMandatoryFields(out ComponentLabel: string): Boolean;
  protected
    procedure Insert; virtual;
    procedure Edit; virtual;
    procedure Remove; virtual;
    {}
    procedure Initialize;
    procedure Finalize;
    {}
    procedure DefineMandatoryFields; virtual; abstract;
    procedure SetMandatoryFields(const Components: TArray<TComponent>);
  end;

implementation

{$R *.dfm}

uses
  Utils.ComponentHelper;

{ TCrud }

procedure TCrud.ActionEditExecute(Sender: TObject);
begin
  Edit;
end;

procedure TCrud.ActionInsertExecute(Sender: TObject);
const
  MESSAGE: string = 'O campo %s é obrigatório.';
var
  ComponentLabel: string;
begin
  if ValidateMandatoryFields(ComponentLabel) then
    Insert
  else
    TMessage.Information(Format(MESSAGE, [ComponentLabel.QuotedString]));
end;

procedure TCrud.ActionRemoveExecute(Sender: TObject);
begin
  Remove;
end;

procedure TCrud.Edit;
begin

end;

procedure TCrud.Finalize;
begin

end;

procedure TCrud.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Finalize;
end;

procedure TCrud.FormShow(Sender: TObject);
begin
  Initialize;
end;

function TCrud.GetComponentLabel(Component: TComponent): string;
var
  ComponentIndex: Integer;
begin
  Result := Component.Name;
  for ComponentIndex := 0 to Pred(ComponentCount) do
  begin
    if Components[ComponentIndex] is TLabel then
    begin
      if (Components[ComponentIndex] as TLabel).FocusControl = Component then
        Exit((Components[ComponentIndex] as TLabel).Caption)
    end
    else if Components[ComponentIndex] is TLabeledEdit then
    begin
      if Components[ComponentIndex] = Component then
        Exit((Components[ComponentIndex] as TLabeledEdit).EditLabel.Caption);
    end
  end;
end;

procedure TCrud.Initialize;
begin
  DefineMandatoryFields;
end;

procedure TCrud.Insert;
begin

end;

procedure TCrud.Remove;
begin

end;

procedure TCrud.SetMandatoryFields(const Components: TArray<TComponent>);
var
  Component: TComponent;
begin
  for Component in Components do
    Component.Mandatory := True;
end;

function TCrud.ValidateMandatoryFields(out ComponentLabel: string): Boolean;
var
  ComponentIndex: Integer;
  Component: TComponent;
begin
  Result := True;
  ComponentLabel := string.Empty;
  for ComponentIndex := 0 to Pred(ComponentCount) do
  begin
    Component := Components[ComponentIndex];
    if Component is TCustomEdit then
    begin
      if not (Component as TCustomEdit).Mandatory then
        Continue;

      if (Component as TCustomEdit).IsEmpty then
      begin
        ComponentLabel := GetComponentLabel(Component);
        Exit(False);
      end;
    end;
  end;
end;

end.
