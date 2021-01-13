unit Model.State;

interface

type
  TState = class sealed
  strict private
    FName: string;
    FAbbreviation: string;
    FCapital: string;
    FRegion: string;
  public
    constructor Create(const AName, AAbbreviation, ACapital, ARegion: string);
    property Name: string read FName write FName;
    property Abbreviation: string read FAbbreviation write FAbbreviation;
    property Capital: string read FCapital write FCapital;
    property Region: string read FRegion write FRegion;
  end;

implementation

constructor TState.Create(const AName, AAbbreviation, ACapital, ARegion: string);
begin
  FName := AName;
  FAbbreviation := AAbbreviation;
  FCapital := ACapital;
  FRegion := ARegion;
end;

end.

