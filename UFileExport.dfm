object DataExport: TDataExport
  Left = 520
  Top = 206
  Width = 724
  Height = 342
  Caption = 'Export Information'
  Color = clBtnFace
  Constraints.MinHeight = 302
  Constraints.MinWidth = 516
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 144
  TextHeight = 20
  object StatusBar1: TStatusBar
    Left = 0
    Top = 271
    Width = 708
    Height = 19
    Panels = <>
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 708
    Height = 271
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    TabWidth = 75
    object TabSheet1: TTabSheet
      Caption = 'Export'
      object Label1: TLabel
        Left = 14
        Top = 25
        Width = 246
        Height = 20
        Caption = 'Select the Export Specification File'
      end
      object Label2: TLabel
        Left = 328
        Top = 25
        Width = 206
        Height = 20
        Caption = 'Select the Export File Format'
      end
      object btnExport: TButton
        Left = 569
        Top = 58
        Width = 116
        Height = 37
        Caption = 'Export'
        TabOrder = 0
        OnClick = btnExportClick
      end
      object btnCancel1: TButton
        Left = 569
        Top = 131
        Width = 116
        Height = 38
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 1
      end
      object cmbxMaps: TComboBox
        Left = 14
        Top = 62
        Width = 260
        Height = 28
        ItemHeight = 20
        TabOrder = 2
        OnChange = cmbxMapsChange
      end
      object cmbxFormats: TComboBox
        Left = 328
        Top = 62
        Width = 223
        Height = 28
        ItemHeight = 20
        TabOrder = 3
        Text = 'cmbxFormats'
      end
    end
  end
  object ExportSaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Save Export File As'
    Left = 228
    Top = 112
  end
end
