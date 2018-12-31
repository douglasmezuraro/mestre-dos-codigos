unit Database.DataModule;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Phys,
  FireDAC.Phys.MySQL,
  FireDAC.Comp.Client,
  Database.Config,
  System.IOUtils,
  Vcl.Forms,
  REST.Json, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB;

type
  TGlobal = class(TDataModule)
    Connection: TFDConnection;
    DriverLink: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure Connect;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TGlobal.Connect;
var
  Path, Json: string;
  Config: TConfig;
begin
  Path := ExtractFilePath(Application.ExeName) + 'Config.json';
  Json := TFile.ReadAllText(Path);
  Config := TJson.JsonToObject<TConfig>(Json);
  try
    Connection.Params.AddPair('DriverId', Config.DriverID);
    Connection.Params.AddPair('Database', Config.Database);
    Connection.Params.AddPair('User_Name', Config.UserName);
    Connection.Params.AddPair('Password', Config.Password);
    Connection.Params.AddPair('Server', Config.Server);
    Connection.Params.AddPair('Port', Config.Port.ToString);

    DriverLink.VendorLib := Config.VendorLib;

    Connection.Connected := True;
  finally
    Config.Free;
  end;
end;

procedure TGlobal.DataModuleCreate(Sender: TObject);
begin
  Connect;
end;

end.

