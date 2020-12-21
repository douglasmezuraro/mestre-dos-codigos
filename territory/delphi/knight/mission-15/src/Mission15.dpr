program Mission15;

//       Author : Douglas Mezuraro
// Modification : 21/12/2020
//        Level : Knight
//      Mission : 15
//    Objective : O componente TFDLocalSql é utilizado para executar comandos SQLs em DataSets em
//                memória, ou seja, sem conexão com bancos de dados. Neste exercício, baixe os arquivos
//                Clientes.xml e Cidades.xml
//                (https://github.com/db1group/mestre-dos-codigos/tree/master/docs/files/cavaleiro-delphi/dados).
//                Em uma aplicação VCL, carregue estes arquivos em dois componentes TFDMemTable. Em
//                seguida, use o componente TFDLocalSql para ligar os dados dos dois componentes
//                (pelo campo IdCidade) de forma que, em uma TDBGrid, sejam exibidos o nome do cliente
//                e o nome da cidade. A aplicação também deve permitir que o usuário filtre os clientes
//                de uma cidade específica.

uses
  System.SysUtils,
  Vcl.Forms,
  Form.Main in 'Form\Form.Main.pas' {Main};

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
