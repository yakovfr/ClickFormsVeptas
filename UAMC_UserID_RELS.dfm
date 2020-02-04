inherited AMC_UserRELS: TAMC_UserRELS
  Width = 941
  Height = 412
  DesignSize = (
    941
    412)
  object Label3: TLabel
    Left = 10
    Top = 16
    Width = 90
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Order No.: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object labelOrder: TLabel
    Left = 103
    Top = 16
    Width = 150
    Height = 13
    AutoSize = False
    Caption = 'None'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 10
    Top = 41
    Width = 90
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Property:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LabelAddress: TLabel
    Left = 103
    Top = 41
    Width = 320
    Height = 13
    AutoSize = False
    Caption = 'None'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LabelCityStZip: TLabel
    Left = 103
    Top = 60
    Width = 320
    Height = 13
    AutoSize = False
    Caption = 'None'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 10
    Top = 83
    Width = 90
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Received:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 10
    Top = 103
    Width = 90
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Due:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LabelRecDate: TLabel
    Left = 103
    Top = 83
    Width = 80
    Height = 13
    AutoSize = False
    Caption = '12/12/08'
  end
  object LabelDueDate: TLabel
    Left = 103
    Top = 103
    Width = 80
    Height = 13
    AutoSize = False
    Caption = '12/12/08'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 404
    Top = 16
    Width = 95
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Confirm Order No'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 404
    Top = 42
    Width = 95
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Vendor ID'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 404
    Top = 68
    Width = 95
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'User ID'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 404
    Top = 94
    Width = 95
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Password'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object RzLine3: TRzLine
    Left = 23
    Top = 133
    Width = 394
    Height = 20
    Visible = False
  end
  object Label1: TLabel
    Left = 30
    Top = 156
    Width = 432
    Height = 13
    Caption = 
      'Was any attempt made to place undue influence on you during the ' +
      'completion of this order?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblInfluence: TLabel
    Left = 30
    Top = 206
    Width = 379
    Height = 13
    Caption = 
      'If yes, please elaborate on the attempt to place undue influence' +
      ' on the appraiser'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object edtOrderID: TEdit
    Left = 506
    Top = 13
    Width = 160
    Height = 21
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object edtVendorID: TEdit
    Left = 507
    Top = 38
    Width = 160
    Height = 21
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object edtUserID: TEdit
    Left = 507
    Top = 63
    Width = 160
    Height = 21
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object edtUserPSW: TEdit
    Left = 507
    Top = 89
    Width = 160
    Height = 21
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    PasswordChar = '*'
    TabOrder = 3
  end
  object radBtnYes: TRadioButton
    Left = 78
    Top = 180
    Width = 67
    Height = 17
    Caption = 'Yes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object radbtnNo: TRadioButton
    Left = 30
    Top = 180
    Width = 43
    Height = 17
    Caption = 'No'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object menoInfluence: TMemo
    Left = 30
    Top = 228
    Width = 491
    Height = 112
    Anchors = [akLeft, akTop, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
end
