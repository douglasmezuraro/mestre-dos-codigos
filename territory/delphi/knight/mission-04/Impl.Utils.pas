unit Impl.Utils;

interface

uses
  System.Classes, System.SysUtils;

type
  TUtils = class
  public
    class function GetFiles(const Path: TFileName): TArray<string>;
  end;

implementation

class function TUtils.GetFiles(const Path: TFileName): TArray<string>;
var
  Files: TStringList;
  SearchRec: TSearchRec;
begin
end;

end.
