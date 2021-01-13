unit Helper.Json;

interface

uses
  System.Json, REST.Json;

type
  TJsonHelper = class Helper for TJson
  public
    class function ArrayToJson(const AArray: TArray<TObject>): string;
    class function ObjectToJson(const AObject: TObject): string;
  end;

implementation

class function TJsonHelper.ArrayToJson(const AArray: TArray<TObject>): string;
var
  LObject: TObject;
  LJsonArray: TJsonArray;
begin
  LJsonArray := TJsonArray.Create;
  try
    for LObject in AArray do
    begin
      LJsonArray.AddElement(TJson.ObjectToJsonObject(LObject));
    end;

    Result := TJson.Format(LJsonArray);
  finally
    LJsonArray.Free;
  end;
end;

class function TJsonHelper.ObjectToJson(const AObject: TObject): string;
begin
  Result := TJson.Format(TJson.ObjectToJsonObject(AObject));
end;

end.

