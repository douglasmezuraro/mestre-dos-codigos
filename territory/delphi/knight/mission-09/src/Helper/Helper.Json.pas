unit Helper.Json;

interface

uses
  System.Json, REST.Json;

type
  TJsonHelper = class Helper for TJson
  public
    class function ArrayToJson(const AArray: TArray<TObject>): string;
  end;

implementation

class function TJsonHelper.ArrayToJson(const AArray: TArray<TObject>): string;
var
  LObject: TObject;
  LArray: TJsonArray;
begin
  LArray := TJsonArray.Create;
  try
    for LObject in AArray do
    begin
      LArray.AddElement(TJson.ObjectToJsonObject(LObject));
    end;

    Result := LArray.ToJson;
  finally
    LArray.Free;
  end;
end;

end.
