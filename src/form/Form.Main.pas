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
    procedure ActionExerciseOneExecute(Sender: TObject);
  end;

implementation

{$R *.dfm}

uses
  Form.Exercise1;

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

end.

