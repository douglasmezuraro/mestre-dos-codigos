object Main: TMain
  Left = 0
  Top = 0
  ActiveControl = Grid
  Caption = 'Delphi Knight - Mission 18'
  ClientHeight = 380
  ClientWidth = 570
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Grid: TDBGrid
    Left = 0
    Top = 0
    Width = 570
    Height = 380
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
        FieldName = 'Description'
        Visible = True
      end>
  end
  object Timer: TTimer
    Enabled = False
    OnTimer = OnTimer
    Left = 384
    Top = 75
  end
  object NotificationCenter: TNotificationCenter
    Left = 281
    Top = 75
  end
  object TrayIcon: TTrayIcon
    OnDblClick = TrayIconDblClick
    Left = 487
    Top = 75
  end
  object DataSet: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'FireDate'
    Params = <>
    Left = 75
    Top = 75
    object FieldFireDate: TDateTimeField
      FieldName = 'FireDate'
    end
    object FieldDescription: TStringField
      FieldName = 'Description'
      Size = 180
    end
  end
  object DataSource: TDataSource
    DataSet = DataSet
    Left = 178
    Top = 75
  end
  object ApplicationEvents: TApplicationEvents
    OnMinimize = ApplicationEventsMinimize
    Left = 260
    Top = 220
  end
end
