object ConvertDM: TConvertDM
  OldCreateOrder = False
  Left = 504
  Top = 171
  Height = 245
  Width = 265
  object SrcConnection: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\ClickForms6\Data' +
      'bases\Reports.mdb;Persist Security Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 56
    Top = 16
  end
  object DestConnection: TADOConnection
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 168
    Top = 16
  end
  object SrcDataSet: TADODataSet
    Connection = SrcConnection
    CommandText = 'Reports'
    CommandType = cmdTable
    Parameters = <>
    Left = 56
    Top = 72
  end
  object DestDataSet: TADODataSet
    Connection = DestConnection
    CommandType = cmdTable
    Parameters = <>
    Left = 168
    Top = 72
  end
  object SrcPhotodataSet: TADODataSet
    Connection = SrcConnection
    Parameters = <>
    Left = 56
    Top = 152
  end
  object DestPhotoDataSet: TADODataSet
    Connection = DestConnection
    Parameters = <>
    Left = 176
    Top = 152
  end
end
