object FormFinder: TFormFinder
  Left = 323
  Top = 155
  Width = 505
  Height = 117
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu]
  Caption = 'Form Finder'
  Color = clBtnFace
  Constraints.MinHeight = 117
  Constraints.MinWidth = 505
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SearchWordsL: TLabel
    Left = 4
    Top = 8
    Width = 74
    Height = 13
    Caption = 'Search Words: '
  end
  object SearchWordsE: TEdit
    Left = 80
    Top = 6
    Width = 225
    Height = 21
    TabOrder = 0
    Text = 'URAR'
    OnKeyUp = SearchWordsEKeyUp
  end
  object FindB: TButton
    Left = 312
    Top = 4
    Width = 75
    Height = 25
    Caption = 'Find'
    TabOrder = 2
    OnClick = FindBClick
  end
  object btnAdd: TButton
    Left = 400
    Top = 4
    Width = 89
    Height = 25
    Cancel = True
    Caption = 'Add to Report'
    Enabled = False
    TabOrder = 3
    OnClick = btnAddClick
  end
  object chkMatchAll: TCheckBox
    Left = 5
    Top = 36
    Width = 145
    Height = 17
    Caption = 'Match All Search Words'
    TabOrder = 1
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 59
    Width = 493
    Height = 22
    Panels = <>
    SimplePanel = True
  end
end
