object DataImport: TDataImport
  Left = 674
  Top = 236
  Width = 565
  Height = 416
  Caption = 'Import Property Data File'
  Color = clBtnFace
  Constraints.MinHeight = 416
  Constraints.MinWidth = 565
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 343
    Width = 549
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      549
      37)
    object btnPrevPage: TButton
      Left = 290
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '<<< Previous'
      Enabled = False
      TabOrder = 0
      OnClick = OnBackClick
    end
    object btnNextPage: TButton
      Left = 378
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Next  >>>'
      TabOrder = 1
      OnClick = OnNextClick
    end
    object btnClose: TButton
      Left = 466
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Close'
      ModalResult = 1
      TabOrder = 2
    end
    object chkOverwrite: TCheckBox
      Left = 145
      Top = 12
      Width = 129
      Height = 17
      Caption = 'Overwrite Existing Text'
      TabOrder = 3
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 549
    Height = 343
    ActivePage = tshMapping
    Align = alClient
    TabOrder = 1
    object tshMapping: TTabSheet
      Caption = 'tshMapping'
      ImageIndex = 1
      TabVisible = False
      OnShow = OnMappingPageShow
      object tsGridMap: TtsGrid
        Left = 0
        Top = 0
        Width = 541
        Height = 333
        Align = alClient
        CheckBoxStyle = stCheck
        Cols = 5
        DefaultColWidth = 95
        DefaultRowHeight = 17
        ExportDelimiter = ','
        HeadingFont.Charset = DEFAULT_CHARSET
        HeadingFont.Color = clWindowText
        HeadingFont.Height = -11
        HeadingFont.Name = 'MS Sans Serif'
        HeadingFont.Style = []
        ParentShowHint = False
        ResizeRows = rrNone
        Rows = 4
        RowSelectMode = rsNone
        ShowHint = False
        StoreData = True
        TabOrder = 0
        ThumbTracking = True
        Version = '3.01.08'
        XMLExport.Version = '1.0'
        XMLExport.DataPacketVersion = '2.0'
        OnCellEdit = OnCellEdit
        OnExit = OnMappingGridExit
        ColProperties = <
          item
            DataCol = 1
            Col.Heading = 'Field No.'
            Col.HeadingHorzAlignment = htaCenter
            Col.ReadOnly = True
            Col.HorzAlignment = htaCenter
            Col.Width = 50
          end
          item
            DataCol = 2
            Col.Heading = 'Data Field Name'
            Col.HeadingHorzAlignment = htaCenter
            Col.ReadOnly = True
            Col.Width = 140
          end
          item
            DataCol = 3
            Col.Color = clBtnFace
            Col.Heading = 'Data  (can be edited)'
            Col.HeadingHorzAlignment = htaCenter
            Col.Width = 140
          end
          item
            DataCol = 4
            Col.Heading = 'ClickForms Cell Name'
            Col.HeadingHorzAlignment = htaCenter
            Col.ReadOnly = True
            Col.Width = 140
          end
          item
            DataCol = 5
            Col.Heading = 'Cell ID'
            Col.HeadingHorzAlignment = htaCenter
            Col.HeadingColor = clWindow
            Col.Visible = False
            Col.Width = 60
          end>
        Data = {
          0100000005000000010000000001000000000100000000010000000001000000
          000000000000000000}
      end
    end
    object tshImport: TTabSheet
      Caption = 'tshImport'
      ImageIndex = 2
      TabVisible = False
      OnShow = OnImportPageShow
      object tsGridRecords: TtsGrid
        Tag = 1
        Left = 0
        Top = 0
        Width = 541
        Height = 333
        Align = alClient
        CheckBoxStyle = stCheck
        ColMoving = False
        Cols = 4
        DefaultColWidth = 70
        DefaultRowHeight = 16
        ExportDelimiter = ','
        HeadingFont.Charset = DEFAULT_CHARSET
        HeadingFont.Color = clWindowText
        HeadingFont.Height = -11
        HeadingFont.Name = 'MS Sans Serif'
        HeadingFont.Style = []
        ParentShowHint = False
        ResizeRows = rrNone
        Rows = 4
        RowSelectMode = rsSingle
        ShowHint = False
        StoreData = True
        TabOrder = 0
        ThumbTracking = True
        Version = '3.01.08'
        XMLExport.Version = '1.0'
        XMLExport.DataPacketVersion = '2.0'
        ColProperties = <
          item
            DataCol = 1
            Col.ButtonType = btCombo
            Col.DropDownStyle = ddDropDownList
            Col.Heading = 'Import To'
            Col.HeadingHorzAlignment = htaCenter
            Col.ParentCombo = False
            Col.Width = 80
            Col.Combo = {
              545046300C547473436F6D626F4772696400044C656674020003546F70020005
              57696474680340010648656967687402780754616253746F70080A4175746F53
              656172636807056173546F700C44726F70446F776E526F7773020A0C44726F70
              446F776E436F6C7302010D44726F70446F776E5374796C65070E646444726F70
              446F776E4C6973740D436865636B426F785374796C6507077374436865636B04
              436F6C7302010543746C3344080F44656661756C74436F6C5769647468024A13
              48656164696E67466F6E742E43686172736574070F44454641554C545F434841
              525345541148656164696E67466F6E742E436F6C6F72070C636C57696E646F77
              546578741248656164696E67466F6E742E48656967687402F51048656164696E
              67466F6E742E4E616D65060D4D532053616E732053657269661148656164696E
              67466F6E742E5374796C650B000948656164696E674F6E080B506172656E7443
              746C3344080E506172656E7453686F7748696E74080A526573697A65436F6C73
              070672634E6F6E650A526573697A65526F7773070672724E6F6E6508526F7742
              61724F6E0804526F777302050A5363726F6C6C42617273070A73735665727469
              63616C0853686F7748696E74080953746F726544617461090D5468756D625472
              61636B696E67090756657273696F6E0607332E30312E303804446174610A3C00
              0000010000000100000001000000000200000001000000010000000003000000
              0100000001000000000400000001000000010000000000000000000000000000}
          end
          item
            DataCol = 3
            Col.Font.Charset = DEFAULT_CHARSET
            Col.Font.Color = clWindowText
            Col.Font.Height = -11
            Col.Font.Name = 'MS Sans Serif'
            Col.Font.Style = []
            Col.ParentFont = False
            Col.Width = 70
          end>
        Data = {010000000300000001000000000001000000000000000000000000}
      end
    end
  end
  object OpenDialog: TOpenDialog
    Left = 480
    Top = 120
  end
end
