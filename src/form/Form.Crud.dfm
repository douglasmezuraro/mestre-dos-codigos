object Crud: TCrud
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = '<Changed in designtime>'
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
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelButtons: TPanel
    Left = 0
    Top = 549
    Width = 800
    Height = 32
    Align = alBottom
    TabOrder = 0
    object ButtonInsert: TSpeedButton
      Left = 1
      Top = 1
      Width = 100
      Height = 30
      Action = ActionInsert
      Align = alLeft
      ExplicitLeft = 24
      ExplicitTop = 16
      ExplicitHeight = 22
    end
    object ButtonEdit: TSpeedButton
      Left = 101
      Top = 1
      Width = 100
      Height = 30
      Action = ActionEdit
      Align = alLeft
      ExplicitLeft = 157
      ExplicitTop = 16
      ExplicitHeight = 22
    end
    object ButtonRemove: TSpeedButton
      Left = 201
      Top = 1
      Width = 100
      Height = 30
      Action = ActionRemove
      Align = alLeft
      ExplicitLeft = 304
      ExplicitHeight = 45
    end
    object ButtonClear: TSpeedButton
      Left = 301
      Top = 1
      Width = 100
      Height = 30
      Action = ActionClear
      Align = alLeft
    end
  end
  object StatusBarStatus: TStatusBar
    Left = 0
    Top = 581
    Width = 800
    Height = 19
    Panels = <>
    SimplePanel = True
    SimpleText = '<Changed in runtime>'
  end
  object PageControlLayout: TPageControl
    Left = 0
    Top = 0
    Width = 800
    Height = 549
    ActivePage = TabSheetData
    Align = alClient
    TabOrder = 2
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 580
    ExplicitHeight = 317
    object TabSheetList: TTabSheet
      Caption = 'Lista'
      ExplicitWidth = 572
      ExplicitHeight = 289
      object Grid: TStringGrid
        Left = 0
        Top = 0
        Width = 792
        Height = 521
        Align = alClient
        ColCount = 1
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        TabOrder = 0
        ExplicitWidth = 572
        ExplicitHeight = 289
      end
    end
    object TabSheetData: TTabSheet
      Caption = 'Dados'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = -64
    end
  end
  object ActionList: TActionList
    Left = 184
    Top = 88
    object ActionInsert: TAction
      Category = 'Crud'
      Caption = 'Inserir'
      OnExecute = ActionInsertExecute
    end
    object ActionEdit: TAction
      Category = 'Crud'
      Caption = 'Editar'
      OnExecute = ActionEditExecute
    end
    object ActionRemove: TAction
      Category = 'Crud'
      Caption = 'Remover'
      OnExecute = ActionRemoveExecute
    end
    object ActionClear: TAction
      Category = 'Crud'
      Caption = '&Limpar'
      OnExecute = ActionClearExecute
    end
  end
end
