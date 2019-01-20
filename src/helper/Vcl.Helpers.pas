unit Vcl.Helpers;

interface

uses
  System.Math,
  System.SysUtils,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Grids,
  Vcl.Mask;

type
  TWinControlHelper = class Helper for TWinControl
  private type
    TTagRole = (trUndefined, trRequired);
  private
    function GetRequired: Boolean;
    procedure SetRequired(const Value: Boolean);
  public
    const RequiredChar: Char = '*';
    function TrySetFocus: Boolean;
    function IsEmpty: Boolean;
    function ToString: string;
    property Required: Boolean read GetRequired write SetRequired;
  end;

  TCustomRadioGroupHelper = class Helper for TCustomRadioGroup
  public
    procedure AddValues(const Values: array of string);
  end;

  TStringGridHelper = class Helper for TStringGrid
  private
    procedure AutoFitColumns;
  public
    const HeaderIndex = 0;
    procedure Remove; overload;
    procedure Remove(const Row: Integer); overload;
    procedure Add(const Values: TArray<string>); overload;
    procedure Add(const Values: TArray<string>; const Row: Integer); overload;
    procedure Update(const Values: TArray<string>);
  end;

const
  OutOfBoundIndex = -1;

implementation

{ TWinControlHelper }

function TWinControlHelper.GetRequired: Boolean;
begin
  Result := Tag = Ord(trRequired);
end;

function TWinControlHelper.IsEmpty: Boolean;
begin
  Result := ToString.Trim.IsEmpty;
end;

procedure TWinControlHelper.SetRequired(const Value: Boolean);
begin
  Tag := Value.ToInteger;
end;

function TWinControlHelper.ToString: string;
var
  Text: string;
begin
  Text := Self.Text;

  if Self is TMaskEdit then
    Text := (Self as TMaskEdit).Text;

  Result := Text;
end;

function TWinControlHelper.TrySetFocus: Boolean;
begin
  Result := CanFocus;
  if Result then
    SetFocus;
end;

{ TCustomRadioGroupHelper }

procedure TCustomRadioGroupHelper.AddValues(const Values: array of string);
var
  Value: string;
begin
  Items.Clear;
  for Value in Values do
    Items.Add(Value);

  if Items.Count > 0 then
    ItemIndex := 0;
end;

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

procedure TStringGridHelper.Update(const Values: TArray<string>);
var
  Column: Integer;
begin
  for Column := 0 to Pred(ColCount) do
    Cells[Column, Row] := Values[Column];
end;

end.

