program Mission06;

//       Author : Douglas Mezuraro
// Modification : 08/12/2020
//        Level : Knight
//      Mission : 06
//    Objective : Em uma aplica��o VCL, declare uma classe Thread respons�vel por fazer o download
//                de um arquivo qualquer da internet. Em seguida, em um formul�rio, adicione um campo
//                de texto para que o usu�rio informe o endere�o do arquivo, e uma barra de progresso
//                para exibir o progresso do download. A classe TThread dever� ser utilizada para
//                baixar o arquivo e atualizar a barra de progresso sem travar a aplica��o.

uses
  Vcl.Forms,
  System.SysUtils,
  Form.Main in 'src\Form\Form.Main.pas' {Main},
  Impl.Downloader in 'src\Impl\Impl.Downloader.pas';

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

