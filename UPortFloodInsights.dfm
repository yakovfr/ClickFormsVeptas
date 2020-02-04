object FloodPort: TFloodPort
  Left = 474
  Top = 256
  Width = 1062
  Height = 568
  Caption = 'Flood Insights Web Service'
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 49
    Width = 1046
    Height = 461
    ActivePage = TabAddress
    Align = alClient
    TabOrder = 0
    TabWidth = 75
    object TabAddress: TTabSheet
      Caption = 'Address'
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
      object Label8: TLabel
        Left = 182
        Top = 52
        Width = 10
        Height = 13
        Caption = 'St'
      end
      object edtCity: TEdit
        Left = 56
        Top = 48
        Width = 121
        Height = 21
        TabOrder = 1
      end
      object edtAddress: TEdit
        Left = 56
        Top = 16
        Width = 297
        Height = 21
        TabOrder = 0
      end
      object edtState: TEdit
        Left = 195
        Top = 48
        Width = 33
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 2
        TabOrder = 2
      end
      object edtZip: TEdit
        Left = 251
        Top = 48
        Width = 46
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 5
        TabOrder = 3
      end
      object edtPlus4: TEdit
        Left = 316
        Top = 48
        Width = 37
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 4
        TabOrder = 4
      end
    end
    object TabResults: TTabSheet
      Caption = 'Results'
      ImageIndex = 1
      object NotebookResults: TNotebook
        Left = 0
        Top = 0
        Width = 1038
        Height = 433
        Align = alClient
        PageIndex = 1
        TabOrder = 0
        object TPage
          Left = 0
          Top = 0
          Caption = 'SingleResult'
          object LabelMsg: TLabel
            Left = 8
            Top = 8
            Width = 536
            Height = 41
            AutoSize = False
            Caption = 
              'Your search for "street, city, state, zip, plus 4" has returned ' +
              'the following adresses. Please select the correct address from t' +
              'he list below and click "Locate" button to get the map. To cance' +
              'l and start over again, click "Cancel" button.'
            WordWrap = True
          end
          object ListBoxAddresses: TListBox
            Left = 6
            Top = 55
            Width = 537
            Height = 167
            ItemHeight = 13
            TabOrder = 0
            OnDblClick = ListBoxAddressesDblClick
          end
        end
        object TPage
          Left = 0
          Top = 0
          Caption = 'MultipleResults'
          object rightPanel: TPanel
            Left = 567
            Top = 0
            Width = 471
            Height = 433
            Align = alRight
            TabOrder = 0
            DesignSize = (
              471
              433)
            object lblAccuracy: TLabel
              Left = 24
              Top = 56
              Width = 45
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Accuracy'
            end
            object lblZip4: TLabel
              Left = 282
              Top = 56
              Width = 27
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Zip+4'
            end
            object lblSFHA: TLabel
              Left = 24
              Top = 85
              Width = 138
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'In Special Flood Hazard Area'
            end
            object lblPanel: TLabel
              Left = 24
              Top = 112
              Width = 37
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Panel #'
            end
            object lblPanelDate: TLabel
              Left = 169
              Top = 112
              Width = 53
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Panel Date'
            end
            object lblZone: TLabel
              Left = 330
              Top = 111
              Width = 25
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Zone'
            end
            object lblCommunity: TLabel
              Left = 24
              Top = 143
              Width = 61
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Community #'
            end
            object lblName: TLabel
              Left = 193
              Top = 143
              Width = 28
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Name'
            end
            object lblLongitude: TLabel
              Left = 24
              Top = 173
              Width = 47
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Longitude'
            end
            object lblcensus: TLabel
              Left = 226
              Top = 173
              Width = 63
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Census Tract'
            end
            object lblLatitude: TLabel
              Left = 24
              Top = 212
              Width = 38
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Latitude'
            end
            object lblFIPS: TLabel
              Left = 256
              Top = 212
              Width = 33
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'FIPS #'
            end
            object lblMapNumber: TLabel
              Left = 26
              Top = 242
              Width = 61
              Height = 13
              Alignment = taRightJustify
              Anchors = [akTop, akRight]
              Caption = 'Map Number'
              FocusControl = edtMapNumber
            end
            object chxPutInClipBrd: TCheckBox
              Left = 24
              Top = 8
              Width = 217
              Height = 17
              Anchors = [akTop, akRight]
              Caption = 'Only Transfer Map to Windows Clipboard'
              TabOrder = 0
            end
            object chxAppendFloodCert: TCheckBox
              Left = 24
              Top = 32
              Width = 231
              Height = 17
              Anchors = [akTop, akRight]
              Caption = 'Transfer to FEMA Flood Determination form'
              TabOrder = 1
            end
            object edtGeoResult: TEdit
              Left = 78
              Top = 52
              Width = 179
              Height = 21
              Anchors = [akTop, akRight]
              AutoSize = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object edtZip4: TEdit
              Left = 322
              Top = 52
              Width = 75
              Height = 21
              Anchors = [akTop, akRight]
              AutoSize = False
              TabOrder = 3
            end
            object edtSFHA: TEdit
              Left = 170
              Top = 83
              Width = 33
              Height = 21
              Anchors = [akTop, akRight]
              AutoSize = False
              TabOrder = 4
            end
            object edtSFHAPhrase: TEdit
              Left = 228
              Top = 83
              Width = 171
              Height = 21
              Anchors = [akTop, akRight]
              AutoSize = False
              TabOrder = 5
            end
            object edtPanel: TEdit
              Left = 69
              Top = 108
              Width = 89
              Height = 21
              Anchors = [akTop, akRight]
              AutoSize = False
              TabOrder = 6
            end
            object edtPanelDate: TEdit
              Left = 230
              Top = 108
              Width = 89
              Height = 21
              Anchors = [akTop, akRight]
              AutoSize = False
              TabOrder = 7
            end
            object edtZone: TEdit
              Left = 366
              Top = 108
              Width = 32
              Height = 21
              Anchors = [akTop, akRight]
              AutoSize = False
              TabOrder = 8
            end
            object edtCommunity: TEdit
              Left = 93
              Top = 140
              Width = 68
              Height = 21
              Anchors = [akTop, akRight]
              AutoSize = False
              TabOrder = 9
            end
            object edtCommunityName: TEdit
              Left = 230
              Top = 140
              Width = 171
              Height = 21
              Anchors = [akTop, akRight]
              AutoSize = False
              TabOrder = 10
            end
            object edtLong: TEdit
              Left = 82
              Top = 169
              Width = 121
              Height = 21
              Anchors = [akTop, akRight]
              AutoSize = False
              TabOrder = 11
            end
            object edtCensus: TEdit
              Left = 297
              Top = 170
              Width = 104
              Height = 21
              Anchors = [akTop, akRight]
              AutoSize = False
              TabOrder = 12
            end
            object edtLat: TEdit
              Left = 78
              Top = 209
              Width = 121
              Height = 21
              Anchors = [akTop, akRight]
              AutoSize = False
              TabOrder = 13
            end
            object edtFIPS: TEdit
              Left = 297
              Top = 209
              Width = 104
              Height = 21
              Anchors = [akTop, akRight]
              AutoSize = False
              TabOrder = 14
            end
            object edtMapNumber: TEdit
              Left = 99
              Top = 239
              Width = 120
              Height = 21
              Anchors = [akTop, akRight]
              AutoSize = False
              TabOrder = 15
            end
          end
          object leftPanel: TPanel
            Left = 0
            Top = 0
            Width = 567
            Height = 433
            Align = alClient
            TabOrder = 1
            object MapImage: TImage
              Left = 1
              Top = 1
              Width = 573
              Height = 442
              Align = alClient
              AutoSize = True
              Stretch = True
            end
          end
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1046
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      1046
      49)
    object btnLocate: TButton
      Left = 410
      Top = 8
      Width = 75
      Height = 25
      Anchors = []
      Caption = 'Locate'
      TabOrder = 0
      OnClick = btnLocateClick
    end
    object btnCancel: TButton
      Left = 545
      Top = 8
      Width = 76
      Height = 25
      Anchors = []
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object AnimateProgress: TAnimate
      Left = 7
      Top = 2
      Width = 48
      Height = 45
      StopFrame = 8
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 510
    Width = 1046
    Height = 19
    Panels = <>
  end
end
