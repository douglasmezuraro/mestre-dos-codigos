object Main: TMain
  Left = 0
  Top = 0
  Caption = 'Delphi Knight - Mission 08'
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
    object ButtonSearch: TButton
      Left = 724
      Top = 1
      Width = 75
      Height = 22
      Action = ActionSearch
      Align = alRight
      TabOrder = 0
    end
    object EditUser: TEdit
      Left = 1
      Top = 1
      Width = 723
      Height = 22
      Align = alClient
      TabOrder = 1
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
    BaseURL = 'https://api.github.com'
    ContentType = 'application/json'
    Params = <>
    HandleRedirects = True
    Left = 30
    Top = 272
  end
  object DataSetAdapter: TRESTResponseDataSetAdapter
    Dataset = DataSet
    FieldDefs = <>
    Response = Response
    Left = 30
    Top = 416
  end
  object DataSet: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
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
    Resource = 'users'
    Response = Response
    SynchronizedEvents = False
    Left = 30
    Top = 320
  end
end
