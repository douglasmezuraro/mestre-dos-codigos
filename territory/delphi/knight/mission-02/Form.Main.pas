unit Form.Main;

interface

uses
  Data.DB, Datasnap.DBClient, Impl.ProgramInfo, Impl.ProgramList, System.Classes, Vcl.Controls,
  Vcl.DBGrids, Vcl.Forms, Vcl.Grids;

type
  TMain = class sealed(TForm)
  {$REGION 'Visual Components'}
    Grid: TDBGrid;
    DataSet: TClientDataSet;
    DataSource: TDataSource;
    FieldName: TStringField;
    FieldVersion: TStringField;
    FieldPublisher: TStringField;
  {$ENDREGION}
  private
    FPrograms: TProgramList;
    procedure ListPrograms;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AfterConstruction; override;
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

constructor TMain.Create(AOwner: TComponent);
begin
  inherited;
  DataSet.CreateDataSet;
  FPrograms := TProgramList.Create;
end;

destructor TMain.Destroy;
begin
  FPrograms.Free;
  inherited;
end;

procedure TMain.AfterConstruction;
begin
  inherited;
  ListPrograms;
end;

procedure TMain.ListPrograms;
var
  Info: TProgramInfo;
begin
  DataSet.DisableControls;
  try
    for Info in FPrograms.ToArray do
    begin
      if not Info.IsEmpty then
      begin
        DataSet.Insert;
        FieldName.AsString := Info.Name;
        FieldVersion.AsString := Info.Version;
        FieldPublisher.AsString := info.Publisher;
        DataSet.Post;
      end;
    end;
  finally
    DataSet.EnableControls;
  end;
end;

end.

