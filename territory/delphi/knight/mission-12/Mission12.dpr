program Mission12;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Impl.Operations in 'Impl.Operations.pas';

procedure Foo;
var
  Operations: TOperations;
  s: string;
  i: Integer;
begin
  Operations := TOperations.Create;
  try
    s := Operations.SortLetters('ggheabcedao');
 //   i := Operations.CountOccurrences('', 'a');
    i := Operations.CountOccurrences('arara', ' ');
  finally
    Operations.Free;
  end;
end;

begin
  Foo;
end.
