object Main: TMain
  Left = 0
  Top = 0
  Caption = 'Delphi Knight - Mission 14'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=fB'
      'User_Name=sysdba'
      'Password=masterkey')
    Left = 36
    Top = 38
  end
end
