unit Form.Main;

interface

uses
  System.Actions,
  System.Classes,
  Vcl.ActnList,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Menus,
  Vcl.StdCtrls;

type
  TMain = class(TForm)
    MainMenu: TMainMenu;
    ActionList: TActionList;
    ActionCrudPerson: TAction;
    MenuItemExerciseOne: TMenuItem;
    MenuItemGeometricCalculator: TMenuItem;
    ActionGeometricCalculator: TAction;
    MenuItemExerciseOne1: TMenuItem;
    procedure ActionCrudPersonExecute(Sender: TObject);
    procedure ActionGeometricCalculatorExecute(Sender: TObject);
  end;

implementation

{$R *.dfm}

uses
  Form.Crud.Person,
  Form.GeometricCalculator;

procedure TMain.ActionCrudPersonExecute(Sender: TObject);
var
  View: TCrudPerson;
begin
  View := TCrudPerson.Create(Self);
  try
    View.ShowModal;
  finally
    View.Free;
  end;
end;

procedure TMain.ActionGeometricCalculatorExecute(Sender: TObject);
var
  View: TGeometricCalculator;
begin
  View := TGeometricCalculator.Create(Self);
  try
    View.ShowModal;
  finally
    View.Free;
  end;
end;

end.

