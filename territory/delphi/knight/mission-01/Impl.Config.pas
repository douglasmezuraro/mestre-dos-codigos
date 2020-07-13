unit Impl.Config;

interface

uses
  Impl.Config.API, System.IniFiles, System.IOUtils, System.SysUtils;

type
  TConfig = class(TInterfacedObject, IServer, IDatabase)
  private
    FIniFile: TIniFile;
    procedure IServer.SaveData = SaveDataServer;
    procedure IDatabase.SaveData = SaveDataDatabase;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SaveDataServer;
    procedure SaveDataDatabase;
    class function FilePath: TFileName;
  end;

implementation

constructor TConfig.Create;
begin
  FIniFile := TIniFile.Create(FilePath);
end;

destructor TConfig.Destroy;
begin
  FIniFile.Free;
  inherited;
end;

class function TConfig.FilePath: TFileName;
begin
  Result := TPath.Combine(TPath.GetDirectoryName(ParamStr(0)), 'Config.ini');
end;

procedure TConfig.SaveDataDatabase;
begin
  FIniFile.WriteString('Server', 'GUIDServidor', '{42A9E80A-670D-459D-B20E-E41F9B3AD880}');
  FIniFile.WriteString('Server', 'NomeServidor', 'fpgServidor.fpgServidorDM');
  FIniFile.WriteString('Server', 'TipoConexao', 'Socket');
  FIniFile.WriteString('Server', 'Porta', '211');
  FIniFile.WriteString('Server', 'NomeExecutavelServidor', '');
  FIniFile.WriteString('Server', 'NomeComputador', 'localhost');
  FIniFile.WriteString('Server', 'enderecoIP', '127.0.0.1');
  FIniFile.WriteString('Server', 'PodeBalancear', 'N');
  FIniFile.WriteString('Server', 'TimeoutRequisicaoCliente', 'N');
  FIniFile.WriteString('Server', 'HabilitaGerenciadorIntegracao', 'S');
end;

procedure TConfig.SaveDataServer;
begin
  FIniFile.WriteString('Database', 'Esquema', 'SAJ');
  FIniFile.WriteString('Database', 'NumeroLinhasFetch', '100');
  FIniFile.WriteString('Database', 'NumeroMaximoConexoes', '5');
  FIniFile.WriteString('Database', 'NumeroMinimoConexoes', '2');
  FIniFile.WriteString('Database', 'TempoDesconexaoConexaoInativa', '500');
  FIniFile.WriteString('Database', 'TempoAtualizacaoLogConexoes', '1');
  FIniFile.WriteString('Database', 'NumeroLinhasFetch', '10000');
  FIniFile.WriteString('Database', 'TipoAcessoBD', 'FireDAC');
  FIniFile.WriteString('Database', 'TipoAcesso', 'FIREDAC');
  FIniFile.WriteString('Database', 'TipoBanco', 'SQLServer');
  FIniFile.WriteString('Database', 'Alias', 'PG5TINT');
  FIniFile.WriteString('Database', 'Server', '172.21.8.8\ISAJ01');
end;

end.

