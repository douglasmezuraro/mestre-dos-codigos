program Mission09;

//       Author : Douglas Mezuraro
// Modification : 08/12/2020
//        Level : Knight
//      Mission : 09
//    Objective : Faça o download e instalação do framework Horse (https://github.com/HashLoad/horse)
//                para criar uma API no Delphi. Essa API deverá exportar duas rotas:
//                  - /estados: retorna uma lista com o nome de todos os estados do Brasil;
//                  - /estado/{id}: retorna o nome, sigla, região e capital do estado referente ao ID informado.
//                Use a página do Wikipedia para definir os IDs:
//                https://pt.wikipedia.org/wiki/Unidades_federativas_do_Brasil

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse in '3rdParty\Horse\src\Horse.pas',
  Horse.Commons in '3rdParty\Horse\src\Horse.Commons.pas',
  Horse.Constants in '3rdParty\Horse\src\Horse.Constants.pas',
  Horse.Core in '3rdParty\Horse\src\Horse.Core.pas',
  Horse.Core.Group in '3rdParty\Horse\src\Horse.Core.Group.pas',
  Horse.Core.Group.Contract in '3rdParty\Horse\src\Horse.Core.Group.Contract.pas',
  Horse.Core.Route in '3rdParty\Horse\src\Horse.Core.Route.pas',
  Horse.Core.Route.Contract in '3rdParty\Horse\src\Horse.Core.Route.Contract.pas',
  Horse.Core.RouterTree in '3rdParty\Horse\src\Horse.Core.RouterTree.pas',
  Horse.Exception in '3rdParty\Horse\src\Horse.Exception.pas',
  Horse.HTTP in '3rdParty\Horse\src\Horse.HTTP.pas',
  Horse.Proc in '3rdParty\Horse\src\Horse.Proc.pas',
  Horse.Provider.Abstract in '3rdParty\Horse\src\Horse.Provider.Abstract.pas',
  Horse.Provider.Apache in '3rdParty\Horse\src\Horse.Provider.Apache.pas',
  Horse.Provider.CGI in '3rdParty\Horse\src\Horse.Provider.CGI.pas',
  Horse.Provider.Console in '3rdParty\Horse\src\Horse.Provider.Console.pas',
  Horse.Provider.Daemon in '3rdParty\Horse\src\Horse.Provider.Daemon.pas',
  Horse.Provider.FPC.Apache in '3rdParty\Horse\src\Horse.Provider.FPC.Apache.pas',
  Horse.Provider.FPC.CGI in '3rdParty\Horse\src\Horse.Provider.FPC.CGI.pas',
  Horse.Provider.FPC.Daemon in '3rdParty\Horse\src\Horse.Provider.FPC.Daemon.pas',
  Horse.Provider.FPC.FastCGI in '3rdParty\Horse\src\Horse.Provider.FPC.FastCGI.pas',
  Horse.Provider.FPC.HTTPApplication in '3rdParty\Horse\src\Horse.Provider.FPC.HTTPApplication.pas',
  Horse.Provider.ISAPI in '3rdParty\Horse\src\Horse.Provider.ISAPI.pas',
  Horse.Provider.VCL in '3rdParty\Horse\src\Horse.Provider.VCL.pas',
  Horse.WebModule in '3rdParty\Horse\src\Horse.WebModule.pas' {HorseWebModule: TWebModule},
  ThirdParty.Posix.Syslog in '3rdParty\Horse\src\ThirdParty.Posix.Syslog.pas',
  Web.WebConst in '3rdParty\Horse\src\Web.WebConst.pas';

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on Error: Exception do
    begin
      Writeln(Error.ClassName, ': ', Error.Message);
    end;
  end;
end.
