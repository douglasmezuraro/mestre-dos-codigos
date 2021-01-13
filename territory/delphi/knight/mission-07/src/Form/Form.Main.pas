unit Form.Main;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ActnList,
  Vcl.ComCtrls, System.Actions, System.UITypes, Vcl.Dialogs, Vcl.Buttons, System.ImageList, Vcl.ImgList,
  Email;

type
  TMain = class sealed(TForm)
  {$REGION 'Components'}
    ActionList: TActionList;
    ActionSend: TAction;
    ComboBoxIdSMTPAuthenticationType: TComboBox;
    ComboBoxIdSSLVersion: TComboBox;
    ComboBoxIdSSLMode: TComboBox;
    ComboBoxIdUseTLS: TComboBox;
    EditHost: TLabeledEdit;
    EditPassword: TLabeledEdit;
    EditPort: TLabeledEdit;
    EditRicipients: TLabeledEdit;
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
    EditCC: TLabeledEdit;
    EditBCC: TLabeledEdit;
    ActionSelectAttachments: TAction;
    ListBoxAttachments: TListBox;
    ButtonSelectAttachments: TSpeedButton;
    LabelAttachments: TLabel;
    ImageList: TImageList;
    ButtonSend: TSpeedButton;
  {$ENDREGION}
    procedure ActionSendExecute(ASender: TObject);
    procedure FormShow(ASender: TObject);
    procedure ActionSelectAttachmentsExecute(ASender: TObject);
  private
    procedure Send;
    function GetDTO: TEmailDTO;
    function SelectAttachments: TArray<string>;
  public
    procedure AfterConstruction; override;
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

procedure TMain.ActionSelectAttachmentsExecute(ASender: TObject);
begin
  ListBoxAttachments.Items.AddStrings(SelectAttachments);
end;

procedure TMain.ActionSendExecute(ASender: TObject);
begin
  Send;
end;

procedure TMain.AfterConstruction;
begin
  inherited;
  ComboBoxIdSSLVersion.Items.AddStrings(TIdSSLVersion.ToStringArray);
  ComboBoxIdSSLMode.Items.AddStrings(TIdSSLMode.ToStringArray);
  ComboBoxIdUseTLS.Items.AddStrings(TIdUseTLS.ToStringArray);
  ComboBoxIdSMTPAuthenticationType.Items.AddStrings(TIdSMTPAuthenticationType.ToStringArray);
end;

procedure TMain.FormShow(ASender: TObject);
begin
  PageControl.ActivePage := TabSheetMessage;
  EditHost.Text := 'smtp.office365.com';
  EditUsername.Text := 'douglas.mezuraro@db1.com.br';
  EditPort.Text := 587.ToString;
  EditSubject.Text := 'E-mail test';
  EditRicipients.Text := 'douglas.mezuraro@db1.com.br, douglasmez@gmail.com';
  MemoBody.Lines.AddStrings(['Mission 07', 'Author: Douglas Mezuraro', 'Last Modification: 09/12/2020']);
  ComboBoxIdSSLVersion.ItemIndex := TIdSSLVersion.sslvTLSv1_2.ToInteger;
  ComboBoxIdSSLMode.ItemIndex := TIdSSLMode.sslmUnassigned.ToInteger;
  ComboBoxIdSMTPAuthenticationType.ItemIndex := TIdSMTPAuthenticationType.satDefault.ToInteger;
  ComboBoxIdUseTLS.ItemIndex := TIdUseTLS.utUseExplicitTLS.ToInteger;
end;

function TMain.GetDTO: TEmailDTO;
var
  LDTO: TEmailDTO;
begin
  LDTO.Host := EditHost.Text;
  LDTO.Username := EditUsername.Text;
  LDTO.Password := TCryptography.Decrypt(EditPassword.Text);
  LDTO.Port := StrToIntDef(EditPort.Text, 0);
  LDTO.Subject := EditSubject.Text;
  LDTO.Recipients := EditRicipients.Text;
  LDTO.CC := EditCC.Text;
  LDTO.BCC := EditBCC.Text;
  LDTO.Body := MemoBody.Lines.ToStringArray;
  LDTO.Attachments := ListBoxAttachments.Items.ToStringArray;
  LDTO.IdSSLVersion := TIdSSLVersion.Parse(ComboBoxIdSSLVersion.ItemIndex);
  LDTO.IdSSLMode := TIdSSLMode.Parse(ComboBoxIdSSLMode.ItemIndex);
  LDTO.IdUseTLS := TIdUseTLS.Parse(ComboBoxIdUseTLS.ItemIndex);
  LDTO.IdSMTPAuthenticationType := TIdSMTPAuthenticationType.Parse(ComboBoxIdSMTPAuthenticationType.ItemIndex);

  Result := LDTO;
end;

function TMain.SelectAttachments: TArray<string>;
var
  LDialog: TOpenDialog;
begin
  LDialog := TOpenDialog.Create(Self);
  try
    LDialog.Options := [ofAllowMultiSelect, ofFileMustExist];

    if LDialog.Execute then
    begin
      Exit(LDialog.Files.ToStringArray);
    end;

    Result := nil;
  finally
    LDialog.Free;
  end;
end;

procedure TMain.Send;
begin
  TThread.CreateAnonymousThread(
    procedure
    var
      LSender: TEmailSender;
    begin
      try
        LSender := TEmailSender.Create(GetDTO);
        try
          LSender.Send;
        finally
          LSender.Free;
        end;
      except
        on E: Exception do
        begin
          MessageDlg(E.Message, TMsgDlgType.mtWarning, mbOKCancel, 0);
        end;
      end;
    end).Start;
end;

end.

