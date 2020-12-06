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
    procedure FormShow(Sender: TObject);
  {$ENDREGION}
  strict private
    FPrograms: TProgramList;
  private
    procedure ListPrograms;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
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

procedure TMain.FormShow(Sender: TObject);
begin
  ListPrograms;
end;

procedure TMain.ListPrograms;
var
  LProgram: TProgramInfo;
begin
  DataSet.DisableControls;
  try
    for LProgram in FPrograms.ToArray do
    begin
      if not LProgram.IsEmpty then
      begin
        DataSet.AppendRecord([LProgram.Name, LProgram.Version, LProgram.Publisher]);
      end;
    end;
  finally
    DataSet.EnableControls;
  end;
end;

end.

