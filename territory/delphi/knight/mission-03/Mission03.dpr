program Mission03;

// Author: Douglas Mezuraro
// Last modification: 06/12/2020
// Level: Knight
// Mission: 03
// Objective: Desenvolva uma aplicação VCL que faça a compactação de arquivos utilizando a classe
// TZipFile. Para isso, no formulário principal, permita que o usuário possa selecionar os arquivos
// que deseja compactar, bem como o caminho e nome do arquivo compactado que será criado. A operação
// deve observar as seguintes regras e comportamentos: Arquivos com extensão .EXE não podem ser
// selecionados (exiba uma mensagem ao usuário);


uses
  MidasLib,
  Vcl.Forms,
  Form.Main in 'src\Form\Form.Main.pas' {Main},
  Helper.ZipFile in 'src\Helper\Helper.ZipFile.pas',
  Impl.Zip in 'src\Impl\Impl.Zip.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;

  ReportMemoryLeaksOnShutdown := True;
end.
