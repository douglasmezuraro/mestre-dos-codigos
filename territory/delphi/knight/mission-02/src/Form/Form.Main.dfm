object Main: TMain
  Left = 0
  Top = 0
  ActiveControl = Grid
  Caption = 'Delphi Knight - Mission 02'
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
  WindowState = wsMaximized
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Grid: TDBGrid
    Left = 0
    Top = 0
    Width = 800
    Height = 600
    Align = alClient
    DataSource = DataSource
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DataSet: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 20
    Top = 44
    object FieldName: TStringField
      FieldName = 'Name'
      Size = 60
    end
    object FieldVersion: TStringField
      FieldName = 'Version'
      Size = 40
    end
    object FieldPublisher: TStringField
      FieldName = 'Publisher'
      Size = 60
    end
  end
  object DataSource: TDataSource
    DataSet = DataSet
    Left = 84
    Top = 44
  end
end
