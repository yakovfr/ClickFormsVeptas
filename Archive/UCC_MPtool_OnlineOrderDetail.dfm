object AWOrderDetail: TAWOrderDetail
  Left = -1511
  Top = 156
  Width = 986
  Height = 673
  Caption = 'Appraisal Order On-line Order Management'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object panelTop: TPanel
    Left = 0
    Top = 0
    Width = 970
    Height = 584
    Align = alClient
    TabOrder = 0
    object groupOrder: TGroupBox
      Left = 0
      Top = 1
      Width = 600
      Height = 132
      Caption = 'Order Information'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label3: TLabel
        Left = 33
        Top = 23
        Width = 53
        Height = 16
        Caption = 'Order ID:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 25
        Top = 98
        Width = 61
        Height = 16
        Caption = 'Order Ref:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 8
        Top = 43
        Width = 78
        Height = 16
        Caption = 'Order Owner:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 24
        Top = 68
        Width = 62
        Height = 16
        Caption = 'Received:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 372
        Top = 23
        Width = 77
        Height = 16
        Caption = 'Order Status:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 385
        Top = 46
        Width = 60
        Height = 16
        Caption = 'Due Date:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edtOrderID: TEdit
        Left = 93
        Top = 20
        Width = 121
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object edtOwner: TEdit
        Left = 93
        Top = 42
        Width = 220
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object edtReceivedDate: TEdit
        Left = 93
        Top = 65
        Width = 121
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object edtStatus: TEdit
        Left = 455
        Top = 20
        Width = 121
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
      end
      object edtDueDate: TEdit
        Left = 455
        Top = 47
        Width = 121
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object OrderRefMemo: TMemo
        Left = 94
        Top = 90
        Width = 500
        Height = 36
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Lines.Strings = (
          '')
        ParentFont = False
        TabOrder = 3
      end
    end
    object groupFee: TGroupBox
      Left = 604
      Top = 276
      Width = 357
      Height = 85
      Caption = 'Order Fee Management'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 4
      object Label1: TLabel
        Left = 11
        Top = 25
        Width = 102
        Height = 16
        Caption = 'Amount Invoiced:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 34
        Top = 56
        Width = 79
        Height = 16
        Caption = 'Amount Paid:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edtInvoice: TEdit
        Left = 118
        Top = 20
        Width = 121
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object edtPaid: TEdit
        Left = 119
        Top = 52
        Width = 121
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
    object groupRequestor: TGroupBox
      Left = 0
      Top = 133
      Width = 600
      Height = 120
      Caption = 'Requestor Information'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 1
      object Label9: TLabel
        Left = 45
        Top = 19
        Width = 40
        Height = 16
        Caption = 'Name:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 320
        Top = 19
        Width = 41
        Height = 16
        Caption = 'E-mail:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 24
        Top = 44
        Width = 61
        Height = 16
        Caption = 'Company:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 319
        Top = 45
        Width = 42
        Height = 16
        Caption = 'Phone:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 31
        Top = 69
        Width = 54
        Height = 16
        Caption = 'Address:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label15: TLabel
        Left = 60
        Top = 95
        Width = 25
        Height = 16
        Caption = 'City:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label16: TLabel
        Left = 336
        Top = 72
        Width = 25
        Height = 16
        Caption = 'Fax:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label17: TLabel
        Left = 250
        Top = 95
        Width = 34
        Height = 16
        Caption = 'State:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label18: TLabel
        Left = 340
        Top = 95
        Width = 22
        Height = 16
        Caption = 'Zip:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edtRequestor: TEdit
        Left = 93
        Top = 15
        Width = 220
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object edtEmail: TEdit
        Left = 366
        Top = 15
        Width = 230
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object edtCompany: TEdit
        Left = 93
        Top = 40
        Width = 220
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object edtPhone: TEdit
        Left = 366
        Top = 40
        Width = 230
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object edtStreet: TEdit
        Left = 93
        Top = 65
        Width = 220
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object edtCity: TEdit
        Left = 93
        Top = 91
        Width = 121
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object edtFax: TEdit
        Left = 366
        Top = 65
        Width = 230
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object edtState: TEdit
        Left = 287
        Top = 91
        Width = 26
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object edtZip: TEdit
        Left = 366
        Top = 91
        Width = 72
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
    end
    object WebBrowser1: TWebBrowser
      Left = 604
      Top = 0
      Width = 357
      Height = 270
      TabOrder = 6
      ControlData = {
        4C000000E6240000E81B00000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
    object groupAppraisal: TGroupBox
      Left = 0
      Top = 416
      Width = 600
      Height = 158
      Caption = 'Property Information'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 3
      object Label35: TLabel
        Left = 46
        Top = 19
        Width = 89
        Height = 16
        Caption = 'Property Type:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label36: TLabel
        Left = 81
        Top = 47
        Width = 54
        Height = 16
        Caption = 'Address:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label37: TLabel
        Left = 110
        Top = 74
        Width = 25
        Height = 16
        Caption = 'City:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label38: TLabel
        Left = 280
        Top = 74
        Width = 34
        Height = 16
        Caption = 'State:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label39: TLabel
        Left = 21
        Top = 107
        Width = 114
        Height = 16
        Caption = 'Property Comment:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label40: TLabel
        Left = 365
        Top = 74
        Width = 22
        Height = 16
        Caption = 'Zip:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label41: TLabel
        Left = 388
        Top = 19
        Width = 205
        Height = 16
        Caption = 'Additional Information (If Available)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label42: TLabel
        Left = 466
        Top = 47
        Width = 81
        Height = 16
        Caption = 'Total Rooms:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label43: TLabel
        Left = 481
        Top = 74
        Width = 66
        Height = 16
        Caption = 'Bedrooms:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label44: TLabel
        Left = 510
        Top = 101
        Width = 37
        Height = 16
        Caption = 'Baths:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edtPropType: TEdit
        Left = 147
        Top = 15
        Width = 212
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object edtPropAddr: TEdit
        Left = 147
        Top = 42
        Width = 272
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object edtPropCity: TEdit
        Left = 147
        Top = 69
        Width = 104
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object edtPropState: TEdit
        Left = 322
        Top = 70
        Width = 26
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object edtPropZip: TEdit
        Left = 393
        Top = 70
        Width = 72
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object PropMemo: TMemo
        Left = 147
        Top = 96
        Width = 332
        Height = 58
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Lines.Strings = (
          '')
        ParentFont = False
        TabOrder = 5
      end
      object edtTotRm: TEdit
        Left = 550
        Top = 42
        Width = 45
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object edtBeds: TEdit
        Left = 550
        Top = 70
        Width = 45
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object edtBaths: TEdit
        Left = 550
        Top = 98
        Width = 45
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
    end
    object groupLoan: TGroupBox
      Left = 604
      Top = 360
      Width = 357
      Height = 216
      Caption = 'Loan Information'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 5
      object Label29: TLabel
        Left = 63
        Top = 29
        Width = 45
        Height = 16
        Caption = 'Lender:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label30: TLabel
        Left = 49
        Top = 93
        Width = 59
        Height = 16
        Caption = 'Loan Amt:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label31: TLabel
        Left = 51
        Top = 61
        Width = 57
        Height = 16
        Caption = 'Borrower:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label32: TLabel
        Left = 65
        Top = 125
        Width = 43
        Height = 16
        Caption = 'Loan #:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label33: TLabel
        Left = 7
        Top = 157
        Width = 101
        Height = 16
        Caption = 'Value Estimated:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label34: TLabel
        Left = 17
        Top = 189
        Width = 91
        Height = 16
        Caption = 'Loan To Value:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edtLender: TEdit
        Left = 118
        Top = 25
        Width = 200
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object edtLoanAmt: TEdit
        Left = 118
        Top = 89
        Width = 125
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object edtBorrower: TEdit
        Left = 118
        Top = 57
        Width = 200
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object edtLoanNum: TEdit
        Left = 118
        Top = 121
        Width = 125
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object edtValueEst: TEdit
        Left = 118
        Top = 153
        Width = 125
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object edtloanValue: TEdit
        Left = 118
        Top = 185
        Width = 125
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
    end
    object groupProperty: TGroupBox
      Left = 0
      Top = 252
      Width = 600
      Height = 165
      Caption = 'Appraisal Order Information'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 2
      object Label19: TLabel
        Left = 43
        Top = 19
        Width = 96
        Height = 16
        Caption = 'Appraisal Type:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label20: TLabel
        Left = 382
        Top = 19
        Width = 70
        Height = 16
        Caption = 'Other Type:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label21: TLabel
        Left = 24
        Top = 43
        Width = 115
        Height = 16
        Caption = 'Appraisal Purpose:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label22: TLabel
        Left = 363
        Top = 43
        Width = 89
        Height = 16
        Caption = 'Other Purpose:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label23: TLabel
        Left = 9
        Top = 68
        Width = 130
        Height = 16
        Caption = 'Requested Due Date:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label24: TLabel
        Left = 412
        Top = 67
        Width = 40
        Height = 16
        Caption = 'FHA #:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label25: TLabel
        Left = 59
        Top = 92
        Width = 80
        Height = 16
        Caption = 'Accepted By:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label26: TLabel
        Left = 35
        Top = 117
        Width = 104
        Height = 16
        Caption = 'Payment Method:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label27: TLabel
        Left = 38
        Top = 142
        Width = 101
        Height = 16
        Caption = 'Delivery Method:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label28: TLabel
        Left = 280
        Top = 79
        Width = 97
        Height = 16
        Caption = 'Order Comment:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edtAppType: TEdit
        Left = 148
        Top = 15
        Width = 124
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object edtOtherType: TEdit
        Left = 462
        Top = 15
        Width = 124
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object edtAppPurpose: TEdit
        Left = 147
        Top = 39
        Width = 124
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object edtOtherPurpose: TEdit
        Left = 462
        Top = 39
        Width = 124
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object edtReqDueDate: TEdit
        Left = 147
        Top = 64
        Width = 124
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object edtFHA: TEdit
        Left = 462
        Top = 63
        Width = 124
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object edtAcceptedBy: TEdit
        Left = 147
        Top = 88
        Width = 124
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object edtPaymentMethod: TEdit
        Left = 147
        Top = 113
        Width = 124
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object edtDeliveryMethod: TEdit
        Left = 147
        Top = 138
        Width = 124
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object OrderMemo: TMemo
        Left = 276
        Top = 96
        Width = 313
        Height = 65
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Lines.Strings = (
          '')
        ParentFont = False
        TabOrder = 9
      end
    end
    object panelLeft: TPanel
      Left = 969
      Top = 1
      Width = 0
      Height = 582
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 7
      Visible = False
      object Label14: TLabel
        Left = 8
        Top = 380
        Width = 56
        Height = 13
        Caption = 'Eff. Date:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object StaticText26: TStaticText
        Left = 0
        Top = 0
        Width = 0
        Height = 17
        Align = alTop
        Alignment = taCenter
        Caption = 'Select A Template Report'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object FileTree: TTreeView
        Left = 0
        Top = 17
        Width = 0
        Height = 325
        Align = alTop
        Images = SelectTemplate.FileImages
        Indent = 19
        ShowLines = False
        SortType = stText
        TabOrder = 1
        OnDblClick = btnStartClick
      end
      object StatusBar: TStatusBar
        Left = 0
        Top = 342
        Width = 0
        Height = 19
        Align = alTop
        Panels = <>
        SimplePanel = True
      end
      object edtEffDate: TRzDateTimeEdit
        Left = 76
        Top = 377
        Width = 120
        Height = 21
        EditType = etDate
        Format = 'mm/dd/yyyy'
        TabOrder = 3
      end
      object StaticText24: TStaticText
        Left = 21
        Top = 412
        Width = 43
        Height = 17
        Caption = 'File No.:'
        TabOrder = 4
      end
      object edtFileNo: TRzEdit
        Left = 76
        Top = 408
        Width = 120
        Height = 21
        TabOrder = 5
      end
      object StaticText21: TStaticText
        Left = 5
        Top = 444
        Width = 59
        Height = 17
        Caption = 'Order Date:'
        TabOrder = 6
      end
      object edtOrderDate: TRzDateTimeEdit
        Left = 76
        Top = 440
        Width = 120
        Height = 21
        EditType = etDate
        Format = 'mm/dd/yyyy'
        TabOrder = 7
      end
      object StaticText22: TStaticText
        Left = 11
        Top = 476
        Width = 53
        Height = 17
        Caption = 'Due Date:'
        TabOrder = 8
      end
      object RzDateTimeEdit1: TRzDateTimeEdit
        Left = 76
        Top = 472
        Width = 120
        Height = 21
        EditType = etDate
        Format = 'mm/dd/yyyy'
        TabOrder = 9
      end
      object btnCancel: TButton
        Left = 4
        Top = 543
        Width = 78
        Height = 25
        Caption = '&Cancel'
        ModalResult = 2
        TabOrder = 10
      end
      object btnStart: TButton
        Left = 119
        Top = 542
        Width = 83
        Height = 25
        Caption = '&Start Appraisal'
        Enabled = False
        TabOrder = 11
        OnClick = btnStartClick
      end
      object ckIncludeFloodMap: TCheckBox
        Left = 11
        Top = 503
        Width = 115
        Height = 17
        Caption = 'Include Flood Map'
        Checked = True
        State = cbChecked
        TabOrder = 12
      end
      object ckIncludeBuildFax: TCheckBox
        Left = 134
        Top = 503
        Width = 105
        Height = 17
        Caption = 'Include Build Fax'
        Checked = True
        State = cbChecked
        TabOrder = 13
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 584
    Width = 970
    Height = 51
    Align = alBottom
    TabOrder = 1
    object btnClose: TButton
      Left = 768
      Top = 12
      Width = 75
      Height = 25
      Caption = '&Cancel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ModalResult = 2
      ParentFont = False
      TabOrder = 0
    end
    object btnPrev: TRzBitBtn
      Left = 29
      Top = 14
      Width = 60
      Caption = '&Prev'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnPrevClick
    end
    object btnNext: TRzBitBtn
      Left = 146
      Top = 14
      Width = 60
      Caption = '&Next'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btnNextClick
    end
  end
  object IdHTTP1: TIdHTTP
    AuthRetries = 0
    AuthProxyRetries = 0
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.ContentRangeInstanceLength = 0
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 732
    Top = 88
  end
  object XMLDocument1: TXMLDocument
    Left = 796
    Top = 88
    DOMVendorDesc = 'MSXML'
  end
end
