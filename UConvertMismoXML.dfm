object ConvertMismoXML: TConvertMismoXML
  Left = 541
  Top = 262
  Width = 725
  Height = 598
  Caption = 'Convert MISMO XMLs to ClickFORMS reports'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 34
    Top = 20
    Width = 82
    Height = 13
    Caption = 'Select  XML Files'
  end
  object GroupBox1: TGroupBox
    Left = 24
    Top = 140
    Width = 575
    Height = 425
    Caption = 'Conversion'
    TabOrder = 0
    object grdFiles: TStringGrid
      Left = 16
      Top = 24
      Width = 543
      Height = 329
      ColCount = 2
      FixedCols = 0
      RowCount = 2
      TabOrder = 0
      ColWidths = (
        204
        335)
    end
    object PrgrBar: TProgressBar
      Left = 16
      Top = 360
      Width = 545
      Height = 17
      TabOrder = 1
    end
    object memo: TMemo
      Left = 2
      Top = 381
      Width = 571
      Height = 42
      Align = alBottom
      ReadOnly = True
      TabOrder = 2
    end
  end
  object btnConvert: TButton
    Left = 616
    Top = 184
    Width = 89
    Height = 25
    Caption = 'Start conversion'
    Enabled = False
    TabOrder = 1
    OnClick = StartConversion
  end
  object btnStop: TButton
    Left = 616
    Top = 216
    Width = 89
    Height = 25
    Caption = 'Stop Conversion'
    Enabled = False
    TabOrder = 2
    OnClick = StopConversion
  end
  object btnClose: TButton
    Left = 616
    Top = 520
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 3
    OnClick = btnCloseClick
  end
  object edtSelectDir: TEdit
    Left = 128
    Top = 16
    Width = 385
    Height = 21
    ReadOnly = True
    TabOrder = 4
  end
  object btnSelectXmls: TButton
    Left = 520
    Top = 14
    Width = 75
    Height = 25
    Caption = 'browse'
    TabOrder = 5
    OnClick = SelectXMLs
  end
  object GroupBox2: TGroupBox
    Left = 24
    Top = 44
    Width = 577
    Height = 93
    TabOrder = 6
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 85
      Height = 13
      Caption = 'Destination Folder'
    end
    object Label3: TLabel
      Left = 8
      Top = 40
      Width = 253
      Height = 13
      Caption = 'Conversion log will be saved to the destination folder'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object chbPrefix: TCheckBox
      Left = 8
      Top = 65
      Width = 177
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Add prefix to converted file name'
      TabOrder = 0
    end
    object edtPrefix: TEdit
      Left = 192
      Top = 65
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object edtDestFolder: TEdit
      Left = 104
      Top = 16
      Width = 385
      Height = 21
      ReadOnly = True
      TabOrder = 2
    end
    object btnFindDestination: TButton
      Left = 494
      Top = 14
      Width = 75
      Height = 25
      Caption = 'browse'
      TabOrder = 3
      OnClick = SelectDestDir
    end
  end
  object OpenDialog: TOpenDialog
    Filter = 'Mismo XML files|*.xml'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofPathMustExist, ofFileMustExist, ofNoReadOnlyReturn, ofEnableSizing]
    Left = 632
    Top = 120
  end
end
