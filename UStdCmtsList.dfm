object ShowCmts: TShowCmts
  Left = 302
  Top = 175
  Width = 457
  Height = 133
  BorderIcons = [biSystemMenu]
  Caption = 'List of available Standard Comments'
  Color = clBtnFace
  Constraints.MinHeight = 125
  Constraints.MinWidth = 205
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object cmtText: TMemo
    Left = 105
    Top = 0
    Width = 264
    Height = 105
    TabStop = False
    Align = alClient
    Lines.Strings = (
      '')
    TabOrder = 1
    OnChange = cmtTextChange
    OnKeyDown = TextKeyDown
  end
  object Panel1: TPanel
    Left = 369
    Top = 0
    Width = 80
    Height = 105
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 2
    object btnDone: TButton
      Left = 4
      Top = 73
      Width = 75
      Height = 23
      Caption = 'Done'
      ModalResult = 1
      TabOrder = 3
      OnClick = btnDoneClick
    end
    object btnInsert: TButton
      Left = 4
      Top = 1
      Width = 75
      Height = 23
      Caption = 'Insert'
      TabOrder = 0
      OnClick = btnInsertClick
    end
    object btnReplace: TButton
      Left = 4
      Top = 49
      Width = 75
      Height = 23
      Caption = 'Replace'
      TabOrder = 2
      OnClick = btnReplaceClick
    end
    object btnAppend: TButton
      Left = 4
      Top = 25
      Width = 75
      Height = 23
      Caption = 'Append'
      TabOrder = 1
      OnClick = btnAppendClick
    end
  end
  object CommentList: TListBox
    Left = 0
    Top = 0
    Width = 105
    Height = 105
    Align = alLeft
    ExtendedSelect = False
    ItemHeight = 13
    TabOrder = 0
    OnClick = CommentListClick
    OnDblClick = CommentListDblClick
    OnKeyDown = CommentListKeyDown
  end
end
