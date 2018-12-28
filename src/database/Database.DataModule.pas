unit Database.DataModule;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait,
  FireDAC.Phys.MySQLDef,
  FireDAC.Phys.MySQL,
  Data.DB,
  FireDAC.Comp.Client,
  Database.Config,
  System.IOUtils,
  Vcl.Forms,
  REST.Json;

type
  TGlobal = class(TDataModule)
    Connection: TFDConnection;
    DriverLink: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure SetConnected(const Value: Boolean);
    function GetConnected: Boolean;
  public
    property Connected: Boolean read GetConnected write SetConnected;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TGlobal.DataModuleCreate(Sender: TObject);
begin
  var Path := ExtractFilePath(Application.ExeName) + 'Config.json';
  var Json := TFile.ReadAllText(Path);
  var Config := TJson.JsonToObject<TConfig>(Json);
  try
    Connection.Params.AddPair('DriverId', Config.DriverID);
    Connection.Params.AddPair('Database', Config.Database);
    Connection.Params.AddPair('User_Name', Config.UserName);
    Connection.Params.AddPair('Password', Config.Password);
    Connection.Params.AddPair('Server', Config.Server);
    Connection.Params.AddPair('Port', Config.Port.ToString);

    DriverLink.VendorLib := Config.VendorLib;
  finally
    Config.Free;
  end;

  Connected := True;
end;

function TGlobal.GetConnected: Boolean;
begin
  Result := Connection.Connected;
end;

procedure TGlobal.SetConnected(const Value: Boolean);
begin
  Connection.Connected := Value;
end;

end.

