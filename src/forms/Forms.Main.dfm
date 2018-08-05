object Main: TMain
  Left = 0
  Top = 0
  Caption = 'Mestre dos C'#243'digos'
  ClientHeight = 600
  ClientWidth = 800
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
    Left = 16
    Top = 52
    object MenuItemExerciseOne: TMenuItem
      Action = ActionExerciseOne
    end
  end
  object ActionList: TActionList
    Left = 16
    Top = 8
    object ActionExerciseOne: TAction
      Caption = 'Exerc'#237'cio 1'
      OnExecute = ActionExerciseOneExecute
    end
  end
end
