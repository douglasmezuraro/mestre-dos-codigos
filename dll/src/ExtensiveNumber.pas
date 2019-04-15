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

    procedure Split;
    function GetValue(const Enum: TDecimalSystem): Byte;

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
  Split;
end;

function TExtensiveNumber.Make: string;
var
  Parse: string;
  Decimal: TDecimalSystem;
begin
  Decimal := TDecimalSystem(Pred(FNumber.Length));

  case Decimal of
    dsUnit              : Parse := Format('%s', [GetUnit]);
    dsTens              : Parse := Format('%s %s', [GetTens, GetUnit]);
    dsHundred           : Parse := Format('%s %s %s', [GetHundred, GetTens, GetUnit]);
    dsThousand          : Parse := Format('%s %s %s %s', [GetThousand, GetHundred, GetTens, GetUnit]);
    dsTensOfThousand    : Parse := Format('%s %s %s %s %s', [GetTensOfThousand, GetThousand, GetHundred, GetTens, GetUnit]);
    dsHundredOfThousand : Parse := Format('%s %s %s %s %s %s', [GetHundredOfThousand, GetTensOfThousand, GetThousand, GetHundred, GetTens, GetUnit])
  else
    Parse := 'zero';
  end;

  Result := Parse.Replace('  ', ' ');
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

procedure TExtensiveNumber.Split;
begin
  FUnit               := GetValue(dsUnit);
  FTens               := GetValue(dsTens);
  FHundred            := GetValue(dsHundred);
  FThousand           := GetValue(dsThousand);
  FTensOfThousand     := GetValue(dsTensOfThousand);
  FHundredOfThounsand := GetValue(dsHundredOfThousand);
end;

function TExtensiveNumber.GetValue(const Enum: TDecimalSystem): Byte;
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

function TExtensiveNumber.FormatNumber: string;
begin

end;

end.

