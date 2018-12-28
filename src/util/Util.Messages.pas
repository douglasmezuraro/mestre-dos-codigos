unit Util.Messages;

interface

uses
  System.UITypes,
  System.SysUtils,
  Vcl.Dialogs;

type
  TMessage = class
  private
    const UNDEFINED_HELP_CTX = -1;
  public
    class procedure Information(const Message: string; const Args: array of const); overload;
    class procedure Information(const Message: string); overload;

    class procedure Warning(const Message: string; const Args: array of const); overload;
    class procedure Warning(const Message: string); overload;

    class procedure Error(const Message: string; const Args: array of const); overload;
    class procedure Error(const Message: string); overload;

    class function Confirmation(const Message: string; const Args: array of const): Boolean; overload;
    class function Confirmation(const Message: string): Boolean; overload;
  end;

implementation

{ TMessage }

class function TMessage.Confirmation(const Message: string; const Args: array of const): Boolean;
begin
  Result := Self.Confirmation(Format(Message, Args));
end;

class function TMessage.Confirmation(const Message: string): Boolean;
begin
  Result := MessageDlg(Message, mtConfirmation, [mbYes, mbNo], UNDEFINED_HELP_CTX) = mrYes;
end;

class procedure TMessage.Error(const Message: string; const Args: array of const);
begin
  Self.Error(Format(Message, Args));
end;

class procedure TMessage.Error(const Message: string);
begin
  MessageDlg(Message, mtError, [mbOK], UNDEFINED_HELP_CTX);
end;

class procedure TMessage.Information(const Message: string; const Args: array of const);
begin
  Self.Information(Format(Message, Args));
end;

class procedure TMessage.Information(const Message: string);
begin
  MessageDlg(Message, mtInformation, [mbOK], UNDEFINED_HELP_CTX);
end;

class procedure TMessage.Warning(const Message: string; const Args: array of const);
begin
  Self.Warning(Format(Message, Args));
end;

class procedure TMessage.Warning(const Message: string);
begin
  MessageDlg(Message, mtWarning, [mbOK], UNDEFINED_HELP_CTX);
end;

end.
