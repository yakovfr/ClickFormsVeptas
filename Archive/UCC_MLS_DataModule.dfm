object MLSDataModule: TMLSDataModule
  OldCreateOrder = False
  Left = 874
  Top = 224
  Height = 297
  Width = 453
  object DS_MLS_Board: TDataSource
    DataSet = CDS_MLS_Board
    Left = 32
    Top = 16
  end
  object CDS_MLS_Board: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 148
    Top = 16
    Data = {
      5D0000009619E0BD0100000018000000030000000000030000005D0002496404
      00010000000000094D4C535F426F617264010049000000010005574944544802
      0002003C00055374617465010049000000010005574944544802000200280000
      00}
    object CDS_MLS_BoardId: TIntegerField
      FieldName = 'Id'
    end
    object CDS_MLS_BoardMLS_Board: TStringField
      FieldName = 'MLS_Board'
      Size = 60
    end
    object CDS_MLS_BoardState: TStringField
      FieldName = 'State'
      Size = 40
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 32
    Top = 76
  end
  object XMLDocument1: TXMLDocument
    Left = 36
    Top = 136
    DOMVendorDesc = 'MSXML'
  end
  object CDS_Generic_StatusCode: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 16
    Data = {
      590000009619E0BD01000000180000000200000000000300000059000A537461
      747573547970650100490000000100055749445448020002003C000B53746174
      757341626272760100490000000100055749445448020002003C000000}
    object CDS_Generic_StatusCodeStatusType: TStringField
      FieldName = 'StatusType'
      Size = 60
    end
    object CDS_GenericStatusCode: TStringField
      FieldName = 'StatusAbbrv'
      Size = 60
    end
  end
  object CDS_UniqueStatusCode: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 72
    Data = {
      590000009619E0BD01000000180000000200000000000300000059000A537461
      747573547970650100490000000100055749445448020002003C000B53746174
      757341626272760100490000000100055749445448020002003C000000}
    object CDS_UniqueStatusCodeStatusType: TStringField
      FieldName = 'StatusType'
      Size = 60
    end
    object CDS_UniqueStatusCodeStatusAbbrv: TStringField
      FieldName = 'StatusAbbrv'
      Size = 60
    end
  end
  object ClientDataSet1: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 152
    Top = 80
    Data = {
      7C0000009619E0BD0100000018000000040000000000030000007C0009576F72
      644465736372010049000000010005574944544802000200640009576F726456
      616C75650100490000000100055749445448020002000A000A576F7264547970
      65496404000100000000000A576F72644C697374496404000100000000000000}
    object ClientDataSet1WordDescr: TStringField
      FieldName = 'WordDescr'
      Size = 100
    end
    object ClientDataSet1WordValue: TStringField
      FieldName = 'WordValue'
      Size = 10
    end
    object ClientDataSet1WordTypeId: TIntegerField
      FieldName = 'WordTypeId'
    end
    object ClientDataSet1WordListId: TIntegerField
      FieldName = 'WordListId'
    end
  end
  object CL_PropList: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 256
    Top = 144
  end
  object XMLPropList: TXMLDocument
    Active = True
    Left = 352
    Top = 144
    DOMVendorDesc = 'MSXML'
  end
end
