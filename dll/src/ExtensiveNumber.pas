unit ExtensiveNumber;

interface

uses
  System.Math,
  System.StrUtils,
  System.SysUtils;

type
  TUnit = (dsHundred, dsTens, dsUnit);
  TTierces = (tMillions, tThousands, tHundreds);

const
  Units: array[1..9] of string = ('um', 'dois', 'três', 'quatro', 'cinco', 'seis', 'sete', 'oito', 'nove');
  UnitsBetweenElevenAndNineteen: array[0..9] of string = ('dez', 'onze', 'doze', 'treze', 'quatorze', 'quinze', 'dezesseis', 'dezessete', 'dezoito', 'dezenove');
  Tens: array[2..9] of string = ('vinte', 'trinta', 'quarenta', 'cinquenta', 'sessenta', 'setenta', 'oitenta', 'noventa');
  Hundreds: array[1..9] of string = ('cento', 'duzentos', 'trezentos', 'quatrocentos', 'quintenhos', 'seiscentos', 'setecentos', 'oitocentos', 'novecentos');

  SingularSuffix: array[TTierces] of string = ('um milhão', 'mil', '');
  PluralSuffix: array[TTierces] of string = ('milhões', 'mil', '');
  Separator: array[Boolean] of string = (' ', ' e ');

  Zero = 'zero';
  OneHundred = 'cem';
  Thousand = 'mil';

type
  TExtensiveNumber = class
  private
    FNumber: Extended;

    FUnit: Byte;
    FTens: Byte;
    FHundred: Byte;

    { Split Methods }
    function Split(const Enum: TUnit): Byte; overload;
    function Split(const Number: Extended; const Enum: TTierces): Extended; overload;

    { Get Value Methods }
    function GetValue(const Enum: TUnit): string; overload;
    function GetValue(const Number: Extended): string; overload;

    { Other }
    function NeedsSeparator(const Enum: TUnit): Boolean;

    { Extensive number functions }
    function GetUnit: string;
    function GetTens: string;
    function GetHundred: string;

    function InternalFormat(const Number: Extended; const Enum: TTierces): string;
  public
    function FormatNumber(const Number: Extended): string;
  end;

implementation

{ TExtensiveNumber }

function TExtensiveNumber.FormatNumber(const Number: Extended): string;
var
  Enum: TTierces;
  Value: string;
begin
  if Number = 0 then
    Exit(Zero);

  for Enum := Low(TTierces) to High(TTierces) do
  begin
    Value := InternalFormat(Number, Enum);
    if Result.IsEmpty then
      Result := Value
    else
      Result := Result + Separator[not Value.IsEmpty] + Value;
  end;
end;

function TExtensiveNumber.InternalFormat(const Number: Extended;
  const Enum: TTierces): string;
begin
  Result := String.empty;

  FNumber  := Split(Number, Enum);
  FUnit    := Split(dsUnit);
  FTens    := Split(dsTens);
  FHundred := Split(dsHundred);

  if FNumber = 0 then
    Exit;

  Result := GetValue(FNumber);

  case Enum of
    tThousands:
      begin
        if FNumber = 1 then
          Result := Thousand
        else
          Result := Result + ' ' + Thousand;
      end;
    tMillions:
      begin
        if FNumber = 1 then
          Result := 'um milhão'
        else
          Result := Result + ' milhões';
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
    Exit('cem');

  Result := Hundreds[FHundred];
end;

function TExtensiveNumber.GetValue(const Enum: TUnit): string;
begin
  Result := string.Empty;
  case Enum of
    dsUnit    : Result := GetUnit;
    dsTens    : Result := GetTens;
    dsHundred : Result := GetHundred;
  end;
end;

function TExtensiveNumber.GetValue(const Number: Extended): string;
var
  Enum: TUnit;
  Value: string;
begin
  for Enum := Low(TUnit) to High(TUnit) do
  begin
    Value := GetValue(Enum);
    if Result.IsEmpty then
      Result := Value
    else
    begin
      if not Value.IsEmpty then
        Result := Result + Separator[NeedsSeparator(Enum)] + Value;
    end;
  end;
end;

function TExtensiveNumber.Split(const Enum: TUnit): Byte;
var
  Value: string;
  Index, Count: Integer;
begin
  Count := Succ(Ord(High(TUnit)));
  Index := Ord(Enum);
  Value := FNumber.ToString.PadLeft(Count, '0');

  Result := StrToIntDef(Value.Chars[Index], 0);
end;

function TExtensiveNumber.Split(const Number: Extended; const Enum: TTierces): Extended;
var
  Value: string;
begin
  Value := Number.ToString.PadLeft(9, '0');

  Result := 0;
  case Enum of
    tHundreds  : Result := Value.Substring(6, 3).ToExtended;
    tThousands : Result := Value.Substring(3, 3).ToExtended;
    tMillions  : Result := Value.Substring(0, 3).ToExtended;
  end;
end;

function TExtensiveNumber.NeedsSeparator(const Enum: TUnit): Boolean;
begin
  Result := False;
  case Enum of
    dsUnit    : Result := FUnit > 0;
    dsTens    : Result := FUnit > 0;
    dsHundred : Result := FTens > 0;
  end;
end;

end.

