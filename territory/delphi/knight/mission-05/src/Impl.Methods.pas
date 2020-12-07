unit Impl.Methods;

interface

uses
  System.Generics.Collections, System.SysUtils, System.Threading;

type
  TMethods = class sealed
  private
    class function IsPrime(const ANumber: Int64): Boolean;
  public
    class function ListPrimeNumbers(const ALow, AHigh: Int64): TArray<Int64>;
  end;

implementation

class function TMethods.IsPrime(const ANumber: Int64): Boolean;
var
  LIndex: Int64;
begin
  if ANumber in [0, 1, 2] then
  begin
    Exit(False);
  end;

  for LIndex := 2 to ANumber div 2 do
  begin
    if ANumber mod LIndex = 0 then
    begin
      Exit(False);
    end;
  end;

  Result := True;
end;

class function TMethods.ListPrimeNumbers(const ALow, AHigh: Int64): TArray<Int64>;
var
  LList: TList<Int64>;
  LThreadList: TThreadList<Int64>;
begin
  LThreadList := TThreadList<Int64>.Create;
  try
    TParallel.&For(ALow, AHigh,
      procedure(ANumber: Int64)
      begin
        if TMethods.IsPrime(ANumber) then
        begin
          LThreadList.Add(ANumber);
        end;
      end);

    LList := LThreadList.LockList;
    LList.Sort;
    Result := LList.ToArray;
  finally
    LThreadList.Free;
  end;
end;

end.
