object DebugFormSpecs: TDebugFormSpecs
  Left = 331
  Top = 156
  Width = 486
  Height = 246
  Caption = 'Print Form Specifications'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 392
    Top = 16
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 392
    Top = 56
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object cbxOptCellID: TCheckBox
    Left = 184
    Top = 112
    Width = 97
    Height = 17
    Caption = 'Print Cell IDs'
    Checked = True
    State = cbChecked
    TabOrder = 2
  end
  object cbxOptContextID: TCheckBox
    Left = 312
    Top = 112
    Width = 97
    Height = 17
    Caption = 'Print Context IDs'
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
  object cbxOptMathID: TCheckBox
    Left = 184
    Top = 136
    Width = 97
    Height = 17
    Caption = 'Print Math IDs'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  object cbxOptLocContextID: TCheckBox
    Left = 312
    Top = 136
    Width = 137
    Height = 17
    Caption = 'Print Local Context IDs'
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
  object cbxOptRspID: TCheckBox
    Left = 184
    Top = 160
    Width = 113
    Height = 17
    Caption = 'Print Response IDs'
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  object cbxOptSampleData: TCheckBox
    Left = 312
    Top = 184
    Width = 129
    Height = 17
    Caption = 'Print Sample Data'
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
  object cbxOptFormInfo: TCheckBox
    Left = 16
    Top = 112
    Width = 129
    Height = 17
    Caption = 'Print Form Infomation'
    Checked = True
    State = cbChecked
    TabOrder = 9
  end
  object cbxOptCellSeqNum: TCheckBox
    Left = 16
    Top = 160
    Width = 113
    Height = 17
    Caption = 'Print Cell Seq IDs'
    Checked = True
    State = cbChecked
    TabOrder = 10
  end
  object cbxPrintFirstForm: TRadioButton
    Left = 16
    Top = 16
    Width = 345
    Height = 17
    Caption = 
      'Print the Form Specs for only the FIRST form in the active Conta' +
      'iner'
    TabOrder = 11
    OnClick = cbxPrintFirstFormClick
  end
  object cbxPrintContainerForms: TRadioButton
    Left = 16
    Top = 56
    Width = 329
    Height = 17
    Caption = 'Print the Form Specs for ALL forms in the active Container'
    TabOrder = 12
    OnClick = cbxPrintContainerFormsClick
  end
  object cbxOptPageIdentifier: TCheckBox
    Left = 16
    Top = 136
    Width = 129
    Height = 17
    Caption = 'Print Page Identifier'
    Checked = True
    State = cbChecked
    TabOrder = 13
  end
  object cbxSetPage: TCheckBox
    Left = 48
    Top = 35
    Width = 169
    Height = 17
    Caption = 'Print only this page in the form:'
    TabOrder = 14
  end
  object cbxPrintAllForms: TRadioButton
    Left = 16
    Top = 80
    Width = 297
    Height = 17
    Caption = 'Print the Form Specs for ALL forms in the Forms Library'
    Enabled = False
    TabOrder = 15
    Visible = False
  end
  object medtPageNo: TMaskEdit
    Left = 216
    Top = 32
    Width = 40
    Height = 21
    EditMask = '99;1;_'
    MaxLength = 2
    TabOrder = 16
    Text = '  '
  end
  object cbxOptXmlID: TCheckBox
    Left = 312
    Top = 160
    Width = 129
    Height = 17
    Caption = 'Print XML IDs'
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
end
