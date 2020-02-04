object GoogleStreetView: TGoogleStreetView
  Left = 280
  Top = 114
  Width = 510
  Height = 314
  Caption = 'GoogleStreetView'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel5: TPanel
    Left = 0
    Top = 0
    Width = 292
    Height = 269
    Align = alRight
    TabOrder = 0
    object StaticText1: TLabel
      Left = 7
      Top = 7
      Width = 97
      Height = 13
      Caption = 'Property Address'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object StaticText2: TLabel
      Left = 7
      Top = 31
      Width = 41
      Height = 13
      Caption = 'Address:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Image1: TImage
      Left = 32
      Top = 113
      Width = 137
      Height = 137
      Stretch = True
    end
    object edtStreet: TEdit
      Left = 55
      Top = 28
      Width = 180
      Height = 21
      TabOrder = 0
      Text = '1357 Echo Valley Dr'
    end
    object btnGetStreetView: TButton
      Left = 57
      Top = 64
      Width = 129
      Height = 25
      Caption = 'Get Street View'
      TabOrder = 1
      OnClick = btnGetStreetViewClick
    end
  end
  object WebBrowser1: TWebBrowser
    Left = 292
    Top = 0
    Width = 449
    Height = 269
    Align = alRight
    TabOrder = 1
    OnNavigateComplete2 = WebBrowser1NavigateComplete2
    ControlData = {
      4C000000682E0000CD1B00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object BingGeoCoder: TGAgisBingGeo
    UseCache = False
    UseClientGeocoder = False
    Left = 166
    Top = 272
  end
  object XMLDocument1: TXMLDocument
    Left = 92
    Top = 300
    DOMVendorDesc = 'MSXML'
  end
  object IdHTTP1: TIdHTTP
    AuthRetries = 0
    AuthProxyRetries = 0
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.ContentRangeInstanceLength = 0
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 216
    Top = 76
  end
end
