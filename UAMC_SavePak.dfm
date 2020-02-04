inherited AMC_SavePak: TAMC_SavePak
  Width = 648
  Height = 320
  ParentFont = False
  object edtXMLDirPath: TEdit
    Left = 82
    Top = 81
    Width = 345
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    Text = 'XML Directory'
  end
  object btnSavePDF: TButton
    Left = 448
    Top = 133
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Save As'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = btnSavePDFClick
  end
  object edtPDFDirPath: TEdit
    Left = 82
    Top = 137
    Width = 345
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    Text = 'PDF Directory'
  end
  object edtENVDirPath: TEdit
    Left = 82
    Top = 193
    Width = 345
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    Text = 'ENV Directory'
  end
  object btnSaveXML: TButton
    Left = 448
    Top = 77
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Save As'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = btnSaveXMLClick
  end
  object btnSaveENV: TButton
    Left = 448
    Top = 189
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Save As'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = btnSaveENVClick
  end
  object stxNoteEmbeddedPDF: TStaticText
    Left = 24
    Top = 60
    Width = 253
    Height = 17
    Caption = 'Note: A copy of the PDF is contained in the XML file.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    Visible = False
  end
  object cbxUseSameFolder: TCheckBox
    Left = 24
    Top = 24
    Width = 17
    Height = 17
    TabOrder = 0
    Visible = False
    OnClick = cbxUseSameFolderClick
  end
  object btnSaveAll: TButton
    Left = 567
    Top = 20
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Save All'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnSaveAllClick
  end
  object stxXMLSaved: TStaticText
    Left = 24
    Top = 104
    Width = 217
    Height = 17
    Caption = 'XML file has been successfully saved'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    Visible = False
  end
  object stxPDFSaved: TStaticText
    Left = 24
    Top = 160
    Width = 216
    Height = 17
    Caption = 'PDF file has been successfully saved'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
    Visible = False
  end
  object stxENVSaved: TStaticText
    Left = 24
    Top = 216
    Width = 217
    Height = 17
    Caption = 'ENV file has been successfully saved'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
    Visible = False
  end
  object stxXML: TStaticText
    Left = 22
    Top = 84
    Width = 45
    Height = 17
    Alignment = taRightJustify
    Caption = 'XML File'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
  end
  object stxPDF: TStaticText
    Left = 22
    Top = 140
    Width = 44
    Height = 17
    Alignment = taRightJustify
    Caption = 'PDF File'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 14
  end
  object stxENV: TStaticText
    Left = 22
    Top = 196
    Width = 45
    Height = 17
    Alignment = taRightJustify
    Caption = 'ENV File'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 15
  end
  object edtSaveAllDirPath: TEdit
    Left = 152
    Top = 22
    Width = 327
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    Text = 'Same Directory'
    Visible = False
  end
  object btnBrowse: TButton
    Left = 485
    Top = 20
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Browse'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 16
    OnClick = btnBrowseClick
  end
  object lblUseSameFolder: TStaticText
    Left = 43
    Top = 24
    Width = 75
    Height = 17
    Caption = 'Save all files to'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 17
    Transparent = False
  end
  object ck_xml: TCheckBox
    Left = 544
    Top = 85
    Width = 57
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Email'
    TabOrder = 18
    OnClick = ck_xmlClick
  end
  object ck_pdf: TCheckBox
    Left = 544
    Top = 141
    Width = 49
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Email'
    TabOrder = 19
    OnClick = ck_pdfClick
  end
  object ck_env: TCheckBox
    Left = 544
    Top = 197
    Width = 49
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Email'
    TabOrder = 20
    OnClick = ck_envClick
  end
  object btnEmail: TButton
    Left = 448
    Top = 232
    Width = 193
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Email Selected Files'
    Enabled = False
    TabOrder = 21
    OnClick = btnEmailClick
  end
  object SelectFolderDialog: TRzSelectFolderDialog
    Options = [sfdoCreateDeleteButtons, sfdoContextMenus, sfdoCreateFolderIcon, sfdoDeleteFolderIcon, sfdoShowHidden]
  end
end
