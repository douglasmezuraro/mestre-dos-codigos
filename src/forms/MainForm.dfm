object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 187
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu: TMainMenu
    Left = 136
    Top = 56
    object Exerccio11: TMenuItem
      Action = ActionExerciseOne
    end
  end
  object ActionList: TActionList
    Left = 96
    Top = 104
    object ActionExerciseOne: TAction
      Caption = 'Exerc'#237'cio 1'
      OnExecute = ActionExerciseOneExecute
    end
  end
end
