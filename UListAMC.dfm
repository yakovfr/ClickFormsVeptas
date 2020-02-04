object AMCList: TAMCList
  Left = 470
  Top = 239
  Width = 537
  Height = 400
  ActiveControl = LookupList
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = [biSystemMenu]
  Caption = 'AMC List'
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ClientsSB: TStatusBar
    Left = 0
    Top = 343
    Width = 521
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 521
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 1
    DesignSize = (
      521
      41)
    object btnTransfer: TButton
      Left = 261
      Top = 7
      Width = 75
      Height = 25
      Hint = 'Transfers the client info to the report'
      Caption = 'Transfer'
      ModalResult = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnTransferClick
    end
    object btnClose: TButton
      Left = 348
      Top = 7
      Width = 75
      Height = 25
      Hint = 'Closes the dialog'
      Cancel = True
      Caption = 'Close'
      ModalResult = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnCloseClick
    end
    object btnNew: TButton
      Left = 13
      Top = 8
      Width = 70
      Height = 25
      Hint = 'Creates a new client record'
      Anchors = [akLeft]
      Caption = 'New'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnNewClick
    end
    object btnSave: TButton
      Left = 91
      Top = 8
      Width = 70
      Height = 25
      Hint = 'Saves the current client record'
      Anchors = [akLeft]
      Caption = 'Save'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnSaveClick
    end
    object btnDelete: TButton
      Left = 169
      Top = 8
      Width = 70
      Height = 25
      Hint = 'Deletes the current client record'
      Caption = 'Delete'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = btnDeleteClick
    end
  end
  object LookupList: TListBox
    Left = 0
    Top = 41
    Width = 136
    Height = 302
    Hint = 'Double-click to transfer to report'
    Align = alLeft
    Constraints.MinWidth = 100
    ItemHeight = 13
    ParentShowHint = False
    ShowHint = True
    Sorted = True
    TabOrder = 2
    OnClick = LookupListClick
    OnDblClick = LookupListDblClick
    OnKeyDown = LookupListKeyDown
  end
  object PageControl: TPageControl
    Left = 136
    Top = 41
    Width = 385
    Height = 302
    ActivePage = InfoSheet
    Align = alClient
    Constraints.MinWidth = 300
    MultiLine = True
    TabOrder = 3
    TabWidth = 120
    object InfoSheet: TTabSheet
      Caption = 'Contact Info'
      Constraints.MinWidth = 100
      object Label14: TLabel
        Left = 7
        Top = 70
        Width = 44
        Height = 13
        Caption = 'Company'
      end
      object Label15: TLabel
        Left = 7
        Top = 95
        Width = 41
        Height = 13
        Caption = 'Address:'
      end
      object Label16: TLabel
        Left = 7
        Top = 116
        Width = 20
        Height = 13
        Caption = 'City:'
      end
      object Label18: TLabel
        Left = 7
        Top = 142
        Width = 34
        Height = 13
        Caption = 'Phone:'
      end
      object Label19: TLabel
        Left = 7
        Top = 168
        Width = 39
        Height = 13
        Caption = 'Cell Ph.:'
      end
      object Label20: TLabel
        Left = 7
        Top = 192
        Width = 32
        Height = 13
        Caption = 'E-Mail:'
      end
      object Label21: TLabel
        Left = 216
        Top = 116
        Width = 13
        Height = 13
        Caption = 'St.'
      end
      object Label22: TLabel
        Left = 172
        Top = 142
        Width = 17
        Height = 13
        Caption = 'Fax'
      end
      object Label23: TLabel
        Left = 172
        Top = 168
        Width = 28
        Height = 13
        Caption = 'Pager'
      end
      object Label24: TLabel
        Left = 288
        Top = 116
        Width = 15
        Height = 13
        Caption = 'Zip'
      end
      object Label1: TLabel
        Left = 7
        Top = 11
        Width = 43
        Height = 13
        Caption = 'Identifier:'
      end
      object Label3: TLabel
        Left = 7
        Top = 45
        Width = 37
        Height = 13
        Caption = 'Mr/Mrs:'
      end
      object Label4: TLabel
        Left = 92
        Top = 46
        Width = 19
        Height = 13
        Caption = 'First'
      end
      object Label5: TLabel
        Left = 220
        Top = 46
        Width = 20
        Height = 13
        Caption = 'Last'
      end
      object Label2: TLabel
        Left = 264
        Top = 12
        Width = 14
        Height = 13
        Caption = 'ID:'
      end
      object Label6: TLabel
        Left = 7
        Top = 215
        Width = 31
        Height = 13
        Caption = 'Notes:'
      end
      object edtEmail: TDBEdit
        Left = 56
        Top = 188
        Width = 313
        Height = 21
        DataField = 'Email'
        DataSource = ListDMMgr.AMCSource
        TabOrder = 14
        OnChange = OnChanges
      end
      object edtCellPh: TDBEdit
        Left = 56
        Top = 163
        Width = 105
        Height = 21
        DataField = 'CellPh'
        DataSource = ListDMMgr.AMCSource
        TabOrder = 12
        OnChange = OnChanges
      end
      object edtPager: TDBEdit
        Left = 208
        Top = 163
        Width = 121
        Height = 21
        DataField = 'Pager'
        DataSource = ListDMMgr.AMCSource
        TabOrder = 13
        OnChange = OnChanges
      end
      object edtPhone: TDBEdit
        Left = 56
        Top = 138
        Width = 105
        Height = 21
        DataField = 'Phone'
        DataSource = ListDMMgr.AMCSource
        TabOrder = 10
        OnChange = OnChanges
      end
      object edtFax: TDBEdit
        Left = 208
        Top = 138
        Width = 121
        Height = 21
        DataField = 'Fax'
        DataSource = ListDMMgr.AMCSource
        TabOrder = 11
        OnChange = OnChanges
      end
      object edtCity: TDBEdit
        Left = 56
        Top = 114
        Width = 153
        Height = 21
        DataField = 'City'
        DataSource = ListDMMgr.AMCSource
        TabOrder = 7
        OnChange = OnChanges
      end
      object edtState: TDBEdit
        Left = 232
        Top = 114
        Width = 49
        Height = 21
        DataField = 'State'
        DataSource = ListDMMgr.AMCSource
        TabOrder = 8
        OnChange = OnChanges
      end
      object edtZip: TDBEdit
        Left = 312
        Top = 114
        Width = 57
        Height = 21
        DataField = 'Zip'
        DataSource = ListDMMgr.AMCSource
        TabOrder = 9
        OnChange = OnChanges
      end
      object edtAddress: TDBEdit
        Left = 56
        Top = 90
        Width = 313
        Height = 21
        DataField = 'Address'
        DataSource = ListDMMgr.AMCSource
        TabOrder = 6
        OnChange = OnChanges
      end
      object edtCompany: TDBEdit
        Left = 56
        Top = 66
        Width = 313
        Height = 21
        DataField = 'CompanyName'
        DataSource = ListDMMgr.AMCSource
        TabOrder = 5
        OnChange = OnChanges
      end
      object edtMr: TDBEdit
        Left = 56
        Top = 42
        Width = 33
        Height = 21
        DataField = 'MrMrs'
        DataSource = ListDMMgr.AMCSource
        TabOrder = 2
        OnChange = OnChanges
      end
      object edtFirst: TDBEdit
        Left = 115
        Top = 42
        Width = 102
        Height = 21
        DataField = 'FirstName'
        DataSource = ListDMMgr.AMCSource
        TabOrder = 3
        OnChange = OnChanges
      end
      object edtLast: TDBEdit
        Left = 245
        Top = 42
        Width = 124
        Height = 21
        DataField = 'LastName'
        DataSource = ListDMMgr.AMCSource
        TabOrder = 4
        OnChange = OnChanges
      end
      object edtLenderID: TDBEdit
        Left = 285
        Top = 8
        Width = 83
        Height = 21
        DataField = 'UserClientID'
        DataSource = ListDMMgr.AMCSource
        TabOrder = 1
        OnChange = OnChanges
      end
      object DBMemo: TDBMemo
        Left = 56
        Top = 213
        Width = 313
        Height = 66
        DataField = 'Notes'
        DataSource = ListDMMgr.AMCSource
        TabOrder = 15
        OnChange = OnChanges
      end
      object edtLookupName: TDBEdit
        Left = 56
        Top = 8
        Width = 201
        Height = 21
        Hint = 'What you type here will appear in the list'
        DataField = 'LookupName'
        DataSource = ListDMMgr.AMCSource
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnChange = OnChanges
        OnKeyDown = ShortCutKeyDown
      end
    end
    object PrefSheet: TTabSheet
      Caption = 'Preference'
      ImageIndex = 1
      object chkbxContactTransfer: TCheckBox
        Left = 8
        Top = 16
        Width = 265
        Height = 17
        Caption = 'Include Contact Name during transfer to forms'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
    end
    object ExportSheet: TTabSheet
      Caption = 'Export/Print'
      ImageIndex = 2
      object btnPrint: TButton
        Left = 8
        Top = 16
        Width = 75
        Height = 25
        Caption = 'Print'
        TabOrder = 0
        OnClick = btnPrintClick
      end
      object btnExport: TButton
        Left = 8
        Top = 48
        Width = 75
        Height = 25
        Caption = 'Export'
        TabOrder = 1
        OnClick = btnExportClick
      end
      object rdoExportText: TRadioButton
        Left = 94
        Top = 54
        Width = 91
        Height = 17
        Caption = 'to Text File'
        Checked = True
        TabOrder = 2
        TabStop = True
      end
      object rdoExportExcel: TRadioButton
        Left = 204
        Top = 54
        Width = 109
        Height = 17
        Caption = 'to Excel'
        TabOrder = 3
      end
    end
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 392
    Top = 344
  end
  object ClientReport: TppReport
    AutoStop = False
    DataPipeline = ppDBPipeline1
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Client List'
    PrinterSetup.Orientation = poLandscape
    PrinterSetup.PaperName = 'Letter'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 12700
    PrinterSetup.mmMarginLeft = 12700
    PrinterSetup.mmMarginRight = 12700
    PrinterSetup.mmMarginTop = 12700
    PrinterSetup.mmPaperHeight = 215900
    PrinterSetup.mmPaperWidth = 279401
    PrinterSetup.PaperSize = 1
    Template.FileName = 'C:\ClickForms6\Reports\clients.rtm'
    CachePages = True
    DeviceType = 'Screen'
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = False
    OutlineSettings.Visible = False
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = False
    Left = 360
    Top = 344
    Version = '7.03'
    mmColumnWidth = 266701
    DataPipelineName = 'ppDBPipeline1'
    object ppClientListTitleBand: TppTitleBand
      mmBottomOffset = 0
      mmHeight = 9260
      mmPrintPosition = 0
      object lblTitle: TppLabel
        UserName = 'lblTitle'
        AutoSize = False
        Caption = 'Client List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 18
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 7535
        mmLeft = 0
        mmTop = 0
        mmWidth = 266436
        BandType = 1
      end
    end
    object ppClientListHeaderBand: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 5292
      mmPrintPosition = 0
      object lneEmail: TppLine
        UserName = 'lneEmail'
        Position = lpBottom
        Weight = 0.750000000000000000
        mmHeight = 3969
        mmLeft = 201084
        mmTop = 0
        mmWidth = 52917
        BandType = 0
      end
      object lneAddress: TppLine
        UserName = 'lneAddress'
        Position = lpBottom
        Weight = 0.750000000000000000
        mmHeight = 3969
        mmLeft = 146844
        mmTop = 0
        mmWidth = 52917
        BandType = 0
      end
      object lneCellPh: TppLine
        UserName = 'lneCellPh'
        Position = lpBottom
        Weight = 0.750000000000000000
        mmHeight = 3969
        mmLeft = 121709
        mmTop = 0
        mmWidth = 23813
        BandType = 0
      end
      object lnePhone: TppLine
        UserName = 'lnePhone'
        Position = lpBottom
        Weight = 0.750000000000000000
        mmHeight = 3969
        mmLeft = 96573
        mmTop = 0
        mmWidth = 23813
        BandType = 0
      end
      object lneName: TppLine
        UserName = 'lneName'
        Position = lpBottom
        Weight = 0.750000000000000000
        mmHeight = 3969
        mmLeft = 42333
        mmTop = 0
        mmWidth = 52917
        BandType = 0
      end
      object lneClientID: TppLine
        UserName = 'lneClientID'
        Position = lpBottom
        Weight = 0.750000000000000000
        mmHeight = 3969
        mmLeft = 27781
        mmTop = 0
        mmWidth = 13229
        BandType = 0
      end
      object lneLookupName: TppLine
        UserName = 'lneLookupName'
        Position = lpBottom
        Weight = 0.750000000000000000
        mmHeight = 3969
        mmLeft = 0
        mmTop = 0
        mmWidth = 26458
        BandType = 0
      end
      object lblClientID: TppLabel
        UserName = 'lblClientID'
        AutoSize = False
        Caption = 'ID'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4191
        mmLeft = 27781
        mmTop = 0
        mmWidth = 13229
        BandType = 0
      end
      object lblLookupName: TppLabel
        UserName = 'lblLookupName'
        AutoSize = False
        Caption = 'Lookup'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4191
        mmLeft = 0
        mmTop = 0
        mmWidth = 26458
        BandType = 0
      end
      object lblAddress: TppLabel
        UserName = 'lblAddress'
        AutoSize = False
        Caption = 'Address'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4191
        mmLeft = 146844
        mmTop = 0
        mmWidth = 52917
        BandType = 0
      end
      object lblPhone: TppLabel
        UserName = 'lblPhone'
        AutoSize = False
        Caption = 'Phone / Fax'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4191
        mmLeft = 96573
        mmTop = 0
        mmWidth = 23813
        BandType = 0
      end
      object lblCellPh: TppLabel
        UserName = 'lblCellPh'
        AutoSize = False
        Caption = 'Cell / Pager'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4191
        mmLeft = 121709
        mmTop = 0
        mmWidth = 23813
        BandType = 0
      end
      object lblEmail: TppLabel
        UserName = 'lblEmail'
        AutoSize = False
        Caption = 'Email'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4191
        mmLeft = 201084
        mmTop = 0
        mmWidth = 52917
        BandType = 0
      end
      object lblName: TppLabel
        UserName = 'lblName'
        AutoSize = False
        Caption = 'Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4191
        mmLeft = 42333
        mmTop = 0
        mmWidth = 52917
        BandType = 0
      end
    end
    object ppClientListDetailBand: TppDetailBand
      mmBottomOffset = 0
      mmHeight = 10583
      mmPrintPosition = 0
      object lneSeparater: TppLine
        UserName = 'lneSeparater'
        Position = lpBottom
        Weight = 0.500000000000000000
        mmHeight = 3969
        mmLeft = 265
        mmTop = 5292
        mmWidth = 253736
        BandType = 4
      end
      object fldClientID: TppDBText
        UserName = 'fldClientID'
        DataField = 'ClientID'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3969
        mmLeft = 27781
        mmTop = 0
        mmWidth = 13229
        BandType = 4
      end
      object fldLookupName: TppDBText
        UserName = 'fldLookupName'
        DataField = 'LookupName'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3969
        mmLeft = 0
        mmTop = 0
        mmWidth = 26458
        BandType = 4
      end
      object fldCompanyName: TppDBText
        UserName = 'fldCompanyName'
        DataField = 'CompanyName'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3969
        mmLeft = 42333
        mmTop = 4233
        mmWidth = 52917
        BandType = 4
      end
      object fldAddress: TppDBText
        UserName = 'fldAddress'
        DataField = 'Address'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3969
        mmLeft = 146844
        mmTop = 0
        mmWidth = 52917
        BandType = 4
      end
      object fldPhone: TppDBText
        UserName = 'fldPhone'
        DataField = 'Phone'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3969
        mmLeft = 96573
        mmTop = 0
        mmWidth = 23813
        BandType = 4
      end
      object fldFax: TppDBText
        UserName = 'fldFax'
        DataField = 'Fax'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3969
        mmLeft = 96573
        mmTop = 4233
        mmWidth = 23813
        BandType = 4
      end
      object fldCellPh: TppDBText
        UserName = 'fldCellPh'
        DataField = 'CellPh'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 3969
        mmLeft = 121709
        mmTop = 0
        mmWidth = 23813
        BandType = 4
      end
      object fldPager: TppDBText
        UserName = 'fldPager'
        DataField = 'Pager'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 4022
        mmLeft = 121709
        mmTop = 4233
        mmWidth = 23813
        BandType = 4
      end
      object fldEmail: TppDBText
        UserName = 'fldEmail'
        DataField = 'Email'
        DataPipeline = ppDBPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        WordWrap = True
        DataPipelineName = 'ppDBPipeline1'
        mmHeight = 8202
        mmLeft = 201084
        mmTop = 0
        mmWidth = 52917
        BandType = 4
      end
      object varName: TppVariable
        UserName = 'varName'
        AutoSize = False
        CalcOrder = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        OnCalc = varNameCalc
        Transparent = True
        mmHeight = 4022
        mmLeft = 42333
        mmTop = 0
        mmWidth = 52917
        BandType = 4
      end
      object varCityStateZip: TppVariable
        UserName = 'varCityStateZip'
        AutoSize = False
        CalcOrder = 1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        OnCalc = varCityStateZipCalc
        Transparent = True
        mmHeight = 4022
        mmLeft = 146844
        mmTop = 4233
        mmWidth = 52917
        BandType = 4
      end
    end
    object ppClientListFooterBand: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 5292
      mmPrintPosition = 0
      object varPageCount: TppVariable
        UserName = 'varPageCount'
        AutoSize = False
        CalcOrder = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        OnCalc = varPageCountCalc
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3969
        mmLeft = 0
        mmTop = 0
        mmWidth = 254001
        BandType = 8
      end
    end
    object ppParameterList1: TppParameterList
    end
  end
  object ppDBPipeline1: TppDBPipeline
    DataSource = ListDMMgr.AMCSource
    UserName = 'DBPipeline1'
    Left = 328
    Top = 344
    object ppDBPipeline1ppField1: TppField
      Alignment = taRightJustify
      FieldAlias = 'ClientID'
      FieldName = 'ClientID'
      FieldLength = 0
      DataType = dtLongint
      DisplayWidth = 0
      Position = 0
    end
    object ppDBPipeline1ppField2: TppField
      FieldAlias = 'UserClientID'
      FieldName = 'UserClientID'
      FieldLength = 20
      DisplayWidth = 20
      Position = 1
    end
    object ppDBPipeline1ppField3: TppField
      FieldAlias = 'LookupName'
      FieldName = 'LookupName'
      FieldLength = 60
      DisplayWidth = 60
      Position = 2
    end
    object ppDBPipeline1ppField4: TppField
      FieldAlias = 'CompanyName'
      FieldName = 'CompanyName'
      FieldLength = 50
      DisplayWidth = 50
      Position = 3
    end
    object ppDBPipeline1ppField5: TppField
      FieldAlias = 'Address'
      FieldName = 'Address'
      FieldLength = 50
      DisplayWidth = 50
      Position = 4
    end
    object ppDBPipeline1ppField6: TppField
      FieldAlias = 'City'
      FieldName = 'City'
      FieldLength = 50
      DisplayWidth = 50
      Position = 5
    end
    object ppDBPipeline1ppField7: TppField
      FieldAlias = 'State'
      FieldName = 'State'
      FieldLength = 7
      DisplayWidth = 7
      Position = 6
    end
    object ppDBPipeline1ppField8: TppField
      FieldAlias = 'Zip'
      FieldName = 'Zip'
      FieldLength = 13
      DisplayWidth = 13
      Position = 7
    end
    object ppDBPipeline1ppField9: TppField
      FieldAlias = 'Phone'
      FieldName = 'Phone'
      FieldLength = 20
      DisplayWidth = 20
      Position = 8
    end
    object ppDBPipeline1ppField10: TppField
      FieldAlias = 'Fax'
      FieldName = 'Fax'
      FieldLength = 20
      DisplayWidth = 20
      Position = 9
    end
    object ppDBPipeline1ppField11: TppField
      FieldAlias = 'CellPh'
      FieldName = 'CellPh'
      FieldLength = 20
      DisplayWidth = 20
      Position = 10
    end
    object ppDBPipeline1ppField12: TppField
      FieldAlias = 'Pager'
      FieldName = 'Pager'
      FieldLength = 20
      DisplayWidth = 20
      Position = 11
    end
    object ppDBPipeline1ppField13: TppField
      FieldAlias = 'Email'
      FieldName = 'Email'
      FieldLength = 60
      DisplayWidth = 60
      Position = 12
    end
    object ppDBPipeline1ppField14: TppField
      FieldAlias = 'MrMrs'
      FieldName = 'MrMrs'
      FieldLength = 6
      DisplayWidth = 6
      Position = 13
    end
    object ppDBPipeline1ppField15: TppField
      FieldAlias = 'FirstName'
      FieldName = 'FirstName'
      FieldLength = 50
      DisplayWidth = 50
      Position = 14
    end
    object ppDBPipeline1ppField16: TppField
      FieldAlias = 'LastName'
      FieldName = 'LastName'
      FieldLength = 50
      DisplayWidth = 50
      Position = 15
    end
    object ppDBPipeline1ppField17: TppField
      FieldAlias = 'Notes'
      FieldName = 'Notes'
      FieldLength = 0
      DataType = dtMemo
      DisplayWidth = 10
      Position = 16
      Searchable = False
      Sortable = False
    end
  end
end