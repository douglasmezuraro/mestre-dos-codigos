unit Impl.Operations;

interface

uses
  System.Generics.Collections, System.SysUtils, System.Character;

type
  EInvalidCharacter = class(EArgumentException);

  TOperations = class sealed
  private
    function Join(const Value: TArray<Char>): string;
  public
    function SortLetters(const Text: string): string;
    function CountOccurrences(const Text: string; const Value: Char): Word;
    function RemoveAccents(const Text: string): string;
  end;

implementation

function TOperations.CountOccurrences(const Text: string; const Value: Char): Word;
var
  Character: Char;
begin
  if (Text.Trim.IsEmpty) or (Value = ' ') then
  begin
    raise EArgumentException.Create('The "text" argument cannot be empty.');
  end;

  Result := 0;
  for Character in Text do
  begin
    if Character = Value then
      Inc(Result);
  end;
end;

function TOperations.Join(const Value: TArray<Char>): string;
var
  Character: Char;
begin
  for Character in Value do
    Result := Result + Character;
end;

function TOperations.RemoveAccents(const Text: string): string;
type
  USASCII = type AnsiString(20127);
var
  Character: Char;
begin
  for Character in Text do
  begin
    if not Character.IsLetterOrDigit then
    begin
      raise EInvalidCharacter.CreateFmt('The character "%s" is not alphanumeric.', [Character]);
    end;
  end;

  Result := string(USASCII(Text));
end;

function TOperations.SortLetters(const Text: string): string;
var
  LArray: TArray<Char>;
begin
  LArray := Text.Replace(' ', '').ToCharArray;
  TArray.Sort<Char>(LArray);
  Result := Join(LArray);
end;

end.
