inherited CrudPerson: TCrudPerson
  Caption = 'Cadastro de pessoas'
  ShowHint = True
  ExplicitTop = -17
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControlLayout: TPageControl
    ActivePage = TabSheetData
    inherited TabSheetData: TTabSheet
      ExplicitLeft = 1
      ExplicitTop = 28
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
        Top = 279
        Width = 95
        Height = 13
        Caption = 'Data de nascimento'
        FocusControl = EditBirth
      end
      object LabelRG: TLabel
        Left = 16
        Top = 233
        Width = 14
        Height = 13
        Caption = 'RG'
        FocusControl = EditRG
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
        Hint = 'Exemplo: douglas@mezuraro.com'
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
        Top = 333
        Width = 350
        Height = 50
        Caption = 'G'#234'nero'
        Columns = 3
        Items.Strings = (
          'Indefinido'
          'Feminino'
          'Masculino')
        TabOrder = 7
        TabStop = True
      end
      object EditBirth: TDateTimePicker
        Left = 16
        Top = 298
        Width = 350
        Height = 21
        Date = 43556.000000000000000000
        Time = 0.950810694441315700
        TabOrder = 6
        OnChange = EditBirthChange
      end
      object EditRG: TEdit
        Left = 16
        Top = 252
        Width = 350
        Height = 21
        Hint = 'Apenas n'#250'meros (0..999999999)'
        TabOrder = 5
        OnExit = EditRGExit
      end
    end
  end
  inherited ActionList: TActionList
    Left = 448
    Top = 184
  end
end
