unit Impl.Cryptography;

interface

type
  TCryptography = class
  public
    class function EnDeCrypt(const Value: string): string;
  end;

implementation

class function TCryptography.EnDeCrypt(const Value: string): string;
var
  Index : integer;
begin
  Result := Value;
  for Index := 1 to Length(Value) do
    Result[Index] := Chr(not(Ord(Value[Index])));
end;

end.
