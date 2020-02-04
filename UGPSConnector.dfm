object GPSConnection: TGPSConnection
  Left = 494
  Top = 193
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Global GPS Connection'
  ClientHeight = 105
  ClientWidth = 422
  Color = clBtnFace
  Constraints.MaxHeight = 139
  Constraints.MaxWidth = 430
  Constraints.MinHeight = 139
  Constraints.MinWidth = 430
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 422
    Height = 105
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 22
      Width = 69
      Height = 13
      Caption = 'GPS Lattitude:'
    end
    object Label2: TLabel
      Left = 10
      Top = 46
      Width = 72
      Height = 13
      Caption = 'GPS Longitude'
    end
    object Label3: TLabel
      Left = 9
      Top = 75
      Width = 87
      Height = 13
      Caption = 'Tracking Satellites'
    end
    object lblSatellites: TLabel
      Left = 106
      Top = 75
      Width = 8
      Height = 13
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 105
      Top = 4
      Width = 40
      Height = 13
      Caption = 'Degrees'
    end
    object Label5: TLabel
      Left = 171
      Top = 4
      Width = 37
      Height = 13
      Caption = 'Minutes'
    end
    object Label6: TLabel
      Left = 232
      Top = 4
      Width = 42
      Height = 13
      Caption = 'Seconds'
    end
    object Label7: TLabel
      Left = 320
      Top = 4
      Width = 39
      Height = 13
      Caption = 'Radians'
    end
    object edtLatDeg: TEdit
      Left = 90
      Top = 19
      Width = 65
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object edtLatMin: TEdit
      Left = 162
      Top = 19
      Width = 57
      Height = 21
      ReadOnly = True
      TabOrder = 1
    end
    object edtLatSec: TEdit
      Left = 226
      Top = 19
      Width = 57
      Height = 21
      ReadOnly = True
      TabOrder = 2
    end
    object edtLonDeg: TEdit
      Left = 90
      Top = 43
      Width = 65
      Height = 21
      ReadOnly = True
      TabOrder = 3
    end
    object edtLonMin: TEdit
      Left = 162
      Top = 43
      Width = 57
      Height = 21
      ReadOnly = True
      TabOrder = 4
    end
    object edtLonSec: TEdit
      Left = 226
      Top = 43
      Width = 57
      Height = 21
      ReadOnly = True
      TabOrder = 5
    end
    object btnTrack: TButton
      Left = 328
      Top = 71
      Width = 82
      Height = 25
      Caption = 'Capture GPS'
      TabOrder = 6
      OnClick = btnTrackClick
    end
    object edtLatRad: TEdit
      Left = 288
      Top = 19
      Width = 121
      Height = 21
      ReadOnly = True
      TabOrder = 7
    end
    object edtLonRad: TEdit
      Left = 289
      Top = 43
      Width = 121
      Height = 21
      ReadOnly = True
      TabOrder = 8
    end
  end
  object GPSReceiver: TZylGPSReceiver
    Commands = [GPGLL, GPGGA, GPVTG, GPRMC, GPGSA, GPGSV, GPZDA]
    OnReceive = GPSReceiverReceive
    Left = 160
    Top = 71
  end
end
