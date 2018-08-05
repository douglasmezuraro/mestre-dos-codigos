object ExerciseOne: TExerciseOne
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Exerc'#237'cio 1'
  ClientHeight = 407
  ClientWidth = 574
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBoxData: TGroupBox
    Left = 0
    Top = 79
    Width = 281
    Height = 258
    Caption = 'Dados'
    TabOrder = 0
    object LabelPhone: TLabel
      Left = 12
      Top = 145
      Width = 42
      Height = 13
      Caption = 'Telefone'
      FocusControl = MaskEditPhone
    end
    object LabelBirth: TLabel
      Left = 12
      Top = 99
      Width = 55
      Height = 13
      Caption = 'Nascimento'
    end
    object LabeledEditName: TLabeledEdit
      Left = 12
      Top = 32
      Width = 249
      Height = 21
      EditLabel.Width = 27
      EditLabel.Height = 13
      EditLabel.Caption = 'Nome'
      TabOrder = 0
    end
    object MaskEditPhone: TMaskEdit
      Left = 12
      Top = 164
      Width = 85
      Height = 21
      EditMask = '!\(99\)90000-0000;1;_'
      MaxLength = 14
      TabOrder = 3
      Text = '(  )     -    '
    end
    object RadioGroupGender: TRadioGroup
      Left = 12
      Top = 207
      Width = 249
      Height = 48
      Caption = 'G'#234'nero'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Indefinido'
        'Feminino'
        'Masculino')
      TabOrder = 4
      TabStop = True
    end
    object LabeledEditLastName: TLabeledEdit
      Left = 12
      Top = 72
      Width = 249
      Height = 21
      EditLabel.Width = 54
      EditLabel.Height = 13
      EditLabel.Caption = 'Sobrenome'
      TabOrder = 1
    end
    object MaskEditBirth: TMaskEdit
      Left = 12
      Top = 118
      Width = 85
      Height = 21
      EditMask = '!00/00/0000;1;_'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
    end
  end
  object ButtonInsert: TButton
    Left = 480
    Top = 30
    Width = 75
    Height = 25
    Action = ActionInsert
    TabOrder = 1
  end
  object ButtonRemove: TButton
    Left = 480
    Top = 61
    Width = 75
    Height = 25
    Action = ActionRemove
    TabOrder = 2
  end
  object GroupBoxIndex: TGroupBox
    Left = 0
    Top = 8
    Width = 281
    Height = 65
    Caption = #205'ndice'
    TabOrder = 3
    object LabelCount: TLabel
      Left = 74
      Top = 35
      Width = 12
      Height = 13
      Caption = 'de'
    end
    object EditCount: TEdit
      Left = 92
      Top = 32
      Width = 56
      Height = 21
      Enabled = False
      NumbersOnly = True
      TabOrder = 1
    end
    object LabeledEditIndex: TLabeledEdit
      Left = 12
      Top = 32
      Width = 56
      Height = 21
      EditLabel.Width = 29
      EditLabel.Height = 13
      EditLabel.Caption = #205'ndice'
      NumbersOnly = True
      TabOrder = 0
      OnExit = ActionIndexExitExecute
    end
  end
  object ActionList: TActionList
    Left = 480
    Top = 136
    object ActionInsert: TAction
      Caption = 'Inserir'
      OnExecute = ActionInsertExecute
    end
    object ActionRemove: TAction
      Caption = 'Remover'
      OnExecute = ActionRemoveExecute
    end
    object ActionIndexExit: TAction
      Caption = 'ActionIndexExit'
      OnExecute = ActionIndexExitExecute
    end
  end
end
