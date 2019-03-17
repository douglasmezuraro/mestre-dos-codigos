inherited Exercise1: TExercise1
  Caption = 'Exerc'#237'cio 1'
  ClientHeight = 476
  ClientWidth = 580
  ExplicitTop = 2
  ExplicitWidth = 596
  ExplicitHeight = 514
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelButtons: TPanel
    Top = 425
    Width = 580
    ExplicitTop = 425
    ExplicitWidth = 580
  end
  inherited StatusBarStatus: TStatusBar
    Top = 457
    Width = 580
    ExplicitTop = 457
    ExplicitWidth = 580
  end
  inherited PageControlLayout: TPageControl
    Width = 580
    Height = 425
    ExplicitWidth = 580
    ExplicitHeight = 425
    inherited TabSheetList: TTabSheet
      ExplicitWidth = 572
      ExplicitHeight = 397
      inherited Grid: TStringGrid
        Width = 572
        Height = 397
        ExplicitWidth = 572
        ExplicitHeight = 397
      end
    end
    inherited TabSheetData: TTabSheet
      ExplicitWidth = 572
      ExplicitHeight = 397
      object LabelName: TLabel
        Left = 16
        Top = 3
        Width = 27
        Height = 13
        Caption = 'Nome'
        FocusControl = EditName
      end
      object LabelLastName: TLabel
        Left = 16
        Top = 49
        Width = 54
        Height = 13
        Caption = 'Sobrenome'
        FocusControl = EditLastName
      end
      object LabelBirth: TLabel
        Left = 16
        Top = 95
        Width = 55
        Height = 13
        Caption = 'Nascimento'
        FocusControl = EditBirth
      end
      object LabelPhone: TLabel
        Left = 16
        Top = 141
        Width = 42
        Height = 13
        Caption = 'Telefone'
        FocusControl = EditPhone
      end
      object LabelEmail: TLabel
        Left = 16
        Top = 187
        Width = 28
        Height = 13
        Caption = 'E-mail'
        FocusControl = EditEmail
      end
      object LabelCPF: TLabel
        Left = 16
        Top = 233
        Width = 19
        Height = 13
        Caption = 'CPF'
        FocusControl = EditCPF
      end
      object EditName: TEdit
        Left = 16
        Top = 22
        Width = 250
        Height = 21
        TabOrder = 0
      end
      object EditLastName: TEdit
        Left = 16
        Top = 68
        Width = 250
        Height = 21
        TabOrder = 1
      end
      object EditBirth: TDateTimePicker
        Left = 16
        Top = 114
        Width = 250
        Height = 21
        Date = 43520.000000000000000000
        Time = 0.959959583342424600
        TabOrder = 2
      end
      object EditPhone: TEdit
        Left = 16
        Top = 160
        Width = 250
        Height = 21
        TabOrder = 3
      end
      object EditEmail: TEdit
        Left = 16
        Top = 206
        Width = 250
        Height = 21
        TabOrder = 4
      end
      object EditCPF: TEdit
        Left = 16
        Top = 252
        Width = 250
        Height = 21
        TabOrder = 5
      end
      object RadioGroupGender: TRadioGroup
        Left = 16
        Top = 279
        Width = 250
        Height = 36
        Caption = 'G'#234'nero'
        Columns = 3
        Items.Strings = (
          'Indefinido'
          'Feminino'
          'Masculino')
        TabOrder = 6
      end
    end
  end
  inherited ActionList: TActionList
    Left = 448
    Top = 184
  end
end
