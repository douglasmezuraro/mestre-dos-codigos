object DM: TDM
  OldCreateOrder = False
  Height = 287
  Width = 590
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=fB'
      'User_Name=sysdba'
      'Password=masterkey')
    LoginPrompt = False
    Left = 75
    Top = 75
  end
  object FDQueryEmployees: TFDQuery
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvGeneratorName]
    Left = 75
    Top = 465
  end
  object FDQueryDepartments: TFDQuery
    Connection = FDConnection
    Left = 75
    Top = 387
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    Left = 75
    Top = 231
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 75
    Top = 153
  end
  object FDQueryEmployeesDepartments: TFDQuery
    Connection = FDConnection
    Left = 75
    Top = 309
  end
end
