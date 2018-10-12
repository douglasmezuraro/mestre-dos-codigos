inherited Exercise1: TExercise1
  Caption = 'Exerc'#237'cio 1'
  ClientHeight = 380
  ClientWidth = 303
  ExplicitTop = -106
  ExplicitWidth = 319
  ExplicitHeight = 418
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelButtons: TPanel
    Top = 329
    Width = 303
    TabOrder = 2
    ExplicitTop = 329
    ExplicitWidth = 303
  end
  object GroupBoxData: TGroupBox [1]
    Left = 8
    Top = 55
    Width = 280
    Height = 265
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
      FocusControl = DateTimePickerBirth
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
      Width = 101
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
    object DateTimePickerBirth: TDateTimePicker
      Left = 12
      Top = 118
      Width = 101
      Height = 21
      Date = 43331.664617638890000000
      Time = 43331.664617638890000000
      TabOrder = 2
      OnExit = DateTimePickerBirthExit
    end
  end
  object GroupBoxIndex: TGroupBox [2]
    Left = 8
    Top = 2
    Width = 280
    Height = 47
    Caption = #205'ndice'
    TabOrder = 0
    object LabelCount: TLabel
      Left = 74
      Top = 19
      Width = 12
      Height = 13
      Caption = 'de'
    end
    object EditCount: TEdit
      Left = 92
      Top = 16
      Width = 56
      Height = 21
      Enabled = False
      NumbersOnly = True
      TabOrder = 1
    end
    object EditIndex: TEdit
      Left = 12
      Top = 16
      Width = 56
      Height = 21
      TabOrder = 0
      OnExit = EditIndexExit
    end
  end
  inherited StatusBarStatus: TStatusBar
    Top = 361
    Width = 303
    ExplicitTop = 361
    ExplicitWidth = 303
  end
  inherited ActionListActions: TActionList
    object ActionIndexExit: TAction
      Category = 'Event'
      Caption = 'ActionIndexExit'
      OnExecute = ActionIndexExitExecute
    end
  end
end
