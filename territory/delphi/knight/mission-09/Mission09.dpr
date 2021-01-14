program Mission09;

// Author: Douglas Mezuraro
// Modification: 21/12/2020
// Level: Knight
// Mission: 09

{$APPTYPE CONSOLE}

{$R *.res}

uses
  MidasLib,
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
  Web.WebConst in '3rdParty\Horse\src\Web.WebConst.pas',
  Server.State in 'src\Server\Server.State.pas',
  Model.State in 'src\Model\Model.State.pas',
  Provider.State in 'src\Provider\Provider.State.pas',
  Helper.Json in 'src\Helper\Helper.Json.pas',
  Provider.API in 'src\Provider\Provider.API.pas';

begin
  try
    THorse.Listen(9000,
      procedure(AHorse: THorse)
      begin
        AHorse.Host := 'localhost';
        Writeln('Server is runing on ', AHorse.Host, ':', AHorse.Port);
      end);
  except
    on E: Exception do
    begin
      Writeln(E.ClassName, ': ', E.Message);
      THorse.StopListen;
    end;
  end;

{$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := DebugHook.ToBoolean;
{$WARN SYMBOL_PLATFORM DEFAULT}
end.

