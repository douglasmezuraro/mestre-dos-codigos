unit Utils.Date;

interface

uses
  System.DateUtils,
  System.SysUtils,
  System.Types;

type
  TDateTimeHelper = record Helper for TDateTime
  public
    const Null: Byte = 0;
    class function Now: TDateTime; static;
    function IsEmpty: Boolean;
    function FromString(const DateTime: string): TDateTime;
    function ToString: string;
    function IncDay(const Days: Integer): TDateTime;
    function IncMonth(const Months: Integer): TDateTime;
    function IncYear(const Years: Integer): TDateTime;
    function Compare(const DateTime: TDateTime): TValueRelationship;
  end;

implementation

{ TDateTimeHelper }

function TDateTimeHelper.Compare(const DateTime: TDateTime): TValueRelationship;
begin
  Result := CompareDateTime(Self, Date);
end;

function TDateTimeHelper.FromString(const DateTime: string): TDateTime;
begin
  Self := StrToDateTimeDef(DateTime, TDateTime.Null);
  Result := Self;
end;

function TDateTimeHelper.IncDay(const Days: Integer): TDateTime;
begin
  Self := System.DateUtils.IncDay(Self, Days);
  Result := Self;
end;

function TDateTimeHelper.IncMonth(const Months: Integer): TDateTime;
begin
  Self := System.SysUtils.IncMonth(Self, Months);
  Result := Self;
end;

function TDateTimeHelper.IncYear(const Years: Integer): TDateTime;
begin
  Self := System.DateUtils.IncYear(Self, Years);
  Result := Self;
end;

function TDateTimeHelper.IsEmpty: Boolean;
begin
  Result := Self = TDateTime.Null;
end;

class function TDateTimeHelper.Now: TDateTime;
begin
  Result := System.SysUtils.Now;
end;

function TDateTimeHelper.ToString: string;
begin
  Result := DateTimeToStr(Self);
end;

end.
