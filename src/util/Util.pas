unit Util;

interface

type
  TUtil = class
  private type
    TMethods = class
    public
      class function ArrayOfToTArray<T>(const Arr: array of T): TArray<T>; static;
    end;
  strict private
    class var FMethods: TMethods;
  public
    class property Methods: TMethods read FMethods;
  end;

implementation

{ TUtil.TMethods }

class function TUtil.TMethods.ArrayOfToTArray<T>(const Arr: array of T): TArray<T>;
var
  Index: Integer;
begin
  SetLength(Result, Length(Arr));
  for Index := 0 to Length(Arr) do
    Result[Index] := Arr[Index];
end;

end.
