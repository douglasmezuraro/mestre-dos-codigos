object GeometricCalculator: TGeometricCalculator
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Calculadora geom'#233'trica'
  ClientHeight = 196
  ClientWidth = 320
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
    Left = 8
    Top = 8
    Width = 145
    Height = 81
    Caption = 'Figura geom'#233'trica'
    TabOrder = 0
    OnClick = RadioGroupGeometricFigureClick
  end
  object ButtonCalculate: TButton
    Left = 159
    Top = 154
    Width = 145
    Height = 25
    Action = ActionCalculate
    TabOrder = 1
  end
  object EditInputA: TLabeledEdit
    Left = 8
    Top = 112
    Width = 145
    Height = 21
    EditLabel.Width = 39
    EditLabel.Height = 13
    EditLabel.Caption = 'Runtime'
    TabOrder = 2
  end
  object EditOutput: TLabeledEdit
    Left = 8
    Top = 156
    Width = 145
    Height = 21
    EditLabel.Width = 26
    EditLabel.Height = 13
    EditLabel.Caption = 'Sa'#237'da'
    ReadOnly = True
    TabOrder = 3
  end
  object RadioGroupCalculationType: TRadioGroup
    Left = 159
    Top = 8
    Width = 145
    Height = 81
    Caption = 'Tipo de c'#225'lculo'
    TabOrder = 4
  end
  object EditInputB: TLabeledEdit
    Left = 159
    Top = 112
    Width = 146
    Height = 21
    EditLabel.Width = 39
    EditLabel.Height = 13
    EditLabel.Caption = 'Runtime'
    TabOrder = 5
  end
  object ActionList: TActionList
    Left = 376
    Top = 80
    object ActionCalculate: TAction
      Caption = '&Calcular'
      OnExecute = ActionCalculateExecute
    end
  end
end
