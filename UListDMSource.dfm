object ListDMMgr: TListDMMgr
  OldCreateOrder = False
  Left = 620
  Top = 281
  Height = 261
  Width = 811
  object ClientSource: TDataSource
    DataSet = ClientData
    Left = 32
    Top = 124
  end
  object ClientData: TADODataSet
    Connection = ClientConnect
    CursorType = ctStatic
    CommandText = 'Client'
    CommandType = cmdTableDirect
    Parameters = <>
    Left = 32
    Top = 68
  end
  object ClientConnect: TADOConnection
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 32
    Top = 12
  end
  object CompQuery: TADOQuery
    Connection = CompConnect
    CursorType = ctStatic
    OnFilterRecord = CompQueryFilterRecord
    OnRecordChangeComplete = CompQueryRecordChangeComplete
    Parameters = <>
    SQL.Strings = (
      'Select * from Comps')
    Left = 437
    Top = 69
  end
  object CompDataSource: TDataSource
    DataSet = CompClientDataSet
    Left = 554
    Top = 124
  end
  object ReportConnect: TADOConnection
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 152
    Top = 12
  end
  object ReportDataSource: TDataSource
    DataSet = ReportData
    Left = 152
    Top = 124
  end
  object ReportData: TADODataSet
    Connection = ReportConnect
    CursorType = ctStatic
    CommandText = 'Reports'
    CommandType = cmdTableDirect
    Parameters = <
      item
        Size = -1
        Value = Null
      end>
    Left = 120
    Top = 68
  end
  object CompPhotoQuery: TADOQuery
    Connection = CompConnect
    Parameters = <>
    Left = 511
    Top = 69
  end
  object CompCFNQuery: TADOQuery
    Connection = CompConnect
    Parameters = <>
    Left = 595
    Top = 69
  end
  object ReportQuery: TADOQuery
    Connection = ReportConnect
    Parameters = <>
    Left = 184
    Top = 68
  end
  object CompTempQuery: TADOQuery
    Connection = CompConnect
    DataSource = CompDataSource
    Parameters = <>
    Left = 680
    Top = 69
  end
  object NeighborConnect: TADOConnection
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 309
    Top = 13
  end
  object NeighborData: TADODataSet
    Connection = NeighborConnect
    CursorLocation = clUseServer
    CommandText = 'Neighborhoods'
    CommandType = cmdTableDirect
    Parameters = <>
    Left = 272
    Top = 69
  end
  object NeighborSource: TDataSource
    DataSet = NeighborData
    Left = 309
    Top = 124
  end
  object NeighborQuery: TADOQuery
    Connection = NeighborConnect
    Parameters = <>
    Left = 344
    Top = 69
  end
  object CompDataSetProvider: TDataSetProvider
    DataSet = CompQuery
    Left = 444
    Top = 132
  end
  object CompClientDataSet: TClientDataSet
    Aggregates = <>
    AutoCalcFields = False
    Filtered = True
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    ProviderName = 'CompDataSetProvider'
    StoreDefs = True
    OnCalcFields = CompClientDataSetCalcFields
    OnFilterRecord = CompClientDataSetFilterRecord
    Left = 660
    Top = 132
    object CompClientDataSetRowNo: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'RowNo'
      Calculated = True
    end
    object CompClientDataSetCompsID: TAutoIncField
      FieldName = 'CompsID'
      ReadOnly = True
    end
    object CompClientDataSetReportType: TWideStringField
      FieldName = 'ReportType'
      Size = 30
    end
    object CompClientDataSetCreateDate: TDateTimeField
      FieldName = 'CreateDate'
    end
    object CompClientDataSetModifiedDate: TDateTimeField
      FieldName = 'ModifiedDate'
    end
    object CompClientDataSetUnitNo: TWideStringField
      FieldName = 'UnitNo'
      Size = 10
    end
    object CompClientDataSetStreetNumber: TWideStringField
      FieldName = 'StreetNumber'
      Size = 10
    end
    object CompClientDataSetStreetName: TWideStringField
      FieldName = 'StreetName'
      Size = 50
    end
    object CompClientDataSetCity: TWideStringField
      FieldName = 'City'
      Size = 30
    end
    object CompClientDataSetState: TWideStringField
      FieldName = 'State'
      Size = 30
    end
    object CompClientDataSetZip: TWideStringField
      FieldName = 'Zip'
      Size = 13
    end
    object CompClientDataSetCounty: TWideStringField
      FieldName = 'County'
      Size = 40
    end
    object CompClientDataSetProjectName: TWideStringField
      FieldName = 'ProjectName'
      Size = 30
    end
    object CompClientDataSetProjectSizeType: TWideStringField
      FieldName = 'ProjectSizeType'
      Size = 30
    end
    object CompClientDataSetFloorLocation: TWideStringField
      FieldName = 'FloorLocation'
    end
    object CompClientDataSetMapRef1: TWideStringField
      FieldName = 'MapRef1'
      Size = 30
    end
    object CompClientDataSetMapRef2: TWideStringField
      FieldName = 'MapRef2'
      Size = 30
    end
    object CompClientDataSetCensus: TWideStringField
      FieldName = 'Census'
      Size = 30
    end
    object CompClientDataSetLongitude: TWideStringField
      FieldName = 'Longitude'
      Size = 30
    end
    object CompClientDataSetLatitude: TWideStringField
      FieldName = 'Latitude'
      Size = 30
    end
    object CompClientDataSetSalesPrice: TIntegerField
      FieldName = 'SalesPrice'
    end
    object CompClientDataSetSalesDate: TDateTimeField
      FieldName = 'SalesDate'
    end
    object CompClientDataSetDataSource: TWideStringField
      FieldName = 'DataSource'
      Size = 30
    end
    object CompClientDataSetPrevSalePrice: TWideStringField
      FieldName = 'PrevSalePrice'
      Size = 50
    end
    object CompClientDataSetPrevSaleDate: TWideStringField
      FieldName = 'PrevSaleDate'
      Size = 50
    end
    object CompClientDataSetPrevDataSource: TWideStringField
      FieldName = 'PrevDataSource'
      Size = 30
    end
    object CompClientDataSetPrev2SalePrice: TWideStringField
      FieldName = 'Prev2SalePrice'
      Size = 50
    end
    object CompClientDataSetPrev2SaleDate: TWideStringField
      FieldName = 'Prev2SaleDate'
      Size = 50
    end
    object CompClientDataSetPrev2DataSource: TWideStringField
      FieldName = 'Prev2DataSource'
      Size = 30
    end
    object CompClientDataSetVerificationSource: TWideStringField
      FieldName = 'VerificationSource'
      Size = 30
    end
    object CompClientDataSetPricePerGrossLivArea: TWideStringField
      FieldName = 'PricePerGrossLivArea'
      Size = 10
    end
    object CompClientDataSetPricePerUnit: TWideStringField
      FieldName = 'PricePerUnit'
      Size = 10
    end
    object CompClientDataSetFinancingConcessions: TWideStringField
      FieldName = 'FinancingConcessions'
      Size = 30
    end
    object CompClientDataSetSalesConcessions: TWideStringField
      FieldName = 'SalesConcessions'
      Size = 30
    end
    object CompClientDataSetHOA_MoAssesment: TWideStringField
      FieldName = 'HOA_MoAssesment'
      Size = 30
    end
    object CompClientDataSetCommonElement1: TWideStringField
      FieldName = 'CommonElement1'
      Size = 30
    end
    object CompClientDataSetCommonElement2: TWideStringField
      FieldName = 'CommonElement2'
      Size = 30
    end
    object CompClientDataSetFurnishings: TWideStringField
      FieldName = 'Furnishings'
      Size = 30
    end
    object CompClientDataSetDaysOnMarket: TWideStringField
      FieldName = 'DaysOnMarket'
      Size = 10
    end
    object CompClientDataSetFinalListPrice: TWideStringField
      FieldName = 'FinalListPrice'
      Size = 15
    end
    object CompClientDataSetSalesListRatio: TWideStringField
      FieldName = 'SalesListRatio'
      Size = 10
    end
    object CompClientDataSetMarketChange: TWideStringField
      FieldName = 'MarketChange'
      Size = 30
    end
    object CompClientDataSetMH_Make: TWideStringField
      FieldName = 'MH_Make'
      Size = 30
    end
    object CompClientDataSetMH_TipOut: TWideStringField
      FieldName = 'MH_TipOut'
      Size = 30
    end
    object CompClientDataSetLocation: TWideStringField
      FieldName = 'Location'
      Size = 30
    end
    object CompClientDataSetLeaseFeeSimple: TWideStringField
      FieldName = 'LeaseFeeSimple'
      Size = 30
    end
    object CompClientDataSetSiteArea: TWideStringField
      FieldName = 'SiteArea'
      Size = 30
    end
    object CompClientDataSetView: TWideStringField
      FieldName = 'View'
      Size = 30
    end
    object CompClientDataSetDesignAppeal: TWideStringField
      FieldName = 'DesignAppeal'
      Size = 30
    end
    object CompClientDataSetInteriorAppealDecor: TWideStringField
      FieldName = 'InteriorAppealDecor'
      Size = 30
    end
    object CompClientDataSetNeighbdAppeal: TWideStringField
      FieldName = 'NeighbdAppeal'
      Size = 30
    end
    object CompClientDataSetQualityConstruction: TWideStringField
      FieldName = 'QualityConstruction'
      Size = 30
    end
    object CompClientDataSetAge: TIntegerField
      FieldName = 'Age'
    end
    object CompClientDataSetCondition: TWideStringField
      FieldName = 'Condition'
      Size = 30
    end
    object CompClientDataSetGrossLivArea: TIntegerField
      FieldName = 'GrossLivArea'
    end
    object CompClientDataSetTotalRooms: TIntegerField
      FieldName = 'TotalRooms'
    end
    object CompClientDataSetBedRooms: TIntegerField
      FieldName = 'BedRooms'
    end
    object CompClientDataSetBathRooms: TFloatField
      FieldName = 'BathRooms'
    end
    object CompClientDataSetUnits: TWideStringField
      FieldName = 'Units'
      Size = 10
    end
    object CompClientDataSetBasementFinished: TWideStringField
      FieldName = 'BasementFinished'
      Size = 30
    end
    object CompClientDataSetRoomsBelowGrade: TWideStringField
      FieldName = 'RoomsBelowGrade'
      Size = 30
    end
    object CompClientDataSetFunctionalUtility: TWideStringField
      FieldName = 'FunctionalUtility'
      Size = 30
    end
    object CompClientDataSetHeatingCooling: TWideStringField
      FieldName = 'HeatingCooling'
      Size = 30
    end
    object CompClientDataSetEnergyEfficientItems: TWideStringField
      FieldName = 'EnergyEfficientItems'
      Size = 30
    end
    object CompClientDataSetGarageCarport: TWideStringField
      FieldName = 'GarageCarport'
      Size = 30
    end
    object CompClientDataSetFencesPoolsEtc: TWideStringField
      FieldName = 'FencesPoolsEtc'
      Size = 30
    end
    object CompClientDataSetFireplaces: TWideStringField
      FieldName = 'Fireplaces'
      Size = 30
    end
    object CompClientDataSetPorchesPatioEtc: TWideStringField
      FieldName = 'PorchesPatioEtc'
      Size = 30
    end
    object CompClientDataSetSignificantFeatures: TWideStringField
      FieldName = 'SignificantFeatures'
      Size = 30
    end
    object CompClientDataSetOtherItem1: TWideStringField
      FieldName = 'OtherItem1'
      Size = 30
    end
    object CompClientDataSetOtherItem2: TWideStringField
      FieldName = 'OtherItem2'
      Size = 30
    end
    object CompClientDataSetOtherItem3: TWideStringField
      FieldName = 'OtherItem3'
      Size = 30
    end
    object CompClientDataSetOtherItem4: TWideStringField
      FieldName = 'OtherItem4'
      Size = 30
    end
    object CompClientDataSetComment: TWideStringField
      FieldName = 'Comment'
      Size = 255
    end
    object CompClientDataSetUserValue1: TWideStringField
      FieldName = 'UserValue1'
      Size = 50
    end
    object CompClientDataSetUserValue2: TWideStringField
      FieldName = 'UserValue2'
      Size = 50
    end
    object CompClientDataSetUserValue3: TWideStringField
      FieldName = 'UserValue3'
      Size = 50
    end
    object CompClientDataSetAdditions: TWideStringField
      FieldName = 'Additions'
      Size = 30
    end
    object CompClientDataSetNoStories: TWideStringField
      FieldName = 'NoStories'
      Size = 10
    end
    object CompClientDataSetParcelNo: TWideStringField
      FieldName = 'ParcelNo'
      Size = 30
    end
    object CompClientDataSetYearBuilt: TWideStringField
      FieldName = 'YearBuilt'
    end
    object CompClientDataSetLegalDescription: TWideStringField
      FieldName = 'LegalDescription'
      Size = 127
    end
    object CompClientDataSetSiteValue: TWideStringField
      FieldName = 'SiteValue'
      Size = 30
    end
    object CompClientDataSetSiteAppeal: TWideStringField
      FieldName = 'SiteAppeal'
      Size = 30
    end
  end
  object CompConnect: TADOConnection
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 554
    Top = 12
  end
  object AMCConnect: TADOConnection
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 114
    Top = 14
  end
  object AMCData: TADODataSet
    Connection = AMCConnect
    CursorType = ctStatic
    CommandText = 'AMC'
    CommandType = cmdTableDirect
    DataSource = ReportDataSource
    Parameters = <>
    Left = 220
    Top = 130
  end
  object AMCSource: TDataSource
    DataSet = AMCData
    Left = 88
    Top = 168
  end
  object AMCQuery: TADOQuery
    Connection = AMCConnect
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select * from AMC')
    Left = 220
    Top = 24
  end
  object ClientQuery: TADOQuery
    Connection = ClientConnect
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      '')
    Left = 28
    Top = 196
  end
end
