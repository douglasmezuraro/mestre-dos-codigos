object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Calculadora geom'#233'trica'
  ClientHeight = 424
  ClientWidth = 420
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object RadioGroupGeometricFigure: TRadioGroup
    Left = 5
    Top = 4
    Width = 200
    Height = 100
    Caption = 'Figura geom'#233'trica'
    TabOrder = 0
    TabStop = True
    OnClick = RadioGroupGeometricFigureClick
  end
  object EditInputA: TLabeledEdit
    Left = 110
    Top = 128
    Width = 200
    Height = 21
    EditLabel.Width = 39
    EditLabel.Height = 13
    EditLabel.Caption = 'Runtime'
    NumbersOnly = True
    TabOrder = 2
  end
  object RadioGroupCalculationType: TRadioGroup
    Left = 210
    Top = 5
    Width = 200
    Height = 100
    Caption = 'Tipo de c'#225'lculo'
    TabOrder = 1
    TabStop = True
  end
  object EditInputB: TLabeledEdit
    Left = 110
    Top = 179
    Width = 200
    Height = 21
    EditLabel.Width = 39
    EditLabel.Height = 13
    EditLabel.Caption = 'Runtime'
    NumbersOnly = True
    TabOrder = 3
  end
  object EditOutput: TLabeledEdit
    Left = 110
    Top = 260
    Width = 200
    Height = 21
    EditLabel.Width = 48
    EditLabel.Height = 13
    EditLabel.Caption = 'Resultado'
    NumbersOnly = True
    ReadOnly = True
    TabOrder = 5
  end
  object ButtonCalculate: TButton
    Left = 155
    Top = 213
    Width = 100
    Height = 25
    Action = ActionCalculate
    TabOrder = 4
  end
  object MemoOutput: TMemo
    Left = 0
    Top = 296
    Width = 420
    Height = 128
    Align = alBottom
    TabOrder = 6
  end
  object ActionList: TActionList
    Left = 32
    Top = 160
    object ActionCalculate: TAction
      Caption = '&Calcular'
      OnExecute = ActionCalculateExecute
    end
  end
end
