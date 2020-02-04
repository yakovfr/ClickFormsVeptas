inherited AMC_BuildPDF: TAMC_BuildPDF
  Width = 658
  Height = 387
  ParentFont = False
  DesignSize = (
    658
    387)
  object cbxSavePDFCopy: TCheckBox
    Left = 27
    Top = 68
    Width = 324
    Height = 17
    Caption = 'Save a copy of the PDF file in this directory:'
    Checked = True
    State = cbChecked
    TabOrder = 0
    OnClick = cbxSavePDFCopyClick
  end
  object edtPDFDirPath: TEdit
    Left = 48
    Top = 121
    Width = 408
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    TabOrder = 1
    Text = 'PDF Directory'
  end
  object cbxPDF_UseCLKName: TCheckBox
    Left = 48
    Top = 97
    Width = 403
    Height = 17
    Caption = 'Save the PDF file with same name as the ClickFORMS report.'
    Checked = True
    State = cbChecked
    TabOrder = 2
    OnClick = cbxPDF_UseCLKNameClick
  end
  object btnCreatePDF: TButton
    Left = 473
    Top = 16
    Width = 95
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Create PDF'
    TabOrder = 3
    OnClick = btnCreatePDFClick
  end
  object btnBrowsePDFDir: TButton
    Left = 475
    Top = 118
    Width = 95
    Height = 27
    Anchors = [akTop, akRight]
    Caption = 'Browse'
    TabOrder = 4
    OnClick = btnBrowsePDFDirClick
  end
  object cbxPreviewPDF: TCheckBox
    Left = 27
    Top = 16
    Width = 204
    Height = 17
    Caption = 'Display the PDF file'
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
  object stxSuccessNote: TStaticText
    Left = 27
    Top = 47
    Width = 140
    Height = 17
    Caption = 'PDF file successfully created'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
  object cbxProtectPDF: TCheckBox
    Left = 238
    Top = 16
    Width = 204
    Height = 17
    Caption = 'Protect the PDF'
    TabOrder = 7
  end
  object SelectFolderDialog: TRzSelectFolderDialog
    Left = 64
    Top = 272
  end
end
