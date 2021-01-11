unit Server.State;

interface

uses
  Helper.Json, Horse, REST.Json, System.SysUtils, Provider.API, Provider.State;

type
  TStateServer = class sealed
  public
    class procedure List(ARequest: THorseRequest; AResponse: THorseResponse; ANext: TProc);
    class procedure Get(ARequest: THorseRequest; AResponse: THorseResponse; ANext: TProc);
  end;

implementation

class procedure TStateServer.Get(ARequest: THorseRequest; AResponse: THorseResponse; ANext: TProc);
var
  LState: TObject;
  LProvider: IProviderAPI;
begin
  LProvider := TStateProvider.Create;
  LState := LProvider.Get(ARequest.Params.Items['id'].ToInteger);

  if Assigned(LState) then
  begin
    AResponse.Send(TJson.ObjectToJson(LState)).Status(THTTPStatus.OK);
    Exit;
  end;

  AResponse.Status(THTTPStatus.NotFound);
end;

class procedure TStateServer.List(ARequest: THorseRequest; AResponse: THorseResponse; ANext: TProc);
var
  LProvider: IProviderAPI;
begin
  LProvider := TStateProvider.Create;
  AResponse.Send(TJson.ArrayToJson(LProvider.List)).Status(THTTPStatus.OK);
end;

initialization
  THorse.Get('/estados', TStateServer.List);
  THorse.Get('/estado/:id', TStateServer.Get);

end.

