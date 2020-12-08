program Mission08;

//       Author : Douglas Mezuraro
// Modification : 08/12/2020
//        Level : Knight
//      Mission : 08
//    Objective : Em uma aplicação VCL, você deverá criar um formulário que permita a pesquisa de
//                usuários do GitHub. Para isso, utilize os componentes da paleta REST Client para
//                acessar a API pública do GitHub (https://api.github.com/users/{busca}), substituindo
//                o texto "{busca}" pela entrada do usuário. Utilize o componente
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

