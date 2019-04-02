unit Helper.Vcl;

interface

uses
  System.Classes,
  System.Math,
  System.SysUtils,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Grids,
  Vcl.Mask,
  Vcl.StdCtrls;

type
  TComponentHelper = class Helper for TComponent
  private
    function GetComponents: TArray<TComponent>;
  public
    procedure Clear;
    property ComponentsArray: TArray<TComponent> read GetComponents;
  end;

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
    property Required: Boolean read GetRequired write SetRequired;
  end;

  TStringGridHelper = class Helper for TStringGrid
  private
    procedure AutoFitColumns;
    procedure Add(const Values: TArray<string>; const Row: Integer); overload;
  public
    const HeaderIndex = 0;
    procedure Remove;
    procedure Add(const Values: TArray<string>); overload;
    procedure AddHeader(const Values: TArray<string>);
    procedure Edit(const Values: TArray<string>);
  end;

implementation

{ TWinControlHelper }

function TWinControlHelper.GetRequired: Boolean;
begin
  Result := Tag = Ord(trRequired);
end;

function TWinControlHelper.IsEmpty: Boolean;
begin
  Result := True;

  if Self is TCustomEdit then
  begin
    Result := (Self as TCustomEdit).Text = string.Empty;
    Exit;
  end;

  if Self is TDateTimePicker then
  begin
    Result := (Self as TDateTimePicker).Date = 0;
    Exit;
  end;

  if Self is TRadioGroup then
  begin
    Result := (Self as TRadioGroup).ItemIndex = -1;
  end;
end;

procedure TWinControlHelper.SetRequired(const Value: Boolean);
begin
  Tag := Value.ToInteger;
end;

function TWinControlHelper.TrySetFocus: Boolean;
begin
  Result := CanFocus;
  if Result then
    SetFocus;
end;

{ TStringGridHelper }

procedure TStringGridHelper.AddHeader(const Values: TArray<string>);
begin
  Add(Values, HeaderIndex);
end;

procedure TStringGridHelper.Add(const Values: TArray<string>);
begin
  Add(Values, RowCount);
end;

procedure TStringGridHelper.Add(const Values: TArray<string>; const Row: Integer);
var
  Insert, Append: Boolean;
  Column, Length: Integer;
  Event: TSelectCellEvent;
begin
  Length := System.Length(Values);

  if Row = HeaderIndex then
    ColCount := Length;

  if ColCount <> Length then
    raise Exception.CreateFmt('Mismatch with the previous column count. Before %d now %d.', [ColCount, Length]);

  Event := OnSelectCell;
  OnSelectCell := nil;
  try
    Insert := (Row > HeaderIndex) and (Row < RowCount);
    Append := Row >= RowCount;

    if Insert or Append then
      RowCount := Succ(RowCount);

    if Insert then
    begin
      for Column := Pred(RowCount) downto Succ(Row) do
        Rows[Column] := Rows[Pred(Column)];
    end;

    for Column := Low(Values) to High(Values) do
      Cells[Column, Row] := Values[Column];

    AutoFitColumns;
  finally
    OnSelectCell := Event;
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

procedure TStringGridHelper.Edit(const Values: TArray<string>);
var
  Column: Integer;
begin
  for Column := 0 to Pred(ColCount) do
    Cells[Column, Row] := Values[Column];

  AutoFitColumns;
end;

{ TComponentHelper }

procedure TComponentHelper.Clear;
var
  Component: TComponent;
begin
  if Self is TCustomEdit then
  begin
    (Self as TCustomEdit).Clear;
    Exit;
  end;

  if Self is TDateTimePicker then
  begin
    (Self as TDateTimePicker).DateTime := Now;
    Exit;
  end;

  if Self is TRadioGroup then
  begin
    (Self as TRadioGroup).ItemIndex := -1;
    Exit;
  end;

  if Self is TForm then
  begin
    for Component in ComponentsArray do
      Component.Clear;
  end;
end;

function TComponentHelper.GetComponents: TArray<TComponent>;
var
  Index: Integer;
begin
  SetLength(Result, ComponentCount);
  for Index := 0 to Pred(ComponentCount) do
    Result[Index] := Components[Index];
end;

end.

