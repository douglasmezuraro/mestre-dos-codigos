object DM: TDM
  OldCreateOrder = False
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
    Left = 148
    Top = 90
  end
  object FDQueryDepartments: TFDQuery
    Connection = FDConnection
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
    Left = 148
    Top = 216
  end
end
