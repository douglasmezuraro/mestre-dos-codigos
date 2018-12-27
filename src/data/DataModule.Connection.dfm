object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 238
  Width = 424
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=MySQL')
    Left = 72
    Top = 48
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\libmysql.dll'
    Left = 168
    Top = 64
  end
end
