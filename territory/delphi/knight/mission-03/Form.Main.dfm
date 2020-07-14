object Main: TMain
  Left = 0
  Top = 0
  ActiveControl = ButtonCompress
  BorderIcons = [biSystemMenu]
  Caption = 'Delphi Knight - Mission 03'
  ClientHeight = 370
  ClientWidth = 677
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
    Left = 498
    Top = 65
    Width = 145
    Height = 25
    Action = ActionCompress
    TabOrder = 0
  end
  object ProgressBarCompression: TProgressBar
    Left = 148
    Top = 303
    Width = 300
    Height = 25
    TabOrder = 1
  end
  object MemoFiles: TMemo
    Left = 24
    Top = 20
    Width = 463
    Height = 183
    TabOrder = 2
  end
  object ButtonSelectFiles: TButton
    Left = 526
    Top = 34
    Width = 75
    Height = 25
    Action = ActionSelectFiles
    TabOrder = 3
  end
  object EditFileName: TEdit
    Left = 24
    Top = 216
    Width = 463
    Height = 21
    TabOrder = 4
  end
  object ButtonSelectFileName: TButton
    Left = 502
    Top = 214
    Width = 75
    Height = 25
    Action = ActionSelectFileName
    TabOrder = 5
  end
  object ActionList: TActionList
    Left = 36
    Top = 48
    object ActionCompress: TAction
      Caption = '&Compress files'
      OnExecute = ActionCompressExecute
    end
    object ActionSelectFiles: TAction
      Caption = '&Select files'
      OnExecute = ActionSelectFilesExecute
    end
    object ActionSelectFileName: TAction
      Caption = 'Save as'
      OnExecute = ActionSelectFileNameExecute
    end
  end
end
