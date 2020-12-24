object Main: TMain
  Left = 0
  Top = 0
  ActiveControl = Grid
  Caption = 'Delphi Knight - Mission 18'
  ClientHeight = 600
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Grid: TDBGrid
    Left = 0
    Top = 0
    Width = 480
    Height = 575
    Align = alClient
    DataSource = DataSource
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'FireDate'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AlertBody'
        Visible = True
      end>
  end
  object dbnvgr1: TDBNavigator
    Left = 0
    Top = 575
    Width = 480
    Height = 25
    Align = alBottom
    TabOrder = 1
    ExplicitLeft = 182
    ExplicitTop = 234
    ExplicitWidth = 240
  end
  object Timer: TTimer
    Enabled = False
    OnTimer = OnTimer
    Left = 75
    Top = 153
  end
  object NotificationCenter: TNotificationCenter
    Left = 384
    Top = 75
  end
  object TrayIcon: TTrayIcon
    OnDblClick = TrayIconDblClick
    Left = 178
    Top = 153
  end
  object DataSet: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'FireDate'
    Params = <>
    AfterPost = DataSetAfterPost
    Left = 178
    Top = 75
    object FieldFireDate: TDateTimeField
      FieldName = 'FireDate'
    end
    object FieldAlertBody: TStringField
      FieldName = 'AlertBody'
      Size = 180
    end
  end
  object DataSource: TDataSource
    DataSet = DataSet
    Left = 281
    Top = 75
  end
  object ApplicationEvents: TApplicationEvents
    OnMinimize = ApplicationEventsMinimize
    Left = 75
    Top = 75
  end
end
