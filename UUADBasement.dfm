object dlgUADBasement: TdlgUADBasement
  Left = 498
  Top = 166
  ActiveControl = edtTotSize
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'UAD: Basement Finish Information'
  ClientHeight = 199
  ClientWidth = 557
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    557
    199)
  PixelsPerInch = 96
  TextHeight = 13
  object lblTotSize: TLabel
    Tag = 1
    Left = 20
    Top = 33
    Width = 89
    Height = 16
    Caption = 'Basement Area'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segeo UI'
    Font.Style = []
    ParentFont = False
  end
  object lblFinSize: TLabel
    Left = 236
    Top = 33
    Width = 79
    Height = 16
    Caption = 'Finished Area'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segeo UI'
    Font.Style = []
    ParentFont = False
  end
  object lblRecRoomCnt: TLabel
    Left = 8
    Top = 89
    Width = 69
    Height = 17
    Alignment = taRightJustify
    Caption = 'Rec. Rooms'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblBedroomCnt: TLabel
    Left = 92
    Top = 89
    Width = 60
    Height = 17
    Alignment = taRightJustify
    Caption = 'Bedrooms'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblFullBathCnt: TLabel
    Left = 174
    Top = 89
    Width = 48
    Height = 17
    Alignment = taRightJustify
    Caption = 'Full Bath'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblHalfBathCnt: TLabel
    Left = 244
    Top = 89
    Width = 52
    Height = 17
    Alignment = taRightJustify
    Caption = 'Half Bath'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblOtherRoomCnt: TLabel
    Left = 303
    Top = 89
    Width = 78
    Height = 17
    Alignment = taRightJustify
    Caption = 'Other Rooms'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblFinPercent: TLabel
    Left = 125
    Top = 33
    Width = 98
    Height = 16
    Caption = 'Finished Percent'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segeo UI'
    Font.Style = []
    ParentFont = False
  end
  object lblSqft1: TLabel
    Left = 80
    Top = 56
    Width = 28
    Height = 16
    Caption = 'SqFt'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segeo UI'
    Font.Style = []
    ParentFont = False
  end
  object lblSqft2: TLabel
    Left = 297
    Top = 56
    Width = 28
    Height = 16
    Caption = 'SqFt'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segeo UI'
    Font.Style = []
    ParentFont = False
  end
  object bbtnCancel: TBitBtn
    Left = 398
    Top = 159
    Width = 70
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = '&Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 11
  end
  object bbtnOK: TBitBtn
    Left = 317
    Top = 159
    Width = 70
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Save'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    OnClick = bbtnOKClick
  end
  object edtTotSize: TEdit
    Tag = 1
    Left = 23
    Top = 53
    Width = 55
    Height = 24
    Hint = '4426'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segeo UI'
    Font.Style = []
    MaxLength = 5
    ParentFont = False
    TabOrder = 1
    Text = '99999'
    OnChange = edtTotSizeChange
    OnKeyPress = edtTotSizeKeyPress
  end
  object edtFinSize: TEdit
    Left = 239
    Top = 53
    Width = 55
    Height = 24
    Hint = '4427'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segeo UI'
    Font.Style = []
    MaxLength = 5
    ParentFont = False
    TabOrder = 3
    Text = '99999'
    OnExit = edtFinSizeExit
    OnKeyPress = edtFinSizeKeyPress
  end
  object rgAccess: TRadioGroup
    Left = 424
    Top = 5
    Width = 121
    Height = 116
    Hint = '4519'
    Caption = 'Access Method'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segeo UI'
    Font.Style = []
    Items.Strings = (
      'Walk-out'
      'Walk-up'
      'Interior only')
    ParentFont = False
    TabOrder = 9
  end
  object rzseRecRoomCnt: TRzSpinEdit
    Left = 32
    Top = 109
    Width = 36
    Height = 25
    Hint = '4428'
    AllowKeyEdit = True
    Max = 9.000000000000000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object rzseBedroomCnt: TRzSpinEdit
    Left = 102
    Top = 109
    Width = 36
    Height = 25
    Hint = '4429'
    AllowKeyEdit = True
    Max = 9.000000000000000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object rzseFullBathCnt: TRzSpinEdit
    Left = 172
    Top = 109
    Width = 36
    Height = 25
    Hint = '4430'
    AllowKeyEdit = True
    Max = 9.000000000000000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object rzseHalfBathCnt: TRzSpinEdit
    Left = 242
    Top = 109
    Width = 36
    Height = 25
    Hint = '4430'
    AllowKeyEdit = True
    Max = 9.000000000000000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object rzseOtherRoomCnt: TRzSpinEdit
    Left = 312
    Top = 109
    Width = 36
    Height = 25
    Hint = '4520'
    AllowKeyEdit = True
    Max = 9.000000000000000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object rzseFinPercent: TRzSpinEdit
    Left = 127
    Top = 53
    Width = 74
    Height = 24
    Hint = '4427'
    AllowBlank = True
    AllowKeyEdit = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segeo UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnExit = rzseFinPercentExit
  end
  object bbtnHelp: TBitBtn
    Left = 479
    Top = 159
    Width = 70
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Help'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
    OnClick = bbtnHelpClick
  end
  object bbtnClear: TBitBtn
    Left = 8
    Top = 159
    Width = 70
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'C&lear'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
    OnClick = bbtnClearClick
  end
  object chkNoBsmt: TCheckBox
    Left = 22
    Top = 9
    Width = 124
    Height = 21
    Caption = 'No Basement'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segeo UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = chkNoBsmtClick
  end
end
