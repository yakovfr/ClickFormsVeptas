object InspectionDetail: TInspectionDetail
  Left = 413
  Top = 55
  BorderStyle = bsSingle
  Caption = 'Inspection Detail'
  ClientHeight = 623
  ClientWidth = 918
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnMouseWheel = FormMouseWheel
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TRzPageControl
    Left = 0
    Top = 57
    Width = 642
    Height = 566
    ActivePage = tabSubjPhotos
    Align = alClient
    TabColors.HighlightBar = clBtnFace
    TabHeight = 26
    TabIndex = 0
    TabOrder = 0
    TabWidth = 150
    OnChange = PageControlChange
    FixedDimension = 26
    object tabSubjPhotos: TRzTabSheet
      Caption = 'Subject Photos'
      object RzLabel1: TRzLabel
        Left = 0
        Top = 195
        Width = 638
        Height = 16
        Align = alTop
        Alignment = taCenter
        Caption = 'Subject Interior/Extra Exterior Photos'
        Color = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object BotPhotoSection: TScrollBox
        Left = 0
        Top = 211
        Width = 638
        Height = 306
        HorzScrollBar.Tracking = True
        VertScrollBar.Tracking = True
        Align = alClient
        TabOrder = 0
        object BotBasePanel: TPanel
          Left = 0
          Top = 0
          Width = 630
          Height = 302
          BevelOuter = bvNone
          TabOrder = 0
        end
      end
      object StatusBar: TStatusBar
        Left = 0
        Top = 517
        Width = 638
        Height = 19
        Panels = <
          item
            Width = 250
          end
          item
            Width = 250
          end>
      end
      object TopPhotoSection: TScrollBox
        Left = 0
        Top = 0
        Width = 638
        Height = 195
        Align = alTop
        Color = clBtnFace
        ParentColor = False
        TabOrder = 2
      end
    end
    object tabCompPhotos: TRzTabSheet
      Caption = 'Comparable Photos'
      object Statusbar2: TStatusBar
        Left = 0
        Top = 517
        Width = 638
        Height = 19
        Panels = <
          item
            Width = 250
          end
          item
            Width = 200
          end
          item
            Width = 50
          end>
      end
      object ScrollBox2: TScrollBox
        Left = 0
        Top = 0
        Width = 638
        Height = 517
        VertScrollBar.Tracking = True
        Align = alClient
        TabOrder = 1
        object CompBasePanel: TPanel
          Left = 0
          Top = 0
          Width = 634
          Height = 513
          TabOrder = 0
          object PhotoDisplayComps: TScrollBox
            Left = 1
            Top = 1
            Width = 632
            Height = 511
            VertScrollBar.Tracking = True
            Align = alClient
            TabOrder = 0
          end
        end
      end
    end
    object tabSketch: TRzTabSheet
      Caption = 'Sketch'
      object ScrollBox1: TScrollBox
        Left = 0
        Top = 0
        Width = 634
        Height = 536
        Align = alClient
        TabOrder = 0
        object BasePanel: TPanel
          Left = 0
          Top = 0
          Width = 630
          Height = 532
          TabOrder = 0
        end
      end
    end
    object TabJson: TRzTabSheet
      Caption = 'Inspection Data'
      object panel123: TPanel
        Left = 0
        Top = 0
        Width = 638
        Height = 41
        Align = alTop
        TabOrder = 0
        object lblInsp_ID: TLabel
          Left = 240
          Top = 16
          Width = 6
          Height = 13
          Caption = '0'
          Visible = False
        end
        object btnPrint: TButton
          Left = 33
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Print'
          TabOrder = 0
          OnClick = btnPrintClick
        end
      end
      object JsonTree: TTreeView
        Left = 0
        Top = 41
        Width = 257
        Height = 495
        Align = alLeft
        Indent = 19
        TabOrder = 1
        Visible = False
      end
      object JsonMemo: TMemo
        Left = 257
        Top = 41
        Width = 381
        Height = 495
        Align = alClient
        Lines.Strings = (
          '')
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 2
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 918
    Height = 57
    Align = alTop
    TabOrder = 1
    DesignSize = (
      918
      57)
    object Label1: TLabel
      Left = 56
      Top = 21
      Width = 118
      Height = 13
      Caption = 'Inspection Property For : '
    end
    object lblSubjectAddr: TLabel
      Left = 184
      Top = 21
      Width = 53
      Height = 16
      Caption = 'Subject'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnTransfer: TButton
      Left = 614
      Top = 13
      Width = 120
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Transfer To Report'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ModalResult = 1
      ParentFont = False
      TabOrder = 0
      OnClick = btnTransferClick
    end
    object btnClose2: TButton
      Left = 794
      Top = 13
      Width = 84
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Close'
      ModalResult = 2
      TabOrder = 1
      OnClick = btnClose2Click
    end
    object chkSaveWorkFile: TCheckBox
      Left = 480
      Top = 20
      Width = 113
      Height = 17
      Caption = 'Save To Work File'
      TabOrder = 2
    end
  end
  object PageControl1: TRzPageControl
    Left = 642
    Top = 57
    Width = 276
    Height = 566
    ActivePage = taPhotos
    Align = alRight
    TabIndex = 0
    TabOrder = 2
    FixedDimension = 17
    object taPhotos: TRzTabSheet
      object PhotoFormOptionPanel: TPanel
        Left = 0
        Top = 0
        Width = 272
        Height = 545
        Align = alClient
        TabOrder = 0
        object rdoMainSubject: TRadioGroup
          Left = 17
          Top = 33
          Width = 252
          Height = 112
          Caption = 'Main Subject Photos'
          ItemIndex = 0
          Items.Strings = (
            '3x5 3 Photos'
            '3x5 3 Photos Comments')
          TabOrder = 0
        end
        object rdoExtraSubject: TRadioGroup
          Left = 18
          Top = 177
          Width = 252
          Height = 144
          Caption = 'Extra Subject Photos'
          ItemIndex = 0
          Items.Strings = (
            '3x5 3 Photos'
            '3x5 6 Photos'
            '3x5 12 Photos'
            '3x5 15 Photos')
          TabOrder = 1
        end
        object rdoMainComp: TRadioGroup
          Left = 18
          Top = 361
          Width = 252
          Height = 112
          Caption = 'Main Sales/Listing Photos'
          ItemIndex = 0
          Items.Strings = (
            '3x5 3 Photos'
            'Non Lender  3 Photos')
          TabOrder = 2
        end
      end
    end
    object taSketch: TRzTabSheet
      ImageIndex = 1
      object GLAGroup: TGroupBox
        Left = 0
        Top = 0
        Width = 272
        Height = 184
        Align = alTop
        Caption = 'Sketch Meta Data: GLA :'
        TabOrder = 0
        object GLA: TMemo
          Left = 2
          Top = 15
          Width = 268
          Height = 167
          Align = alClient
          ReadOnly = True
          TabOrder = 0
        end
      end
      object NonGLAGroup: TGroupBox
        Left = 0
        Top = 184
        Width = 272
        Height = 224
        Align = alTop
        Caption = 'Sketch Meta Data: Non GLA:'
        TabOrder = 1
        object NonGLA: TMemo
          Left = 2
          Top = 15
          Width = 268
          Height = 207
          Align = alClient
          ReadOnly = True
          TabOrder = 0
        end
      end
    end
    object taData: TRzTabSheet
      ImageIndex = 2
    end
  end
  object Printer: TPrintDialog
    Left = 200
    Top = 128
  end
end
