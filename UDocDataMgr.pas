unit UDocDataMgr;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted 2003-2011 by Bradford Technologies, Inc. }

{ This unit handles data associated with the container.    }
{ It basically is a manager of data objects that know how to  }
{ read and write themselves to the container file. One object }
{ is the sketcher data file, which is saved in the report and }
{ passed to the sketcher when invoked.                        }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


interface

uses
  Classes, Contnrs, SysUtils;


const
  ddSketchData        = 'SKETCH';
  ddMSEstimateData    = 'MS_ESTIMATEID';
  ddAWMSEstimateData  = 'AWMS_ESTIMATEID';
  ddCRMMSEstimateData = 'CRMMS_ESTIMATEID';
  ddAWAppraisalOrder  = 'AppraisalOrder';    //Historical: AppraisalExpress orders from AppraisalWorld
  ddRELSOrderInfo     = 'AMC_RELS_ORDER';
  ddRELSOrderInfoEZQ  = 'EZQ_RELS_ORDER';    // ProQuality by Jeferson 09.17.09 to add Rels order constant
  ddRELSValidationUserComment    = 'RELS_Report_Validation_UserComment'; // ProQuality RELS_COMMENTARY_ADDENDUM XML data 
  ddAMCOrderInfo      = 'AMC_ORDER';
  ddAMCValidationUserComment    = 'AMC_Report_Validation_UserComment';
  ddUADEnabled        = 'UADEnabled';        //UAD Acitve indicator for Doc
  ddAMCReviewOverride = 'AMC_Review_Override';

type
  { Each individual piece of data is stored in a     }
  { TDocData object. This object knows how to handle }
  { its data and may be specialized for the data.    }

  TDocDataList = class;

  TDataItem = class(TMemoryStream)
  private
    FParent: TDocDataList;
    FKind: String;
  public
    constructor Create(AOwner: TDocDataList);
    procedure WriteToStream(Stream: TStream);
    procedure ReadFromStream(Stream: TStream);
    property Kind: String read FKind write FKind;
    property Parent: TDocDataList read FParent write FParent;
  end;


  { TDocDataList is a general list holder for storing }
  { and managing the data objects associated with the }
  { report file. It owns the data objects.            }

  TDocDataList = class(TObjectList)
    FDoc: TComponent;
    constructor Create(AOwner: TComponent);
    procedure LoadDataStream(const StrKind: String; Stream: TStream);
    procedure UpdateData(const dataKind: String; Stream: TStream);
    function HasData(const dataKind: String): Boolean;
    function FindData(const dataKind: String): TMemoryStream;
    procedure DeleteData(const dataKind: String);
    procedure WriteToStream(Stream: TStream);
    procedure ReadFromStream(Stream: TStream);
    property Owner: TComponent read FDoc write FDoc;
  end;

implementation

uses
  UContainer, UFileUtils, UStatus;


{ TDataItem }

constructor TDataItem.Create(AOwner: TDocDataList);
begin
  inherited Create;
  
  FParent := AOwner;
  FKind := '';
end;

procedure TDataItem.ReadFromStream(Stream: TStream);
var
  {someRefdata: LongInt; }
  dataLen: LongInt;
begin
  {someRefdata := }ReadLongFromStream(Stream);   //read the ref (zero for now)
  FKind := ReadStringFromStream(Stream);       //read the kind
  dataLen := ReadLongFromStream(Stream);       //read data length

  CopyFrom(Stream, dataLen);                   //read the data
end;

procedure TDataItem.WriteToStream(Stream: TStream);
var
  someRefdata: LongInt;
begin
  someRefdata := 0;

  WriteLongToStream(someRefdata, Stream);       //write some cell & data assoc
  WriteStringToStream(FKind, Stream);           //write kind
  WriteLongToStream(Size, Stream);              //write size

  SaveToStream(Stream);                         //write data
end;



{ TDocDataList }

constructor TDocDataList.Create(AOwner: TComponent);
begin
  inherited Create;

  FDoc := AOwner;
  OwnsObjects := True;
end;

//makes a copy of the data and puts it into a DataItem and in the data list
procedure TDocDataList.LoadDataStream(const StrKind: String; Stream: TStream);
var
  Item: TDataItem;
begin
  Item := TDataItem.Create(Self);
  try
    Item.Kind := strKind;
    Item.LoadFromStream(Stream);      //put the data into the item
    Add(Item);                        //add the item to the Data List
  except
    ShowNotice('There is a problem loading the '+ StrKind + ' data.');
  end;
end;

procedure TDocDataList.DeleteData(const dataKind: String);
var
  Item: TDataItem;
begin
  Item := TDataItem(FindData(dataKind));
  if assigned(Item) then              //we have this item
    Remove(Item)                      //so remove it
end;

procedure TDocDataList.UpdateData(const dataKind: String; Stream: TStream);
var
  Item: TDataItem;
begin
  Item := TDataItem(FindData(dataKind));
  if Item <> nil then                   //we have prev item
    if Stream = nil then                //but update data is nil, means kill prev data
      Remove(Item)                      //so remove old guy
    else
      Item.LoadFromStream(Stream)       //have new data, load it

  else if Stream <> nil then            //no prev data item
    LoadDataStream(dataKind, Stream);   //create a new one, load the data into it
end;

function TDocDataList.FindData(const dataKind: String): TMemoryStream;
var
  i: integer;
begin
  result := nil;
  i := 0;
  if count > 0 then
    while (i < count) do
      if (CompareText(TDataItem(Items[i]).Kind, dataKind)= 0) then
        begin
          result := TDataItem(Items[i]);
          Result.Position := 0;                //      reset the position
          break;
        end
      else
        inc(i);
end;

function TDocDataList.HasData(const dataKind: String): Boolean;
var
  Item: TDataItem;
begin
  Item := TDataItem(FindData(dataKind));
  result := assigned(Item);      //we have this item
end;

procedure TDocDataList.WriteToStream(Stream: TStream);
var
  i: Integer;
begin
  WriteLongToStream(Count, Stream);     //Always write the number of data objects

  if Count > 0 then
    for i := 0 to Count-1 do
      begin
        WriteLongToStream(0, Stream);      //some kind of ref value to assoc cell & data
        TDataItem(Items[i]).WriteToStream(Stream);
      end;
end;

procedure TDocDataList.ReadFromStream(Stream: TStream);
var
  i: Integer;
  N: LongInt;
  Data: TDataItem;
begin
  N:= ReadLongFromStream(Stream);     //Always read the number of data objects

  if N > 0 then
    for i := 0 to N-1 do
      begin
        ReadLongFromStream(Stream);             //not used yet

        Data := TDataItem.Create(Self);          //create data item
        try
          Data.ReadFromStream(Stream);           //it reads its stuff
        finally
          Add(Data);                             //add it to the mgr
        end;
      end;
end;

end.
