object DocPropEditor: TDocPropEditor
  Left = 784
  Top = 160
  Width = 310
  Height = 626
  BorderIcons = [biSystemMenu]
  Caption = 'Report Properties'
  Color = clBtnFace
  Constraints.MinHeight = 242
  Constraints.MinWidth = 273
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 579
    Width = 302
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object ValueListEditor: TValueListEditor
    Left = 0
    Top = 0
    Width = 302
    Height = 539
    Align = alClient
    DefaultRowHeight = 22
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSizing, goColSizing, goEditing, goTabs, goAlwaysShowEditor, goThumbTracking]
    ParentFont = False
    ScrollBars = ssVertical
    Strings.Strings = (
      'Report Type='
      'File No='
      'Search Keywords='
      'Street Number='
      'Street Name='
      'City='
      'State='
      'Zip='
      'County='
      'Census Tract='
      'Parcel No='
      'Neighborhood='
      'Map Reference='
      'Total Rooms='
      'Bedrooms='
      'Bathrooms='
      'Gross Living Area='
      'Site Area='
      'Appraisal Date='
      'Appraisal Value='
      'Borrower='
      'Client='
      'Author='
      'Date Created='
      'Last Modified=')
    TabOrder = 1
    TitleCaptions.Strings = (
      'Property'
      'Value')
    OnKeyDown = ValueListEditorKeyDown
    ColWidths = (
      138
      141)
  end
  object btnPanel: TPanel
    Left = 0
    Top = 539
    Width = 302
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btnSave: TButton
      Left = 97
      Top = 10
      Width = 107
      Height = 25
      Caption = 'Save to Report List'
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnRefresh: TButton
      Left = 14
      Top = 10
      Width = 70
      Height = 25
      Hint = 'Re-collects data from the report'
      Caption = 'Refresh'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnRefreshClick
    end
    object btnOk: TButton
      Left = 214
      Top = 10
      Width = 70
      Height = 25
      Caption = 'Close'
      ModalResult = 1
      TabOrder = 2
    end
  end
end
