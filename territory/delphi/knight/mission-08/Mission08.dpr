program Mission08;

//       Author : Douglas Mezuraro
// Modification : 08/12/2020
//        Level : Knight
//      Mission : 08
//    Objective : Em uma aplica��o VCL, voc� dever� criar um formul�rio que permita a pesquisa de
//                usu�rios do GitHub. Para isso, utilize os componentes da paleta REST Client para
//                acessar a API p�blica do GitHub (https://api.github.com/users/{busca}), substituindo
//                o texto "{busca}" pela entrada do usu�rio. Utilize o componente
//                TRestResponseDataSetAdapter para apresentar os resultados em um componente TDBGrid.

uses
  Vcl.Forms,
  System.SysUtils,
  Helper.DBGrid in 'src\Helper\Helper.DBGrid.pas',
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

