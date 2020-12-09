unit Impl.Cryptography;

interface

type
  TCryptography = class sealed
  private
    class function EncryptOrDecrypt(const AValue: string): string;
  public
    class function Encrypt(const AValue: string): string;
    class function Decrypt(const AValue: string): string;
  end;

implementation

class function TCryptography.Encrypt(const AValue: string): string;
begin
  Result := EncryptOrDecrypt(AValue);
end;

class function TCryptography.Decrypt(const AValue: string): string;
begin
  Result := EncryptOrDecrypt(AValue);
end;

class function TCryptography.EncryptOrDecrypt(const AValue: string): string;
var
  LIndex : Integer;
begin
  Result := AValue;
  for LIndex := 1 to Length(AValue) do
  begin
    Result[LIndex] := Chr(not(Ord(AValue[LIndex])));
  end;
end;

end.
