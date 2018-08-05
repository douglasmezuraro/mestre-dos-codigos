unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList, Vcl.Menus;

type
  TForm1 = class(TForm)
    MainMenu: TMainMenu;
    ActionList: TActionList;
    ActionExerciseOne: TAction;
    Exerccio11: TMenuItem;
    procedure ActionExerciseOneExecute(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  Forms.ExerciseOne;

procedure TForm1.ActionExerciseOneExecute(Sender: TObject);
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
