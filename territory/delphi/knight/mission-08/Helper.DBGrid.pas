unit Helper.DBGrid;

interface

uses
  System.Classes,
  System.Math,
  System.Types,
  Vcl.DBGrids;

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
  Enumerator: TCollectionEnumerator;
  TextWidth, TitleWidth: Integer;
begin
  Enumerator := Columns.GetEnumerator;
  try
    while Enumerator.MoveNext do
    begin
      TextWidth := DEFAULT_OFFSET + Canvas.TextExtent((Enumerator.GetCurrent as TColumn).Field.DisplayText).Width;
      TitleWidth := DEFAULT_OFFSET + Canvas.TextExtent((Enumerator.GetCurrent as TColumn).Field.DisplayLabel).Width;

      (Enumerator.GetCurrent as TColumn).Width := Max(TitleWidth, TextWidth);
    end;
  finally
    Enumerator.Free;
  end;
end;

end.
