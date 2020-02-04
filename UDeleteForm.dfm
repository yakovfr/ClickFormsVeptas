object DeleteForms: TDeleteForms
  Left = 586
  Top = 196
  Width = 385
  Height = 305
  Caption = 'Delete Forms'
  Color = clBtnFace
  Constraints.MaxWidth = 385
  Constraints.MinHeight = 270
  Constraints.MinWidth = 385
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 252
    Width = 377
    Height = 19
    Panels = <>
    SimplePanel = True
    SimpleText = '  Press SHIFT to select/deselect all forms'
  end
  object Panel2: TPanel
    Left = 276
    Top = 0
    Width = 101
    Height = 252
    Align = alRight
    TabOrder = 1
    object btnCancel: TButton
      Left = 14
      Top = 208
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
    end
    object btnDelete: TButton
      Left = 14
      Top = 168
      Width = 75
      Height = 25
      Caption = 'Delete'
      Enabled = False
      TabOrder = 1
      OnClick = btnDeleteClick
    end
  end
  object GridDeleteList: TtsGrid
    Left = 0
    Top = 0
    Width = 276
    Height = 252
    Align = alClient
    CheckBoxStyle = stCheck
    Cols = 2
    DefaultRowHeight = 18
    ExportDelimiter = ','
    HeadingFont.Charset = DEFAULT_CHARSET
    HeadingFont.Color = clWindowText
    HeadingFont.Height = -11
    HeadingFont.Name = 'MS Sans Serif'
    HeadingFont.Style = []
    HeadingOn = False
    RowBarIndicator = False
    RowBarWidth = 0
    RowChangedIndicator = riOff
    Rows = 4
    ScrollBars = ssVertical
    StoreData = True
    TabOrder = 2
    ThumbTracking = True
    Version = '3.01.08'
    XMLExport.Version = '1.0'
    XMLExport.DataPacketVersion = '2.0'
    OnClickCell = GridDeleteListClickCell
    Data = {0000000000000000}
  end
end
