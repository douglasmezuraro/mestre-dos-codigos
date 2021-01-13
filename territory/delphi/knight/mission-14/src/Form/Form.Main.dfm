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
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
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
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
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
      'User_Name=sysdba'
      'Password=masterkey'
      'CharacterSet=WIN1252'
      'ExtendedMetadata=True'
      'OpenMode=OpenOrCreate'
      'OSAuthent=No'
      'Database=C:\MISSION_14.fdb'
      'DriverID=fB')
    LoginPrompt = False
    Left = 534
    Top = 75
  end
  object FDQueryEmployees: TFDQuery
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'GEN_FUNCIONARIO'
    UpdateOptions.AutoIncFields = 'ID'
    SQL.Strings = (
      'SELECT'
      '    *'
      'FROM'
      '    FUNCIONARIO')
    Left = 381
    Top = 153
  end
  object FDQueryDepartments: TFDQuery
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'GEN_DEPARTAMENTO'
    UpdateOptions.AutoIncFields = 'ID'
    SQL.Strings = (
      'SELECT'
      '    *'
      'FROM'
      '    DEPARTAMENTO')
    Left = 534
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
    SQL.Strings = (
      'SELECT'
      '    FUNCIONARIO_ID AS FUNCIONARIO,'
      '    DEPARTAMENTO_ID AS DEPARTAMENTO'
      'FROM'
      '    FUNCIONARIO_DEPARTAMENTO')
    Left = 228
    Top = 153
  end
  object FDScript: TFDScript
    SQLScripts = <
      item
        Name = 'DDL'
        SQL.Strings = (
          'CREATE DOMAIN TString VARCHAR(80);'
          'CREATE DOMAIN TDateTime TIMESTAMP;'
          'CREATE DOMAIN TDouble DECIMAL(10, 2);'
          'CREATE DOMAIN TInteger INTEGER;'
          'CREATE DOMAIN TPhone CHAR(11);'
          ''
          'CREATE SEQUENCE GEN_FUNCIONARIO;'
          'CREATE SEQUENCE GEN_DEPARTAMENTO;'
          ''
          'CREATE TABLE FUNCIONARIO'
          '    ('
          '        ID TInteger PRIMARY KEY,'
          '        NOME TString,'
          '        ADMISSAO TDateTime,'
          '        SALARIO TDouble'
          '    );'
          ''
          'CREATE TABLE DEPARTAMENTO'
          '    ('
          '        ID TInteger PRIMARY KEY,'
          '        DESCRICAO TString,'
          '        TELEFONE TPhone'
          '    );'
          ''
          'CREATE TABLE FUNCIONARIO_DEPARTAMENTO'
          '    ('
          
            '        FUNCIONARIO_ID TInteger NOT NULL REFERENCES FUNCIONARIO(' +
            'ID),'
          
            '        DEPARTAMENTO_ID TInteger NOT NULL REFERENCES DEPARTAMENT' +
            'O(ID)'
          '    );')
      end>
    Connection = FDConnection
    Params = <>
    Macros = <>
    Left = 687
    Top = 153
  end
end
