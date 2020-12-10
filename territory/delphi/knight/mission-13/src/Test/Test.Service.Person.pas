unit Test.Service.Person;

interface

uses
  DUnitX.TestFramework, System.SysUtils, Delphi.Mocks, uPessoaRepository, uPessoa, uPessoaService,
  uPessoaService.Impl;

type
  [TestFixture]
  TServiceTest = class sealed
  strict private
    FService: IPessoaService;
    FRepository: TMock<IPessoaRepository>;
    FPerson: TPessoa;
  public
    [Setup]
    procedure Setup;

    [TearDown]
    procedure TearDown;

    [Test]
    [TestCase('Valid person', 'Douglas Mezuraro,18/06/1996')]
    procedure SavePersonWhenPersonIsValid(const AName, ABirthDate: string);

    [Test]
    [TestCase('Empty name', ',18/06/1996,O nome não foi informado')]
    [TestCase('Empty birthdate', 'Douglas Mezuraro,,A Data de nascimento não foi informada')]
    [TestCase('Underage person', 'Douglas Mezuraro,10/12/2020,Menor de idade não pode ser cadastrado')]
    procedure TestSavePersonWhenPersonIsInvalid(const AName, ABirthDate, AExceptionMessage: string);
  end;

implementation

procedure TServiceTest.Setup;
begin
  FRepository := TMock<IPessoaRepository>.Create;
  FService := TPessoaService.Create(FRepository);
  FPerson := TPessoa.Create;
end;

procedure TServiceTest.TearDown;
begin
  FPerson.Free;
end;

procedure TServiceTest.SavePersonWhenPersonIsValid(const AName, ABirthDate: string);
begin
  FRepository.Setup.WillReturnDefault('PersistirDados', True);

  FPerson.Nome := AName;
  FPerson.DataNascimento := System.SysUtils.StrToDateDef(ABirthDate, 0);

  Assert.IsTrue(FService.Salvar(FPerson));
end;

procedure TServiceTest.TestSavePersonWhenPersonIsInvalid(const AName, ABirthDate, AExceptionMessage: string);
begin
  Assert.WillRaiseWithMessage(
    procedure
    begin
      FPerson.Nome := AName;
      FPerson.DataNascimento := System.SysUtils.StrToDateDef(ABirthDate, 0);

      FService.Salvar(FPerson);
    end,
    Exception,
    AExceptionMessage);
end;

initialization
  TDUnitX.RegisterTestFixture(TServiceTest);

end.
