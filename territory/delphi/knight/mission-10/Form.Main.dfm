object Main: TMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'E-mail validator'
  ClientHeight = 92
  ClientWidth = 533
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
  object EditEmail: TLabeledEdit
    Left = 40
    Top = 36
    Width = 367
    Height = 21
    EditLabel.Width = 28
    EditLabel.Height = 13
    EditLabel.Caption = 'E-mail'
    TabOrder = 0
  end
  object ButtonValidate: TButton
    Left = 412
    Top = 34
    Width = 75
    Height = 25
    Action = ActionValidate
    TabOrder = 1
  end
  object ActionList: TActionList
    Left = 388
    Top = 232
    object ActionValidate: TAction
      Caption = '&Validate'
      OnExecute = ActionValidateExecute
    end
  end
end
