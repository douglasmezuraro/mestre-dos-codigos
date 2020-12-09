object Main: TMain
  Left = 0
  Top = 0
  Caption = 'E-mail sender'
  ClientHeight = 497
  ClientWidth = 600
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 600
    Height = 456
    ActivePage = TabSheetConfiguration
    Align = alClient
    TabOrder = 0
    object TabSheetMessage: TTabSheet
      Caption = 'Message'
      object LabelBody: TLabel
        Left = 15
        Top = 99
        Width = 24
        Height = 13
        Caption = 'Body'
        FocusControl = MemoBody
      end
      object MemoBody: TMemo
        Left = 15
        Top = 114
        Width = 563
        Height = 301
        TabOrder = 0
      end
      object EditSubject: TLabeledEdit
        Left = 15
        Top = 23
        Width = 563
        Height = 21
        EditLabel.Width = 36
        EditLabel.Height = 13
        EditLabel.Caption = 'Subject'
        TabOrder = 1
      end
      object EditRecepients: TLabeledEdit
        Left = 15
        Top = 68
        Width = 563
        Height = 21
        EditLabel.Width = 53
        EditLabel.Height = 13
        EditLabel.Caption = 'Recepients'
        TabOrder = 2
      end
    end
    object TabSheetConfiguration: TTabSheet
      Caption = 'Configuration'
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
        Width = 563
        Height = 21
        EditLabel.Width = 22
        EditLabel.Height = 13
        EditLabel.Caption = 'Host'
        TabOrder = 0
      end
      object EditUsername: TLabeledEdit
        Left = 15
        Top = 68
        Width = 563
        Height = 21
        EditLabel.Width = 48
        EditLabel.Height = 13
        EditLabel.Caption = 'Username'
        TabOrder = 1
      end
      object EditPassword: TLabeledEdit
        Left = 15
        Top = 112
        Width = 563
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
        Width = 563
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
        Width = 563
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
          Width = 530
          Height = 21
          Style = csDropDownList
          TabOrder = 0
        end
        object ComboBoxIdSSLMode: TComboBox
          Left = 15
          Top = 85
          Width = 530
          Height = 21
          Style = csDropDownList
          TabOrder = 1
        end
      end
      object ComboBoxIdUseTLS: TComboBox
        Left = 15
        Top = 201
        Width = 563
        Height = 21
        Style = csDropDownList
        TabOrder = 5
      end
      object ComboBoxIdSMTPAuthenticationType: TComboBox
        Left = 15
        Top = 246
        Width = 563
        Height = 21
        Style = csDropDownList
        TabOrder = 6
      end
    end
  end
  object Panel: TPanel
    Left = 0
    Top = 456
    Width = 600
    Height = 41
    Align = alBottom
    TabOrder = 1
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
  end
end
