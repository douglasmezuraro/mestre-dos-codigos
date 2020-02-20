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
  object EditURL: TLabeledEdit
    Left = 54
    Top = 58
    Width = 385
    Height = 21
    EditLabel.Width = 19
    EditLabel.Height = 13
    EditLabel.Caption = 'URL'
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
    Left = 54
    Top = 104
    Width = 475
    Height = 25
    TabOrder = 2
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
