object Main: TMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Downloader'
  ClientHeight = 194
  ClientWidth = 430
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object EditSource: TLabeledEdit
    Left = 20
    Top = 30
    Width = 385
    Height = 21
    EditLabel.Width = 33
    EditLabel.Height = 13
    EditLabel.Caption = 'Source'
    TabOrder = 0
  end
  object ButtonDownload: TButton
    Left = 170
    Top = 111
    Width = 75
    Height = 25
    Action = ActionDownload
    TabOrder = 1
  end
  object ProgressBar: TProgressBar
    Left = 20
    Top = 156
    Width = 385
    Height = 25
    TabOrder = 2
  end
  object EditTarget: TLabeledEdit
    Left = 20
    Top = 71
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
