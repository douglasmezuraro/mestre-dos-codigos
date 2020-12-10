program Mission14;

//       Author : Douglas Mezuraro
// Modification : 10/12/2020
//        Level : Knight
//      Mission : 14
//    Objective : Crie um banco de dados no Firebird 3.0 com as seguintes tabelas e campos:
//                  * FUNCIONARIO
//                      - ID
//                      - Nome
//                      - Data de Admiss�o
//                      - Sal�rio
//                  * DEPARTAMENTO
//                      - ID
//                      - Descri��o
//                      - Telefone
//                  * FUNCIONARIO_DEPARTAMENTO
//                      - IDFuncionario
//                      - IDDepartamento
//                Crie uma alica��o VCL que permita cadastrar funcion�rios, departamentos e vincular
//                funcion�rios a departamentos (mestre-detalhe). A conex�o com o banco de dados e a
//                manipula��o de dados devem ser feitas com FireDAC.

uses
  Vcl.Forms,
  System.SysUtils,
  Form.Main in 'src\Form\Form.Main.pas' {Main};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;

{$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := DebugHook.ToBoolean;
{$WARN SYMBOL_PLATFORM DEFAULT}
end.
