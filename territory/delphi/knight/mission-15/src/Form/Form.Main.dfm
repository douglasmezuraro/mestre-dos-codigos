object Main: TMain
  AlignWithMargins = True
  Left = 0
  Top = 0
  Caption = 'Delphi Knight - Mission 15'
  ClientHeight = 600
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Grid: TDBGrid
    Left = 0
    Top = 29
    Width = 800
    Height = 571
    Align = alClient
    DataSource = DataSource
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 800
    Height = 29
    Align = alTop
    TabOrder = 1
    object EditCitie: TEdit
      Left = 1
      Top = 1
      Width = 664
      Height = 27
      Align = alLeft
      TabOrder = 0
    end
    object ButtonSearch: TButton
      Left = 665
      Top = 1
      Width = 134
      Height = 27
      Action = ActionSearch
      Align = alClient
      TabOrder = 1
      ExplicitLeft = 640
      ExplicitTop = 6
      ExplicitWidth = 75
      ExplicitHeight = 25
    end
  end
  object FDMemTableCustomers: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    LocalSQL = FDLocalSQL
    Left = 362
    Top = 50
  end
  object FDMemTableCities: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    LocalSQL = FDLocalSQL
    Left = 440
    Top = 50
  end
  object FDLocalSQL: TFDLocalSQL
    Connection = FDConnection
    DataSets = <
      item
        DataSet = FDMemTableCustomers
        Name = 'CUSTOMERS'
      end
      item
        DataSet = FDMemTableCities
        Name = 'CITIES'
      end>
    Left = 284
    Top = 50
  end
  object DataSource: TDataSource
    DataSet = FDQuery
    Left = 50
    Top = 50
  end
  object FDQuery: TFDQuery
    LocalSQL = FDLocalSQL
    Connection = FDConnection
    SQL.Strings = (
      'SELECT'
      #9'CUSTOMERS.ID AS '#39'Id'#39','
      #9'CUSTOMERS.NOME AS '#39'Pessoa'#39','
      #9'CITIES.NOME AS '#39'Cidade'#39
      'FROM'
      #9'CUSTOMERS'
      'JOIN'
      #9'CITIES ON CITIES.IDCIDADE = CUSTOMERS.IDCIDADE')
    Left = 518
    Top = 50
  end
  object FDStanStorageXMLLink: TFDStanStorageXMLLink
    Left = 596
    Top = 50
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 206
    Top = 50
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 128
    Top = 50
  end
  object ActionList: TActionList
    Left = 454
    Top = 240
    object ActionSearch: TAction
      Caption = 'Search'
      OnExecute = ActionSearchExecute
    end
  end
end
