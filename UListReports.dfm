object ReportList: TReportList
  Left = 690
  Top = 283
  Width = 794
  Height = 465
  BorderIcons = [biSystemMenu]
  Caption = 'List of Reports'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 41
    Width = 786
    Height = 374
    ActivePage = TabExport
    Align = alClient
    TabOrder = 0
    TabWidth = 100
    object TabList: TTabSheet
      Caption = 'Reports'
      object ReportGrid: TdxDBGrid
        Left = 0
        Top = 0
        Width = 774
        Height = 341
        Bands = <
          item
          end>
        DefaultLayout = True
        HeaderPanelRowCount = 1
        KeyField = 'ReportID'
        ShowGroupPanel = True
        SummaryGroups = <>
        SummarySeparator = ', '
        Align = alClient
        TabOrder = 0
        OnDblClick = ReportGridDblClick
        DataSource = ListDMMgr.ReportDataSource
        Filter.Active = True
        Filter.CaseInsensitive = True
        Filter.Criteria = {00000000}
        GroupPanelColor = clBackground
        OptionsBehavior = [edgoAutoCopySelectedToClipboard, edgoAutoSort, edgoCaseInsensitive, edgoDblClick, edgoDragScroll, edgoEditing, edgoEnterShowEditor, edgoHorzThrough, edgoImmediateEditor, edgoMultiSelect, edgoMultiSort, edgoShowHourGlass, edgoStoreToIniFile, edgoTabs, edgoTabThrough, edgoVertThrough]
        OptionsCustomize = [edgoBandMoving, edgoBandSizing, edgoColumnMoving, edgoColumnSizing, edgoNotHideColumn]
        OptionsDB = [edgoCanAppend, edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks, edgoUseLocate]
        OptionsView = [edgoBandHeaderWidth, edgoDrawEndEllipsis, edgoIndicator]
        OnEditChange = ReportGridEditChange
        object ReportGridReportType: TdxDBGridColumn
          Alignment = taLeftJustify
          Caption = 'Type'
          HeaderAlignment = taCenter
          Sorted = csUp
          Width = 60
          BandIndex = 0
          RowIndex = 0
          FieldName = 'ReportType'
        end
        object ReportGridFileNo: TdxDBGridColumn
          Tag = 1
          Alignment = taLeftJustify
          HeaderAlignment = taCenter
          Width = 75
          BandIndex = 0
          RowIndex = 0
          FieldName = 'FileNo'
        end
        object ReportGridSearchKeyWords: TdxDBGridColumn
          Tag = 2
          HeaderAlignment = taCenter
          Width = 120
          BandIndex = 0
          RowIndex = 0
          FieldName = 'SearchKeyWords'
        end
        object ReportGridStreetNumber: TdxDBGridColumn
          Tag = 3
          Caption = 'Street No.'
          HeaderAlignment = taCenter
          Width = 75
          BandIndex = 0
          RowIndex = 0
          FieldName = 'StreetNumber'
        end
        object ReportGridStreetName: TdxDBGridColumn
          Tag = 4
          HeaderAlignment = taCenter
          Width = 100
          BandIndex = 0
          RowIndex = 0
          FieldName = 'StreetName'
        end
        object ReportGridCity: TdxDBGridColumn
          Tag = 5
          HeaderAlignment = taCenter
          Width = 100
          BandIndex = 0
          RowIndex = 0
          FieldName = 'City'
        end
        object ReportGridState: TdxDBGridColumn
          Tag = 6
          HeaderAlignment = taCenter
          Width = 50
          BandIndex = 0
          RowIndex = 0
          FieldName = 'State'
        end
        object ReportGridZip: TdxDBGridColumn
          Tag = 7
          HeaderAlignment = taCenter
          Width = 50
          BandIndex = 0
          RowIndex = 0
          FieldName = 'Zip'
        end
        object ReportGridCounty: TdxDBGridColumn
          Tag = 8
          HeaderAlignment = taCenter
          Width = 90
          BandIndex = 0
          RowIndex = 0
          FieldName = 'County'
        end
        object ReportGridCensusTract: TdxDBGridColumn
          Tag = 9
          Width = 100
          BandIndex = 0
          RowIndex = 0
          FieldName = 'CensusTract'
        end
        object ReportGridParcelNo: TdxDBGridColumn
          Tag = 10
          Width = 100
          BandIndex = 0
          RowIndex = 0
          FieldName = 'ParcelNo'
        end
        object ReportGridNeighborhood: TdxDBGridColumn
          Tag = 11
          Width = 110
          BandIndex = 0
          RowIndex = 0
          FieldName = 'Neighborhood'
        end
        object ReportGridMapRef: TdxDBGridColumn
          Tag = 12
          Width = 75
          BandIndex = 0
          RowIndex = 0
          FieldName = 'MapRef'
        end
        object ReportGridTotalRooms: TdxDBGridColumn
          Tag = 13
          Caption = 'Total Rms'
          Width = 75
          BandIndex = 0
          RowIndex = 0
          FieldName = 'TotalRooms'
        end
        object ReportGridBedRooms: TdxDBGridColumn
          Tag = 14
          Caption = 'BedRms'
          Width = 75
          BandIndex = 0
          RowIndex = 0
          FieldName = 'BedRooms'
        end
        object ReportGridBathRooms: TdxDBGridColumn
          Tag = 15
          Caption = 'BathRms'
          Width = 75
          BandIndex = 0
          RowIndex = 0
          FieldName = 'BathRooms'
        end
        object ReportGridGrossLivingArea: TdxDBGridColumn
          Tag = 16
          Caption = 'GrossLivArea'
          Width = 100
          BandIndex = 0
          RowIndex = 0
          FieldName = 'GrossLivingArea'
        end
        object ReportGridBorrower: TdxDBGridColumn
          Tag = 17
          Width = 124
          BandIndex = 0
          RowIndex = 0
          FieldName = 'Borrower'
        end
        object ReportGridClient: TdxDBGridColumn
          Tag = 18
          Width = 124
          BandIndex = 0
          RowIndex = 0
          FieldName = 'Client'
        end
        object ReportGridAuthor: TdxDBGridColumn
          Tag = 19
          Width = 124
          BandIndex = 0
          RowIndex = 0
          FieldName = 'Author'
        end
        object ReportGridAppraisalDate: TdxDBGridColumn
          Tag = 20
          Width = 90
          BandIndex = 0
          RowIndex = 0
          FieldName = 'AppraisalDate'
        end
        object ReportGridAppraisalValue: TdxDBGridColumn
          Tag = 21
          Width = 95
          BandIndex = 0
          RowIndex = 0
          FieldName = 'AppraisalValue'
        end
        object ReportGridDateCreated: TdxDBGridDateColumn
          Tag = 22
          Width = 100
          BandIndex = 0
          RowIndex = 0
          FieldName = 'DateCreated'
        end
        object ReportGridLastModified: TdxDBGridDateColumn
          Tag = 23
          Width = 100
          BandIndex = 0
          RowIndex = 0
          FieldName = 'LastModified'
        end
        object ReportGridReportPath: TdxDBGridColumn
          Tag = 24
          Width = 700
          BandIndex = 0
          RowIndex = 0
          FieldName = 'ReportPath'
        end
      end
    end
    object TabPref: TTabSheet
      Caption = 'Preferences'
      ImageIndex = 1
      object FieldListTL: TdxTreeList
        Left = 0
        Top = 0
        Width = 254
        Height = 341
        Bands = <
          item
          end>
        DefaultLayout = True
        HeaderPanelRowCount = 1
        Align = alLeft
        TabOrder = 0
        Options = [aoEditing, aoTabThrough, aoImmediateEditor]
        OptionsEx = [aoUseBitmap, aoBandHeaderWidth, aoAutoCalcPreviewLines, aoBandSizing, aoBandMoving, aoEnterShowEditor, aoDragScroll, aoDragExpand, aoKeepColumnWidth]
        TreeLineColor = clGrayText
        ShowGrid = True
        ShowRoot = False
        object VisibleC: TdxTreeListCheckColumn
          Alignment = taCenter
          Caption = 'Visible'
          HeaderAlignment = taCenter
          Width = 50
          BandIndex = 0
          RowIndex = 0
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          OnToggleClick = VisibleCToggleClick
        end
        object FieldC: TdxTreeListColumn
          Caption = 'Field'
          DisableDragging = True
          DisableEditor = True
          HeaderAlignment = taCenter
          ReadOnly = True
          Width = 180
          BandIndex = 0
          RowIndex = 0
        end
      end
      object btnRestore: TButton
        Left = 320
        Top = 16
        Width = 89
        Height = 25
        Hint = 'Restores the default grid layout'
        Caption = 'Restore Defaults'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btnRestoreClick
      end
    end
    object TabExport: TTabSheet
      Caption = 'Options'
      ImageIndex = 2
      object lblFeedback: TLabel
        Left = 376
        Top = 24
        Width = 3
        Height = 13
      end
      object Label2: TLabel
        Left = 24
        Top = 250
        Width = 232
        Height = 13
        Caption = 'The current Reports List will be renamed as *.bak'
      end
      object Label4: TLabel
        Left = 24
        Top = 232
        Width = 129
        Height = 13
        Caption = 'Note: When Rebuilding . . .'
      end
      object Label5: TLabel
        Left = 24
        Top = 267
        Width = 259
        Height = 13
        Caption = 'The rebuild process starts with a new, empty database.'
      end
      object btnPrint: TButton
        Left = 24
        Top = 64
        Width = 75
        Height = 25
        Caption = 'Print'
        TabOrder = 0
        OnClick = btnPrintClick
      end
      object rdoExportText: TRadioButton
        Left = 112
        Top = 128
        Width = 113
        Height = 17
        Caption = 'to Text File'
        Checked = True
        TabOrder = 1
        TabStop = True
      end
      object rdoExportExcell: TRadioButton
        Left = 208
        Top = 128
        Width = 81
        Height = 17
        Caption = 'to Excel'
        TabOrder = 2
      end
      object btnExport: TButton
        Left = 24
        Top = 123
        Width = 75
        Height = 25
        Caption = 'Export'
        TabOrder = 3
        OnClick = btnExportClick
      end
      object ckbSelectedOnly: TCheckBox
        Left = 24
        Top = 24
        Width = 129
        Height = 17
        Caption = 'Only selected records'
        TabOrder = 4
      end
      object btnRebuild: TButton
        Left = 24
        Top = 192
        Width = 75
        Height = 25
        Hint = 'The entire list of reports will be rebuilt'
        Caption = 'Rebuild List'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = btnRebuildClick
      end
      object btnCancelRebuild: TButton
        Left = 136
        Top = 192
        Width = 75
        Height = 25
        Caption = 'Cancel'
        TabOrder = 6
        OnClick = btnCancelRebuildClick
      end
      object lbxFileNames: TListBox
        Left = 376
        Top = 48
        Width = 313
        Height = 265
        ItemHeight = 13
        TabOrder = 7
      end
    end
  end
  object ReportSB: TStatusBar
    Left = 0
    Top = 415
    Width = 786
    Height = 19
    Panels = <>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 786
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object lblFor: TLabel
      Left = 287
      Top = 8
      Width = 12
      Height = 13
      Caption = 'for'
    end
    object lblSearch: TLabel
      Left = 137
      Top = 9
      Width = 34
      Height = 13
      Caption = 'Search'
    end
    object btnNew: TButton
      Left = 2
      Top = 4
      Width = 63
      Height = 25
      Hint = 'Creates a new entry in the Reports List'
      Caption = 'New'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnNewClick
    end
    object btnDelete: TButton
      Left = 70
      Top = 4
      Width = 59
      Height = 25
      Hint = 'Deletes the current entry in the Reports List'
      Caption = 'Delete'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnDeleteClick
    end
    object btnOpen: TButton
      Left = 640
      Top = 4
      Width = 62
      Height = 25
      Hint = 'Opend the selected file'
      Caption = 'Open'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnOpenClick
    end
    object btnOpenClone: TButton
      Left = 549
      Top = 4
      Width = 82
      Height = 25
      Hint = 'Opens the selected file as a clone'
      Caption = 'Open as Clone'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnOpenCloneClick
    end
    object btnFind: TButton
      Left = 442
      Top = 4
      Width = 65
      Height = 25
      Caption = 'Search'
      TabOrder = 6
      OnClick = OnBtnFilterClick
    end
    object cmbFields: TComboBox
      Left = 177
      Top = 6
      Width = 105
      Height = 21
      ItemHeight = 13
      TabOrder = 4
      Text = 'Specify Column'
      OnChange = OnFilterFieldChanged
    end
    object edtFilter: TEdit
      Left = 304
      Top = 6
      Width = 131
      Height = 21
      TabOrder = 5
      OnChange = OnEditFilterChanged
    end
    object btnClose: TButton
      Left = 710
      Top = 4
      Width = 65
      Height = 25
      Hint = 'Closes the window. Changes are saved automatically'
      Cancel = True
      Caption = 'Close'
      ModalResult = 2
      TabOrder = 7
    end
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 584
    Top = 352
  end
  object dxComponentPrinter1: TdxComponentPrinter
    CurrentLink = dxComponentPrinter1Link1
    PreviewOptions.PreviewBoundsRect = {000000000000000056050000D8020000}
    Version = 0
    Left = 640
    Top = 352
    object dxComponentPrinter1Link1: TdxDBGridReportLink
      Active = True
      Caption = 'New Report'
      Component = ReportGrid
      DateTime = 43389.543657511570000000
      DesignerHelpContext = 0
      PrinterPage.Footer = 250
      PrinterPage.Header = 250
      PrinterPage.Margins.Bottom = 500
      PrinterPage.Margins.Left = 500
      PrinterPage.Margins.Right = 500
      PrinterPage.Margins.Top = 500
      PrinterPage.MinMargins.Bottom = 0
      PrinterPage.MinMargins.Left = 0
      PrinterPage.MinMargins.Right = 0
      PrinterPage.MinMargins.Top = 0
      PrinterPage.PageFooter.Font.Charset = DEFAULT_CHARSET
      PrinterPage.PageFooter.Font.Color = clWindowText
      PrinterPage.PageFooter.Font.Height = -11
      PrinterPage.PageFooter.Font.Name = 'Tahoma'
      PrinterPage.PageFooter.Font.Style = []
      PrinterPage.PageHeader.Font.Charset = DEFAULT_CHARSET
      PrinterPage.PageHeader.Font.Color = clWindowText
      PrinterPage.PageHeader.Font.Height = -11
      PrinterPage.PageHeader.Font.Name = 'Tahoma'
      PrinterPage.PageHeader.Font.Style = []
      PrinterPage.PageSize.X = 8500
      PrinterPage.PageSize.Y = 11000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 1
      ReportTitle.Font.Charset = DEFAULT_CHARSET
      ReportTitle.Font.Color = clWindowText
      ReportTitle.Font.Height = -19
      ReportTitle.Font.Name = 'Times New Roman'
      ReportTitle.Font.Style = [fsBold]
      BandFont.Charset = DEFAULT_CHARSET
      BandFont.Color = clWindowText
      BandFont.Height = -11
      BandFont.Name = 'Times New Roman'
      BandFont.Style = []
      EvenFont.Charset = DEFAULT_CHARSET
      EvenFont.Color = clWindowText
      EvenFont.Height = -11
      EvenFont.Name = 'Times New Roman'
      EvenFont.Style = []
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'Times New Roman'
      FooterFont.Style = []
      GroupNodeFont.Charset = DEFAULT_CHARSET
      GroupNodeFont.Color = clWindowText
      GroupNodeFont.Height = -11
      GroupNodeFont.Name = 'Times New Roman'
      GroupNodeFont.Style = []
      HeaderFont.Charset = DEFAULT_CHARSET
      HeaderFont.Color = clWindowText
      HeaderFont.Height = -11
      HeaderFont.Name = 'Times New Roman'
      HeaderFont.Style = []
      OddFont.Charset = DEFAULT_CHARSET
      OddFont.Color = clWindowText
      OddFont.Height = -11
      OddFont.Name = 'Times New Roman'
      OddFont.Style = []
      Options = [tlpoBands, tlpoHeaders, tlpoFooters, tlpoRowFooters, tlpoPreview, tlpoPreviewGrid, tlpoGrid, tlpoFlatCheckMarks, tlpoSoft3D, tlpoRowFooterGrid, tlpoExpandButtons]
      PreviewFont.Charset = DEFAULT_CHARSET
      PreviewFont.Color = clWindowText
      PreviewFont.Height = -11
      PreviewFont.Name = 'Times New Roman'
      PreviewFont.Style = []
      RowFooterFont.Charset = DEFAULT_CHARSET
      RowFooterFont.Color = clWindowText
      RowFooterFont.Height = -11
      RowFooterFont.Name = 'Times New Roman'
      RowFooterFont.Style = []
      BuiltInReportLink = True
    end
  end
  object SelectFolderDialog: TRzSelectFolderDialog
    Options = [sfdoContextMenus, sfdoShowHidden]
    Left = 540
    Top = 353
  end
end
