unit Impl.Operations;

interface

uses
  System.Generics.Collections, System.SysUtils, System.Character;

type
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
  LValue: Char;
begin
  if Text.IsEmpty then
    raise EArgumentException.Create('The "text" argument cannot be empty.');

  if not LValue.IsDefined then
    raise EArgumentException.Create('The "value" argument cannot be empty.');

  Result := Result.MinValue;
  for LValue in Text do
  begin
    if LValue = Value then
      Inc(Result);
  end;
end;

function TOperations.Join(const Value: TArray<Char>): string;
var
  LValue: Char;
begin
  for LValue in Value do
    Result := Result + LValue;
end;

function TOperations.RemoveAccents(const Text: string): string;
const
  ASCII_CODE_PAGE = 20127;
type
  USASCII = type AnsiString(ASCII_CODE_PAGE);
begin
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
