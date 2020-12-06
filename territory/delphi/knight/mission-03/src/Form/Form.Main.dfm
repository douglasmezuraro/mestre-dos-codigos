object Main: TMain
  Left = 0
  Top = 0
  ActiveControl = ButtonCompress
  BorderIcons = [biSystemMenu]
  Caption = 'Delphi Knight - Mission 03'
  ClientHeight = 600
  ClientWidth = 800
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
    Left = 640
    Top = 560
    Width = 145
    Height = 25
    Action = ActionCompress
    TabOrder = 0
  end
  object ProgressBarCompression: TProgressBar
    Left = 15
    Top = 560
    Width = 619
    Height = 25
    TabOrder = 1
  end
  object GroupBoxInput: TGroupBox
    Left = 15
    Top = 15
    Width = 770
    Height = 446
    Caption = 'Input'
    TabOrder = 2
    object MemoFiles: TMemo
      Left = 10
      Top = 15
      Width = 656
      Height = 420
      ReadOnly = True
      TabOrder = 0
    end
    object ButtonSelectFiles: TButton
      Left = 672
      Top = 13
      Width = 75
      Height = 25
      Action = ActionSelectFiles
      TabOrder = 1
    end
  end
  object GroupBox1: TGroupBox
    Left = 15
    Top = 477
    Width = 770
    Height = 68
    Caption = 'Output'
    TabOrder = 3
    object EditFileName: TEdit
      Left = 14
      Top = 26
      Width = 652
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object ButtonSelectFileName: TButton
      Left = 672
      Top = 22
      Width = 75
      Height = 25
      Action = ActionSelectFileName
      TabOrder = 1
    end
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
