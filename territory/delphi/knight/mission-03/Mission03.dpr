program Mission03;

// Author: Douglas Mezuraro
// Last modification: 06/12/2020
// Level: Knight
// Mission: 03
// Objective: Desenvolva uma aplica��o VCL que fa�a a compacta��o de arquivos utilizando a classe
// TZipFile. Para isso, no formul�rio principal, permita que o usu�rio possa selecionar os arquivos
// que deseja compactar, bem como o caminho e nome do arquivo compactado que ser� criado. A opera��o
// deve observar as seguintes regras e comportamentos: Arquivos com extens�o .EXE n�o podem ser
// selecionados (exiba uma mensagem ao usu�rio);


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
