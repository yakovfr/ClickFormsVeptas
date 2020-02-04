object PrefAppFiletypes: TPrefAppFiletypes
  Left = 0
  Top = 0
  Width = 590
  Height = 326
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 590
    Height = 65
    Align = alTop
    Alignment = taLeftJustify
    Caption = '  Order File Associations'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object gbAssociation: TGroupBox
      Left = 176
      Top = 3
      Width = 409
      Height = 58
      Caption = 'No Association Selected'
      TabOrder = 0
      object lblExtension: TLabel
        Left = 4
        Top = 15
        Width = 58
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Extension'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDesc: TLabel
        Left = 63
        Top = 15
        Width = 194
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Description'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edtExt: TEdit
        Left = 9
        Top = 31
        Width = 49
        Height = 21
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object edtDesc: TEdit
        Left = 63
        Top = 31
        Width = 194
        Height = 21
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object bbtnAdd: TBitBtn
        Tag = 2
        Left = 262
        Top = 17
        Width = 41
        Height = 25
        Caption = '&Add'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = bbtnAddClick
      end
      object bbtnEdit: TBitBtn
        Tag = 1
        Left = 310
        Top = 17
        Width = 41
        Height = 25
        Caption = '&Edit'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = bbtnEditClick
      end
      object bbtnSave: TBitBtn
        Left = 359
        Top = 17
        Width = 41
        Height = 25
        Caption = '&Save'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = bbtnSaveClick
      end
    end
  end
  object tsGrid: TtsGrid
    Left = 0
    Top = 65
    Width = 590
    Height = 261
    Align = alClient
    CheckBoxStyle = stCheck
    ColMoving = False
    Cols = 4
    ColSelectMode = csNone
    ExportDelimiter = ','
    HeadingFont.Charset = DEFAULT_CHARSET
    HeadingFont.Color = clWindowText
    HeadingFont.Height = -11
    HeadingFont.Name = 'MS Sans Serif'
    HeadingFont.Style = []
    ParentShowHint = False
    RowBarOn = False
    Rows = 1
    RowSelectMode = rsSingle
    ShowHint = False
    StoreData = True
    TabOrder = 1
    Version = '3.01.08'
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    OnClickCell = tsGridClickCell
    ColProperties = <
      item
        DataCol = 1
        Col.Font.Charset = DEFAULT_CHARSET
        Col.Font.Color = clWindowText
        Col.Font.Height = -11
        Col.Font.Name = 'MS Sans Serif'
        Col.Font.Style = []
        Col.Heading = 'Extension'
        Col.HeadingFont.Charset = DEFAULT_CHARSET
        Col.HeadingFont.Color = clWindowText
        Col.HeadingFont.Height = -11
        Col.HeadingFont.Name = 'MS Sans Serif'
        Col.HeadingFont.Style = [fsBold]
        Col.HeadingHorzAlignment = htaCenter
        Col.HeadingParentFont = False
        Col.ParentFont = False
        Col.ReadOnly = True
        Col.HorzAlignment = htaCenter
        Col.Width = 75
      end
      item
        DataCol = 2
        Col.Heading = 'Description'
        Col.HeadingFont.Charset = DEFAULT_CHARSET
        Col.HeadingFont.Color = clWindowText
        Col.HeadingFont.Height = -11
        Col.HeadingFont.Name = 'MS Sans Serif'
        Col.HeadingFont.Style = [fsBold]
        Col.HeadingHorzAlignment = htaCenter
        Col.HeadingParentFont = False
        Col.ReadOnly = True
        Col.HorzAlignment = htaCenter
        Col.Width = 184
      end
      item
        DataCol = 3
        Col.ControlType = ctCheck
        Col.Heading = 'Set'
        Col.HeadingFont.Charset = DEFAULT_CHARSET
        Col.HeadingFont.Color = clWindowText
        Col.HeadingFont.Height = -11
        Col.HeadingFont.Name = 'MS Sans Serif'
        Col.HeadingFont.Style = [fsBold]
        Col.HeadingHorzAlignment = htaCenter
        Col.HeadingParentFont = False
        Col.HeadingImageAlignment = htaCenter
        Col.Width = 55
      end
      item
        DataCol = 4
        Col.ControlType = ctCheck
        Col.Font.Charset = DEFAULT_CHARSET
        Col.Font.Color = clWindowText
        Col.Font.Height = -11
        Col.Font.Name = 'MS Sans Serif'
        Col.Font.Style = []
        Col.Heading = 'Delete'
        Col.HeadingFont.Charset = DEFAULT_CHARSET
        Col.HeadingFont.Color = clWindowText
        Col.HeadingFont.Height = -11
        Col.HeadingFont.Name = 'MS Sans Serif'
        Col.HeadingFont.Style = [fsBold]
        Col.HeadingHorzAlignment = htaCenter
        Col.HeadingParentFont = False
        Col.ParentFont = False
        Col.HorzAlignment = htaCenter
        Col.Width = 55
      end>
    CellProperties = <
      item
        DataCol = 2
        DataRow = 1
        Cell.Color = clInactiveBorder
        Cell.ReadOnly = roOn
      end
      item
        DataCol = 1
        DataRow = 1
        Cell.Color = clInactiveBorder
        Cell.Font.Charset = DEFAULT_CHARSET
        Cell.Font.Color = clBlack
        Cell.Font.Height = -11
        Cell.Font.Name = 'MS Sans Serif'
        Cell.Font.Style = []
        Cell.ParentFont = False
        Cell.ReadOnly = roOn
      end
      item
        DataCol = 4
        DataRow = 1
        Cell.Color = clInactiveBorder
        Cell.ReadOnly = roOn
      end>
    Data = {
      0100000004000000010000000001000000000200000000020000000000000000
      00000000}
  end
end
