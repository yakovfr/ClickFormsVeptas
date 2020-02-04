object BlackKnightLPS: TBlackKnightLPS
  Left = 350
  Top = 135
  Width = 1117
  Height = 673
  Caption = 'Black Knight Property Data Service'
  Color = clBtnFace
  Constraints.MinHeight = 673
  Constraints.MinWidth = 1117
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 1109
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object btnClose: TButton
      Left = 417
      Top = 4
      Width = 76
      Height = 20
      Caption = 'Close'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnCloseClick
    end
  end
  object RzPageControl1: TRzPageControl
    Left = 0
    Top = 28
    Width = 1109
    Height = 614
    ActivePage = TabSearchAddress
    ActivePageDefault = TabSearchAddress
    Align = alClient
    ShowShadow = False
    TabIndex = 0
    TabOrder = 1
    TabStyle = tsRoundCorners
    TabWidth = 150
    FixedDimension = 19
    object TabSearchAddress: TRzTabSheet
      Caption = 'Address to Search'
      object Label1: TLabel
        Left = 9
        Top = 16
        Width = 80
        Height = 13
        Caption = 'Property Address'
      end
      object Label2: TLabel
        Left = 73
        Top = 42
        Width = 17
        Height = 13
        Caption = 'City'
      end
      object Label3: TLabel
        Left = 289
        Top = 42
        Width = 25
        Height = 13
        Caption = 'State'
      end
      object Label4: TLabel
        Left = 385
        Top = 42
        Width = 15
        Height = 13
        Caption = 'Zip'
      end
      object edtCity: TEdit
        Left = 100
        Top = 39
        Width = 169
        Height = 21
        TabOrder = 1
      end
      object edtAddress: TEdit
        Left = 100
        Top = 13
        Width = 309
        Height = 21
        TabOrder = 0
      end
      object edtState: TEdit
        Left = 321
        Top = 39
        Width = 42
        Height = 21
        TabOrder = 2
      end
      object edtZip: TEdit
        Left = 409
        Top = 39
        Width = 84
        Height = 21
        TabOrder = 3
      end
      object btnLocate: TButton
        Left = 417
        Top = 8
        Width = 77
        Height = 25
        Caption = 'Search'
        TabOrder = 4
        OnClick = btnLocateClick
      end
      object AnimateProgress: TAnimate
        Left = 420
        Top = 81
        Width = 48
        Height = 45
        StopFrame = 8
      end
    end
    object TabSubjectResults: TRzTabSheet
      TabVisible = False
      Caption = 'Subject Results'
      object tsSubjectGrid: TtsGrid
        Tag = 3
        Left = 0
        Top = 57
        Width = 1107
        Height = 533
        Align = alClient
        CellSelectMode = cmNone
        CheckBoxStyle = stCheck
        ColMoving = False
        Cols = 2
        ColSelectMode = csNone
        DefaultButtonHeight = 13
        DefaultButtonWidth = 40
        DefaultColWidth = 165
        DefaultRowHeight = 20
        ExportDelimiter = ','
        FlatButtons = False
        HeadingFont.Charset = DEFAULT_CHARSET
        HeadingFont.Color = clWindowText
        HeadingFont.Height = -11
        HeadingFont.Name = 'MS Sans Serif'
        HeadingFont.Style = []
        HeadingParentFont = False
        ParentShowHint = False
        ResizeRows = rrNone
        RowBarIndicator = False
        RowBarOn = False
        Rows = 1
        ShowHint = True
        StoreData = True
        TabOrder = 0
        ThumbTracking = True
        Version = '3.01.08'
        XMLExport.Version = '1.0'
        XMLExport.DataPacketVersion = '2.0'
        ColProperties = <
          item
            DataCol = 1
            FieldName = 'Field'
            Col.FieldName = 'Field'
            Col.Font.Charset = DEFAULT_CHARSET
            Col.Font.Color = clWindowText
            Col.Font.Height = -11
            Col.Font.Name = 'MS Sans Serif'
            Col.Font.Style = [fsBold]
            Col.Heading = 'Field Name'
            Col.HeadingFont.Charset = DEFAULT_CHARSET
            Col.HeadingFont.Color = clWindowText
            Col.HeadingFont.Height = -11
            Col.HeadingFont.Name = 'MS Sans Serif'
            Col.HeadingFont.Style = [fsBold]
            Col.HeadingHorzAlignment = htaLeft
            Col.HeadingParentFont = False
            Col.HeadingVertAlignment = vtaCenter
            Col.ParentFont = False
            Col.ReadOnly = True
            Col.Width = 165
          end
          item
            DataCol = 2
            FieldName = 'Location Path'
            Col.FieldName = 'Location Path'
            Col.Heading = 'Data'
            Col.HeadingFont.Charset = DEFAULT_CHARSET
            Col.HeadingFont.Color = clWindowText
            Col.HeadingFont.Height = -11
            Col.HeadingFont.Name = 'MS Sans Serif'
            Col.HeadingFont.Style = [fsBold]
            Col.HeadingHorzAlignment = htaLeft
            Col.HeadingParentFont = False
            Col.HeadingVertAlignment = vtaCenter
            Col.Width = 165
            Col.WordWrap = wwOff
          end>
        Data = {0100000002000000010000000001000000000000000000000000}
      end
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 1107
        Height = 57
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label10: TLabel
          Left = 8
          Top = 7
          Width = 322
          Height = 39
          Caption = 
            'Note: You can edit the subject results by typing into the grid. ' +
            ' Press "Transfer To Report" to transfer data. '#13'Press "Close" whe' +
            'n you are finished.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object chkOverrideTextSubject: TCheckBox
          Left = 349
          Top = 12
          Width = 14
          Height = 17
          TabOrder = 0
        end
        object btnTransferSubject: TButton
          Left = 611
          Top = 9
          Width = 110
          Height = 25
          Caption = 'Transfer To Report'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = btnTransferSubjectClick
        end
        object stxOverrideTextSubject: TStaticText
          Left = 369
          Top = 14
          Width = 238
          Height = 20
          AutoSize = False
          Caption = 'Override Existing Text in Report'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
      end
    end
    object TabCompsFound: TRzTabSheet
      TabVisible = False
      Caption = 'Comparables Found'
      Constraints.MinWidth = 980
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 1103
        Height = 81
        Align = alTop
        BevelOuter = bvNone
        Constraints.MinWidth = 970
        TabOrder = 0
        object Label11: TLabel
          Left = 8
          Top = 7
          Width = 336
          Height = 52
          Caption = 
            'Note: Use the drop-down menu to select comps to transfer '#13'into y' +
            'our report.  You can also edit the comparable results '#13'by typing' +
            ' into the grid.  Press "Transfer To Report" to '#13'transfer data.  ' +
            'Press "Close" when you are done.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object chkOverrideTextComps: TCheckBox
          Left = 371
          Top = 8
          Width = 17
          Height = 17
          Constraints.MinWidth = 17
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object btnTransferComps: TButton
          Left = 632
          Top = 5
          Width = 110
          Height = 25
          Caption = 'Transfer To Report'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = btnTransferCompsClick
        end
        object btnInsertCompsPage: TButton
          Left = 632
          Top = 36
          Width = 111
          Height = 25
          Caption = 'Add a Comp Page'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = btnInsertCompsPageClick
        end
        object stxOverrideTextComps: TStaticText
          Left = 387
          Top = 10
          Width = 240
          Height = 19
          AutoSize = False
          Caption = 'Override Existing Text in Report'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
      end
      object tsCompGrid: TtsGrid
        Tag = 2
        Left = 0
        Top = 81
        Width = 1103
        Height = 504
        Align = alClient
        CheckBoxStyle = stCheck
        ColMoving = False
        Cols = 16
        DefaultColWidth = 165
        DefaultRowHeight = 20
        ExportDelimiter = ','
        FixedColCount = 1
        HeadingFont.Charset = DEFAULT_CHARSET
        HeadingFont.Color = clWindowText
        HeadingFont.Height = -11
        HeadingFont.Name = 'MS Sans Serif'
        HeadingFont.Style = []
        HeadingParentFont = False
        ParentShowHint = False
        ResizeRows = rrNone
        RowBarOn = False
        Rows = 4
        RowSelectMode = rsSingle
        ShowHint = False
        StoreData = True
        TabOrder = 1
        ThumbTracking = True
        Version = '3.01.08'
        XMLExport.Version = '1.0'
        XMLExport.DataPacketVersion = '2.0'
        OnComboRollUp = tsCompGridComboRollUp
        ColProperties = <
          item
            DataCol = 1
            Col.Font.Charset = DEFAULT_CHARSET
            Col.Font.Color = clWindowText
            Col.Font.Height = -11
            Col.Font.Name = 'MS Sans Serif'
            Col.Font.Style = [fsBold]
            Col.Heading = 'Field Name'
            Col.HeadingFont.Charset = DEFAULT_CHARSET
            Col.HeadingFont.Color = clWindowText
            Col.HeadingFont.Height = -11
            Col.HeadingFont.Name = 'MS Sans Serif'
            Col.HeadingFont.Style = [fsBold]
            Col.HeadingHorzAlignment = htaLeft
            Col.HeadingParentFont = False
            Col.ParentFont = False
            Col.ReadOnly = True
            Col.Width = 165
          end
          item
            DataCol = 2
            Col.Font.Charset = DEFAULT_CHARSET
            Col.Font.Color = clWindowText
            Col.Font.Height = -11
            Col.Font.Name = 'MS Sans Serif'
            Col.Font.Style = []
            Col.ParentCombo = False
            Col.ParentFont = False
            Col.Width = 165
          end>
        RowProperties = <
          item
            DataRow = 1
            DisplayRow = 1
            Row.Font.Charset = DEFAULT_CHARSET
            Row.Font.Color = clWindowText
            Row.Font.Height = -11
            Row.Font.Name = 'MS Sans Serif'
            Row.Font.Style = [fsBold]
            Row.Height = 20
            Row.ParentFont = False
          end>
        CellProperties = <
          item
            DataCol = 8
            DataRow = 1
            Cell.ButtonType = btCombo
            Cell.DropDownStyle = ddDropDownList
            Cell.ParentCombo = False
            Cell.ReadOnly = roOff
            Cell.Combo = {
              545046300C547473436F6D626F4772696400035461670201044C656674020003
              546F7002000557696474680340010648656967687402780754616253746F7008
              0A4175746F5365617263680708617343656E7465720C44726F70446F776E526F
              7773020F0C44726F70446F776E436F6C7302010D44726F70446F776E5374796C
              65070E646444726F70446F776E4C6973740D436865636B426F785374796C6507
              077374436865636B04436F6C7302010543746C3344080F44656661756C74436F
              6C576964746803AF001348656164696E67466F6E742E43686172736574070F44
              454641554C545F434841525345541148656164696E67466F6E742E436F6C6F72
              070C636C57696E646F77546578741248656164696E67466F6E742E4865696768
              7402F51048656164696E67466F6E742E4E616D65060D4D532053616E73205365
              7269661148656164696E67466F6E742E5374796C650B000948656164696E674F
              6E081148656164696E67506172656E74466F6E74080B506172656E7443746C33
              44080E506172656E7453686F7748696E74080A526573697A65436F6C73070672
              634E6F6E650A526573697A65526F7773070672724E6F6E6508526F774261724F
              6E0804526F777302000A5363726F6C6C42617273070A7373566572746963616C
              0853686F7748696E74080953746F726544617461090D5468756D62547261636B
              696E67090756657273696F6E0607332E30312E303804446174610A0800000000
              000000000000000000}
          end
          item
            DataCol = 4
            DataRow = 1
            Cell.ButtonType = btCombo
            Cell.DropDownStyle = ddDropDownList
            Cell.ParentCombo = False
            Cell.ReadOnly = roOff
            Cell.Combo = {
              545046300C547473436F6D626F4772696400035461670201044C656674020003
              546F7002000557696474680340010648656967687402780754616253746F7008
              0A4175746F5365617263680708617343656E7465720C44726F70446F776E526F
              7773020F0C44726F70446F776E436F6C7302010D44726F70446F776E5374796C
              65070E646444726F70446F776E4C6973740D436865636B426F785374796C6507
              077374436865636B04436F6C7302010543746C3344080F44656661756C74436F
              6C576964746803AF001348656164696E67466F6E742E43686172736574070F44
              454641554C545F434841525345541148656164696E67466F6E742E436F6C6F72
              070C636C57696E646F77546578741248656164696E67466F6E742E4865696768
              7402F51048656164696E67466F6E742E4E616D65060D4D532053616E73205365
              7269661148656164696E67466F6E742E5374796C650B000948656164696E674F
              6E081148656164696E67506172656E74466F6E74080B506172656E7443746C33
              44080E506172656E7453686F7748696E74080A526573697A65436F6C73070672
              634E6F6E650A526573697A65526F7773070672724E6F6E6508526F774261724F
              6E0804526F777302000A5363726F6C6C42617273070A7373566572746963616C
              0853686F7748696E74080953746F726544617461090D5468756D62547261636B
              696E67090756657273696F6E0607332E30312E303804446174610A0800000000
              000000000000000000}
          end
          item
            DataCol = 2
            DataRow = 1
            Cell.ButtonType = btCombo
            Cell.DropDownStyle = ddDropDownList
            Cell.Font.Charset = DEFAULT_CHARSET
            Cell.Font.Color = clWindowText
            Cell.Font.Height = -11
            Cell.Font.Name = 'MS Sans Serif'
            Cell.Font.Style = [fsBold]
            Cell.ParentCombo = False
            Cell.ParentFont = False
            Cell.ReadOnly = roOff
            Cell.Combo = {
              545046300C547473436F6D626F4772696400035461670201044C656674020003
              546F7002000557696474680340010648656967687402780754616253746F7008
              0A4175746F5365617263680708617343656E7465720C44726F70446F776E526F
              7773020F0C44726F70446F776E436F6C7302010D44726F70446F776E5374796C
              65070E646444726F70446F776E4C6973740D436865636B426F785374796C6507
              077374436865636B04436F6C7302010543746C3344080F44656661756C74436F
              6C576964746803A0001348656164696E67466F6E742E43686172736574070F44
              454641554C545F434841525345541148656164696E67466F6E742E436F6C6F72
              070C636C57696E646F77546578741248656164696E67466F6E742E4865696768
              7402F51048656164696E67466F6E742E4E616D65060D4D532053616E73205365
              7269661148656164696E67466F6E742E5374796C650B000948656164696E674F
              6E081148656164696E67506172656E74466F6E74080B506172656E7443746C33
              44080E506172656E7453686F7748696E74080A526573697A65436F6C73070672
              634E6F6E650A526573697A65526F7773070672724E6F6E6508526F774261724F
              6E0804526F777302000A5363726F6C6C42617273070A7373566572746963616C
              0853686F7748696E74080953746F726544617461090D5468756D62547261636B
              696E67090756657273696F6E0607332E30312E303804446174610A0800000000
              000000000000000000}
          end
          item
            DataCol = 1
            DataRow = 1
            Cell.Font.Charset = DEFAULT_CHARSET
            Cell.Font.Color = clWindowText
            Cell.Font.Height = -11
            Cell.Font.Name = 'MS Sans Serif'
            Cell.Font.Style = [fsBold]
            Cell.ParentFont = False
            Cell.ReadOnly = roOn
          end
          item
            DataCol = 3
            DataRow = 1
            Cell.ButtonType = btCombo
            Cell.DropDownStyle = ddDropDownList
            Cell.ParentCombo = False
            Cell.ReadOnly = roOff
            Cell.Combo = {
              545046300C547473436F6D626F4772696400035461670201044C656674020003
              546F7002000557696474680340010648656967687402780754616253746F7008
              0A4175746F5365617263680708617343656E7465720C44726F70446F776E526F
              7773020F0C44726F70446F776E436F6C7302010D44726F70446F776E5374796C
              65070E646444726F70446F776E4C6973740D436865636B426F785374796C6507
              077374436865636B04436F6C7302010543746C3344080F44656661756C74436F
              6C576964746803A0001348656164696E67466F6E742E43686172736574070F44
              454641554C545F434841525345541148656164696E67466F6E742E436F6C6F72
              070C636C57696E646F77546578741248656164696E67466F6E742E4865696768
              7402F51048656164696E67466F6E742E4E616D65060D4D532053616E73205365
              7269661148656164696E67466F6E742E5374796C650B000948656164696E674F
              6E081148656164696E67506172656E74466F6E74080B506172656E7443746C33
              44080E506172656E7453686F7748696E74080A526573697A65436F6C73070672
              634E6F6E650A526573697A65526F7773070672724E6F6E6508526F774261724F
              6E0804526F777302000A5363726F6C6C42617273070A7373566572746963616C
              0853686F7748696E74080953746F726544617461090D5468756D62547261636B
              696E67090756657273696F6E0607332E30312E303804446174610A0800000000
              000000000000000000}
          end
          item
            DataCol = 6
            DataRow = 1
            Cell.ButtonType = btCombo
            Cell.DropDownStyle = ddDropDownList
            Cell.ParentCombo = False
            Cell.ReadOnly = roOff
            Cell.Combo = {
              545046300C547473436F6D626F4772696400035461670201044C656674020003
              546F7002000557696474680340010648656967687402780754616253746F7008
              0A4175746F5365617263680708617343656E7465720C44726F70446F776E526F
              7773020F0C44726F70446F776E436F6C7302010D44726F70446F776E5374796C
              65070E646444726F70446F776E4C6973740D436865636B426F785374796C6507
              077374436865636B04436F6C7302010543746C3344080F44656661756C74436F
              6C576964746803AF001348656164696E67466F6E742E43686172736574070F44
              454641554C545F434841525345541148656164696E67466F6E742E436F6C6F72
              070C636C57696E646F77546578741248656164696E67466F6E742E4865696768
              7402F51048656164696E67466F6E742E4E616D65060D4D532053616E73205365
              7269661148656164696E67466F6E742E5374796C650B000948656164696E674F
              6E081148656164696E67506172656E74466F6E74080B506172656E7443746C33
              44080E506172656E7453686F7748696E74080A526573697A65436F6C73070672
              634E6F6E650A526573697A65526F7773070672724E6F6E6508526F774261724F
              6E0804526F777302000A5363726F6C6C42617273070A7373566572746963616C
              0853686F7748696E74080953746F726544617461090D5468756D62547261636B
              696E67090756657273696F6E0607332E30312E303804446174610A0800000000
              000000000000000000}
          end
          item
            DataCol = 5
            DataRow = 1
            Cell.ButtonType = btCombo
            Cell.DropDownStyle = ddDropDownList
            Cell.ParentCombo = False
            Cell.ReadOnly = roOff
            Cell.Combo = {
              545046300C547473436F6D626F4772696400035461670201044C656674020003
              546F7002000557696474680340010648656967687402780754616253746F7008
              0A4175746F5365617263680708617343656E7465720C44726F70446F776E526F
              7773020F0C44726F70446F776E436F6C7302010D44726F70446F776E5374796C
              65070E646444726F70446F776E4C6973740D436865636B426F785374796C6507
              077374436865636B04436F6C7302010543746C3344080F44656661756C74436F
              6C576964746803AF001348656164696E67466F6E742E43686172736574070F44
              454641554C545F434841525345541148656164696E67466F6E742E436F6C6F72
              070C636C57696E646F77546578741248656164696E67466F6E742E4865696768
              7402F51048656164696E67466F6E742E4E616D65060D4D532053616E73205365
              7269661148656164696E67466F6E742E5374796C650B000948656164696E674F
              6E081148656164696E67506172656E74466F6E74080B506172656E7443746C33
              44080E506172656E7453686F7748696E74080A526573697A65436F6C73070672
              634E6F6E650A526573697A65526F7773070672724E6F6E6508526F774261724F
              6E0804526F777302000A5363726F6C6C42617273070A7373566572746963616C
              0853686F7748696E74080953746F726544617461090D5468756D62547261636B
              696E67090756657273696F6E0607332E30312E303804446174610A0800000000
              000000000000000000}
          end
          item
            DataCol = 7
            DataRow = 1
            Cell.ButtonType = btCombo
            Cell.DropDownStyle = ddDropDownList
            Cell.ParentCombo = False
            Cell.ReadOnly = roOff
            Cell.Combo = {
              545046300C547473436F6D626F4772696400035461670201044C656674020003
              546F7002000557696474680340010648656967687402780754616253746F7008
              0A4175746F5365617263680708617343656E7465720C44726F70446F776E526F
              7773020F0C44726F70446F776E436F6C7302010D44726F70446F776E5374796C
              65070E646444726F70446F776E4C6973740D436865636B426F785374796C6507
              077374436865636B04436F6C7302010543746C3344080F44656661756C74436F
              6C576964746803AF001348656164696E67466F6E742E43686172736574070F44
              454641554C545F434841525345541148656164696E67466F6E742E436F6C6F72
              070C636C57696E646F77546578741248656164696E67466F6E742E4865696768
              7402F51048656164696E67466F6E742E4E616D65060D4D532053616E73205365
              7269661148656164696E67466F6E742E5374796C650B000948656164696E674F
              6E081148656164696E67506172656E74466F6E74080B506172656E7443746C33
              44080E506172656E7453686F7748696E74080A526573697A65436F6C73070672
              634E6F6E650A526573697A65526F7773070672724E6F6E6508526F774261724F
              6E0804526F777302000A5363726F6C6C42617273070A7373566572746963616C
              0853686F7748696E74080953746F726544617461090D5468756D62547261636B
              696E67090756657273696F6E0607332E30312E303804446174610A0800000000
              000000000000000000}
          end
          item
            DataCol = 12
            DataRow = 1
            Cell.ButtonType = btCombo
            Cell.DropDownStyle = ddDropDownList
            Cell.ParentCombo = False
            Cell.ReadOnly = roOff
            Cell.Combo = {
              545046300C547473436F6D626F4772696400035461670201044C656674020003
              546F7002000557696474680340010648656967687402780754616253746F7008
              0A4175746F5365617263680708617343656E7465720C44726F70446F776E526F
              7773020F0C44726F70446F776E436F6C7302010D44726F70446F776E5374796C
              65070E646444726F70446F776E4C6973740D436865636B426F785374796C6507
              077374436865636B04436F6C7302010543746C3344080F44656661756C74436F
              6C576964746803AF001348656164696E67466F6E742E43686172736574070F44
              454641554C545F434841525345541148656164696E67466F6E742E436F6C6F72
              070C636C57696E646F77546578741248656164696E67466F6E742E4865696768
              7402F51048656164696E67466F6E742E4E616D65060D4D532053616E73205365
              7269661148656164696E67466F6E742E5374796C650B000948656164696E674F
              6E081148656164696E67506172656E74466F6E74080B506172656E7443746C33
              44080E506172656E7453686F7748696E74080A526573697A65436F6C73070672
              634E6F6E650A526573697A65526F7773070672724E6F6E6508526F774261724F
              6E0804526F777302000A5363726F6C6C42617273070A7373566572746963616C
              0853686F7748696E74080953746F726544617461090D5468756D62547261636B
              696E67090756657273696F6E0607332E30312E303804446174610A0800000000
              000000000000000000}
          end
          item
            DataCol = 10
            DataRow = 1
            Cell.ButtonType = btCombo
            Cell.DropDownStyle = ddDropDownList
            Cell.ParentCombo = False
            Cell.ReadOnly = roOff
            Cell.Combo = {
              545046300C547473436F6D626F4772696400035461670201044C656674020003
              546F7002000557696474680340010648656967687402780754616253746F7008
              0A4175746F5365617263680708617343656E7465720C44726F70446F776E526F
              7773020F0C44726F70446F776E436F6C7302010D44726F70446F776E5374796C
              65070E646444726F70446F776E4C6973740D436865636B426F785374796C6507
              077374436865636B04436F6C7302010543746C3344080F44656661756C74436F
              6C576964746803AF001348656164696E67466F6E742E43686172736574070F44
              454641554C545F434841525345541148656164696E67466F6E742E436F6C6F72
              070C636C57696E646F77546578741248656164696E67466F6E742E4865696768
              7402F51048656164696E67466F6E742E4E616D65060D4D532053616E73205365
              7269661148656164696E67466F6E742E5374796C650B000948656164696E674F
              6E081148656164696E67506172656E74466F6E74080B506172656E7443746C33
              44080E506172656E7453686F7748696E74080A526573697A65436F6C73070672
              634E6F6E650A526573697A65526F7773070672724E6F6E6508526F774261724F
              6E0804526F777302010A5363726F6C6C42617273070A7373566572746963616C
              0853686F7748696E74080953746F726544617461090D5468756D62547261636B
              696E67090756657273696F6E0607332E30312E303804446174610A0800000000
              000000000000000000}
          end
          item
            DataCol = 9
            DataRow = 1
            Cell.ButtonType = btCombo
            Cell.DropDownStyle = ddDropDownList
            Cell.ParentCombo = False
            Cell.ReadOnly = roOff
            Cell.Combo = {
              545046300C547473436F6D626F4772696400035461670201044C656674020003
              546F7002000557696474680340010648656967687402780754616253746F7008
              0A4175746F5365617263680708617343656E7465720C44726F70446F776E526F
              7773020F0C44726F70446F776E436F6C7302010D44726F70446F776E5374796C
              65070E646444726F70446F776E4C6973740D436865636B426F785374796C6507
              077374436865636B04436F6C7302010543746C3344080F44656661756C74436F
              6C576964746803AF001348656164696E67466F6E742E43686172736574070F44
              454641554C545F434841525345541148656164696E67466F6E742E436F6C6F72
              070C636C57696E646F77546578741248656164696E67466F6E742E4865696768
              7402F51048656164696E67466F6E742E4E616D65060D4D532053616E73205365
              7269661148656164696E67466F6E742E5374796C650B000948656164696E674F
              6E081148656164696E67506172656E74466F6E74080B506172656E7443746C33
              44080E506172656E7453686F7748696E74080A526573697A65436F6C73070672
              634E6F6E650A526573697A65526F7773070672724E6F6E6508526F774261724F
              6E0804526F777302000A5363726F6C6C42617273070A7373566572746963616C
              0853686F7748696E74080953746F726544617461090D5468756D62547261636B
              696E67090756657273696F6E0607332E30312E303804446174610A0800000000
              000000000000000000}
          end
          item
            DataCol = 11
            DataRow = 1
            Cell.ButtonType = btCombo
            Cell.DropDownStyle = ddDropDownList
            Cell.ParentCombo = False
            Cell.ReadOnly = roOff
            Cell.Combo = {
              545046300C547473436F6D626F4772696400035461670201044C656674020003
              546F7002000557696474680340010648656967687402780754616253746F7008
              0A4175746F5365617263680708617343656E7465720C44726F70446F776E526F
              7773020F0C44726F70446F776E436F6C7302010D44726F70446F776E5374796C
              65070E646444726F70446F776E4C6973740D436865636B426F785374796C6507
              077374436865636B04436F6C7302010543746C3344080F44656661756C74436F
              6C576964746803AF001348656164696E67466F6E742E43686172736574070F44
              454641554C545F434841525345541148656164696E67466F6E742E436F6C6F72
              070C636C57696E646F77546578741248656164696E67466F6E742E4865696768
              7402F51048656164696E67466F6E742E4E616D65060D4D532053616E73205365
              7269661148656164696E67466F6E742E5374796C650B000948656164696E674F
              6E081148656164696E67506172656E74466F6E74080B506172656E7443746C33
              44080E506172656E7453686F7748696E74080A526573697A65436F6C73070672
              634E6F6E650A526573697A65526F7773070672724E6F6E6508526F774261724F
              6E0804526F777302000A5363726F6C6C42617273070A7373566572746963616C
              0853686F7748696E74080953746F726544617461090D5468756D62547261636B
              696E67090756657273696F6E0607332E30312E303804446174610A0800000000
              000000000000000000}
          end
          item
            DataCol = 14
            DataRow = 1
            Cell.ButtonType = btCombo
            Cell.DropDownStyle = ddDropDownList
            Cell.ParentCombo = False
            Cell.ReadOnly = roOff
            Cell.Combo = {
              545046300C547473436F6D626F4772696400035461670201044C656674020003
              546F7002000557696474680340010648656967687402780754616253746F7008
              0A4175746F5365617263680708617343656E7465720C44726F70446F776E526F
              7773020F0C44726F70446F776E436F6C7302010D44726F70446F776E5374796C
              65070E646444726F70446F776E4C6973740D436865636B426F785374796C6507
              077374436865636B04436F6C7302010543746C3344080F44656661756C74436F
              6C576964746803AF001348656164696E67466F6E742E43686172736574070F44
              454641554C545F434841525345541148656164696E67466F6E742E436F6C6F72
              070C636C57696E646F77546578741248656164696E67466F6E742E4865696768
              7402F51048656164696E67466F6E742E4E616D65060D4D532053616E73205365
              7269661148656164696E67466F6E742E5374796C650B000948656164696E674F
              6E081148656164696E67506172656E74466F6E74080B506172656E7443746C33
              44080E506172656E7453686F7748696E74080A526573697A65436F6C73070672
              634E6F6E650A526573697A65526F7773070672724E6F6E6508526F774261724F
              6E0804526F777302000A5363726F6C6C42617273070A7373566572746963616C
              0853686F7748696E74080953746F726544617461090D5468756D62547261636B
              696E67090756657273696F6E0607332E30312E303804446174610A0800000000
              000000000000000000}
          end
          item
            DataCol = 13
            DataRow = 1
            Cell.ButtonType = btCombo
            Cell.DropDownStyle = ddDropDownList
            Cell.ParentCombo = False
            Cell.ReadOnly = roOff
            Cell.Combo = {
              545046300C547473436F6D626F4772696400035461670201044C656674020003
              546F7002000557696474680340010648656967687402780754616253746F7008
              0A4175746F5365617263680708617343656E7465720C44726F70446F776E526F
              7773020F0C44726F70446F776E436F6C7302010D44726F70446F776E5374796C
              65070E646444726F70446F776E4C6973740D436865636B426F785374796C6507
              077374436865636B04436F6C7302010543746C3344080F44656661756C74436F
              6C576964746803AF001348656164696E67466F6E742E43686172736574070F44
              454641554C545F434841525345541148656164696E67466F6E742E436F6C6F72
              070C636C57696E646F77546578741248656164696E67466F6E742E4865696768
              7402F51048656164696E67466F6E742E4E616D65060D4D532053616E73205365
              7269661148656164696E67466F6E742E5374796C650B000948656164696E674F
              6E081148656164696E67506172656E74466F6E74080B506172656E7443746C33
              44080E506172656E7453686F7748696E74080A526573697A65436F6C73070672
              634E6F6E650A526573697A65526F7773070672724E6F6E6508526F774261724F
              6E0804526F777302000A5363726F6C6C42617273070A7373566572746963616C
              0853686F7748696E74080953746F726544617461090D5468756D62547261636B
              696E67090756657273696F6E0607332E30312E303804446174610A0800000000
              000000000000000000}
          end
          item
            DataCol = 15
            DataRow = 1
            Cell.ButtonType = btCombo
            Cell.DropDownStyle = ddDropDownList
            Cell.ParentCombo = False
            Cell.ReadOnly = roOff
            Cell.Combo = {
              545046300C547473436F6D626F4772696400035461670201044C656674020003
              546F7002000557696474680340010648656967687402780754616253746F7008
              0A4175746F5365617263680708617343656E7465720C44726F70446F776E526F
              7773020F0C44726F70446F776E436F6C7302010D44726F70446F776E5374796C
              65070E646444726F70446F776E4C6973740D436865636B426F785374796C6507
              077374436865636B04436F6C7302010543746C3344080F44656661756C74436F
              6C576964746803AF001348656164696E67466F6E742E43686172736574070F44
              454641554C545F434841525345541148656164696E67466F6E742E436F6C6F72
              070C636C57696E646F77546578741248656164696E67466F6E742E4865696768
              7402F51048656164696E67466F6E742E4E616D65060D4D532053616E73205365
              7269661148656164696E67466F6E742E5374796C650B000948656164696E674F
              6E081148656164696E67506172656E74466F6E74080B506172656E7443746C33
              44080E506172656E7453686F7748696E74080A526573697A65436F6C73070672
              634E6F6E650A526573697A65526F7773070672724E6F6E6508526F774261724F
              6E0804526F777302000A5363726F6C6C42617273070A7373566572746963616C
              0853686F7748696E74080953746F726544617461090D5468756D62547261636B
              696E67090756657273696F6E0607332E30312E303804446174610A0800000000
              000000000000000000}
          end
          item
            DataCol = 16
            DataRow = 1
            Cell.ButtonType = btCombo
            Cell.DropDownStyle = ddDropDownList
            Cell.ParentCombo = False
            Cell.ReadOnly = roOff
            Cell.Combo = {
              545046300C547473436F6D626F4772696400035461670201044C656674020003
              546F7002000557696474680340010648656967687402780754616253746F7008
              0A4175746F5365617263680708617343656E7465720C44726F70446F776E526F
              7773020F0C44726F70446F776E436F6C7302010D44726F70446F776E5374796C
              65070E646444726F70446F776E4C6973740D436865636B426F785374796C6507
              077374436865636B04436F6C7302010543746C3344080F44656661756C74436F
              6C576964746803AF001348656164696E67466F6E742E43686172736574070F44
              454641554C545F434841525345541148656164696E67466F6E742E436F6C6F72
              070C636C57696E646F77546578741248656164696E67466F6E742E4865696768
              7402F51048656164696E67466F6E742E4E616D65060D4D532053616E73205365
              7269661148656164696E67466F6E742E5374796C650B000948656164696E674F
              6E081148656164696E67506172656E74466F6E74080B506172656E7443746C33
              44080E506172656E7453686F7748696E74080A526573697A65436F6C73070672
              634E6F6E650A526573697A65526F7773070672724E6F6E6508526F774261724F
              6E0804526F777302000A5363726F6C6C42617273070A7373566572746963616C
              0853686F7748696E74080953746F726544617461090D5468756D62547261636B
              696E67090756657273696F6E0607332E30312E303804446174610A0800000000
              000000000000000000}
          end>
        Data = {
          010000000D0000000109000000496D706F727420546F01000000000100000000
          0000000001000000000000000001000000000200000003000000010000000001
          0000000001000000000300000010000000000100000000000000000000000000
          0000000001000000000000000000000000}
      end
    end
    object TabTransferPrefs: TRzTabSheet
      Caption = 'Transfer Preferences'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 1107
        Height = 46
        Align = alTop
        TabOrder = 0
        object Label8: TLabel
          Left = 16
          Top = 12
          Width = 361
          Height = 13
          Caption = 'Note: Hit the "Save Changes" button to save your preferences.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object btnSaveFidelityPrefs: TButton
          Left = 407
          Top = 8
          Width = 104
          Height = 25
          Caption = 'Save Changes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = btnSaveFidelityPrefsClick
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 46
        Width = 1107
        Height = 398
        Align = alClient
        TabOrder = 1
        object GroupBox2: TGroupBox
          Left = 1
          Top = 1
          Width = 1105
          Height = 396
          Align = alClient
          Caption = 'Subject Preferences'
          Constraints.MinHeight = 258
          TabOrder = 0
          object chkAPNTransferSubj: TCheckBox
            Left = 6
            Top = 25
            Width = 249
            Height = 16
            Caption = 'Transfer APN to City/State/Zip field'
            TabOrder = 0
          end
          object chkAssessedLand: TCheckBox
            Left = 6
            Top = 48
            Width = 256
            Height = 17
            Caption = 'Transfer Assessed Land Value to Cost Approach'
            TabOrder = 1
          end
          object chkAssessedImprovements: TCheckBox
            Left = 6
            Top = 72
            Width = 274
            Height = 18
            Caption = 'Transfer Assessed Improvements to Cost Approach'
            TabOrder = 2
          end
          object chkRecordingDateContract: TCheckBox
            Left = 291
            Top = 48
            Width = 265
            Height = 17
            Caption = 'Transfer Recording Date to Contract Date field'
            TabOrder = 3
          end
          object chkRecordingDatePrior: TCheckBox
            Left = 291
            Top = 72
            Width = 265
            Height = 18
            Caption = 'Transfer Recording Date to Date of Prior Sale field'
            TabOrder = 4
          end
          object chkSalesPriceContract: TCheckBox
            Left = 291
            Top = 120
            Width = 241
            Height = 17
            Caption = 'Transfer Sales Price to Contract Price field'
            TabOrder = 5
          end
          object chkSalesPricePrior: TCheckBox
            Left = 291
            Top = 144
            Width = 249
            Height = 17
            Caption = 'Transfer Sales Price to Price of Prior Sale field'
            TabOrder = 6
          end
          object chkFidelityTransferSubject: TCheckBox
            Left = 6
            Top = 120
            Width = 273
            Height = 17
            Caption = 'Transfer "Fidelity" as the Data Source for Prior Sales'
            TabOrder = 7
          end
          object chkSalesPriceGrid: TCheckBox
            Left = 291
            Top = 96
            Width = 202
            Height = 17
            Caption = 'Transfer Sales Price to the Grid'
            Checked = True
            State = cbChecked
            TabOrder = 8
          end
          object chkFidelityTransferSubjectDataSource: TCheckBox
            Left = 6
            Top = 96
            Width = 241
            Height = 17
            Caption = 'Transfer "Fidelity" as the Data Source'
            Checked = True
            State = cbChecked
            TabOrder = 9
          end
          object chkFidelityTransferSubjectVerificationSource: TCheckBox
            Left = 6
            Top = 144
            Width = 241
            Height = 17
            Caption = 'Transfer "Fidelity" as the Verification Source'
            TabOrder = 10
          end
          object chkRecordingDateSubjectGrid: TCheckBox
            Left = 291
            Top = 25
            Width = 265
            Height = 16
            Caption = 'Transfer Recording Date to Date of Sale on Grid'
            Checked = True
            State = cbChecked
            TabOrder = 11
          end
        end
      end
      object Panel5: TPanel
        Left = 0
        Top = 444
        Width = 1107
        Height = 146
        Align = alBottom
        TabOrder = 2
        object GroupBox3: TGroupBox
          Left = 1
          Top = 1
          Width = 305
          Height = 144
          Align = alLeft
          Caption = 'Comparable Preferences'
          TabOrder = 0
          object chkAPNTransferComps: TCheckBox
            Left = 16
            Top = 25
            Width = 204
            Height = 16
            Caption = 'Transfer APN to City/State/Zip field'
            TabOrder = 0
          end
          object chkFidelityTransferComp: TCheckBox
            Left = 16
            Top = 48
            Width = 241
            Height = 17
            Caption = 'Transfer "Fidelity" as the Data Source'
            Checked = True
            State = cbChecked
            TabOrder = 1
          end
          object chkFidelityTransferVerification: TCheckBox
            Left = 16
            Top = 72
            Width = 241
            Height = 18
            Caption = 'Transfer "Fidelity" as the Verification Source'
            TabOrder = 2
          end
        end
        object GroupBox1: TGroupBox
          Left = 306
          Top = 1
          Width = 800
          Height = 144
          Align = alClient
          Caption = 'Other Preferences'
          TabOrder = 1
          object chkFidelityDueDiligence: TCheckBox
            Left = 25
            Top = 25
            Width = 200
            Height = 16
            Caption = 'Transfer Data to Due Diligence Form'
            Checked = True
            State = cbChecked
            TabOrder = 0
          end
          object chkHighlightFields: TCheckBox
            Left = 25
            Top = 48
            Width = 192
            Height = 17
            Caption = 'Highlight Fields That Transfer Data'
            Checked = True
            State = cbChecked
            TabOrder = 1
          end
        end
      end
    end
  end
end
