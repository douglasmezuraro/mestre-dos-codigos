unit ExtensiveNumber;

interface

uses
  System.StrUtils,
  System.SysUtils;

const
  Unidades: array[0..9] of string = ('zero', 'um', 'dois', 'três', 'quatro', 'cinco', 'seis', 'sete', 'oito', 'nove');
  DezenasEspeciais: array[0..9] of string = ('dez', 'onze', 'doze', 'treze', 'quatorze', 'quinze', 'dezesseis', 'dezessete', 'dezoito', 'dezenove');
  Dezenas: array[2..9] of string = ('vinte', 'trinta', 'quarenta', 'cinquenta', 'sessenta', 'setenta', 'oitenta', 'noventa');
  Centenas: array[1..9] of string = ('cento', 'duzentos', 'trezentos', 'quatrocentos', 'quintenhos', 'seiscentos', 'setecentos', 'oitocentos', 'novecentos');

type
  TDecimalSystem = (nlUnidade, nlDezena, nlCentena, nlMilhar, nlDezenaMilhar, nlCentenaMilhar);

  TExtensiveNumber = class
  private
    FNumber: string;

    FUnidade: Integer;
    FDezena: Integer;
    FCentena: Integer;
    FMilhar: Integer;
    FDezenaMilhar: Integer;
    FCentenaMilhar: Integer;

    procedure Split;
    function GetValue(const Enum: TDecimalSystem): Byte;

    function Unidade: string;
    function Dezena: string;
    function Centena: string;
    function Milhar: string;
    function DezenaMilhar: string;
    function CentenaMilhar: string;
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
    nlUnidade       : Parse := Format('%s', [Unidade]);
    nlDezena        : Parse := Format('%s %s', [Dezena, Unidade]);
    nlCentena       : Parse := Format('%s %s %s', [Centena, Dezena, Unidade]);
    nlMilhar        : Parse := Format('%s %s %s %s', [Milhar, Centena, Dezena, Unidade]);
    nlDezenaMilhar  : Parse := Format('%s %s %s %s %s', [DezenaMilhar, Milhar, Centena, Dezena, Unidade]);
    nlCentenaMilhar : Parse := Format('%s %s %s %s %s %s', [CentenaMilhar, DezenaMilhar, Milhar, Centena, Dezena, Unidade])
  else
    Parse := 'zero';
  end;

  Result := Parse.Replace('  ', ' ');
end;

function TExtensiveNumber.Unidade: string;
begin
  if FDezena = 1 then
    Exit;

  Result := Unidades[FUnidade];
end;

function TExtensiveNumber.Dezena: string;
begin
  if FDezena = 0 then
    Exit;

  if FDezena = 1 then
    Exit(DezenasEspeciais[FUnidade]);

  Result := Dezenas[FDezena];
end;

function TExtensiveNumber.Centena: string;
begin
  if FCentena = 0 then
    Exit;

  if (FUnidade = 0) and (FDezena = 0) then
    Exit('cem');

  Result := Centenas[FCentena];
end;

function TExtensiveNumber.Milhar: string;
begin
  if (FMilhar = 1) or (FDezenaMilhar <> 0) or (FCentenaMilhar <> 0) then
    Exit('mil');

  if FMilhar = 0 then
    Exit;

  Result := Unidades[FMilhar] + ' mil';
end;

function TExtensiveNumber.DezenaMilhar: string;
begin
  if FDezenaMilhar = 0 then
    Exit;

  if FDezenaMilhar = 1 then
    Exit(DezenasEspeciais[FMilhar]);

  Result := Dezenas[FDezenaMilhar];
end;

function TExtensiveNumber.CentenaMilhar: string;
begin
  if FCentenaMilhar = 0 then
    Exit;

  if (FMilhar = 0) and (FDezenaMilhar = 0) then
    Exit('cem');

  Result := Centenas[FCentenaMilhar];
end;

procedure TExtensiveNumber.Split;
begin
  FUnidade       := GetValue(nlUnidade);
  FDezena        := GetValue(nlDezena);
  FCentena       := GetValue(nlCentena);
  FMilhar        := GetValue(nlMilhar);
  FDezenaMilhar  := GetValue(nlDezenaMilhar);
  FCentenaMilhar := GetValue(nlCentenaMilhar);
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

end.

