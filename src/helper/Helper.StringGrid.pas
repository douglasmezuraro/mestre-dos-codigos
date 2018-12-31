unit Helper.StringGrid;

interface

uses
  System.Math,
  System.SysUtils,
  Vcl.ComCtrls,
  Vcl.Grids;

type
  TStringGridHelper = class Helper for TStringGrid
  public
    const HeaderIndex = 0;
    procedure Remove; overload;
    procedure Remove(const Row: Integer); overload;
    procedure Add(const Values: TArray<string>; const Header: Boolean = False);
    procedure AutoFitColumns;
  end;

implementation

{ TStringGridHelper }

procedure TStringGridHelper.Add(const Values: TArray<string>;
  const Header: Boolean);
var
  RowIndex: Word;
  ColumnIndex: Byte;
  Length: Integer;
  Event: TSelectCellEvent;
begin
  Event := OnSelectCell;
  OnSelectCell := nil;
  try
    RowIndex := 0;
    if not Header then
    begin
      RowIndex := RowCount;
      RowCount := Succ(RowCount);
      Row := RowIndex;
    end;

    Length := System.Length(Values);

    if ColCount = 1 then
      ColCount := Length
    else if ColCount <> Length then
      raise Exception.Create('Mismatch with the previous column count.');

    for ColumnIndex := Low(Values) to High(Values) do
      Cells[ColumnIndex, RowIndex] := Values[ColumnIndex];

    AutoFitColumns;
  finally
    OnSelectCell := Event;
  end;
end;

procedure TStringGridHelper.Remove;
begin
  Remove(Row);
end;

procedure TStringGridHelper.AutoFitColumns;
const
  BlankSpace = 15;
var
  Column, Row, Width: Integer;
begin
  for Column := 0 to Pred(ColCount) do
  begin
    Width := 0;
    for Row := 0 to Pred(RowCount) do
    begin
      Width := Max(Width, Canvas.TextWidth(Cells[Column, Row]));
    end;
    ColWidths[Column] := Width + BlankSpace + GridLineWidth;
  end;
end;

procedure TStringGridHelper.Remove(const Row: Integer);
var
  Index: Integer;
begin
  if Row <> Pred(RowCount) then
  begin
    for Index := Row to Pred(RowCount) do
      Rows[Index] := Rows[Succ(Index)];
  end;

  RowCount := Pred(RowCount);
  AutoFitColumns;
end;

end.

