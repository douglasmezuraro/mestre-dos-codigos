unit Forms.ExerciseOne;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.Actions,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Math,
  Vcl.ActnList,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Mask,
  Vcl.Samples.Spin,
  Vcl.StdCtrls;

type
  TExerciseOne = class(TForm)
    ButtonInsert: TButton;
    ActionList: TActionList;
    ActionInsert: TAction;
    ActionIndexExit: TAction;
    ActionRemove: TAction;
    ButtonRemove: TButton;
  private
  end;

implementation

{$R *.dfm}

uses
  Utils.DynamicArray,
  Utils.ComponentHelper;

{ TExerciseOne }

constructor TExerciseOne.Create(AOwner: TComponent);
begin

end;

end.
