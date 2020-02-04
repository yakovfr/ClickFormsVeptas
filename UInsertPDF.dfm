object PDFViewer: TPDFViewer
  Left = 1010
  Top = 241
  Width = 550
  Height = 510
  ActiveControl = rbtnAllPages
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Select PDF Pages to Insert'
  Color = clBtnFace
  Constraints.MinHeight = 510
  Constraints.MinWidth = 550
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    534
    474)
  PixelsPerInch = 96
  TextHeight = 13
  object lblExhibitTitle: TLabel
    Left = 320
    Top = 296
    Width = 79
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'New Exhibit Title'
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 455
    Width = 534
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object btnInsert: TButton
    Left = 328
    Top = 400
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Insert'
    ModalResult = 1
    TabOrder = 4
    OnClick = btnInsertClick
  end
  object btnCancel: TButton
    Left = 432
    Top = 400
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
  object rgpFormType: TRadioGroup
    Left = 320
    Top = 136
    Width = 209
    Height = 129
    Anchors = [akTop, akRight]
    Caption = 'Insert Into...'
    ItemIndex = 1
    Items.Strings = (
      'Selected Exhibit Cell'
      'New Legal Size Exhibit Addendum'
      'New Letter Size Exhibit Addendum'
      'New Legal Size (no borders) Exhibit'
      'New Letter Size (no borders) Exhibit')
    TabOrder = 2
    OnClick = rgpFormTypeClick
  end
  object GroupBox1: TGroupBox
    Left = 320
    Top = 24
    Width = 201
    Height = 89
    Anchors = [akTop, akRight]
    Caption = 'Select PDF Pages to Insert'
    TabOrder = 1
    object Label1: TLabel
      Left = 112
      Top = 49
      Width = 9
      Height = 13
      Caption = 'to'
    end
    object rbtnAllPages: TRadioButton
      Left = 16
      Top = 24
      Width = 81
      Height = 17
      Caption = 'All Pages'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rbtnPgRange: TRadioButton
      Left = 16
      Top = 48
      Width = 57
      Height = 17
      Caption = 'Pages'
      TabOrder = 1
    end
    object edtPgStart: TEdit
      Left = 72
      Top = 46
      Width = 33
      Height = 21
      TabOrder = 2
      Text = '1'
      OnChange = edtPgStartChange
    end
    object edtPgEnd: TEdit
      Left = 128
      Top = 46
      Width = 33
      Height = 21
      TabOrder = 3
      Text = '1'
      OnChange = edtPgStartChange
    end
  end
  object edtTitle: TEdit
    Left = 320
    Top = 312
    Width = 201
    Height = 21
    Anchors = [akTop, akRight]
    TabOrder = 3
    Text = 'Sales Contract'
  end
  object pnlViewer: TPanel
    Left = 0
    Top = 0
    Width = 301
    Height = 455
    Align = alLeft
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvNone
    TabOrder = 0
    object Viewer: TGdViewer
      Left = 0
      Top = 0
      Width = 284
      Height = 455
      Align = alClient
      TabOrder = 0
      OnPageChange = ViewerPageChange
      ControlData = {
        93B200003C020000030008000BF25747200000005F0065007800740065006E00
        740078005A1D0000030008000AF25747200000005F0065007800740065006E00
        74007900072F00000B000A002F18E5962400000065006E00610062006C006500
        6D0065006E007500000000000B000A003B9F35D524000000730069006C006500
        6E0074006D006F0064006500FFFF000003000F006BC254FB3000000070006400
        6600640070006900720065006E0064006500720069006E0067002C0100000000
        030008003976C76A200000007A006F006F006D006D006F006400650002000000
        02000B000B89C4CE2400000062006F0072006400650072007300740079006C00
        6500000002000A00256015332400000061007000700065006100720061006E00
        630065000000000003000900267525BE240000006200610063006B0063006F00
        6C006F007200FFFFFF0000000B001200C0A9137F340000007300630072006F00
        6C006C006F007000740069006D0069007A006100740069006F006E00FFFF0000
        08000A0027BBA5BE580000006C006900630065006E00730065006B0065007900
        1900000031003500310039003700390036003700340033003600340035003800
        33003700370037003100320039003100350033003200000003000E00E7DA4F06
        2C0000006D006F0075007300650077006800650065006C006D006F0064006500
        010000000B00140000599D2A04FEFFFF6F007000740069006D0069007A006500
        640072006100770069006E00670073007000650065006400FFFF0000}
    end
    object ViewerScrollBar: TScrollBar
      Left = 284
      Top = 0
      Width = 17
      Height = 455
      Align = alRight
      Enabled = False
      Kind = sbVertical
      Max = 0
      PageSize = 0
      TabOrder = 1
      OnScroll = ViewerScrollBarScroll
    end
  end
  object Cropper: TImaging
    Left = 360
    Top = 344
    Width = 100
    Height = 41
    ControlData = {
      93B2000048000000030008000BF25747200000005F0065007800740065006E00
      74007800E5020000030008000AF25747E0FFFFFF5F0065007800740065006E00
      74007900E5020000}
  end
end
