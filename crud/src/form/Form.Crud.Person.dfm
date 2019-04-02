inherited CrudPerson: TCrudPerson
  Caption = 'Cadastro de pessoas'
  ShowHint = True
  ExplicitTop = -17
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControlLayout: TPageControl
    inherited TabSheetList: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 792
      ExplicitHeight = 521
    end
    inherited TabSheetData: TTabSheet
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
      object LabelPhone: TLabel
        Left = 16
        Top = 95
        Width = 42
        Height = 13
        Caption = 'Telefone'
        FocusControl = EditPhone
      end
      object LabelEmail: TLabel
        Left = 16
        Top = 141
        Width = 28
        Height = 13
        Caption = 'E-mail'
        FocusControl = EditEmail
      end
      object LabelCPF: TLabel
        Left = 16
        Top = 187
        Width = 19
        Height = 13
        Caption = 'CPF'
        FocusControl = EditCPF
      end
      object LabelBirth: TLabel
        Left = 16
        Top = 233
        Width = 95
        Height = 13
        Caption = 'Data de nascimento'
        FocusControl = EditBirth
      end
      object EditName: TEdit
        Left = 16
        Top = 22
        Width = 350
        Height = 21
        Hint = 'Apenas letras'
        TabOrder = 0
        OnExit = EditNameExit
      end
      object EditLastName: TEdit
        Left = 16
        Top = 68
        Width = 350
        Height = 21
        Hint = 'Apenas letras'
        TabOrder = 1
        OnExit = EditLastNameExit
      end
      object EditPhone: TEdit
        Left = 16
        Top = 114
        Width = 350
        Height = 21
        Hint = 'Exemplo: (44)3222-9999'
        TabOrder = 2
        OnExit = EditPhoneExit
      end
      object EditEmail: TEdit
        Left = 16
        Top = 160
        Width = 350
        Height = 21
        Hint = 'Exemplo: teste@teste.com'
        TabOrder = 3
        OnExit = EditEmailExit
      end
      object EditCPF: TEdit
        Left = 16
        Top = 206
        Width = 350
        Height = 21
        Hint = 'Exemplo: 101.202.303-40'
        TabOrder = 4
        OnExit = EditCPFExit
      end
      object RadioGroupGender: TRadioGroup
        Left = 16
        Top = 279
        Width = 350
        Height = 50
        Caption = 'G'#234'nero'
        Columns = 3
        Items.Strings = (
          'Indefinido'
          'Feminino'
          'Masculino')
        TabOrder = 5
        TabStop = True
      end
      object EditBirth: TDateTimePicker
        Left = 16
        Top = 252
        Width = 350
        Height = 21
        Date = 43556.000000000000000000
        Time = 0.950810694441315700
        TabOrder = 6
        OnChange = EditBirthChange
      end
    end
  end
  inherited ActionList: TActionList
    Left = 448
    Top = 184
  end
end
