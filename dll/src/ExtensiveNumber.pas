unit ExtensiveNumber;

interface

uses
  System.Math,
  System.StrUtils,
  System.SysUtils,
  System.Types;

const
  Units: array[1..9] of string = ('um', 'dois', 'três', 'quatro', 'cinco', 'seis', 'sete', 'oito', 'nove');
  UnitsBetweenElevenAndNineteen: array[0..9] of string = ('dez', 'onze', 'doze', 'treze', 'quatorze', 'quinze', 'dezesseis', 'dezessete', 'dezoito', 'dezenove');
  Tens: array[2..9] of string = ('vinte', 'trinta', 'quarenta', 'cinquenta', 'sessenta', 'setenta', 'oitenta', 'noventa');
  Hundreds: array[1..9] of string = ('cento', 'duzentos', 'trezentos', 'quatrocentos', 'quintenhos', 'seiscentos', 'setecentos', 'oitocentos', 'novecentos');

  Zero = 'zero';
  OneHundred = 'cem';
  Thousand = 'mil';
  
type
  TDecimalSystem = (dsUnit, dsTens, dsHundred, dsThousand, dsTensOfThousand, dsHundredOfThousand);

  TExtensiveNumber = class
  private
    FNumber: string;

    FUnit: Byte;
    FTens: Byte;
    FHundred: Byte;
    FThousand: Byte;
    FTensOfThousand: Byte;
    FHundredOfThousand: Byte;

    { Useful Methods }
    procedure SplitNumber;
    function GetValueAsNumber(const Enum: TDecimalSystem): Byte;
    function GetValueAsString(const Enum: TDecimalSystem): string;
    function NeedsSeparator(const Enum: TDecimalSystem): Boolean;

    { Extensive number functions }
    function GetUnit: string;
    function GetTens: string;
    function GetHundred: string;
    function GetThousand: string;
    function GetTensOfThousand: string;
    function GetHundredOfThousand: string;
  public
    constructor Create(const Number: Extended);
    function FormatNumber: string;
  end;

implementation

{ TExtensiveNumber }

constructor TExtensiveNumber.Create(const Number: Extended);
begin
  FNumber := Number.ToString;
  SplitNumber;
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

  if FNumber.ToInteger = 100 then
    Exit(OneHundred);

  Result := Hundreds[FHundred];
end;

function TExtensiveNumber.GetThousand: string;
begin
  Result := string.Empty;

  case CompareValue(FNumber.ToInteger, 1000) of
    LessThanValue    : Result := string.Empty;
    EqualsValue      : Result := Thousand;
    GreaterThanValue :
      begin 
        if (FTensOfThousand > 0) or (FHundredOfThousand > 0) then
          Exit( ' ' + Thousand);

        Result := Units[FThousand] + ' ' + Thousand;
      end;      
  end;
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

procedure TExtensiveNumber.SplitNumber;
begin
  FUnit               := GetValueAsNumber(dsUnit);
  FTens               := GetValueAsNumber(dsTens);
  FHundred            := GetValueAsNumber(dsHundred);
  FThousand           := GetValueAsNumber(dsThousand);
  FTensOfThousand     := GetValueAsNumber(dsTensOfThousand);
  FHundredOfThousand := GetValueAsNumber(dsHundredOfThousand);
end;

function TExtensiveNumber.FormatNumber: string;
const
  Separator: array[Boolean] of string = (' ', ' e ');
var
  Enum: TDecimalSystem;
begin
  Result := string.empty;

  if FNumber.ToInteger = 0 then
    Exit(Zero);
  
  for Enum := High(TDecimalSystem) downto Low(TDecimalSystem) do
  begin
    if Result.IsEmpty then
      Result := GetValueAsString(Enum)
    else
      Result := Result + Separator[NeedsSeparator(Enum)] + GetValueAsString(Enum);                                                  
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

function TExtensiveNumber.NeedsSeparator(const Enum: TDecimalSystem): Boolean;
begin
  case Enum of
    dsUnit              : Result := (FTens > 1) and (FUnit > 0);
    dsTens              : Result := (FTens > 1) and (FUnit > 0);
    dsHundred           : Result := False;
    dsThousand          : Result := False;
    dsTensOfThousand    : Result := False;
    dsHundredOfThousand : Result := False;
  else
    Result := False;
  end;
end;

end.

