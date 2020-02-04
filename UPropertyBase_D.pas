unit UPropertyBase;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted 2006-2011 by Bradford Technologies, Inc. }

{ This unit the base for the TProperty object. TProperty will hold all }
{ the descriptive data (factual and subjective) about the property.    }
{ Created: 11/21/11 - initial definition.}

interface

uses
  Windows, Classes, ExtCtrls, Contnrs;

type
  TPhoto = Class(TObject)
    FPic: TImage;
    FType: String;
    FCaption: String;
    FSource: String;
    FDate: String;
  end;

  TPhotoList = Class(TObjectList);

  TProperty = class(TObject)
    FAPN: String;
    FLatitude: String;
    FLongitude: String;
    FType: String;
    FCensusTract: String;
    FLegalDesc: String;
    FNeighbodhoodName: String;
    FSubdivisionName: String;
    FREO: Boolean;
    FShortSale: Boolean;
    FDistressed: Boolean;
    FStreetAddress: String;
    FStreetName: String;
    FUnitNo: String;
    FCity: String;
    State: String;
    Zip: String;
    County: String;
    MLSID: String;
    ListingStatus: String;
    ListingStatusDate: String;
    ListPriceOrig: Integer;
    ListDateOrig: String;
    ListPriceCur: Integer;
    ListDateCur: String;
    DOM: Integer;
    CDOM: Integer;
    ExpiredDate: String;
    WithdrawnDate: String;
    ContractDate: String;
    CloseDate: String;
    SalePrice: Integer;
    SaleDate: String;
    YearBuilt: Integer;
    YearRemodeled: Integer;
    YearUpdated: Integer;
    Design: String;
    Stories: String;
    SiteArea: Integer;
    SiteShape: String;
    SiteViews: String;
    SiteAmenities: String;
    GLA: Integer;
    RoomTotal: Integer;
    BedroomCount: Integer;
    BathroomTotal: Integer;
    BathroomFullCount: Integer;
    BathroomHalfCount: Integer;
    Bathroom1QtrCount: Integer;
    Bathroom3QtrCount: Integer;
    GarageCarCount: Integer;
    GarageDesc: String;
    CarportCarCount: Integer;
    CarportDesc: String;
    ParkingCount: Integer;
    ParkingDesc: String;
    BasementGLA: Integer;
    BasementFinPercent: Integer;
    BasementFinGLA: Integer;
    BasementBedRooms: Integer;
    BasementFullBaths: Integer;
    BasementHalfBaths: Integer;
    BasementRecRoom: Integer;
    BasementOtherRms: Integer;
    FireplacesCount: Integer;
    FireplaceDesc: String;
    HeatingDesc: String;
    CoolingDesc: String;
    FEMAFloodZone: String;
    FEMAMap: String;
    FEMAMapDate: String;
    InFloodArea: String;
    PoolCount: String;
    PoolDesc: String;
    SpaCount: String;
    SpaDesc: String;
    DeckArea: String;
    DeckDesc: String;
    PatioArea: String;
    PatioDesc: String;
    FTaxYr: String;
    FTaxAmt: String;
    FInHOA: Boolean;
    FHOAFee: Integer;
    FHOAFeeFreq: String; 
    FPropertyCondition: String;
    FPropertQuality: String;
    FPropertyOwner: String;
    FDataSource: String;
    FDataSecondSource: String;
    FSaleConcessions: String;
    FFinanceConessions: String;
    FConcessionAmt: Integer;
    FMLSComments: String;
    FPhotos: TPhotoList;
    FUserData: TStringList;
    procedure ReadFromStream(AStream: TStream);
    procedure WriteToStream(AStream: TStream);
    procedure ReadFromFile(AFile: String);
    procedure WriteToFile(AFile: String);
  end;

  TPropertyList = class(TObjectList)
    procedure ReadFromStream(AStream: TStream);
    procedure WriteToStream(AStream: TStream);
    procedure ReadFromFile(AFile: String);
    procedure WriteToFile(AFile: String);
  end;


implementation

{ TProperty }

procedure TProperty.ReadFromFile(AFile: String);
begin
//
end;

procedure TProperty.ReadFromStream(AStream: TStream);
begin
//
end;

procedure TProperty.WriteToFile(AFile: String);
begin
//
end;

procedure TProperty.WriteToStream(AStream: TStream);
begin
//
end;

{ TPropertyList }

procedure TPropertyList.ReadFromFile(AFile: String);
begin
//
end;

procedure TPropertyList.ReadFromStream(AStream: TStream);
begin
//
end;

procedure TPropertyList.WriteToFile(AFile: String);
begin
//
end;

procedure TPropertyList.WriteToStream(AStream: TStream);
begin
//
end;

end.
