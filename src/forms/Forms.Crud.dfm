object Crud: TCrud
  Left = 0
  Top = 0
  Caption = '<Changed in Design Time>'
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
    Top = 568
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
  end
  object ActionListActions: TActionList
    Left = 504
    Top = 48
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
  end
end
