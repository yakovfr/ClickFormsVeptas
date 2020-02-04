object FloodZonePort: TFloodZonePort
  Left = 677
  Top = 188
  BorderStyle = bsDialog
  Caption = 'Flood Zone Determination Web Service'
  ClientHeight = 336
  ClientWidth = 592
  Color = clBtnFace
  Constraints.MinHeight = 335
  Constraints.MinWidth = 565
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 592
    Height = 336
    Align = alClient
    TabOrder = 0
    DesignSize = (
      592
      336)
    object Label2: TLabel
      Left = 13
      Top = 21
      Width = 38
      Height = 13
      Caption = 'Address'
    end
    object Label3: TLabel
      Left = 14
      Top = 51
      Width = 17
      Height = 13
      Caption = 'City'
    end
    object Label8: TLabel
      Left = 182
      Top = 52
      Width = 10
      Height = 13
      Caption = 'St'
    end
    object Label6: TLabel
      Left = 232
      Top = 51
      Width = 15
      Height = 13
      Caption = 'Zip'
    end
    object Label5: TLabel
      Left = 299
      Top = 51
      Width = 12
      Height = 13
      Caption = '+4'
    end
    object RzLine1: TRzLine
      Left = 0
      Top = 80
      Width = 577
      Height = 20
      Anchors = [akLeft, akTop, akRight]
    end
    object Label9: TLabel
      Left = 19
      Top = 115
      Width = 95
      Height = 13
      Caption = 'Accuracy of Results'
    end
    object RzLine2: TRzLine
      Left = 0
      Top = 144
      Width = 406
      Height = 20
      Anchors = [akLeft, akTop, akRight]
    end
    object lblSFHA: TLabel
      Left = 21
      Top = 181
      Width = 138
      Height = 13
      Caption = 'In Special Flood Hazard Area'
    end
    object Label10: TLabel
      Left = 171
      Top = 208
      Width = 53
      Height = 13
      Caption = 'Panel Date'
    end
    object Label11: TLabel
      Left = 334
      Top = 207
      Width = 25
      Height = 13
      Caption = 'Zone'
    end
    object Label1: TLabel
      Left = 21
      Top = 269
      Width = 47
      Height = 13
      Caption = 'Longitude'
    end
    object Label4: TLabel
      Left = 215
      Top = 269
      Width = 63
      Height = 13
      Caption = 'Census Tract'
    end
    object lblZip4: TLabel
      Left = 220
      Top = 294
      Width = 27
      Height = 13
      Caption = 'Zip+4'
    end
    object Label7: TLabel
      Left = 23
      Top = 292
      Width = 38
      Height = 13
      Caption = 'Latitude'
    end
    object Label12: TLabel
      Left = 22
      Top = 208
      Width = 37
      Height = 13
      Caption = 'Panel #'
    end
    object Label13: TLabel
      Left = 22
      Top = 236
      Width = 61
      Height = 13
      Caption = 'Map Number'
    end
    object edtAddress: TEdit
      Left = 56
      Top = 16
      Width = 297
      Height = 21
      TabOrder = 0
    end
    object edtCity: TEdit
      Left = 56
      Top = 48
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object edtState: TEdit
      Left = 195
      Top = 48
      Width = 33
      Height = 21
      MaxLength = 2
      TabOrder = 2
    end
    object edtZip: TEdit
      Left = 251
      Top = 48
      Width = 46
      Height = 21
      MaxLength = 5
      TabOrder = 3
    end
    object edtPlus4: TEdit
      Left = 316
      Top = 48
      Width = 37
      Height = 21
      MaxLength = 4
      TabOrder = 4
    end
    object btnLocate: TButton
      Left = 443
      Top = 16
      Width = 126
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Get Flood Zone Data'
      TabOrder = 5
      OnClick = btnLocateClick
    end
    object btnCancel: TButton
      Left = 443
      Top = 48
      Width = 126
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 6
    end
    object edtGeoResult: TEdit
      Left = 123
      Top = 111
      Width = 278
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object edtSFHA: TEdit
      Left = 178
      Top = 179
      Width = 33
      Height = 21
      TabOrder = 8
    end
    object edtSFHAPhrase: TEdit
      Left = 227
      Top = 179
      Width = 171
      Height = 21
      TabOrder = 9
    end
    object edtPanel: TEdit
      Left = 69
      Top = 204
      Width = 90
      Height = 21
      TabOrder = 10
    end
    object edtPanelDate: TEdit
      Left = 229
      Top = 204
      Width = 89
      Height = 21
      TabOrder = 11
    end
    object edtZone: TEdit
      Left = 366
      Top = 204
      Width = 32
      Height = 21
      TabOrder = 12
    end
    object edtLong: TEdit
      Left = 86
      Top = 265
      Width = 121
      Height = 21
      TabOrder = 13
    end
    object edtCensus: TEdit
      Left = 284
      Top = 265
      Width = 121
      Height = 21
      TabOrder = 14
    end
    object edtZip4: TEdit
      Left = 285
      Top = 290
      Width = 121
      Height = 21
      TabOrder = 15
    end
    object edtLat: TEdit
      Left = 86
      Top = 289
      Width = 121
      Height = 21
      TabOrder = 16
    end
    object AnimateProgress: TAnimate
      Left = 463
      Top = 98
      Width = 48
      Height = 45
      StopFrame = 8
    end
    object edtMapNumber: TEdit
      Left = 96
      Top = 232
      Width = 121
      Height = 21
      TabOrder = 18
    end
  end
end
