unit Helper.DBGrid;

interface

uses
  System.Classes, System.Math, System.Types, Vcl.DBGrids;

type
  TDBGridHelper = class Helper for TDBGrid
  public
    procedure FitColumns;
  end;

implementation

procedure TDBGridHelper.FitColumns;
const
  DEFAULT_OFFSET = 5;
var
  LEnumerator: TCollectionEnumerator;
  LTextWidth, LTitleWidth: Integer;
begin
  LEnumerator := Columns.GetEnumerator;
  try
    while LEnumerator.MoveNext do
    begin
      LTextWidth := DEFAULT_OFFSET + Canvas.TextExtent((LEnumerator.GetCurrent as TColumn).Field.DisplayText).Width;
      LTitleWidth := DEFAULT_OFFSET + Canvas.TextExtent((LEnumerator.GetCurrent as TColumn).Field.DisplayLabel).Width;

      (LEnumerator.GetCurrent as TColumn).Width := Max(LTitleWidth, LTextWidth);
    end;
  finally
    LEnumerator.Free;
  end;
end;

end.
