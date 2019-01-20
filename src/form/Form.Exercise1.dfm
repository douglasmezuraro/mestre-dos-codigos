inherited Exercise1: TExercise1
  Caption = 'Exerc'#237'cio 1'
  ClientHeight = 368
  ClientWidth = 580
  ExplicitWidth = 596
  ExplicitHeight = 406
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelButtons: TPanel
    Top = 317
    Width = 580
    ExplicitTop = 317
    ExplicitWidth = 580
  end
  inherited StatusBarStatus: TStatusBar
    Top = 349
    Width = 580
    ExplicitTop = 349
    ExplicitWidth = 580
  end
  object PageControlLayout: TPageControl [2]
    Left = 0
    Top = 0
    Width = 580
    Height = 317
    ActivePage = TabSheetData
    Align = alClient
    TabOrder = 2
    object TabSheetList: TTabSheet
      Caption = 'Lista'
      object Grid: TStringGrid
        Left = 0
        Top = 0
        Width = 572
        Height = 289
        Align = alClient
        ColCount = 1
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        TabOrder = 0
        OnSelectCell = GridSelectCell
      end
    end
    object TabSheetData: TTabSheet
      Caption = 'Dados'
      ImageIndex = 1
      object LabelBirth: TLabel
        Left = 13
        Top = 43
        Width = 55
        Height = 13
        Caption = 'Nascimento'
        FocusControl = DateTimePickerBirth
      end
      object RadioGroupGender: TRadioGroup
        Left = 13
        Top = 129
        Width = 249
        Height = 48
        Caption = 'G'#234'nero'
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          'Indefinido'
          'Feminino'
          'Masculino')
        TabOrder = 6
        TabStop = True
      end
      object LabeledEditPhone: TLabeledEdit
        Left = 268
        Top = 102
        Width = 121
        Height = 21
        EditLabel.Width = 42
        EditLabel.Height = 13
        EditLabel.Caption = 'Telefone'
        TabOrder = 5
        OnExit = LabeledEditPhoneExit
      end
      object LabeledEditEmail: TLabeledEdit
        Left = 13
        Top = 102
        Width = 249
        Height = 21
        EditLabel.Width = 28
        EditLabel.Height = 13
        EditLabel.Caption = 'E-mail'
        TabOrder = 4
        OnExit = LabeledEditEmailExit
      end
      object DateTimePickerBirth: TDateTimePicker
        Left = 12
        Top = 62
        Width = 101
        Height = 21
        Date = 43331.000000000000000000
        Time = 0.664617638889467400
        TabOrder = 2
        OnExit = DateTimePickerBirthExit
      end
      object LabeledEditCPF: TLabeledEdit
        Left = 119
        Top = 62
        Width = 142
        Height = 21
        EditLabel.Width = 19
        EditLabel.Height = 13
        EditLabel.Caption = 'CPF'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnExit = LabeledEditCPFExit
      end
      object LabeledEditName: TLabeledEdit
        Left = 12
        Top = 16
        Width = 249
        Height = 21
        EditLabel.Width = 27
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome'
        TabOrder = 0
        OnExit = LabeledEditNameExit
      end
      object LabeledEditLastName: TLabeledEdit
        Left = 267
        Top = 16
        Width = 249
        Height = 21
        EditLabel.Width = 54
        EditLabel.Height = 13
        EditLabel.Caption = 'Sobrenome'
        TabOrder = 1
      end
    end
  end
  inherited ActionListActions: TActionList
    Left = 448
    Top = 184
  end
end
