object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 388
  Width = 611
  object FDConnection: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'OSAuthent=No'
      'CharacterSet=WIN1252'
      'OpenMode=OpenOrCreate'
      'ExtendedMetadata=True'
      
        'Database=C:\Users\douglas.mezuraro\Documents\GitHub\mestre-dos-c' +
        'odigos\territory\delphi\knight\mission-14\bin\Win32\Debug\DATABA' +
        'SE.FDB'
      'DriverID=fB')
    LoginPrompt = False
    Left = 38
    Top = 38
  end
  object FDQueryEmployees: TFDQuery
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvGeneratorName]
    SQL.Strings = (
      'SELECT * FROM FUNCIONARIO')
    Left = 148
    Top = 90
    object FieldFDQueryFuncionariosID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FieldFDQueryFuncionariosNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 80
    end
    object TimeStampFieldFDQueryFuncionariosADMISSAO: TSQLTimeStampField
      FieldName = 'ADMISSAO'
      Origin = 'ADMISSAO'
    end
    object BCDFieldFDQueryFuncionariosSALARIO: TBCDField
      FieldName = 'SALARIO'
      Origin = 'SALARIO'
      Precision = 18
    end
  end
  object FDQueryDepartments: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT * FROM DEPARTAMENTO')
    Left = 148
    Top = 152
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    Left = 111
    Top = 331
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 110
    Top = 281
  end
  object FDQueryEmployeesDepartments: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT * FROM FUNCIONARIO_DEPARTAMENTO')
    Left = 148
    Top = 216
  end
end
