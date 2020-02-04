object WPDFConfig2: TWPDFConfig2
  Left = 553
  Top = 160
  Width = 613
  Height = 631
  Caption = 'Create Adobe PDF File'
  Color = clBtnFace
  Constraints.MinHeight = 630
  Constraints.MinWidth = 600
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 576
    Width = 601
    Height = 19
    Panels = <>
    SimplePanel = True
    SimpleText = '   Press SHIFT to select or deselect multiple pages'
  end
  object PageControl: TPageControl
    Left = 0
    Top = 45
    Width = 601
    Height = 132
    ActivePage = security
    Align = alTop
    TabOrder = 1
    TabWidth = 75
    object security: TTabSheet
      Caption = 'Security'
      ImageIndex = 2
      object LabelViewPSW: TLabel
        Left = 284
        Top = 36
        Width = 81
        Height = 13
        Caption = 'Viewer Password'
      end
      object LabelNotReqed: TLabel
        Left = 384
        Top = 56
        Width = 62
        Height = 13
        Caption = '(not required)'
        Visible = False
      end
      object cbxEncrypt: TCheckBox
        Left = 5
        Top = 11
        Width = 204
        Height = 17
        Caption = 'Protect PDF File'
        TabOrder = 0
        OnClick = cbxEncryptClick
      end
      object edtUserPSW: TEdit
        Left = 284
        Top = 54
        Width = 89
        Height = 21
        TabOrder = 1
      end
      object cbxViewOnly: TCheckBox
        Left = 20
        Top = 59
        Width = 133
        Height = 17
        Caption = 'Allow View Only'
        TabOrder = 2
        OnClick = cbxViewOnlyClick
      end
      object cbxAllowPrint: TCheckBox
        Left = 20
        Top = 35
        Width = 149
        Height = 17
        Caption = 'Allow View and Printing'
        TabOrder = 3
        OnClick = cbxNotViewOnlyClick
      end
      object cbxAllowCopy: TCheckBox
        Left = 175
        Top = 35
        Width = 106
        Height = 17
        Caption = 'Allow Copying'
        TabOrder = 4
        OnClick = cbxNotViewOnlyClick
      end
      object cbxAllowChange: TCheckBox
        Left = 175
        Top = 59
        Width = 105
        Height = 17
        Caption = 'Allow Changes'
        TabOrder = 5
        OnClick = cbxNotViewOnlyClick
      end
    end
    object general: TTabSheet
      Caption = 'Properties'
      object Label4: TLabel
        Left = 8
        Top = 7
        Width = 31
        Height = 13
        Caption = 'Author'
      end
      object Label5: TLabel
        Left = 8
        Top = 31
        Width = 36
        Height = 13
        Caption = 'Subject'
      end
      object cbxThumbnails: TCheckBox
        Left = 8
        Top = 62
        Width = 177
        Height = 17
        Caption = 'Include Thumbnail Page Images'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object cbxBookmarks: TCheckBox
        Left = 224
        Top = 61
        Width = 121
        Height = 17
        Caption = 'Include Bookmarks'
        Enabled = False
        TabOrder = 1
        Visible = False
      end
      object edtAuthor: TEdit
        Left = 48
        Top = 5
        Width = 320
        Height = 21
        TabOrder = 2
      end
      object edtSubject: TEdit
        Left = 48
        Top = 29
        Width = 320
        Height = 21
        TabOrder = 3
      end
    end
    object Advanced: TTabSheet
      Caption = 'Advanced'
      ImageIndex = 1
      object CompressionGroup: TRadioGroup
        Left = 216
        Top = 8
        Width = 113
        Height = 89
        Caption = 'Compression'
        ItemIndex = 1
        Items.Strings = (
          'None'
          'Compress')
        TabOrder = 0
      end
      object FontEmbedGroup: TRadioGroup
        Left = 24
        Top = 8
        Width = 153
        Height = 89
        Caption = 'Embed Fonts'
        ItemIndex = 1
        Items.Strings = (
          'No Embedded Fonts'
          'Embed TrueType Fonts')
        TabOrder = 1
      end
    end
  end
  object PrListGrid: TtsGrid
    Left = 0
    Top = 177
    Width = 601
    Height = 399
    Cursor = crArrow
    Hint = 'Press SHIFT to select all pages'
    Align = alClient
    AlwaysShowFocus = True
    AlwaysShowScrollBar = ssVertical
    CheckBoxStyle = stCheck
    Cols = 2
    DefaultRowHeight = 20
    ExportDelimiter = ','
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    HeadingHorzAlignment = htaCenter
    HeadingFont.Charset = DEFAULT_CHARSET
    HeadingFont.Color = clWindowText
    HeadingFont.Height = -11
    HeadingFont.Name = 'MS Sans Serif'
    HeadingFont.Style = []
    HeadingHeight = 20
    HeadingVertAlignment = vtaCenter
    ParentFont = False
    ParentShowHint = False
    RowBarIndicator = False
    RowBarOn = False
    Rows = 1
    ScrollBars = ssVertical
    ShowHint = True
    StoreData = True
    TabOrder = 2
    ThumbTracking = True
    Version = '3.01.08'
    WordWrap = wwOff
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    OnClickCell = PrListGridClickCell
    ColProperties = <
      item
        DataCol = 1
        Col.ControlType = ctCheck
        Col.Heading = 'Include'
        Col.HeadingHorzAlignment = htaCenter
        Col.HeadingVertAlignment = vtaCenter
        Col.Width = 50
      end
      item
        DataCol = 2
        Col.Heading = 'Page Title'
        Col.ReadOnly = True
        Col.Width = 345
      end>
    CellProperties = <
      item
        DataCol = 1
        DataRow = 1
        Cell.Font.Charset = DEFAULT_CHARSET
        Cell.Font.Color = clWindowText
        Cell.Font.Height = -11
        Cell.Font.Name = 'MS Sans Serif'
        Cell.Font.Style = []
        Cell.ParentFont = False
      end>
    Data = {0100000002000000010000000001000000000000000000000000}
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 601
    Height = 45
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object btnCreatePDF: TButton
      Left = 202
      Top = 10
      Width = 73
      Height = 25
      Caption = 'Create PDF'
      Default = True
      TabOrder = 0
      OnClick = btnCreatePDFClick
    end
    object btnCancel: TButton
      Left = 291
      Top = 10
      Width = 73
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object cbxLaunchPDF: TCheckBox
      Left = 7
      Top = 14
      Width = 154
      Height = 17
      Caption = 'Auto Launch PDF File'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 2
    end
  end
  object PDFSaveDialog: TSaveDialog
    DefaultExt = 'pdf'
    Filter = 'PDF|*.pdf'
    Left = 360
    Top = 40
  end
end
