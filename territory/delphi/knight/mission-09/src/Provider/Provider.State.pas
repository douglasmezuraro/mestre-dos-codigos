unit Provider.State;

interface

uses
  Model.State, System.Generics.Collections, Provider.API;

type
  TStateProvider = class sealed(TInterfacedObject, IProviderAPI)
  strict private
    FDatabase: TDictionary<UInt64, TObject>;
  private
    procedure MockDatabase;
  public
    constructor Create;
    destructor Destroy; override;
    function List: TArray<TObject>;
    function Get(const AId: UInt64): TObject;
  end;

implementation

constructor TStateProvider.Create;
begin
  FDatabase := TDictionary<UInt64, TObject>.Create;
  MockDatabase;
end;

destructor TStateProvider.Destroy;
begin
  FDatabase.Free;
  inherited;
end;

function TStateProvider.Get(const AId: UInt64): TObject;
begin
  Result := FDatabase.Items[AId];
end;

function TStateProvider.List: TArray<TObject>;
begin
  Result := FDatabase.Values.ToArray;
end;

procedure TStateProvider.MockDatabase;
begin
  FDatabase.Add(01, TState.Create('Acre', 'AC', 'RioBranco', 'Norte'));
  FDatabase.Add(02, TState.Create('Alagoas', 'AL', 'Maceió', 'Nordeste'));
  FDatabase.Add(03, TState.Create('Amapá', 'AP', 'Macapá', 'Norte'));
  FDatabase.Add(04, TState.Create('Amazonas', 'AM', 'Manaus', 'Norte'));
  FDatabase.Add(05, TState.Create('Bahia', 'BA', 'Salvador', 'Nordeste'));
  FDatabase.Add(06, TState.Create('Ceará', 'CE', 'Fortaleza', 'Nordeste'));
  FDatabase.Add(07, TState.Create('Distrito Federal', 'DF', 'Brasília', 'Centro-Oeste'));
  FDatabase.Add(08, TState.Create('Espírito Santo', 'ES', 'Vitória', 'Sudeste'));
  FDatabase.Add(09, TState.Create('Goiás', 'GO', 'Goiânia', 'Centro-Oeste'));
  FDatabase.Add(10, TState.Create('Maranhão', 'MA', 'São Luís', 'Nordeste'));
  FDatabase.Add(11, TState.Create('Mato Grosso', 'MT', 'Cuiabá', 'Centro-Oeste'));
  FDatabase.Add(12, TState.Create('Mato Grosso do Sul', 'MS', 'Campo Grande', 'Centro-Oeste'));
  FDatabase.Add(13, TState.Create('Minas Gerais', 'MG', 'Belo Horizonte', 'Sudeste'));
  FDatabase.Add(14, TState.Create('Pará', 'PA', 'Belém', 'Norte'));
  FDatabase.Add(15, TState.Create('Paraíba', 'PB', 'João Pessoa', 'Nordeste'));
  FDatabase.Add(16, TState.Create('Paraná', 'PR', 'Curitiba', 'Sul'));
  FDatabase.Add(17, TState.Create('Pernambuco', 'PE', 'Recife', 'Centro-Leste'));
  FDatabase.Add(18, TState.Create('Piauí', 'PI', 'Teresina', 'Nordeste'));
  FDatabase.Add(19, TState.Create('Rio de Janeiro', 'RJ', 'Rio d eJaneiro', 'Sudeste'));
  FDatabase.Add(20, TState.Create('Rio Grande do Norte', 'RN', 'Natal', 'Nordeste'));
  FDatabase.Add(21, TState.Create('Rio Grande do Sul', 'RS', 'Porto Alegre', 'Sul'));
  FDatabase.Add(22, TState.Create('Rondônia', 'RO', 'Porto Velho', 'Norte'));
  FDatabase.Add(23, TState.Create('Roraima', 'RR', 'Boa Vista', 'Norte'));
  FDatabase.Add(24, TState.Create('Santa Catarina', 'SC', 'Florianópolis', 'Sul'));
  FDatabase.Add(25, TState.Create('São Paulo', 'SP', 'São Paulo', 'Sudeste'));
  FDatabase.Add(26, TState.Create('Sergipe', 'SE', 'Aracaju', 'Nordeste'));
  FDatabase.Add(27, TState.Create('Tocantins', 'TO', 'Palmas', 'Norte'));
end;

end.
