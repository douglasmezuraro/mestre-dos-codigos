unit Impl.Operations;

interface

uses
  System.Generics.Collections, System.SysUtils, System.Character;

type
  EInvalidCharacter = class sealed(EArgumentException);

  TOperations = class sealed
  private
    function Join(const AChars: TArray<Char>): string;
  public
    function SortLetters(const AText: string): string;
    function CountOccurrences(const AText: string; const AChar: Char): UInt64;
    function RemoveAccents(const AText: string): string;
  end;

implementation

function TOperations.CountOccurrences(const AText: string; const AChar: Char): UInt64;
var
  LChar: Char;
begin
  if (AText.Trim.IsEmpty) or (AChar = ' ') then
  begin
    raise EArgumentException.Create('The "text" argument cannot be empty.');
  end;

  Result := 0;
  for LChar in AText do
  begin
    if LChar = AChar then
    begin
      Inc(Result);
    end;
  end;
end;

function TOperations.Join(const AChars: TArray<Char>): string;
var
  LChar: Char;
begin
  Result := string.Empty;
  for LChar in AChars do
  begin
    Result := Result + LChar;
  end;
end;

function TOperations.RemoveAccents(const AText: string): string;
type
  TUSASCII = type AnsiString(20127);
var
  LChar: Char;
begin
  for LChar in AText do
  begin
    if not LChar.IsLetterOrDigit then
    begin
      raise EInvalidCharacter.CreateFmt('The character "%s" is not alphanumeric.', [LChar]);
    end;
  end;

  Result := string(TUSASCII(AText));
end;

function TOperations.SortLetters(const AText: string): string;
var
  LArray: TArray<Char>;
begin
  LArray := AText.Replace(' ', '').ToCharArray;
  TArray.Sort<Char>(LArray);
  Result := Join(LArray);
end;

end.
