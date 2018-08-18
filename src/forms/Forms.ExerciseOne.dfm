object ExerciseOne: TExerciseOne
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Exerc'#237'cio 1'
  ClientHeight = 407
  ClientWidth = 574
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonInsert: TButton
    Left = 480
    Top = 30
    Width = 75
    Height = 25
    Action = ActionInsert
    TabOrder = 0
  end
  object ButtonRemove: TButton
    Left = 480
    Top = 61
    Width = 75
    Height = 25
    Action = ActionRemove
    TabOrder = 1
  end
  object ActionList: TActionList
    Left = 480
    Top = 136
    object ActionInsert: TAction
      Caption = 'Inserir'
    end
    object ActionRemove: TAction
      Caption = 'Remover'
    end
    object ActionIndexExit: TAction
      Caption = 'ActionIndexExit'
    end
  end
end
