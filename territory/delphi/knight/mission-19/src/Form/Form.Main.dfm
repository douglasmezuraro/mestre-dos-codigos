object Main: TMain
  Left = 0
  Top = 0
  Caption = 'Delphi Knight - Mission 19'
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
  object Panel: TPanel
    Left = 0
    Top = 555
    Width = 800
    Height = 45
    Align = alBottom
    TabOrder = 0
    object ButtonInsert: TButton
      Left = 1
      Top = 1
      Width = 100
      Height = 43
      Action = ActionInsert
      Align = alLeft
      TabOrder = 0
    end
  end
  object Memo: TMemo
    Left = 0
    Top = 0
    Width = 800
    Height = 555
    Align = alClient
    ReadOnly = True
    TabOrder = 1
    WordWrap = False
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 281
    Top = 75
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    Left = 384
    Top = 75
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=C:\MISSION_19.fdb'
      'CharacterSet=WIN1252'
      'ExtendedMetadata=True'
      'OpenMode=OpenOrCreate'
      'DriverID=fB')
    LoginPrompt = False
    Left = 180
    Top = 75
  end
  object FDQuery: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'INSERT INTO'
      
        '    FUNCIONARIO (ID, NOME, CIDADE, EMAIL, DATANASC, PROFISSAO, C' +
        'ARTAO)'
      'VALUES'
      
        '    (:ID, :NOME, :CIDADE, :EMAIL, :DATANASC, :PROFISSAO, :CARTAO' +
        ');')
    Left = 487
    Top = 75
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'NOME'
        DataType = ftString
        ParamType = ptInput
        Size = 180
      end
      item
        Name = 'CIDADE'
        DataType = ftString
        ParamType = ptInput
        Size = 180
      end
      item
        Name = 'EMAIL'
        DataType = ftString
        ParamType = ptInput
        Size = 180
      end
      item
        Name = 'DATANASC'
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'PROFISSAO'
        DataType = ftString
        ParamType = ptInput
        Size = 180
      end
      item
        Name = 'CARTAO'
        DataType = ftString
        ParamType = ptInput
        Size = 180
      end>
  end
  object ActionList: TActionList
    Left = 75
    Top = 75
    object ActionInsert: TAction
      Caption = 'Insert'
      OnExecute = ActionInsertExecute
    end
  end
  object FDScript: TFDScript
    SQLScripts = <
      item
        Name = 'DDL'
        SQL.Strings = (
          'CREATE TABLE FUNCIONARIO'
          '    (         '
          '        ID INTEGER,'
          '        NOME VARCHAR (180),'
          '        CIDADE VARCHAR (180),'
          '        EMAIL VARCHAR (180),'
          '        DATANASC TIMESTAMP,'
          '        PROFISSAO VARCHAR (180),'
          '        CARTAO VARCHAR (180)'
          '    );')
      end>
    Connection = FDConnection
    Params = <>
    Macros = <>
    Left = 68
    Top = 186
  end
end
