object Main: TMain
  Left = 0
  Top = 0
  Caption = 'E-mail sender'
  ClientHeight = 497
  ClientWidth = 635
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
    Width = 635
    Height = 456
    ActivePage = TabSheetConfiguration
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 421
    object TabSheetMessage: TTabSheet
      Caption = 'Message'
      ExplicitHeight = 393
      object LabelBody: TLabel
        Left = 20
        Top = 103
        Width = 24
        Height = 13
        Caption = 'Body'
        FocusControl = MemoBody
      end
      object MemoBody: TMemo
        Left = 20
        Top = 120
        Width = 427
        Height = 261
        TabOrder = 0
      end
      object EditSubject: TLabeledEdit
        Left = 20
        Top = 23
        Width = 427
        Height = 21
        EditLabel.Width = 36
        EditLabel.Height = 13
        EditLabel.Caption = 'Subject'
        TabOrder = 1
      end
      object EditRecepients: TLabeledEdit
        Left = 20
        Top = 68
        Width = 427
        Height = 21
        EditLabel.Width = 53
        EditLabel.Height = 13
        EditLabel.Caption = 'Recepients'
        TabOrder = 2
      end
    end
    object TabSheetConfiguration: TTabSheet
      Caption = 'Configuration'
      ExplicitHeight = 393
      object LabelUseTLS: TLabel
        Left = 14
        Top = 188
        Width = 38
        Height = 13
        Caption = 'Use TLS'
        FocusControl = ComboBoxUseTLS
      end
      object LabelAuthType: TLabel
        Left = 14
        Top = 231
        Width = 48
        Height = 13
        Caption = 'Auth type'
        FocusControl = ComboBoxAuthType
      end
      object EditHost: TLabeledEdit
        Left = 14
        Top = 24
        Width = 427
        Height = 21
        EditLabel.Width = 22
        EditLabel.Height = 13
        EditLabel.Caption = 'Host'
        TabOrder = 0
      end
      object EditUsername: TLabeledEdit
        Left = 14
        Top = 66
        Width = 427
        Height = 21
        EditLabel.Width = 48
        EditLabel.Height = 13
        EditLabel.Caption = 'Username'
        TabOrder = 1
      end
      object EditPassword: TLabeledEdit
        Left = 14
        Top = 113
        Width = 427
        Height = 21
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'Password'
        PasswordChar = '*'
        TabOrder = 2
      end
      object EditPort: TLabeledEdit
        Left = 14
        Top = 158
        Width = 427
        Height = 21
        EditLabel.Width = 20
        EditLabel.Height = 13
        EditLabel.Caption = 'Port'
        NumbersOnly = True
        TabOrder = 3
      end
      object GroupBoxSSL: TGroupBox
        Left = 14
        Top = 284
        Width = 427
        Height = 135
        Caption = 'SSL'
        TabOrder = 4
        object LabelSSLMethod: TLabel
          Left = 12
          Top = 21
          Width = 36
          Height = 13
          Caption = 'Method'
          FocusControl = ComboBoxMethod
        end
        object LabelSSLMode: TLabel
          Left = 12
          Top = 70
          Width = 26
          Height = 13
          Caption = 'Mode'
        end
        object ComboBoxMethod: TComboBox
          Left = 12
          Top = 40
          Width = 387
          Height = 21
          Style = csDropDownList
          TabOrder = 0
        end
        object ComboBoxMode: TComboBox
          Left = 12
          Top = 89
          Width = 387
          Height = 21
          Style = csDropDownList
          TabOrder = 1
        end
      end
      object ComboBoxUseTLS: TComboBox
        Left = 14
        Top = 204
        Width = 427
        Height = 21
        Style = csDropDownList
        TabOrder = 5
      end
      object ComboBoxAuthType: TComboBox
        Left = 14
        Top = 246
        Width = 427
        Height = 21
        Style = csDropDownList
        TabOrder = 6
      end
    end
  end
  object Panel: TPanel
    Left = 0
    Top = 456
    Width = 635
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 421
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
