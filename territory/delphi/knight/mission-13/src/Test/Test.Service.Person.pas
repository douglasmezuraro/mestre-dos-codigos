unit Test.Service.Person;

interface

uses
  DUnitX.TestFramework, uPessoa, uPessoaService, uPessoaService.Impl, System.SysUtils;

type
  [TestFixture]
  TServiceTests = class sealed
  strict private
    FService: IPessoaService;
  public
    [Setup]
    procedure Setup;

    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestSavePerson;
  end;

implementation

procedure TServiceTests.Setup;
begin
  FService := TPessoaService.Create(nil);
end;

procedure TServiceTests.TearDown;
begin

end;

procedure TServiceTests.TestSavePerson;
var
  LPerson: TPessoa;
begin
  LPerson := TPessoa.Create;
  try
    LPerson.ID := TGUID.NewGuid;
    LPerson.Nome := 'Douglas Mezuraro';
    LPerson.DataNascimento := System.SysUtils.StrToDate('18/06/1996');
    LPerson.EstadoCivil := TEstadoCivil.ecSolteiro;

    Assert.IsTrue(FService.Salvar(LPerson));
  finally
    LPerson.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TServiceTests);

end.
