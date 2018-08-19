unit Forms.Crud;

interface

uses
  System.Actions,
  System.Classes,
  System.SysUtils,
  Utils.ComponentHelper,
  Utils.Constants,
  Utils.Messages,
  Vcl.ActnList,
  Vcl.Buttons,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls,
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
  protected
    { Crud actions }
    procedure Insert; virtual;
    procedure Edit; virtual;
    procedure Remove; virtual;
    { Form initialization and finalization }
    procedure Initialize;
    procedure Finalize;
    { Mandatory components }
    procedure DefineMandatoryComponents(Components: TArray<TComponent>); overload;
    procedure DefineMandatoryComponents; overload; virtual; abstract;
    { Other useful methods }
    procedure Clear; virtual; abstract;
    procedure SetStatusBarText(const Text: string);
  end;

implementation

{$R *.dfm}

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
  if Self.ValidateMandatoryComponents(ComponentLabel) then
    Insert
  else
    TMessage.Information(Format(MESSAGE, [ComponentLabel.QuotedString]));
end;

procedure TCrud.ActionRemoveExecute(Sender: TObject);
begin
  Remove;
end;

procedure TCrud.DefineMandatoryComponents(Components: TArray<TComponent>);
begin
  SetMandatoryComponents(Components);
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

procedure TCrud.Initialize;
begin
  DefineMandatoryComponents;
  SetStatusBarText(Format('%s campos obrigatórios.', [MANDATORY_CHAR]));
end;

procedure TCrud.Insert;
begin

end;

procedure TCrud.Remove;
begin
  Clear;
end;

procedure TCrud.SetStatusBarText(const Text: string);
begin
  StatusBarStatus.SimpleText := Text;
end;

end.
