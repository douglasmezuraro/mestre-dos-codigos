object Main: TMain
  Left = 0
  Top = 0
  Caption = 'GitHub User Search'
  ClientHeight = 600
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 800
    Height = 24
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 578
    object ButtonSearch: TButton
      Left = 724
      Top = 1
      Width = 75
      Height = 22
      Action = ActionSearch
      Align = alRight
      TabOrder = 0
      ExplicitLeft = 502
    end
    object EditUser: TEdit
      Left = 1
      Top = 1
      Width = 723
      Height = 22
      Align = alClient
      TabOrder = 1
      ExplicitWidth = 501
      ExplicitHeight = 21
    end
  end
  object Grid: TDBGrid
    Left = 0
    Top = 24
    Width = 800
    Height = 576
    Align = alClient
    DataSource = DataSource
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object ActionList: TActionList
    Left = 30
    Top = 80
    object ActionSearch: TAction
      Caption = '&Search'
      OnExecute = ActionSearchExecute
    end
  end
  object RestClient: TRESTClient
    Authenticator = Authenticator
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'https://api.github.com/users/'
    Params = <>
    HandleRedirects = True
    Left = 30
    Top = 272
  end
  object DataSetAdapter: TRESTResponseDataSetAdapter
    Active = True
    Dataset = DataSet
    FieldDefs = <>
    Response = Response
    Left = 30
    Top = 416
  end
  object DataSet: TClientDataSet
    PersistDataPacket.Data = {
      D10000009619E0BD0100000018000000020001000000030000007B00076D6573
      7361676502004A000000010005574944544802000200FE0111646F63756D656E
      746174696F6E5F75726C02004A000000010005574944544802000200FE010100
      0A4348414E47455F4C4F47040082000300000001000000000000000400000004
      0012004E006F007400200046006F0075006E0064003E00680074007400700073
      003A002F002F0064006500760065006C006F007000650072002E006700690074
      006800750062002E0063006F006D002F0076003300}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'message'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'documentation_url'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 30
    Top = 128
  end
  object DataSource: TDataSource
    DataSet = DataSet
    Left = 30
    Top = 176
  end
  object Response: TRESTResponse
    ContentType = 'application/json'
    Left = 30
    Top = 368
  end
  object Authenticator: TOAuth2Authenticator
    Left = 30
    Top = 224
  end
  object Request: TRESTRequest
    Client = RestClient
    Params = <>
    Response = Response
    SynchronizedEvents = False
    Left = 30
    Top = 320
  end
end
