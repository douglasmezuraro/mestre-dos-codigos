inherited Exercise1: TExercise1
  Caption = 'Exercise1'
  ExplicitTop = 8
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBoxData: TGroupBox [1]
    Left = 0
    Top = 79
    Width = 281
    Height = 258
    Caption = 'Dados'
    TabOrder = 1
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
      FocusControl = MaskEditBirth
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
      Width = 81
      Height = 21
      EditMask = '!\(99\)90000-0000;0;_'
      MaxLength = 14
      TabOrder = 3
      Text = ''
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
      Width = 83
      Height = 21
      EditMask = '!00/00/0000;0;_'
      MaxLength = 10
      TabOrder = 2
      Text = ''
      OnExit = MaskEditBirthExit
    end
  end
  object GroupBoxIndex: TGroupBox [2]
    Left = 0
    Top = 8
    Width = 281
    Height = 65
    Caption = #205'ndice'
    TabOrder = 2
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
    end
  end
  inherited ActionListActions: TActionList
    object ActionIndexExit: TAction
      Category = 'Event'
      Caption = 'ActionIndexExit'
      OnExecute = ActionIndexExitExecute
    end
  end
end
