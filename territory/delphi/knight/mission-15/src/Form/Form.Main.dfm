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
    Top = 0
    Width = 800
    Height = 600
    Align = alClient
    DataSource = DataSource
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
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
    Left = 188
    Top = 104
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
    Left = 186
    Top = 154
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
    Left = 188
    Top = 210
  end
  object DataSource: TDataSource
    DataSet = FDQuery
    Left = 192
    Top = 52
  end
  object FDQuery: TFDQuery
    LocalSQL = FDLocalSQL
    Connection = FDConnection
    SQL.Strings = (
      'SELECT'
      #9'CUSTOMERS.ID,'
      #9'CUSTOMERS.NOME,'
      #9'CUSTOMERS.IDCIDADE,'
      #9'CITIES.NOME AS NOMECIDADE'
      'FROM'
      #9'CUSTOMERS'
      'JOIN'
      #9'CITIES ON CITIES.IDCIDADE = CUSTOMERS.IDCIDADE')
    Left = 190
    Top = 276
  end
  object FDStanStorageXMLLink: TFDStanStorageXMLLink
    Left = 424
    Top = 374
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 496
    Top = 226
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 386
    Top = 166
  end
end
