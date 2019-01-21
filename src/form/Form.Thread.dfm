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
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ProgressBarA: TProgressBar
    Left = 16
    Top = 40
    Width = 150
    Height = 17
    TabOrder = 0
  end
  object ProgressBarB: TProgressBar
    Left = 16
    Top = 72
    Width = 150
    Height = 17
    TabOrder = 1
  end
  object ButtonStart: TButton
    Left = 272
    Top = 40
    Width = 97
    Height = 25
    Action = ActionStart
    TabOrder = 2
  end
  object ButtonPause: TButton
    Left = 264
    Top = 104
    Width = 75
    Height = 25
    Action = ActionPause
    TabOrder = 3
  end
  object ActionList: TActionList
    Left = 288
    Top = 48
    object ActionStart: TAction
      Caption = '&Iniciar download'
      OnExecute = ActionStartExecute
    end
    object ActionPause: TAction
      Caption = '&Pause'
      OnExecute = ActionPauseExecute
    end
  end
end
