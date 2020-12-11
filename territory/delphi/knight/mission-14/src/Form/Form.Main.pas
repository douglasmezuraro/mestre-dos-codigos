unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.IOUtils, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, Bde.DBTables,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef;

type
  TMain = class sealed(TForm)
    FDConnection: TFDConnection;
  private
    function GetDatabasePath: string;
    function ConnectToDatabase: Boolean;
    function DatabaseExists: Boolean;
    procedure RunInitialMigration(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

constructor TMain.Create(AOwner: TComponent);
begin
  inherited;
  ConnectToDatabase;
end;

function TMain.ConnectToDatabase: Boolean;
begin
  FDConnection.Params.Values['OpenMode'] := 'OpenOrCreate';
  FDConnection.Params.Values['DriverID'] := 'FB';
  FDConnection.Params.Values['User_Name'] := 'SYSDBA';
  FDConnection.Params.Values['Password'] := 'masterkey';
  FDConnection.Params.Values['CharacterSet'] := 'WIN1252';
  FDConnection.Params.Values['Database'] := GetDatabasePath;

  if not DatabaseExists then
  begin
    FDConnection.AfterConnect := RunInitialMigration;
  end;

  FDConnection.Connected := True;
  Result := FDConnection.Connected;
end;

function TMain.DatabaseExists: Boolean;
begin
  Result := TFile.Exists(GetDatabasePath);
end;

function TMain.GetDatabasePath: string;
begin
  Result := TPath.Combine(TPath.GetDirectoryName(Application.ExeName), 'database.fdb');
end;

procedure TMain.RunInitialMigration(Sender: TObject);
begin
  raise ENotImplemented.Create('Run Migration');
end;

end.

