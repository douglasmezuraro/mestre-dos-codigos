unit Form.Main;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ActnList,
  Vcl.ComCtrls, System.Actions, System.UITypes, Vcl.Dialogs, Email.Wrapper, Impl.Cryptography;

type
  TMain = class sealed(TForm)
  {$REGION 'Visual Components'}
    ActionList: TActionList;
    ActionSendEmail: TAction;
    ButtonSendEmail: TButton;
    ComboBoxIdSMTPAuthenticationType: TComboBox;
    ComboBoxIdSSLVersion: TComboBox;
    ComboBoxIdSSLMode: TComboBox;
    ComboBoxIdUseTLS: TComboBox;
    EditHost: TLabeledEdit;
    EditPassword: TLabeledEdit;
    EditPort: TLabeledEdit;
    EditRecepients: TLabeledEdit;
    EditSubject: TLabeledEdit;
    EditUsername: TLabeledEdit;
    GroupBoxSSL: TGroupBox;
    LabeIdSMTPAuthenticationType: TLabel;
    LabelBody: TLabel;
    LabelIdSSLVersion: TLabel;
    LabelIdSSLMode: TLabel;
    LabelUseTLS: TLabel;
    MemoBody: TMemo;
    PageControl: TPageControl;
    Panel: TPanel;
    TabSheetConfiguration: TTabSheet;
    TabSheetMessage: TTabSheet;
  {$ENDREGION}
    procedure ActionSendEmailExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure SendEmail;
  public
    procedure AfterConstruction; override;

  end;

var
  Main: TMain;

implementation

{$R *.dfm}

procedure TMain.ActionSendEmailExecute(Sender: TObject);
begin
  SendEmail;
end;

procedure TMain.AfterConstruction;
begin
  inherited;
  PageControl.ActivePage := TabSheetMessage;
  ComboBoxIdSSLVersion.Items.AddStrings(TIdSSLVersion.ToStringArray);
  ComboBoxIdSSLMode.Items.AddStrings(TIdSSLMode.ToStringArray);
  ComboBoxIdUseTLS.Items.AddStrings(TIdUseTLS.ToStringArray);
  ComboBoxIdSMTPAuthenticationType.Items.AddStrings(TIdSMTPAuthenticationType.ToStringArray);
end;

procedure TMain.FormShow(Sender: TObject);
begin
  EditHost.Text := 'smtp.gmail.com';
  EditUsername.Text := 'douglasmez@gmail.com';
  EditPort.Text := 465.ToString;
  EditSubject.Text := 'E-mail test';
  EditRecepients.Text := string.Join(', ', ['douglas.mezuraro@db1.com.br', 'douglasmez@gmail.com']);
  MemoBody.Lines.AddStrings(['Mission 07', 'Author: Douglas Mezuraro', 'Last Modification: 28/02/2020']);
  ComboBoxIdSSLVersion.ItemIndex := Ord(TIdSSLVersion.sslvSSLv23);
  ComboBoxIdSSLMode.ItemIndex := Ord(TIdSSLMode.sslmClient);
  ComboBoxIdSMTPAuthenticationType.ItemIndex := Ord(TIdUseTLS.utUseImplicitTLS);
  ComboBoxIdUseTLS.ItemIndex := Ord(TIdSMTPAuthenticationType.satDefault);
end;

procedure TMain.SendEmail;
var
  LDTO: TEmailDTO;
  LSender: TEmailSender;
begin
  LDTO.Host := EditHost.Text;
  LDTO.Username := EditUsername.Text;
  LDTO.Password := TCryptography.Decrypt(EditPassword.Text);
  LDTO.Port := StrToIntDef(EditPort.Text, Word.MinValue);
  LDTO.IdUseTLS := TIdUseTLS(ComboBoxIdUseTLS.ItemIndex);
  LDTO.IdSMTPAuthenticationType := TIdSMTPAuthenticationType(ComboBoxIdSMTPAuthenticationType.ItemIndex);
  LDTO.Subject := EditSubject.Text;
  LDTO.Recipients := string(EditRecepients.Text).Split([', ']);
  LDTO.Body := MemoBody.Lines.ToStringArray;
  LDTO.IdSSLVersion := TIdSSLVersion(ComboBoxIdSSLVersion.ItemIndex);
  LDTO.IdSSLMode := TIdSSLMode(ComboBoxIdSSLMode.ItemIndex);

  try
    LSender := TEmailSender.Create(LDTO);
    try
      LSender.Send;
    finally
      LSender.Free;
    end;
  except
    on Error: EEmailSenderArgumentException do
    begin
      MessageDlg(Error.Message, TMsgDlgType.mtWarning, mbOKCancel, 0);
    end;

    on Error: Exception do
    begin
      MessageDlg('Unhandled Error: ' +Error.Message, TMsgDlgType.mtWarning, mbOKCancel, 0);
    end;
  end;
end;

end.

