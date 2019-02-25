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
    ActionExerciseOne: TAction;
    MenuItemExerciseOne: TMenuItem;
    MenuItemGeometricCalculator: TMenuItem;
    ActionGeometricCalculator: TAction;
    MenuItemExerciseOne1: TMenuItem;
    procedure ActionExerciseOneExecute(Sender: TObject);
    procedure ActionGeometricCalculatorExecute(Sender: TObject);
  end;

implementation

{$R *.dfm}

uses
  Form.Exercise1,
  Form.GeometricCalculator;

procedure TMain.ActionExerciseOneExecute(Sender: TObject);
var
  View: TExercise1;
begin
  View := TExercise1.Create(Self);
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

