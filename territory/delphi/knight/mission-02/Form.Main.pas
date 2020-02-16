unit Form.Main;

interface

uses
  System.Classes, Vcl.Controls, Vcl.Forms, Data.DB, Vcl.DBGrids, Datasnap.DBClient, Vcl.Grids,
  Impl.ProgramList, Impl.ProgramInfo;

type
  TMain = class(TForm)
    GridPrograms: TDBGrid;
  private
    FDataSet: TClientDataSet;
    FDataSource: TDataSource;
    procedure ListPrograms;
    procedure LinkComponents;
    procedure CreateDataSet;
  public
    constructor Create(AOwner: TComponent); override;
    procedure AfterConstruction; override;
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

constructor TMain.Create(AOwner: TComponent);
begin
  inherited;
  FDataSource := TDataSource.Create(AOwner);
  FDataSet := TClientDataSet.Create(AOwner);
end;

procedure TMain.AfterConstruction;
begin
  inherited;
  CreateDataSet;
  LinkComponents;
  ListPrograms;
end;

procedure TMain.CreateDataSet;
begin
  FDataSet.FieldDefs.Add('Name', TFieldType.ftString, 60);
  FDataSet.FieldDefs.Add('Version', TFieldType.ftString, 40);
  FDataSet.FieldDefs.Add('Publisher', TFieldType.ftString, 60);

  FDataSet.CreateDataSet;
end;

procedure TMain.LinkComponents;
begin
  FDataSource.DataSet := FDataSet;
  GridPrograms.DataSource := FDataSource;
end;

procedure TMain.ListPrograms;
var
  Prog: TProgramInfo;
  ProgramList: TProgramList;
begin
  ProgramList := TProgramList.Create;
  try
    for Prog in ProgramList.List do
    begin
      FDataSet.Insert;
      FDataSet.FieldByName('Name').AsString := Prog.Name;
      FDataSet.FieldByName('Version').AsString := Prog.Version;
      FDataSet.FieldByName('Publisher').AsString := Prog.Publisher;
      FDataSet.Post;
    end;
  finally
    ProgramList.Free;
  end;
end;

end.

