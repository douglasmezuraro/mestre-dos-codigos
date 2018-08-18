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
  Forms.Exercise1;

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
