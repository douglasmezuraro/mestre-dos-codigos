unit Form.Main;

interface

uses
  System.Classes, Vcl.Controls, Vcl.Forms, Data.DB, Vcl.DBGrids, Vcl.ComCtrls, Vcl.Grids;

type
  TMain = class sealed(TForm)
  {$REGION 'Visual Components'}
    DataSourceDepartments: TDataSource;
    DataSourceEmployees: TDataSource;
    DataSourceEmployeesDepartments: TDataSource;
    GridDepartments: TDBGrid;
    GridEmployees: TDBGrid;
    GridEmployeesDepartments: TDBGrid;
    PageControl: TPageControl;
    TabSheetDepartments: TTabSheet;
    TabSheetEmployees: TTabSheet;
    TabSheetEmployeesDepartments: TTabSheet;
  {$ENDREGION}
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

end.

