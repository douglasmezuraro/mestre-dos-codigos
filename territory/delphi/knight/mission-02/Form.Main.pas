unit Form.Main;

interface

uses
  Data.DB,
  Datasnap.DBClient,
  Impl.ProgramInfo,
  Impl.ProgramList,
  System.Classes,
  Vcl.Controls,
  Vcl.DBGrids,
  Vcl.Forms,
  Vcl.Grids;

type
  TMain = class sealed(TForm)
    Grid: TDBGrid;
  strict private
    FDataSet: TClientDataSet;
    FDataSource: TDataSource;
  private
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
  Grid.DataSource := FDataSource;
end;

procedure TMain.ListPrograms;
var
  Prog: TProgramInfo;
  ProgramList: TProgramList;
begin
  FDataSet.DisableControls;
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
    FDataSet.EnableControls;
  end;
end;

end.

