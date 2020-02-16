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

  Separator: array[Boolean] of string = (' ', ' e ');

  Zero = 'zero';
  Thousand = 'mil';
  OneHundred = 'cem';
  OneMillion = 'um milhão';
  Millions = 'milhões';

type
  TExtensiveNumber = class
  private
    FNumber: Integer;

    FUnit: Byte;
    FTens: Byte;
    FHundred: Byte;

    { Split Methods }
    function Split(const Enum: TUnit): Byte; overload;
    function Split(const Number: Extended; const Enum: TTierces): Integer; overload;

    { Get Value Methods }
    function GetValue(const Enum: TUnit): string; overload;
    function GetValue(const Number: Integer): string; overload;

    { Other }
    function NeedsSeparator(const Enum: TUnit): Boolean;

    { Extensive number functions }
    function GetUnit: string;
    function GetTens: string;
    function GetHundred: string;

    function FormatTierce(const Number: Integer; const Enum: TTierces): string;
    function InternalFormat(const Number: Integer): string;
  public
    function Format(const Number: Extended): string;
  end;

implementation

{ TExtensiveNumber }

function TExtensiveNumber.Format(const Number: Extended): string;
var
  Trunc, Frac: Integer;
begin
  if Number = 0 then
    Exit(Zero);

  Trunc := System.Trunc(Number);
  Frac  := System.Round(System.Frac(Number) * 100);

  Result := InternalFormat(Trunc);
  if Frac > 0 then
    Result := Result + ' vírgula ' + InternalFormat(Frac);
end;

function TExtensiveNumber.InternalFormat(const Number: Integer): string;
var
  Enum: TTierces;
  Value: string;
begin
  for Enum := Low(TTierces) to High(TTierces) do
  begin
    Value := FormatTierce(Number, Enum);
    if Result.IsEmpty then
      Result := Value
    else
      Result := Result + Separator[not Value.IsEmpty] + Value;
  end;
end;

function TExtensiveNumber.FormatTierce(const Number: Integer;
  const Enum: TTierces): string;
begin
  Result := String.empty;

  FNumber  := Split(Number, Enum);

  if FNumber = 0 then
    Exit;

  FUnit    := Split(dsUnit);
  FTens    := Split(dsTens);
  FHundred := Split(dsHundred);

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
          Result := OneMillion
        else
          Result := Result + ' ' + Millions;
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

function TExtensiveNumber.GetValue(const Enum: TUnit): string;
begin
  Result := string.Empty;
  case Enum of
    dsUnit    : Result := GetUnit;
    dsTens    : Result := GetTens;
    dsHundred : Result := GetHundred;
  end;
end;

function TExtensiveNumber.GetValue(const Number: Integer): string;
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

function TExtensiveNumber.Split(const Number: Extended; const Enum: TTierces): Integer;
var
  Value: string;
begin
  Value := Number.ToString.PadLeft(9, '0');

  Result := 0;
  case Enum of
    tHundreds  : Result := Value.Substring(6, 3).ToInteger;
    tThousands : Result := Value.Substring(3, 3).ToInteger;
    tMillions  : Result := Value.Substring(0, 3).ToInteger;
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

