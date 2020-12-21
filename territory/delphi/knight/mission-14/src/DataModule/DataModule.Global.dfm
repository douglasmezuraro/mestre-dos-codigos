object DM: TDM
  OldCreateOrder = False
  Height = 388
  Width = 611
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=fB'
      'User_Name=sysdba'
      'Password=masterkey')
    LoginPrompt = False
    Left = 60
    Top = 32
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
