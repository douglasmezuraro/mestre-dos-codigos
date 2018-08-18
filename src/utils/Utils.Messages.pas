unit Utils.Messages;

interface

uses
  System.UITypes,
  Vcl.Dialogs;

type
  TMessage = class
  private
    const UNDEFINED_HELP_CTX = -1;
  public
    class procedure Information(const Message: string);
    class procedure Warning(const Message: string);
    class procedure Error(const Message: string);
    class function Confirmation(const Message: string): Boolean;
  end;

implementation

{ TMessage }

class function TMessage.Confirmation(const Message: string): Boolean;
begin
  Result := MessageDlg(Message, mtConfirmation, [mbYes, mbNo], UNDEFINED_HELP_CTX) = mrYes;
end;

class procedure TMessage.Error(const Message: string);
begin
  MessageDlg(Message, mtError, [mbOK], UNDEFINED_HELP_CTX);
end;

class procedure TMessage.Information(const Message: string);
begin
  MessageDlg(Message, mtInformation, [mbOK], UNDEFINED_HELP_CTX);
end;

class procedure TMessage.Warning(const Message: string);
begin
  MessageDlg(Message, mtWarning, [mbOK], UNDEFINED_HELP_CTX);
end;

end.
