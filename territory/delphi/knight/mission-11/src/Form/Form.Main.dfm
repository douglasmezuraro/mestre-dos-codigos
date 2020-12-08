object Main: TMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Consulta de endere'#231'os'
  ClientHeight = 275
  ClientWidth = 449
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBoxAddress: TGroupBox
    Left = 15
    Top = 82
    Width = 419
    Height = 177
    Caption = 'Endere'#231'o'
    TabOrder = 0
    object EditAddress: TLabeledEdit
      Left = 26
      Top = 40
      Width = 365
      Height = 21
      EditLabel.Width = 55
      EditLabel.Height = 13
      EditLabel.Caption = 'Logradouro'
      ReadOnly = True
      TabOrder = 0
    end
    object EditNeibourhood: TLabeledEdit
      Left = 26
      Top = 86
      Width = 365
      Height = 21
      EditLabel.Width = 28
      EditLabel.Height = 13
      EditLabel.Caption = 'Bairro'
      ReadOnly = True
      TabOrder = 1
    end
    object EditCity: TLabeledEdit
      Left = 26
      Top = 132
      Width = 299
      Height = 21
      EditLabel.Width = 33
      EditLabel.Height = 13
      EditLabel.Caption = 'Cidade'
      ReadOnly = True
      TabOrder = 2
    end
    object EditUF: TLabeledEdit
      Left = 332
      Top = 132
      Width = 57
      Height = 21
      EditLabel.Width = 13
      EditLabel.Height = 13
      EditLabel.Caption = 'UF'
      ReadOnly = True
      TabOrder = 3
    end
  end
  object GroupBoxSearch: TGroupBox
    Left = 15
    Top = 15
    Width = 419
    Height = 53
    Caption = 'Busca'
    TabOrder = 1
    object EditCEP: TMaskEdit
      Left = 20
      Top = 20
      Width = 69
      Height = 21
      EditMask = '00000\-000;1;_'
      MaxLength = 9
      TabOrder = 0
      Text = '     -   '
    end
    object ButtonSearch: TButton
      Left = 94
      Top = 18
      Width = 75
      Height = 25
      Action = ActionSearch
      TabOrder = 1
    end
  end
  object ActionList: TActionList
    Left = 520
    Top = 34
    object ActionSearch: TAction
      Caption = '&Buscar'
      OnExecute = ActionSearchExecute
    end
  end
end
