object Main: TMain
  Left = 0
  Top = 0
  ActiveControl = Grid
  Caption = 'Delphi Knight - Mission 18'
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
  object Grid: TDBGrid
    Left = 0
    Top = 0
    Width = 800
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
        Width = 650
        Visible = True
      end>
  end
  object DBNavigator: TDBNavigator
    Left = 0
    Top = 575
    Width = 800
    Height = 25
    DataSource = DataSource
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 0
    ExplicitWidth = 480
  end
  object Timer: TTimer
    Enabled = False
    OnTimer = OnTimer
    Left = 487
    Top = 75
  end
  object NotificationCenter: TNotificationCenter
    OnReceiveLocalNotification = OnReceiveLocalNotification
    Left = 384
    Top = 75
  end
  object TrayIcon: TTrayIcon
    OnDblClick = OnTrayIconDblClick
    Left = 590
    Top = 75
  end
  object DataSet: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'FireDate'
    Params = <>
    AfterPost = OnDataSetAfterPost
    Left = 178
    Top = 75
    object FieldFireDate: TDateTimeField
      FieldName = 'FireDate'
      Required = True
    end
    object FieldAlertBody: TStringField
      FieldName = 'AlertBody'
      Required = True
      Size = 180
    end
  end
  object DataSource: TDataSource
    DataSet = DataSet
    Left = 281
    Top = 75
  end
  object ApplicationEvents: TApplicationEvents
    OnMinimize = OnMinimize
    Left = 75
    Top = 75
  end
end
