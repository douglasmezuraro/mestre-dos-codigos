object Global: TGlobal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 238
  Width = 424
  object Connection: TFDConnection
    Params.Strings = (
      'DriverID=MySQL')
    Left = 72
    Top = 48
  end
  object DriverLink: TFDPhysMySQLDriverLink
    Left = 144
    Top = 96
  end
end
