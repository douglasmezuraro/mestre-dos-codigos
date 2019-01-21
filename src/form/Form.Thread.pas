unit Form.Thread;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.ComCtrls, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    ProgressBarA: TProgressBar;
    ProgressBarB: TProgressBar;
    ActionList: TActionList;
    ActionStart: TAction;
    ButtonStart: TButton;
    ButtonPause: TButton;
    ActionPause: TAction;
    procedure ActionStartExecute(Sender: TObject);
    procedure ActionPauseExecute(Sender: TObject);
  private
    A, B: TThread;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ActionPauseExecute(Sender: TObject);
begin
  A.Suspended := True;
end;

procedure TForm1.ActionStartExecute(Sender: TObject);
begin
  A := TThread.CreateAnonymousThread(
    procedure
    var
      I: Integer;
    begin
      for I := 0 to 100 do
      begin
        Sleep(100);
        ProgressBarA.Position := I;
        ProgressBarA.Update;
      end;
    end);

  B := TThread.CreateAnonymousThread(
    procedure
    var
      I: Integer;
    begin
      for I := 0 to 100 do
      begin
        Sleep(150);
        ProgressBarB.Position := I;
        ProgressBarB.Update;

      end;
    end);

  A.Start;
  B.Start;
end;

end.
