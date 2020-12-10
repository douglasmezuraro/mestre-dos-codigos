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
    FRepositoryMock: TMock<IPessoaRepository>;
  public
    [Setup]
    procedure Setup;

    [Test]
    [TestCase('Empty name', ',18/06/1996,O nome não foi informado')]
    [TestCase('Empty birthdate', 'Douglas Mezuraro,,A Data de nascimento não foi informada')]
    [TestCase('Underage person', 'Douglas Mezuraro,10/12/2020,Menor de idade não pode ser cadastrado')]
    procedure TestSavePersonWhenDataIsIncomplete(const AName, ABirthDate, AExceptionMessage: string);
  end;

implementation

procedure TServiceTest.Setup;
begin
  FRepositoryMock := TMock<IPessoaRepository>.Create;
  FService := TPessoaService.Create(FRepositoryMock);
end;

procedure TServiceTest.TestSavePersonWhenDataIsIncomplete(const AName, ABirthDate, AExceptionMessage: string);
begin
  FRepositoryMock.Setup.WillRaise('PersistirDados', Exception);

  Assert.WillRaiseWithMessage(
    procedure
    var
      LPerson: TPessoa;
    begin
      LPerson := TPessoa.Create;
      try
        LPerson.Nome := AName;
        LPerson.DataNascimento := System.SysUtils.StrToDateDef(ABirthDate, 0);

        FService.Salvar(LPerson);
      finally
        LPerson.Free;
      end;
    end,
    Exception,
    AExceptionMessage);
end;

initialization
  TDUnitX.RegisterTestFixture(TServiceTest);

end.
