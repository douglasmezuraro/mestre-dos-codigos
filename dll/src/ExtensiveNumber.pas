unit ExtensiveNumber;

interface

uses
  System.Math,
  System.StrUtils,
  System.SysUtils;

const
  Units: array[1..9] of string = ('um', 'dois', 'três', 'quatro', 'cinco', 'seis', 'sete', 'oito', 'nove');
  UnitsBetweenElevenAndNineteen: array[0..9] of string = ('dez', 'onze', 'doze', 'treze', 'quatorze', 'quinze', 'dezesseis', 'dezessete', 'dezoito', 'dezenove');
  Tens: array[2..9] of string = ('vinte', 'trinta', 'quarenta', 'cinquenta', 'sessenta', 'setenta', 'oitenta', 'noventa');
  Hundreds: array[1..9] of string = ('cento', 'duzentos', 'trezentos', 'quatrocentos', 'quintenhos', 'seiscentos', 'setecentos', 'oitocentos', 'novecentos');

  Zero = 'zero';
  OneHundred = 'cem';
  Thousand = 'mil';
  
type
  TDecimalSystem = (dsHundredOfThousand, dsTensOfThousand, dsThousand, dsHundred, dsTens, dsUnit);

  TExtensiveNumber = class
  private
    FNumber: Extended;

    FUnit: Byte;
    FTens: Byte;
    FHundred: Byte;
    FThousand: Byte;
    FTensOfThousand: Byte;
    FHundredOfThousand: Byte;

    { Split Methods }
    procedure Split; overload;
    function Split(const Enum: TDecimalSystem): Byte; overload;

    { Useful Methods }
    function GetValue(const Enum: TDecimalSystem): string;
    function NeedsSeparator(const Enum: TDecimalSystem): Boolean;

    { Extensive number functions }
    function GetUnit: string;
    function GetTens: string;
    function GetHundred: string;
    function GetThousand: string;
    function GetTensOfThousand: string;
    function GetHundredOfThousand: string;

    function InternalFormat: string;
  public
    function FormatNumber(const Number: Extended): string;
  end;

implementation

{ TExtensiveNumber }

function TExtensiveNumber.FormatNumber(const Number: Extended): string;
begin
  FNumber := Number;

  Split;

  Result := InternalFormat;
end;

function TExtensiveNumber.InternalFormat: string;
const
  Separator: array[Boolean] of string = (' ', ' e ');
var
  Enum: TDecimalSystem;
  Parse: string;
begin
  if FNumber = 0 then
    Exit(Zero);

  for Enum := Low(TDecimalSystem) to High(TDecimalSystem) do
  begin
    Parse := GetValue(Enum);
    if Result.IsEmpty then
      Result := Parse
    else
    begin
      if not Parse.IsEmpty then
        Result := Result + Separator[NeedsSeparator(Enum)] + Parse;
    end;
  end;
end;

function TExtensiveNumber.GetUnit: string;
begin
  Result := string.Empty;

  if FUnit = 0 then
    Exit;

  if FTens = 1 then
    Exit;

  Result := Units[FUnit];
end;

function TExtensiveNumber.GetTens: string;
begin
  Result := string.Empty;

  if FTens = 0 then
    Exit;

  if FTens = 1 then
    Exit(UnitsBetweenElevenAndNineteen[FUnit]);

  Result := Tens[FTens];
end;

function TExtensiveNumber.GetHundred: string;
begin
  Result := string.Empty;

  if FHundred = 0 then
    Exit;

  if FNumber = 100 then
    Exit(OneHundred);

  Result := Hundreds[FHundred];
end;

function TExtensiveNumber.GetThousand: string;
begin
  Result := string.Empty;

  if FNumber < 1000 then
    Exit;

  if FThousand = 1 then
    Exit(Thousand);

  if FTensOfThousand = 1 then
    Exit(Thousand);

  Result := Units[FThousand] + ' ' + Thousand;
end;

function TExtensiveNumber.GetTensOfThousand: string;
begin
  Result := string.Empty;

  if FTensOfThousand = 0 then
    Exit;

  if FTensOfThousand = 1 then
    Exit(UnitsBetweenElevenAndNineteen[FThousand]);

  Result := Tens[FTensOfThousand];
end;

function TExtensiveNumber.GetHundredOfThousand: string;
begin
  Result := string.Empty;

  if FHundredOfThousand = 0 then
    Exit;

  if (FThousand = 0) and (FTensOfThousand = 0) then
    Exit(OneHundred);

  Result := Hundreds[FHundredOfThousand];
end;

procedure TExtensiveNumber.Split;
begin
  FUnit              := Split(dsUnit);
  FTens              := Split(dsTens);
  FHundred           := Split(dsHundred);
  FThousand          := Split(dsThousand);
  FTensOfThousand    := Split(dsTensOfThousand);
  FHundredOfThousand := Split(dsHundredOfThousand);
end;

function TExtensiveNumber.Split(const Enum: TDecimalSystem): Byte;
var
  Value: string;
  Index, Count: Integer;
begin
  Count := Succ(Ord(High(TDecimalSystem)));
  Index := Ord(Enum);
  Value := FNumber.ToString.PadLeft(Count, '0');

  Result := StrToIntDef(Value.Chars[Index], 0);
end;

function TExtensiveNumber.GetValue(const Enum: TDecimalSystem): string;
begin
  Result := string.Empty;
  case Enum of
    dsUnit              : Result := GetUnit;
    dsTens              : Result := GetTens;
    dsHundred           : Result := GetHundred;
    dsThousand          : Result := GetThousand;
    dsTensOfThousand    : Result := GetTensOfThousand;
    dsHundredOfThousand : Result := GetHundredOfThousand;
  end;
end;

function TExtensiveNumber.NeedsSeparator(const Enum: TDecimalSystem): Boolean;
begin
  case Enum of
    dsUnit, dsTens: Result := (FTens <> 1) and (FUnit > 0);
  else
    Result := False;
  end;
end;

end.

