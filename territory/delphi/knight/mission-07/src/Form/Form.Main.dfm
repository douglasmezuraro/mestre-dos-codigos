object Main: TMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'E-mail sender'
  ClientHeight = 600
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 800
    Height = 559
    ActivePage = TabSheetMessage
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 600
    ExplicitHeight = 456
    object TabSheetMessage: TTabSheet
      Caption = 'Message'
      ExplicitTop = 23
      object LabelBody: TLabel
        Left = 15
        Top = 187
        Width = 24
        Height = 13
        Caption = 'Body'
        FocusControl = MemoBody
      end
      object ButtonSelectAttachments: TSpeedButton
        Left = 760
        Top = 390
        Width = 23
        Height = 22
        Action = ActionSelectAttachments
      end
      object LabelAttachments: TLabel
        Left = 15
        Top = 373
        Width = 61
        Height = 13
        Caption = 'Attachments'
      end
      object MemoBody: TMemo
        Left = 15
        Top = 206
        Width = 764
        Height = 155
        TabOrder = 0
      end
      object EditSubject: TLabeledEdit
        Left = 15
        Top = 23
        Width = 764
        Height = 21
        EditLabel.Width = 36
        EditLabel.Height = 13
        EditLabel.Caption = 'Subject'
        TabOrder = 1
      end
      object EditRicipients: TLabeledEdit
        Left = 15
        Top = 68
        Width = 764
        Height = 21
        EditLabel.Width = 45
        EditLabel.Height = 13
        EditLabel.Caption = 'Ricipients'
        TabOrder = 2
      end
      object EditCC: TLabeledEdit
        Left = 15
        Top = 112
        Width = 764
        Height = 21
        EditLabel.Width = 14
        EditLabel.Height = 13
        EditLabel.Caption = 'CC'
        TabOrder = 3
      end
      object EditBCC: TLabeledEdit
        Left = 15
        Top = 156
        Width = 764
        Height = 21
        EditLabel.Width = 20
        EditLabel.Height = 13
        EditLabel.Caption = 'BCC'
        TabOrder = 4
      end
      object ListBoxAttachments: TListBox
        Left = 15
        Top = 392
        Width = 735
        Height = 123
        ItemHeight = 13
        TabOrder = 5
      end
    end
    object TabSheetConfiguration: TTabSheet
      Caption = 'Configuration'
      ExplicitWidth = 592
      ExplicitHeight = 428
      object LabelUseTLS: TLabel
        Left = 15
        Top = 188
        Width = 38
        Height = 13
        Caption = 'Use TLS'
        FocusControl = ComboBoxIdUseTLS
      end
      object LabeIdSMTPAuthenticationType: TLabel
        Left = 15
        Top = 231
        Width = 48
        Height = 13
        Caption = 'Auth type'
        FocusControl = ComboBoxIdSMTPAuthenticationType
      end
      object EditHost: TLabeledEdit
        Left = 15
        Top = 23
        Width = 764
        Height = 21
        EditLabel.Width = 22
        EditLabel.Height = 13
        EditLabel.Caption = 'Host'
        TabOrder = 0
      end
      object EditUsername: TLabeledEdit
        Left = 15
        Top = 68
        Width = 764
        Height = 21
        EditLabel.Width = 48
        EditLabel.Height = 13
        EditLabel.Caption = 'Username'
        TabOrder = 1
      end
      object EditPassword: TLabeledEdit
        Left = 15
        Top = 112
        Width = 764
        Height = 21
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'Password'
        PasswordChar = '*'
        TabOrder = 2
      end
      object EditPort: TLabeledEdit
        Left = 15
        Top = 157
        Width = 764
        Height = 21
        EditLabel.Width = 20
        EditLabel.Height = 13
        EditLabel.Caption = 'Port'
        NumbersOnly = True
        TabOrder = 3
      end
      object GroupBoxSSL: TGroupBox
        Left = 15
        Top = 284
        Width = 764
        Height = 127
        Caption = 'SSL'
        TabOrder = 4
        object LabelIdSSLVersion: TLabel
          Left = 15
          Top = 21
          Width = 35
          Height = 13
          Caption = 'Version'
          FocusControl = ComboBoxIdSSLVersion
        end
        object LabelIdSSLMode: TLabel
          Left = 15
          Top = 70
          Width = 26
          Height = 13
          Caption = 'Mode'
        end
        object ComboBoxIdSSLVersion: TComboBox
          Left = 15
          Top = 36
          Width = 732
          Height = 21
          Style = csDropDownList
          TabOrder = 0
        end
        object ComboBoxIdSSLMode: TComboBox
          Left = 15
          Top = 85
          Width = 732
          Height = 21
          Style = csDropDownList
          TabOrder = 1
        end
      end
      object ComboBoxIdUseTLS: TComboBox
        Left = 15
        Top = 201
        Width = 764
        Height = 21
        Style = csDropDownList
        TabOrder = 5
      end
      object ComboBoxIdSMTPAuthenticationType: TComboBox
        Left = 15
        Top = 246
        Width = 764
        Height = 21
        Style = csDropDownList
        TabOrder = 6
      end
    end
  end
  object Panel: TPanel
    Left = 0
    Top = 559
    Width = 800
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 456
    ExplicitWidth = 600
    object ButtonSendEmail: TButton
      Left = 1
      Top = 1
      Width = 100
      Height = 39
      Action = ActionSendEmail
      Align = alLeft
      TabOrder = 0
    end
  end
  object ActionList: TActionList
    Left = 502
    Top = 34
    object ActionSendEmail: TAction
      Caption = '&Send e-mail'
      OnExecute = ActionSendEmailExecute
    end
    object ActionSelectAttachments: TAction
      OnExecute = ActionSelectAttachmentsExecute
    end
  end
end
