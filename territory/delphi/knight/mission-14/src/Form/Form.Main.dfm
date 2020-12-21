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
    object TabSheetRelationship: TTabSheet
      Caption = 'Empregados x Departamentos'
      ImageIndex = 2
      object GridRelationship: TDBGrid
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
    DataSet = DM.FDQueryEmployees
    Left = 80
    Top = 72
  end
  object DataSourceDepartments: TDataSource
    DataSet = DM.FDQueryDepartments
    Left = 80
    Top = 124
  end
  object DataSourceEmployeesDepartments: TDataSource
    DataSet = DM.FDQueryEmployeesDepartments
    Left = 80
    Top = 182
  end
end
