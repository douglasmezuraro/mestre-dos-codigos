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
    ExplicitTop = 559
    object ButtonInsert: TButton
      Left = 1
      Top = 1
      Width = 100
      Height = 43
      Align = alLeft
      Caption = 'ButtonInsert'
      TabOrder = 0
      OnClick = ButtonInsertClick
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
    ExplicitLeft = 148
    ExplicitTop = 146
    ExplicitWidth = 185
    ExplicitHeight = 89
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 384
    Top = 75
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    Left = 487
    Top = 75
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=fB'
      'User_Name=sysdba'
      'Password=masterkey')
    LoginPrompt = False
    Left = 281
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
    Left = 590
    Top = 75
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'NOME'
        DataType = ftString
        ParamType = ptInput
        Size = 180
        Value = Null
      end
      item
        Name = 'CIDADE'
        DataType = ftString
        ParamType = ptInput
        Size = 180
        Value = Null
      end
      item
        Name = 'EMAIL'
        DataType = ftString
        ParamType = ptInput
        Size = 180
        Value = Null
      end
      item
        Name = 'DATANASC'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PROFISSAO'
        DataType = ftString
        ParamType = ptInput
        Size = 180
        Value = Null
      end
      item
        Name = 'CARTAO'
        DataType = ftString
        ParamType = ptInput
        Size = 180
        Value = Null
      end>
  end
end
