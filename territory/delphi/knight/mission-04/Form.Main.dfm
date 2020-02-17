object Main: TMain
  Left = 0
  Top = 0
  Caption = 'Main'
  ClientHeight = 600
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBoxPaths: TGroupBox
    Left = 0
    Top = 0
    Width = 800
    Height = 149
    Align = alTop
    Caption = 'Paths'
    TabOrder = 0
    object EditPathA: TLabeledEdit
      Left = 38
      Top = 34
      Width = 327
      Height = 21
      EditLabel.Width = 31
      EditLabel.Height = 13
      EditLabel.Caption = 'Path 1'
      TabOrder = 0
    end
    object EditPathB: TLabeledEdit
      Left = 38
      Top = 78
      Width = 327
      Height = 21
      EditLabel.Width = 31
      EditLabel.Height = 13
      EditLabel.Caption = 'Path 2'
      TabOrder = 1
    end
    object EditPathC: TLabeledEdit
      Left = 38
      Top = 118
      Width = 327
      Height = 21
      EditLabel.Width = 31
      EditLabel.Height = 13
      EditLabel.Caption = 'Path 3'
      TabOrder = 2
    end
    object ButtonPathA: TButton
      Left = 371
      Top = 32
      Width = 25
      Height = 25
      Action = ActionSelectPathA
      TabOrder = 3
    end
    object ButtonPathB: TButton
      Left = 371
      Top = 76
      Width = 25
      Height = 25
      Action = ActionSelectPathB
      TabOrder = 4
    end
    object ButtonPathC: TButton
      Left = 371
      Top = 116
      Width = 25
      Height = 25
      Action = ActionSelectPathC
      TabOrder = 5
    end
    object ButtonListFiles: TButton
      Left = 510
      Top = 44
      Width = 75
      Height = 25
      Action = ActionListFiles
      TabOrder = 6
    end
    object Button1: TButton
      Left = 674
      Top = 96
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 7
    end
  end
  object MemoFilesA: TMemo
    Left = 0
    Top = 149
    Width = 267
    Height = 451
    Align = alLeft
    TabOrder = 1
  end
  object MemoFilesB: TMemo
    Left = 267
    Top = 149
    Width = 266
    Height = 451
    Align = alLeft
    TabOrder = 2
  end
  object MemoFilesC: TMemo
    Left = 533
    Top = 149
    Width = 267
    Height = 451
    Align = alLeft
    TabOrder = 3
  end
  object ActionList: TActionList
    Left = 570
    Top = 64
    object ActionSelectPathA: TAction
      OnExecute = ActionSelectPathAExecute
    end
    object ActionSelectPathB: TAction
      OnExecute = ActionSelectPathBExecute
    end
    object ActionSelectPathC: TAction
      OnExecute = ActionSelectPathCExecute
    end
    object ActionListFiles: TAction
      Caption = '&List files'
      OnExecute = ActionListFilesExecute
    end
  end
end
