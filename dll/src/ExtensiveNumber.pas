unit ExtensiveNumber;

interface

uses
  System.StrUtils,
  System.SysUtils;

const
  Units: array[0..9] of string = ('zero', 'um', 'dois', 'três', 'quatro', 'cinco', 'seis', 'sete', 'oito', 'nove');
  UnitsBetweenElevenAndNineteen: array[0..9] of string = ('dez', 'onze', 'doze', 'treze', 'quatorze', 'quinze', 'dezesseis', 'dezessete', 'dezoito', 'dezenove');
  Tens: array[2..9] of string = ('vinte', 'trinta', 'quarenta', 'cinquenta', 'sessenta', 'setenta', 'oitenta', 'noventa');
  Hundreds: array[1..9] of string = ('cento', 'duzentos', 'trezentos', 'quatrocentos', 'quintenhos', 'seiscentos', 'setecentos', 'oitocentos', 'novecentos');

type
  TDecimalSystem = (dsUnit, dsTens, dsHundred, dsThousand, dsTensOfThousand, dsHundredOfThousand);

  TExtensiveNumber = class
  private
    FNumber: string;

    FUnit: Integer;
    FTens: Integer;
    FHundred: Integer;
    FThousand: Integer;
    FTensOfThousand: Integer;
    FHundredOfThounsand: Integer;

    procedure SplitNumber;
    function GetValueAsNumber(const Enum: TDecimalSystem): Byte;
    function GetValueAsString(const Enum: TDecimalSystem): string;

    function GetUnit: string;
    function GetTens: string;
    function GetHundred: string;
    function GetThousand: string;
    function GetTensOfThousand: string;
    function GetHundredOfThousand: string;

    function FormatNumber: string;
  public
    constructor Create(const Number: Extended);
    function Make: string;
  end;

implementation

{ TExtensiveNumber }

constructor TExtensiveNumber.Create(const Number: Extended);
begin
  FNumber := Number.ToString;
  SplitNumber;
end;

function TExtensiveNumber.Make: string;
begin
  Result := FormatNumber;
end;

function TExtensiveNumber.GetUnit: string;
begin
  if FTens = 1 then
    Exit;

  Result := Units[FUnit];
end;

function TExtensiveNumber.GetTens: string;
begin
  if FTens = 0 then
    Exit;

  if FTens = 1 then
    Exit(UnitsBetweenElevenAndNineteen[FUnit]);

  Result := Tens[FTens];
end;

function TExtensiveNumber.GetHundred: string;
begin
  if FHundred = 0 then
    Exit;

  if (FUnit = 0) and (FTens = 0) then
    Exit('cem');

  Result := Hundreds[FHundred];
end;

function TExtensiveNumber.GetThousand: string;
begin
  if (FThousand = 1) or (FTensOfThousand <> 0) or (FHundredOfThounsand <> 0) then
    Exit('mil');

  if FThousand = 0 then
    Exit;

  Result := Units[FThousand] + ' mil';
end;

function TExtensiveNumber.GetTensOfThousand: string;
begin
  if FTensOfThousand = 0 then
    Exit;

  if FTensOfThousand = 1 then
    Exit(UnitsBetweenElevenAndNineteen[FThousand]);

  Result := Tens[FTensOfThousand];
end;

function TExtensiveNumber.GetHundredOfThousand: string;
begin
  if FHundredOfThounsand = 0 then
    Exit;

  if (FThousand = 0) and (FTensOfThousand = 0) then
    Exit('cem');

  Result := Hundreds[FHundredOfThounsand];
end;

procedure TExtensiveNumber.SplitNumber;
begin
  FUnit               := GetValueAsNumber(dsUnit);
  FTens               := GetValueAsNumber(dsTens);
  FHundred            := GetValueAsNumber(dsHundred);
  FThousand           := GetValueAsNumber(dsThousand);
  FTensOfThousand     := GetValueAsNumber(dsTensOfThousand);
  FHundredOfThounsand := GetValueAsNumber(dsHundredOfThousand);
end;

function TExtensiveNumber.FormatNumber: string;
var
  Enum: TDecimalSystem;
begin
  Result := string.empty;
  for Enum := High(TDecimalSystem) downto Low(TDecimalSystem) do
  begin
    if Result.IsEmpty then
      Result := GetValueAsString(Enum)
    else
      Result := Result + ' ' + GetValueAsString(Enum);
  end;
end;

function TExtensiveNumber.GetValueAsNumber(const Enum: TDecimalSystem): Byte;
var
  Value: string;
  Index, Min, Max: Integer;
begin
  Min := Ord(Enum);
  Max := Ord(High(TDecimalSystem));
  Index := Max - Min;

  Value := FNumber.PadLeft(Succ(Ord(High(TDecimalSystem))), '0');

  Result := string(Value.Chars[Index]).ToInteger
end;

function TExtensiveNumber.GetValueAsString(const Enum: TDecimalSystem): string;
begin
  case Enum of
    dsUnit              : Result := GetUnit;
    dsTens              : Result := GetTens;
    dsHundred           : Result := GetHundred;
    dsThousand          : Result := GetThousand;
    dsTensOfThousand    : Result := GetTensOfThousand;
    dsHundredOfThousand : Result := GetHundredOfThousand;
  else
    Result := 'NaN';
  end;
end;

end.

