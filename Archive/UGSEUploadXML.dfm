object UploadUADXML: TUploadUADXML
  Left = 514
  Top = 226
  Width = 828
  Height = 576
  ActiveControl = Panel1
  Caption = 'Upload UAD XML'
  Color = clBtnFace
  Constraints.MinHeight = 136
  Constraints.MinWidth = 631
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 812
    Height = 145
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object rzlCFReview: TRzLine
      Left = 253
      Top = 11
      Width = 26
      Height = 20
      ShowArrows = saEnd
    end
    object lblSelAMC: TLabel
      Left = 544
      Top = 88
      Width = 56
      Height = 13
      Caption = 'Select AMC'
      Visible = False
    end
    object stProcessWait: TStaticText
      Left = 8
      Top = 118
      Width = 505
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BevelInner = bvLowered
      BevelKind = bkTile
      Caption = 
        'Outstanding Errors / Warnings, please run the Centract Quality R' +
        'eview'
      Color = clYellow
      ParentColor = False
      TabOrder = 3
      Transparent = False
      Visible = False
    end
    object bbtnCFReview: TBitBtn
      Left = 128
      Top = 8
      Width = 121
      Height = 25
      Caption = 'Report Review'
      TabOrder = 0
      OnClick = bbtnCFReviewClick
      NumGlyphs = 2
    end
    object bbtnCreateXML: TBitBtn
      Left = 278
      Top = 8
      Width = 107
      Height = 25
      Caption = 'Create XML'
      TabOrder = 1
      OnClick = bbtnCreateXMLClick
      NumGlyphs = 2
    end
    object bbtnClose: TBitBtn
      Left = 568
      Top = 8
      Width = 80
      Height = 25
      Caption = 'Close'
      TabOrder = 2
      OnClick = bbtnCloseClick
      NumGlyphs = 2
    end
    object bbtnExpCollapse: TBitBtn
      Left = 688
      Top = 48
      Width = 75
      Height = 25
      Caption = 'Collapse'
      TabOrder = 4
      OnClick = bbtnExpCollapseClick
    end
    object cmbAMClist: TComboBox
      Left = 616
      Top = 88
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 5
      Visible = False
    end
    object bbtnSendXML: TBitBtn
      Left = 448
      Top = 8
      Width = 105
      Height = 25
      Caption = 'Upload Report XML'
      TabOrder = 6
      OnClick = bbtnSendXMLClick
    end
    object btnSelectENV: TButton
      Left = 464
      Top = 48
      Width = 80
      Height = 25
      Caption = 'Create ENV File'
      TabOrder = 7
      OnClick = OnSelectEnv
    end
    object grpOverride: TGroupBox
      Left = 8
      Top = 40
      Width = 401
      Height = 49
      Caption = 'Override'
      TabOrder = 8
      object lblOverrideCode: TLabel
        Left = 216
        Top = 24
        Width = 96
        Height = 13
        Caption = 'Enter Override Code'
      end
      object bbtnRequestOverride: TBitBtn
        Left = 0
        Top = 16
        Width = 97
        Height = 25
        Caption = 'Request Override'
        TabOrder = 0
        OnClick = bbtnRequestOverrideClick
      end
      object bbtnOverride: TBitBtn
        Left = 112
        Top = 16
        Width = 97
        Height = 25
        Caption = 'Override'
        TabOrder = 1
        OnClick = bbtnOverrideClick
      end
      object edtOverrideCode: TEdit
        Left = 320
        Top = 16
        Width = 57
        Height = 21
        TabOrder = 2
      end
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 145
    Width = 812
    Height = 374
    ActivePage = PgSelectForms
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TabWidth = 125
    OnChange = PageControlChange
    object PgSelectForms: TTabSheet
      Caption = 'Report Form List'
      OnShow = PgSelectFormsShow
      object ExportFormGrid: TosAdvDbGrid
        Left = 0
        Top = 0
        Width = 804
        Height = 346
        Align = alClient
        TabOrder = 0
        Enabled = False
        StoreData = True
        ExportDelimiter = ','
        FieldState = fsCustomized
        Rows = 4
        Cols = 3
        Version = '3.01.08'
        XMLExport.Version = '1.0'
        XMLExport.DataPacketVersion = '2.0'
        GridOptions.Color = clWindow
        GridOptions.DefaultButtonWidth = 11
        GridOptions.DefaultButtonHeight = 9
        GridOptions.GridMode = gmBrowse
        GridOptions.TotalBandColor = clBtnFace
        ColumnOptions.ColMoving = False
        ColumnOptions.DefaultColWidth = 300
        ColumnOptions.ResizeCols = rcNone
        EditOptions.CheckBoxStyle = stXP
        MemoOptions.EditorShortCut = 0
        MemoOptions.EditorOptions = [moWordWrap, moWantTabs, moWantReturns, moSizeable]
        MemoOptions.ScrollBars = ssVertical
        HeadingOptions.Button = hbNone
        HeadingOptions.Color = clBtnFace
        HeadingOptions.Font.Charset = DEFAULT_CHARSET
        HeadingOptions.Font.Color = clWindowText
        HeadingOptions.Font.Height = -11
        HeadingOptions.Font.Name = 'MS Sans Serif'
        HeadingOptions.Font.Style = []
        HeadingOptions.Height = 16
        HeadingOptions.ParentFont = False
        ScrollingOptions.ThumbTracking = True
        RowOptions.ResizeRows = rrNone
        RowOptions.RowBarIndicator = False
        RowOptions.RowBarOn = False
        RowOptions.RowMoving = False
        RowOptions.DefaultRowHeight = 18
        GroupingSortingOptions.AnsiSort = False
        GroupingSortingOptions.SortOnHeadingClick = False
        GroupingSortingOptions.GroupFont.Charset = DEFAULT_CHARSET
        GroupingSortingOptions.GroupFont.Color = clWindowText
        GroupingSortingOptions.GroupFont.Height = -11
        GroupingSortingOptions.GroupFont.Name = 'MS Sans Serif'
        GroupingSortingOptions.GroupFont.Style = []
        GroupingSortingOptions.GroupFootersOn = False
        PrintOptions.PrintWithGridFormats = True
        OnClickCell = ExportFormGridClickCell
        ColProperties = <
          item
            DataCol = 1
            FieldName = 'Include'
            Col.ControlType = ctCheck
            Col.FieldName = 'Include'
            Col.Heading = 'Include'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaCenter
            Col.Width = 50
            Col.AssignedValues = '?'
          end
          item
            DataCol = 2
            Col.Heading = 'Report Form Name'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaLeft
            Col.Width = 400
            Col.AssignedValues = '?'
          end
          item
            DataCol = 3
            Col.Heading = 'Report Form ID'
            Col.HeadingFont.Charset = DEFAULT_CHARSET
            Col.HeadingFont.Color = clWindowText
            Col.HeadingFont.Height = -11
            Col.HeadingFont.Name = 'MS Sans Serif'
            Col.HeadingFont.Style = []
            Col.HeadingHorzAlignment = htaCenter
            Col.HeadingParentFont = False
            Col.HorzAlignment = htaRight
            Col.Visible = False
            Col.Width = 100
            Col.AssignedValues = '?'
          end>
        Data = {0000000000000000}
      end
    end
    object PgReviewErrs: TTabSheet
      Caption = 'UAD Review'
      ImageIndex = 6
      object CFReviewErrorGrid: TosAdvDbGrid
        Left = 0
        Top = 41
        Width = 804
        Height = 305
        Align = alClient
        TabOrder = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        StoreData = True
        ExportDelimiter = ','
        FieldState = fsCustomized
        Rows = 1
        Cols = 6
        Version = '3.01.08'
        XMLExport.Version = '1.0'
        XMLExport.DataPacketVersion = '2.0'
        GridOptions.ButtonEdgeWidth = 3
        GridOptions.Color = clWindow
        GridOptions.DefaultButtonWidth = 35
        GridOptions.DefaultButtonHeight = 9
        GridOptions.FlatButtons = False
        GridOptions.ParentFont = False
        GridOptions.TotalBandColor = clBtnFace
        ColumnOptions.ColMoving = False
        ColumnOptions.DefaultColWidth = 64
        ColumnOptions.ResizeCols = rcNone
        MemoOptions.EditorShortCut = 0
        MemoOptions.EditorOptions = [moWordWrap, moWantTabs, moWantReturns, moSizeable]
        MemoOptions.ScrollBars = ssVertical
        HeadingOptions.Button = hbNone
        HeadingOptions.Color = clBtnFace
        HeadingOptions.Font.Charset = DEFAULT_CHARSET
        HeadingOptions.Font.Color = clWindowText
        HeadingOptions.Font.Height = -11
        HeadingOptions.Font.Name = 'MS Sans Serif'
        HeadingOptions.Font.Style = []
        HeadingOptions.Height = 16
        HeadingOptions.ParentFont = False
        SelectionOptions.CellSelectMode = cmNone
        SelectionOptions.ColSelectMode = csNone
        SelectionOptions.RowSelectMode = rsNone
        ScrollingOptions.ThumbTracking = True
        RowOptions.RowBarIndicator = False
        RowOptions.RowBarOn = False
        RowOptions.RowMoving = False
        RowOptions.DefaultRowHeight = 28
        GroupingSortingOptions.AnsiSort = False
        GroupingSortingOptions.SortOnHeadingClick = False
        GroupingSortingOptions.GroupFont.Charset = DEFAULT_CHARSET
        GroupingSortingOptions.GroupFont.Color = clWindowText
        GroupingSortingOptions.GroupFont.Height = -11
        GroupingSortingOptions.GroupFont.Name = 'MS Sans Serif'
        GroupingSortingOptions.GroupFont.Style = []
        GroupingSortingOptions.GroupFootersOn = False
        PrintOptions.PrintWithGridFormats = True
        OnButtonClick = CFReviewErrorGridButtonClick
        OnDblClickCell = CFReviewErrorGridDblClickCell
        ColProperties = <
          item
            DataCol = 1
            Col.Heading = 'Type'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaCenter
            Col.Width = 50
            Col.AssignedValues = '?'
          end
          item
            DataCol = 2
            Col.ButtonType = btNormal
            Col.Heading = 'Locate'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaLeft
            Col.Width = 42
            Col.AssignedValues = '?'
          end
          item
            DataCol = 3
            Col.Heading = 'Error Message'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaCenter
            Col.Width = 400
            Col.AssignedValues = '?'
          end
          item
            DataCol = 4
            Col.Heading = 'Form'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaCenter
            Col.Width = 170
            Col.AssignedValues = '?'
          end
          item
            DataCol = 5
            Col.Heading = 'Page'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaCenter
            Col.Width = 35
            Col.AssignedValues = '?'
          end
          item
            DataCol = 6
            Col.Heading = 'Cell'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaCenter
            Col.Width = 35
            Col.AssignedValues = '?'
          end>
        Data = {0000000000000000}
      end
      object pnlCFReview: TPanel
        Left = 0
        Top = 0
        Width = 804
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object CFErrorText: TLabel
          Left = 7
          Top = 11
          Width = 402
          Height = 13
          AutoSize = False
          Caption = '999 Error(s) remaining     999 Warning(s) remaining'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
        object bbtnGoToSave: TBitBtn
          Left = 424
          Top = 5
          Width = 80
          Height = 24
          Caption = 'Continue'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = bbtnGoToSaveClick
          NumGlyphs = 2
        end
      end
    end
    object PgOptions: TTabSheet
      Caption = 'Preferences'
      ImageIndex = 2
      OnShow = OnSendOptionsShow
      DesignSize = (
        804
        346)
      object cbxCreatePDF: TCheckBox
        Left = 24
        Top = 24
        Width = 353
        Height = 17
        Caption = 'Save a copy of the FINAL PDF file in this directory:'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = cbxCreatePDFClick
      end
      object edtPDFDirPath: TEdit
        Left = 54
        Top = 48
        Width = 493
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ReadOnly = True
        TabOrder = 1
        Text = 'PDF Directory'
      end
      object cbxPDF_UseCLKName: TCheckBox
        Left = 54
        Top = 85
        Width = 321
        Height = 17
        Caption = 'Save the PDF file with same name as the ClickFORMS report.'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object btnBrowsePDFDir: TButton
        Left = 556
        Top = 44
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Browse'
        TabOrder = 3
        OnClick = btnBrowsePDFDirClick
      end
      object btnReviewPDF: TButton
        Left = 54
        Top = 113
        Width = 75
        Height = 25
        Caption = 'Review PDF'
        TabOrder = 4
        OnClick = btnReviewPDFClick
      end
    end
    object PgSuccess: TTabSheet
      Caption = 'Congratulations'
      ImageIndex = 5
      object stLastMsg: TStaticText
        Left = 17
        Top = 48
        Width = 504
        Height = 17
        BevelInner = bvLowered
        BevelKind = bkTile
        Caption = 
          'Your appraisal report was NOT accepted. It requires a successful' +
          ' Centract Quality Review before sending.'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        Transparent = False
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 519
    Width = 812
    Height = 19
    Panels = <>
  end
  object SaveDialog: TSaveDialog
    Left = 16
    Top = 432
  end
  object SelectFolderDialog: TRzSelectFolderDialog
    Left = 44
    Top = 433
  end
  object scripter: TDCScripter
    Events = <>
    ScriptName = 'Reviewer'
    Left = 72
    Top = 432
  end
  object OpenDialog: TOpenDialog
    Left = 108
    Top = 433
  end
end
