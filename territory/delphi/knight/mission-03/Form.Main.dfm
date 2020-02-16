object Main: TMain
  Left = 0
  Top = 0
  ActiveControl = ButtonCompress
  BorderIcons = [biSystemMenu]
  Caption = 'Delphi Knight - Mission 03'
  ClientHeight = 110
  ClientWidth = 340
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
  object ButtonCompress: TButton
    Left = 102
    Top = 65
    Width = 145
    Height = 25
    Action = ActionCompress
    TabOrder = 0
  end
  object ProgressBarCompression: TProgressBar
    Left = 20
    Top = 20
    Width = 300
    Height = 25
    TabOrder = 1
  end
  object ActionList: TActionList
    Left = 36
    Top = 48
    object ActionCompress: TAction
      Caption = '&Compress files'
      OnExecute = ActionCompressExecute
    end
  end
end
