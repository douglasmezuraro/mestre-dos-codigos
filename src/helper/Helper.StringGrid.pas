unit Helper.StringGrid;

interface

uses
  System.Math,
  System.SysUtils,
  Vcl.ComCtrls,
  Vcl.Grids;

type
  TStringGridHelper = class Helper for TStringGrid
  private
    procedure AutoFitColumns;
  public
    const HeaderIndex = 0;
    procedure Remove; overload;
    procedure Remove(const Row: Integer); overload;
    procedure Add(const Values: TArray<string>); overload;
    procedure Add(const Values: TArray<string>; const Row: Integer); overload;
  end;

implementation

{ TStringGridHelper }

procedure TStringGridHelper.Add(const Values: TArray<string>);
begin
  Add(Values, RowCount);
end;

procedure TStringGridHelper.Add(const Values: TArray<string>; const Row: Integer);
var
  Insert, Append: Boolean;
  Column, Length: Integer;
  OldEvent: TSelectCellEvent;
begin
  Length := System.Length(Values);

  if Row = HeaderIndex then
    ColCount := Length;

  if ColCount <> Length then
    raise Exception.CreateFmt('Mismatch with the previous column count. Before %d now %d', [ColCount, Length]);

  OldEvent := OnSelectCell;
  OnSelectCell := nil;
  try
    Insert := (Row > HeaderIndex) and (Row < RowCount);
    Append := Row >= RowCount;

    if Insert or Append then
      RowCount := Succ(RowCount);

    if Insert then
      for Column := Pred(RowCount) downto Succ(Row) do
        Rows[Column] := Rows[Pred(Column)];

    for Column := Low(Values) to High(Values) do
      Cells[Column, Row] := Values[Column];

    AutoFitColumns;
  finally
    OnSelectCell := OldEvent;
  end;
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

procedure TStringGridHelper.Remove;
begin
  Remove(Row);
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

