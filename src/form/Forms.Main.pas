unit Forms.Main;

interface

uses
  System.Actions,
  System.Classes,
  System.SysUtils,
  Vcl.ActnList,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Menus;

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
  Forms.Exercise1;

procedure TMain.ActionExerciseOneExecute(Sender: TObject);
begin
  var View := TExercise1.Create(Self);
  try
    View.ShowModal;
  finally
    View.Free;
  end;
end;

end.

