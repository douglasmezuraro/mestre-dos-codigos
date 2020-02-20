object Main: TMain
  Left = 0
  Top = 0
  Caption = 'Main'
  ClientHeight = 177
  ClientWidth = 584
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object EditSource: TLabeledEdit
    Left = 54
    Top = 48
    Width = 385
    Height = 21
    EditLabel.Width = 33
    EditLabel.Height = 13
    EditLabel.Caption = 'Source'
    TabOrder = 0
  end
  object ButtonDownload: TButton
    Left = 454
    Top = 56
    Width = 75
    Height = 25
    Action = ActionDownload
    TabOrder = 1
  end
  object ProgressBar: TProgressBar
    Left = 50
    Top = 130
    Width = 475
    Height = 25
    TabOrder = 2
  end
  object EditTarget: TLabeledEdit
    Left = 54
    Top = 90
    Width = 385
    Height = 21
    EditLabel.Width = 32
    EditLabel.Height = 13
    EditLabel.Caption = 'Target'
    TabOrder = 3
  end
  object ActionList: TActionList
    Left = 514
    Top = 178
    object ActionDownload: TAction
      Caption = '&Download'
      OnExecute = ActionDownloadExecute
    end
  end
end
