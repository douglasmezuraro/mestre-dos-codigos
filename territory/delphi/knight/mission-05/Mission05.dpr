program Mission05;

// Author: Douglas Mezuraro
// Last modification: 18/02/2020
// Level: Knight
// Mission: 05
// Objective: Build a console or VCL application that finds prime numbers up to one million using
// the "TParellel" class.

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils, System.Threading;

function Prime(const Value: Int64): Boolean;
var
  Index: Int64;
  Count: Byte;
begin
  Count := 0;

  for Index := 1 to Value do
  begin
    if Count > 2 then
      Exit(False);

    if Value mod Index = 0 then
      Inc(Count);
  end;

  Result := True;
end;

begin
  TParallel.For(1, 1000000,
    procedure(Index: Int64)
    begin
      if Prime(Index) then
      begin
        Writeln(string.Format('The number %d is prime.', [Index]));
      end;
    end);

  Readln;

  ReportMemoryLeaksOnShutdown := True;
end.
