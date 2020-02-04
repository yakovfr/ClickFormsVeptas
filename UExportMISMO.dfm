object ExportMISMOReport: TExportMISMOReport
  Left = 720
  Top = 205
  Width = 659
  Height = 552
  BorderIcons = [biSystemMenu]
  Caption = 'Send Appraisal Report (MISMO XML)'
  Color = clBtnFace
  Constraints.MinHeight = 512
  Constraints.MinWidth = 575
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 643
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      643
      57)
    object RzLine1: TRzLine
      Left = 112
      Top = 19
      Width = 51
      Height = 20
    end
    object RzLine2: TRzLine
      Left = 236
      Top = 19
      Width = 57
      Height = 20
    end
    object btnValidate: TButton
      Left = 34
      Top = 16
      Width = 81
      Height = 25
      Caption = 'Validate XML'
      TabOrder = 0
      OnClick = btnValidateClick
    end
    object btnSend: TButton
      Left = 293
      Top = 16
      Width = 81
      Height = 25
      Caption = 'Send'
      TabOrder = 1
      OnClick = btnSendClick
    end
    object btnClose: TButton
      Left = 553
      Top = 16
      Width = 81
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Close'
      TabOrder = 2
      OnClick = btnCloseClick
    end
    object btnReviewPDF: TButton
      Left = 163
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Review PDF'
      TabOrder = 3
      OnClick = btnReviewPDFClick
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 57
    Width = 643
    Height = 440
    ActivePage = PgSuccess
    Align = alClient
    TabOrder = 1
    TabWidth = 125
    object PgInfluenceInfo: TTabSheet
      Caption = 'Undue Influence'
      ImageIndex = 4
      DesignSize = (
        635
        412)
      object GroupBox1: TGroupBox
        Left = 24
        Top = 16
        Width = 513
        Height = 379
        Anchors = [akLeft, akTop, akBottom]
        TabOrder = 0
        DesignSize = (
          513
          379)
        object Label1: TLabel
          Left = 23
          Top = 24
          Width = 378
          Height = 13
          Caption = 
            'Was any attempt made by the lender to place undue influence on t' +
            'he appraiser?'
        end
        object lblInfluence: TLabel
          Left = 24
          Top = 90
          Width = 379
          Height = 13
          Caption = 
            'If yes, please elaborate on the attempt to place undue influence' +
            ' on the appraiser'
        end
        object radbtnNo: TRadioButton
          Left = 24
          Top = 56
          Width = 49
          Height = 17
          Caption = 'No'
          TabOrder = 0
          OnClick = radbtnNoClick
        end
        object radBtnYes: TRadioButton
          Left = 72
          Top = 56
          Width = 41
          Height = 17
          Caption = 'Yes'
          TabOrder = 1
          OnClick = radBtnYesClick
        end
        object menoInfluence: TMemo
          Left = 24
          Top = 112
          Width = 457
          Height = 243
          Anchors = [akLeft, akTop, akBottom]
          TabOrder = 2
          OnKeyPress = menoInfluenceKeyPress
        end
        object btnNext: TButton
          Left = 328
          Top = 52
          Width = 75
          Height = 25
          Caption = 'Continue'
          TabOrder = 3
          OnClick = btnNextClick
        end
      end
    end
    object PgSelectForms: TTabSheet
      Caption = 'Specify Report Forms'
      OnShow = PgSelectFormsShow
      object ExportFormGrid: TosAdvDbGrid
        Left = 0
        Top = 0
        Width = 643
        Height = 414
        Align = alClient
        TabOrder = 0
        StoreData = True
        ExportDelimiter = ','
        FieldState = fsCustomized
        Rows = 4
        Cols = 2
        Version = '3.01.08'
        XMLExport.Version = '1.0'
        XMLExport.DataPacketVersion = '2.0'
        GridOptions.Color = clWindow
        GridOptions.DefaultButtonWidth = 11
        GridOptions.DefaultButtonHeight = 9
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
          end>
        Data = {0000000000000000}
      end
    end
    object PgXMLErrorList: TTabSheet
      Caption = 'Validation Errors'
      ImageIndex = 1
      object XMLErrorGrid: TosAdvDbGrid
        Left = 0
        Top = 0
        Width = 643
        Height = 414
        Align = alClient
        TabOrder = 0
        StoreData = True
        ExportDelimiter = ','
        FieldState = fsCustomized
        Rows = 4
        Cols = 5
        Version = '3.01.08'
        XMLExport.Version = '1.0'
        XMLExport.DataPacketVersion = '2.0'
        GridOptions.ButtonEdgeWidth = 3
        GridOptions.Color = clWindow
        GridOptions.DefaultButtonWidth = 35
        GridOptions.DefaultButtonHeight = 9
        GridOptions.FlatButtons = False
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
        SelectionOptions.CellSelectMode = cmNone
        SelectionOptions.ColSelectMode = csNone
        SelectionOptions.RowSelectMode = rsNone
        ScrollingOptions.ThumbTracking = True
        RowOptions.RowBarIndicator = False
        RowOptions.RowBarOn = False
        RowOptions.RowMoving = False
        RowOptions.DefaultRowHeight = 18
        GroupingSortingOptions.AnsiSort = False
        GroupingSortingOptions.GroupFont.Charset = DEFAULT_CHARSET
        GroupingSortingOptions.GroupFont.Color = clWindowText
        GroupingSortingOptions.GroupFont.Height = -11
        GroupingSortingOptions.GroupFont.Name = 'MS Sans Serif'
        GroupingSortingOptions.GroupFont.Style = []
        GroupingSortingOptions.GroupFootersOn = False
        PrintOptions.PrintWithGridFormats = True
        OnButtonClick = XMLErrorGridButtonClick
        OnDblClickCell = XMLErrorGridDblClickCell
        ColProperties = <
          item
            DataCol = 1
            Col.Heading = 'Form'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaCenter
            Col.Width = 80
            Col.AssignedValues = '?'
          end
          item
            DataCol = 2
            Col.Heading = 'Page'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaCenter
            Col.Width = 35
            Col.AssignedValues = '?'
          end
          item
            DataCol = 3
            Col.Heading = 'Cell'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaCenter
            Col.Width = 35
            Col.AssignedValues = '?'
          end
          item
            DataCol = 4
            Col.Heading = 'Error Message'
            Col.Width = 300
            Col.AssignedValues = '?'
          end
          item
            DataCol = 5
            Col.ButtonType = btNormal
            Col.Heading = 'Locate'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaCenter
            Col.Width = 45
            Col.AssignedValues = '?'
          end>
        Data = {0000000000000000}
      end
    end
    object PgRELSErrorList: TTabSheet
      Caption = 'RELS Validation Errors'
      ImageIndex = 3
      object ConditionLbl: TLabel
        Left = 8
        Top = 256
        Width = 124
        Height = 13
        Caption = 'Export this appraisal report'
      end
      object RELSErrorGrid: TosAdvDbGrid
        Left = 0
        Top = 0
        Width = 643
        Height = 414
        Align = alClient
        TabOrder = 0
        StoreData = True
        ExportDelimiter = ','
        FieldState = fsCustomized
        Rows = 4
        Cols = 4
        Version = '3.01.08'
        XMLExport.Version = '1.0'
        XMLExport.DataPacketVersion = '2.0'
        GridOptions.ButtonEdgeWidth = 3
        GridOptions.Color = clWindow
        GridOptions.DefaultButtonWidth = 35
        GridOptions.DefaultButtonHeight = 9
        GridOptions.FlatButtons = False
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
        SelectionOptions.CellSelectMode = cmNone
        SelectionOptions.ColSelectMode = csNone
        SelectionOptions.RowSelectMode = rsNone
        ScrollingOptions.ThumbTracking = True
        RowOptions.RowBarIndicator = False
        RowOptions.RowBarOn = False
        RowOptions.RowMoving = False
        RowOptions.DefaultRowHeight = 18
        GroupingSortingOptions.AnsiSort = False
        GroupingSortingOptions.GroupFont.Charset = DEFAULT_CHARSET
        GroupingSortingOptions.GroupFont.Color = clWindowText
        GroupingSortingOptions.GroupFont.Height = -11
        GroupingSortingOptions.GroupFont.Name = 'MS Sans Serif'
        GroupingSortingOptions.GroupFont.Style = []
        GroupingSortingOptions.GroupFootersOn = False
        PrintOptions.PrintWithGridFormats = True
        OnButtonClick = RELSErrorGridButtonClick
        OnDblClickCell = RELSErrorGridDblClickCell
        ColProperties = <
          item
            DataCol = 1
            Col.Heading = 'Type'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaCenter
            Col.Width = 70
            Col.AssignedValues = '?'
          end
          item
            DataCol = 2
            Col.Heading = 'Form Section'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaCenter
            Col.Width = 95
            Col.AssignedValues = '?'
          end
          item
            DataCol = 3
            Col.Heading = 'Description'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaCenter
            Col.Width = 345
            Col.WordWrap = wwOn
            Col.AssignedValues = '?'
          end
          item
            DataCol = 4
            Col.ButtonType = btNormal
            Col.Heading = 'Locate'
            Col.HeadingHorzAlignment = htaCenter
            Col.HorzAlignment = htaCenter
            Col.Width = 45
            Col.AssignedValues = '?'
          end>
        Data = {0000000000000000}
      end
    end
    object PgSuccess: TTabSheet
      Caption = 'Validation Errors'
      ImageIndex = 5
      object Memo1: TMemo
        Left = 48
        Top = 32
        Width = 513
        Height = 121
        Lines.Strings = (
          'REPORT VALIDATION WAS SUCCESSFUL.'
          ''
          
            'Your report data has been validated and is ready for final trans' +
            'mission. Please click the Send button to '
          'transmit.')
        TabOrder = 0
      end
    end
    object PgOptions: TTabSheet
      Caption = 'Sending Options'
      ImageIndex = 2
      DesignSize = (
        635
        412)
      object cbxSaveXMLFile: TCheckBox
        Left = 24
        Top = 26
        Width = 305
        Height = 17
        Caption = 'Save a copy of the exported XML file in this directory:'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = cbxSaveXMLFileClick
      end
      object edtXMLDirPath: TEdit
        Left = 54
        Top = 50
        Width = 480
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ReadOnly = True
        TabOrder = 1
        Text = 'XML Directory'
      end
      object btnBrowseXMLDir: TButton
        Left = 549
        Top = 47
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Browse'
        TabOrder = 2
        OnClick = btnBrowseXMLDirClick
      end
      object cbxCreatePDF: TCheckBox
        Left = 24
        Top = 120
        Width = 353
        Height = 17
        Caption = 'Save a copy of the FINAL PDF file in this directory:'
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnClick = cbxCreatePDFClick
      end
      object cbxDisplayPDF: TCheckBox
        Left = 54
        Top = 199
        Width = 243
        Height = 17
        Caption = 'Display PDF for final review before sending.'
        Checked = True
        State = cbChecked
        TabOrder = 4
        OnClick = cbxDisplayPDFClick
      end
      object RadioGroup1: TRadioGroup
        Left = 24
        Top = 280
        Width = 361
        Height = 105
        Caption = 'Report Images, Sketches, Maps and Signatures'
        ItemIndex = 2
        Items.Strings = (
          'Embed in XML file'
          'Reference from XML file'
          'Do nothing - PDF contains the images and signatures')
        TabOrder = 5
      end
      object cbxXML_UseCLKName: TCheckBox
        Left = 54
        Top = 79
        Width = 321
        Height = 17
        Caption = 'Save the XML file with same name as the ClickFORMS report.'
        Checked = True
        State = cbChecked
        TabOrder = 6
      end
      object edtPDFDirPath: TEdit
        Left = 54
        Top = 144
        Width = 480
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ReadOnly = True
        TabOrder = 7
        Text = 'PDF Directory'
      end
      object cbxPDF_UseCLKName: TCheckBox
        Left = 54
        Top = 173
        Width = 321
        Height = 17
        Caption = 'Save the PDF file with same name as the ClickFORMS report.'
        Checked = True
        State = cbChecked
        TabOrder = 8
      end
      object btnBrowsePDFDir: TButton
        Left = 549
        Top = 141
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Browse'
        TabOrder = 9
        OnClick = btnBrowsePDFDirClick
      end
      object cbxPDFShowPref: TCheckBox
        Left = 55
        Top = 224
        Width = 178
        Height = 17
        Caption = 'Display PDF Security Options.'
        Checked = True
        State = cbChecked
        TabOrder = 10
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 497
    Width = 643
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
end
