program Mission14;

//       Author : Douglas Mezuraro
// Modification : 21/12/2020
//        Level : Knight
//      Mission : 14
//    Objective : Crie um banco de dados no Firebird 3.0 com as seguintes tabelas e campos:
//                  * FUNCIONARIO
//                      - ID
//                      - Nome
//                      - Data de Admissão
//                      - Salário
//                  * DEPARTAMENTO
//                      - ID
//                      - Descrição
//                      - Telefone
//                  * FUNCIONARIO_DEPARTAMENTO
//                      - IDFuncionario
//                      - IDDepartamento
//                Crie uma alicação VCL que permita cadastrar funcionários, departamentos e vincular
//                funcionários a departamentos (mestre-detalhe). A conexão com o banco de dados e a
//                manipulação de dados devem ser feitas com FireDAC.



{$R *.dres}

uses
  Vcl.Forms,
  System.SysUtils,
  Form.Main in 'src\Form\Form.Main.pas' {Main},
  DataModule.Global in 'src\DataModule\DataModule.Global.pas' {DM};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TDM, DM);
  Application.Run;

{$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := DebugHook.ToBoolean;
{$WARN SYMBOL_PLATFORM DEFAULT}
end.
