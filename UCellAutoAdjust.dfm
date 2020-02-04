object AutoCellAdjustEditor: TAutoCellAdjustEditor
  Left = 720
  Top = 177
  Width = 622
  Height = 621
  Caption = 'Automatic Adjustment Settings'
  Color = clBtnFace
  Constraints.MinWidth = 450
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 614
    Height = 129
    Align = alTop
    BevelOuter = bvNone
    Constraints.MinWidth = 450
    TabOrder = 0
    object btnOk: TButton
      Left = 383
      Top = 46
      Width = 80
      Height = 21
      Caption = 'Apply'
      ModalResult = 1
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TButton
      Left = 473
      Top = 46
      Width = 80
      Height = 21
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object cbxSaveDefault: TCheckBox
      Left = 16
      Top = 31
      Width = 345
      Height = 20
      Caption = 'Use these adjustment values in new reports.'
      TabOrder = 5
    end
    object cmbxSelectList: TComboBox
      Left = 16
      Top = 10
      Width = 169
      Height = 21
      ItemHeight = 13
      Sorted = True
      TabOrder = 4
      Text = 'No lists have been saved yet'
      OnChange = cmbxSelectListChange
    end
    object btnSaveList: TButton
      Left = 383
      Top = 75
      Width = 80
      Height = 21
      Caption = 'Save List As'
      TabOrder = 2
      OnClick = btnSaveListClick
    end
    object cbxSumRoomAdj: TCheckBox
      Left = 16
      Top = 54
      Width = 345
      Height = 19
      Caption = 'Sum Room Adjustments'
      TabOrder = 6
      OnClick = sbxSumRoomAdjClick
    end
    object btnDelete: TButton
      Left = 474
      Top = 75
      Width = 80
      Height = 21
      Caption = 'Delete List'
      TabOrder = 3
      OnClick = btnDeleteClick
    end
    object cbxAdjustbyDay: TCheckBox
      Left = 16
      Top = 75
      Width = 359
      Height = 20
      Caption = 'Pro-Rate Date adjustments by Day instead of Rounded Whole Month'
      TabOrder = 7
      OnClick = cbxAdjustbyDayClick
    end
  end
  object AutoAdjGrid: TtsGrid
    Tag = 5
    Left = 0
    Top = 129
    Width = 614
    Height = 442
    Align = alClient
    CellSelectMode = cmNone
    CheckBoxStyle = stCheck
    ColMoving = False
    Cols = 7
    ColSelectMode = csNone
    DefaultRowHeight = 21
    ExportDelimiter = ','
    HeadingHorzAlignment = htaCenter
    HeadingFont.Charset = DEFAULT_CHARSET
    HeadingFont.Color = clWindowText
    HeadingFont.Height = -11
    HeadingFont.Name = 'MS Sans Serif'
    HeadingFont.Style = []
    HeadingHeight = 30
    HeadingParentFont = False
    HeadingVertAlignment = vtaCenter
    ParentShowHint = False
    PrintTotals = False
    RowBarIndicator = False
    RowBarOn = False
    Rows = 18
    RowSelectMode = rsNone
    ShowHint = True
    StoreData = True
    TabOrder = 1
    ThumbTracking = True
    Version = '3.01.08'
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    OnClickCell = AutoAdjGridClickCell
    OnKeyDown = AutoAdjGridKeyDown
    OnKeyPress = AutoAdjGridKeyPress
    ColProperties = <
      item
        DataCol = 1
        FieldName = 'ID'
        Col.FieldName = 'ID'
        Col.Heading = 'ID'
        Col.HeadingColor = clWindow
        Col.Visible = False
        Col.Width = 42
      end
      item
        DataCol = 2
        FieldName = 'Active'
        Col.ControlType = ctCheck
        Col.FieldName = 'Active'
        Col.Heading = 'Active'
        Col.ParentCombo = False
        Col.Width = 50
      end
      item
        DataCol = 3
        FieldName = 'Adjust For Difference In'
        Col.FieldName = 'Adjust For Difference In'
        Col.Heading = 'Adjust For Difference In'
        Col.ReadOnly = True
        Col.HorzAlignment = htaLeft
        Col.Width = 117
      end
      item
        DataCol = 4
        FieldName = 'Adjustment ($ Per Unit)'
        Col.FieldName = 'Adjustment ($ Per Unit)'
        Col.Heading = 'Adjustment '
        Col.HeadingHorzAlignment = htaCenter
        Col.HorzAlignment = htaCenter
        Col.Width = 70
      end
      item
        DataCol = 5
        Col.ButtonType = btCombo
        Col.Heading = 'Calculation Mode'
        Col.ParentCombo = False
        Col.Width = 133
        Col.Combo = {
          545046300C547473436F6D626F4772696400044C656674020003546F70020005
          57696474680340010648656967687402780754616253746F7008134175746F46
          696C6C436F6E766572744361736507076166634E6F6E650C44726F70446F776E
          526F777302020C44726F70446F776E436F6C7302010D436865636B426F785374
          796C6507077374436865636B04436F6C7302010543746C3344080F4465666175
          6C74436F6C5769647468024A1044656661756C74526F7748656967687402170D
          4669786564526F77436F756E7402010C466F6E742E43686172736574070F4445
          4641554C545F434841525345540A466F6E742E436F6C6F72070C636C57696E64
          6F77546578740B466F6E742E48656967687402F509466F6E742E4E616D65060D
          4D532053616E732053657269660A466F6E742E5374796C650B00134865616469
          6E67466F6E742E43686172736574070F44454641554C545F4348415253455411
          48656164696E67466F6E742E436F6C6F72070C636C57696E646F775465787412
          48656164696E67466F6E742E48656967687402F51048656164696E67466F6E74
          2E4E616D65060D4D532053616E732053657269661148656164696E67466F6E74
          2E5374796C650B000948656164696E674F6E081148656164696E67506172656E
          74466F6E74080B506172656E7443746C3344080A506172656E74466F6E74080E
          506172656E7453686F7748696E74080A526573697A65436F6C73070672634E6F
          6E650A526573697A65526F7773070672724E6F6E6508526F774261724F6E0804
          526F777302020A5363726F6C6C42617273070A7373566572746963616C085368
          6F7748696E74080953746F726544617461090D5468756D62547261636B696E67
          090756657273696F6E0607332E30312E30380D436F6C50726F70657274696573
          0E010744617461436F6C020109436F6C2E57696474680272000004446174610A
          3700000001000000010000000100000000020000000100000001150000002520
          53616C652050726963652070657220556E697400000000000000000000}
      end
      item
        DataCol = 6
        FieldName = 'Units'
        Col.FieldName = 'Units'
        Col.Heading = 'Units'
        Col.ReadOnly = True
        Col.HorzAlignment = htaCenter
        Col.Width = 103
      end
      item
        DataCol = 7
        FieldName = 'Only If Diff. Greater Than $'
        Col.FieldName = 'Only If Diff. Greater Than $'
        Col.Heading = 'Only If Diff. Greater Than'
        Col.HorzAlignment = htaCenter
        Col.Width = 85
      end>
    Data = {
      0100000007000000010100000031020000000001000000000100000000010000
      0000010000000001000000000200000007000000010100000032020000000001
      0000000001000000000100000000010000000001000000000300000007000000
      0101000000330200000000000000000100000000040000000200000001010000
      0034020000000005000000020000000002000000000600000002000000000200
      0000000700000002000000000200000000080000000200000000020000000009
      000000020000000002000000000A000000020000000002000000000B00000002
      0000000002000000000C000000020000000002000000000D0000000200000000
      02000000000E000000020000000002000000000000000000000000}
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 571
    Width = 614
    Height = 19
    Panels = <>
  end
end
