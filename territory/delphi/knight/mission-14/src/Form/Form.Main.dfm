object Main: TMain
  Left = 0
  Top = 0
  Caption = 'Delphi Knight - Mission 14'
  ClientHeight = 648
  ClientWidth = 1047
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 1047
    Height = 648
    ActivePage = TabSheetEmployees
    Align = alClient
    TabOrder = 0
    object TabSheetEmployees: TTabSheet
      Caption = 'Empregados'
      object GridEmployees: TDBGrid
        Left = 0
        Top = 0
        Width = 1039
        Height = 620
        Align = alClient
        DataSource = DataSourceEmployees
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object TabSheetDepartments: TTabSheet
      Caption = 'Departamentos'
      ImageIndex = 1
      object GridDepartments: TDBGrid
        Left = 0
        Top = 0
        Width = 1039
        Height = 620
        Align = alClient
        DataSource = DataSourceDepartments
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object TabSheetEmployeesDepartments: TTabSheet
      Caption = 'Empregados x Departamentos'
      ImageIndex = 2
      object GridEmployeesDepartments: TDBGrid
        Left = 0
        Top = 0
        Width = 1039
        Height = 620
        Align = alClient
        DataSource = DataSourceEmployeesDepartments
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
  end
  object DataSourceEmployees: TDataSource
    DataSet = FDQueryEmployees
    Left = 381
    Top = 75
  end
  object DataSourceDepartments: TDataSource
    DataSet = FDQueryDepartments
    Left = 228
    Top = 75
  end
  object DataSourceEmployeesDepartments: TDataSource
    DataSet = FDQueryEmployeesDepartments
    Left = 75
    Top = 75
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=fB'
      'User_Name=sysdba'
      'Password=masterkey')
    LoginPrompt = False
    Left = 534
    Top = 75
  end
  object FDQueryEmployees: TFDQuery
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvGeneratorName]
    Left = 534
    Top = 153
  end
  object FDQueryDepartments: TFDQuery
    Connection = FDConnection
    Left = 381
    Top = 153
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    Left = 75
    Top = 153
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 687
    Top = 75
  end
  object FDQueryEmployeesDepartments: TFDQuery
    Connection = FDConnection
    Left = 228
    Top = 153
  end
end
