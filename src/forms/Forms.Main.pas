unit Forms.Main;

interface

uses
  System.Actions,
  System.Classes,
  System.SysUtils,
  System.Variants,
  Vcl.ActnList,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Menus,
  Winapi.Messages,
  Winapi.Windows;

type
  TMain = class(TForm)
    MainMenu: TMainMenu;
    ActionList: TActionList;
    ActionExerciseOne: TAction;
    MenuItemExerciseOne: TMenuItem;
    procedure ActionExerciseOneExecute(Sender: TObject);
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

uses
  Forms.ExerciseOne;

procedure TMain.ActionExerciseOneExecute(Sender: TObject);
var
  View: TExerciseOne;
begin
  View := TExerciseOne.Create(Self);
  try
    View.ShowModal;
  finally
    View.Free;
  end;
end;

end.
