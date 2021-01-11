unit Test.Service.Person;

interface

uses
  DUnitX.TestFramework, Data.DB, System.SysUtils, Delphi.Mocks, uPessoaRepository, uPessoaService,
  uPessoaService.Impl, uPessoa;

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
    [TestCase('Tests the service when person is valid', 'Douglas Mezuraro,18/06/1996')]
    procedure TestSavePersonWhenPersonIsValid(const AName, ABirthDate: string);

    [Test]
    [TestCase('Tests the service when person name is empty', ',18/06/1996,O nome não foi informado')]
    [TestCase('Tests the service when person birthdate is empty', 'Douglas Mezuraro,,A Data de nascimento não foi informada')]
    [TestCase('Tests the service when person is underage', 'Douglas Mezuraro,10/12/2020,Menor de idade não pode ser cadastrado')]
    procedure TestSavePersonWhenPersonIsInvalid(const AName, ABirthDate, AExceptionMessage: string);

    [Test]
    [TestCase('Tests the service when repository raises a database exception', 'Douglas Mezuraro,18/06/1996')]
    procedure TestSavePersonWhenRepositoryRaisesDatabaseException(const AName, ABirthDate: string);

    [Test]
    [TestCase('Tests the service when repository raises an exception', 'Douglas Mezuraro,18/06/1996')]
    procedure TestSavePersonWhenRepositoryRaisesException(const AName, ABirthDate: string);
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

procedure TServiceTest.TestSavePersonWhenPersonIsValid(const AName, ABirthDate: string);
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

procedure TServiceTest.TestSavePersonWhenRepositoryRaisesDatabaseException(const AName, ABirthDate: string);
begin
  FRepository.Setup.WillRaise('PersistirDados', EDatabaseError);

  Assert.WillRaise(
    procedure
    begin
      FPerson.Nome := AName;
      FPerson.DataNascimento := System.SysUtils.StrToDateDef(ABirthDate, 0);

      FService.Salvar(FPerson);
    end,
    EArgumentException);
end;

procedure TServiceTest.TestSavePersonWhenRepositoryRaisesException(const AName, ABirthDate: string);
begin
  FRepository.Setup.WillRaise('PersistirDados', Exception);

  Assert.WillRaise(
    procedure
    begin
      FPerson.Nome := AName;
      FPerson.DataNascimento := System.SysUtils.StrToDateDef(ABirthDate, 0);

      FService.Salvar(FPerson);
    end,
    Exception);
end;

initialization
  TDUnitX.RegisterTestFixture(TServiceTest);

end.

