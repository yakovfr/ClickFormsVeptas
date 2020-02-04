unit UCC_MLS_DBRead;

{  MLS Mapping Module     }
{  Bradford Technologies, Inc. }
{  All Rights Reserved         }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc. }

{ Unit responsable to call the web-service and get MLS data }
{ get - XML Map }
{ get - all mls bord name and id }
{ get - all wordlist that belong to the mls of chose }
{ Create and format all the virtual grids }

interface


  function  MLS_WebServiceMap(userID,userCoKey, orderKey : String; SecToken : WideString; MLS_ID : Integer): Boolean;
  function  MLS_WebServiceList(userID,userCoKey, orderKey : String; SecToken : WideString): Boolean;
  function MLS_WebServiceEnhancement(userID,userCoKey,orderKey : String; SecToken : WideString; MLS_ID : Integer; var MLSResponseData:WideString) : String;
  function  MLS_WebServiceAvailable(userID:Integer): Boolean;

implementation

Uses
  SysUtils, Windows, Graphics, IniFiles, StdCtrls, StrUtils, Classes,
  Grids_ts, TSGrid, ActiveX, Controls,
  AWSI_Server_Access, AWSI_Server_MLS, {UCC_Appraisal,} UBase64,
  UCC_Globals, UCC_MLS_Globals, UCC_MLS_DataModule, UWebConfig, UCC_MLS_ImportData,
  XMLDoc, XMLIntf, UGlobals, UWindowsInfo, uStatus;

//var
//  secToken : WideString;

function MLS_WebServiceAvailable(userID:Integer) : Boolean;
var
  UsageCredent        : clsUsageAccessCredentials;
  response            : clsGetUsageAvailabilityResponse;
  i                   : integer;
begin
  result := False;
  try
    try
      UsageCredent := clsUsageAccessCredentials.Create;
      UsageCredent.CustomerId := userID;
      UsageCredent.ServiceId  := 'SLZXU348SJ42VXBF2DAVULCT9HH7M8FMM76VYV7EWYP5VFZSZG6NRAKZYTVZ256SPDG8NGR2X8KQCJR4RCG7Q4PVLCL6MP2B';
      with GetMlsServerPortType(True,awsiMLSServer,nil ) do
        begin
          response := MlsService_GetUsageAvailability(UsageCredent);
          if response.Results.Code = 0 then
            begin
              result := True;
            end
          else
            ShowAlert(atWarnAlert, response.Results.Description);
        end;
    finally
      UsageCredent.Free;
    end;
  except

  end;
end;


function MLS_WebServiceList(userID,userCoKey,orderKey : String; SecToken : WideString) : Boolean;
var
  servCredent         : clsUserCredentials;
  response            : clsGetMlsListResponse;
  MLSList             : clsMlsBoardList;
  GenericList         : clsGenericStatusCodeList;
  i                   : integer;
begin
  result := False;
  try
    try
      servCredent                := clsUserCredentials.Create;
      servCredent.Username       := userID;
      servCredent.Password       := SecToken;
      servCredent.CompanyKey     := userCoKey;
      servCredent.OrderNumberKey := orderKey;
      servCredent.Purchase       := 1;
      with GetMlsServerPortType(True,awsiMLSServer,nil ) do
        begin
          response := MlsService_GetMlsList(servCredent);
          if response.Results.Code = 0 then
            begin
              result := True;
              {Get Genereric list to translate STATUS fot 1004mc }
              GenericList := response.ResponseData.GenericStatusCodes;
              for I := 0 to high(GenericList)- 1 do
                begin
                  MLSDataModule.CDS_Generic_StatusCode.Append;
                  MLSDataModule.CDS_Generic_StatusCode.FieldByName('StatusType').AsString := GenericList[i].StatusType;
                  MLSDataModule.CDS_Generic_StatusCode.FieldByName('StatusAbbrv').AsString := GenericList[i].StatusAbbreviation;
                  MLSDataModule.CDS_Generic_StatusCode.Post;
                end;
              {Get all MLS Name }
              MLSList:=  response.ResponseData.MlsBoards;
              for I := 0 to high(MLSList)-1 do
                begin
                  MLSDataModule.CDS_MLS_Board.Append;
                  MLSDataModule.CDS_MLS_Board.FieldByName('id').AsInteger          := MLSList[i].MlsId;
                  MLSDataModule.CDS_MLS_Board.FieldByName('MLS_Board').AsString    := MLSList[i].MlsName;
                  MLSDataModule.CDS_MLS_Board.FieldByName('State').AsString        := MLSList[i].MlsState;
                  MLSDataModule.CDS_MLS_Board.Post;
                end;
            end
          else
            ShowAlert(atWarnAlert, response.Results.Description);
        end;
    finally
      servCredent.Free;
    end;
  except

  end;
end;
/// Function responsible for get : Master Exported Fields,MLS Map and Wordlist
function MLS_WebServiceMap(userID,userCoKey,orderKey : String; SecToken : WideString; MLS_ID : Integer) : Boolean;
var
  servCredent         : clsUserCredentials;
  MLSresponse         : clsGetMlsResponse;
  MLS_Detail          : clsGetMlsDetails;
  Acknowledgement     : clsAcknowledgement;
  Wordlist            : clsMlsFieldList;
  i,x                 : integer;
  uniqueStatusAbbrv   : clsMlsStatusCodeList;
  testString          : TStringList; // test debug only
  testStr             : String;      // test debug only
begin
  // Assuming the Map is not Ready or do not exist
  result := False;
  // Get MLS Map and WordList of DataBase
  try
    // Create Credential Object
    servCredent                := clsUserCredentials.Create;
    // Load Credential data
    servCredent.Username       := userID;
    servCredent.Password       := SecToken;
    servCredent.CompanyKey     := userCoKey;
    servCredent.OrderNumberKey := orderKey;
    servCredent.Purchase       := 1;
    // Create MLS Detail Object to pass MLS ID to the web service
    MLS_Detail := clsGetMlsDetails.Create;
    // MLS chose by the Appraisal
    MLS_Detail.MlsId := MLS_ID;
    // Call Web Service
    with GetMlsServerPortType(True,awsiMLSServer,nil ) do
      begin
        MLSresponse := MlsService_GetMls(servCredent,MLS_Detail);
      end;
    // If Success = 0
    if MLSresponse.Results.Code = 0  then
      begin
        //MLSresponse.ResponseData.
        result := True;
        CC_MLSImport.serviceresponse := MLSresponse.Results.Description;
        // Now send back the Sucessful transaction to Bob
        // Create Object
        Acknowledgement :=  clsAcknowledgement.Create;
        // Load Object with Sucessfull code get from mls service
        Acknowledgement.Received := 1;
        Acknowledgement.ServiceAcknowledgement := MLSresponse.ResponseData.ServiceAcknowledgement;

        // Send Acknowledgement Back
        with GetMlsServerPortType(True,awsiMLSServer,nil ) do
             MlsService_Acknowledgement(servCredent,Acknowledgement);
          //Get the Unique Code Abreviation for 1004mc
          if (High(MLSresponse.ResponseData.MlsStatusAbbreviations) > 0) then
          begin
            uniqueStatusAbbrv := MLSresponse.ResponseData.MlsStatusAbbreviations;
            for x := 0 to High(uniqueStatusAbbrv) -1 do
              begin
                MLSDataModule.CDS_UniqueStatusCode.Append;
                MLSDataModule.CDS_UniqueStatusCode.FieldByName('StatusType').AsString := uniqueStatusAbbrv[x].StatusType;
                MLSDataModule.CDS_UniqueStatusCode.FieldByName('StatusAbbrv').AsString := uniqueStatusAbbrv[x].StatusAbbreviation;
                MLSDataModule.CDS_UniqueStatusCode.Post;
              end;
          end;
          // Getting the master_exported_fields data.
          CC_MLSImport.master_export_fields := MLSresponse.ResponseData.ExportFields;
          // Getting the XML Map load into the system
          MLSDataModule.XMLDocument1.loadfromxml(MLSResponse.ResponseData.XmlMap);
          MLSDataModule.XMLDocument1.XML;
          // Getting the Array of wordlist of Database
          Wordlist := MLSresponse.ResponseData.MlsWords;
          // Load Array data into a ClientDataSet memory Table
          testString := TStringList.Create;
          for I := 0 to high(Wordlist) do
            begin
              MLSDataModule.ClientDataSet1.Append;
              MLSDataModule.ClientDataSet1.FieldByName('WordDescr').AsString := Wordlist[i].WordDescr;
              MLSDataModule.ClientDataSet1.FieldByName('WordValue').AsString := Wordlist[i].WordValue;
              MLSDataModule.ClientDataSet1.FieldByName('WordTypeId').AsInteger := Wordlist[i].WordTypeId;
              MLSDataModule.ClientDataSet1.FieldByName('WordListId').AsInteger := Wordlist[i].WordListId;
              MLSDataModule.ClientDataSet1.Post;
              // this code below is used for debug only(TEST), look what webservice sent.
              testStr :=  Wordlist[i].WordDescr + 'id= '+ IntToStr(Wordlist[i].WordTypeId);
              testString.Add(testStr);
            end;
          Acknowledgement.Free;
      end
     else
       begin
         CC_MLSImport.serviceresponse := MLSresponse.Results.Description;
       end;
    // the line below is used for test debug only. To save the data into a file.
//    testString.SaveToFile('c:\temp\MLSImportData.txt');
  finally
    MLS_Detail.free;    // Now Web Service work Done! Free objects.
    servCredent.free;
    if assigned(testString) then
      testString.Free;
  end;
end;

function MLS_WebServiceEnhancement(userID,userCoKey,orderKey : String; SecToken : WideString; MLS_ID : Integer; var MLSResponseData:WideString) : String;
var
  credentials : clsMlsEnhancementCredentials;
  servCredent : clsUserCredentials;
  mlsdetails : clsGetMlsEnhancementDetails;
  mlsresponse : clsGetMlsEnhancementResponse;
  Acknowledgement : clsAcknowledgement;
  Buffer : TStringList;
  Xcolumn,LNode,XMetaData,XExtraField  : IXMLNode;
//  prop  : TProperty;
  i,x, Count : Integer;
  ExtraFields : String;
begin
 PushMouseCursor(crHourglass);
 try
  try
    // Credentials
    credentials := clsMlsEnhancementCredentials.Create;
    credentials.Username := userID;
    credentials.Password := SecToken;
    credentials.CompanyKey := userCoKey;
    credentials.OrderNumberKey := orderKey;
    credentials.Purchase := 1;
    credentials.ServiceId := 'SLZXU348SJ42VXBF2DAVULCT9HH7M8FMM76VYV7EWYP5VFZSZG6NRAKZYTVZ256SPDG8NGR2X8KQCJR4RCG7Q4PVLCL6MP2B';

    Buffer := TStringList.Create;
    Buffer.LoadFromFile(CC_MLSImport.cbxFiles.Text);

    // MLS Details - Buffer Data and MLS ID
    mlsdetails := clsGetMlsEnhancementDetails.Create;
    mlsdetails.MlsId := MLS_ID;
    mlsdetails.DataBuffer := Base64Encode(Buffer.Text);
    with GetMlsServerPortType(True,awsiMLSServer,nil ) do
      begin
        mlsresponse := MlsService_GetMlsEnhancement(credentials,mlsdetails);
      end;
    if mlsresponse.Results.Code = 0 then
      begin
       // Ok Successful call send Acknowledgement Back To Bob
       // Create Object
        Acknowledgement := clsAcknowledgement.Create;
        servCredent := clsUserCredentials.Create; //# Acknowledgement credentials
        try
          // get Acknowledgement key
          Acknowledgement.Received := 1;
          Acknowledgement.ServiceAcknowledgement := MLSresponse.ResponseData.ServiceAcknowledgement;
          // Load Credential data
          servCredent.Username       := userID;
          servCredent.Password       := SecToken;
          servCredent.CompanyKey     := userCoKey;
          servCredent.OrderNumberKey := orderKey;
          servCredent.Purchase       := 0;
          // Send Acknowledgement Back
          with GetMlsServerPortType(True,awsiMLSServer,nil ) do
             MlsService_Acknowledgement(servCredent,Acknowledgement);
        finally
          Acknowledgement.Free;
          servCredent.free;
        end;

        //mlsresponse.ResponseData.ServiceAcknowledgement
        if mlsresponse.ResponseData.DataBuffer = '#303' then
         begin
            result :=  'No data is coming back, the address was not found.';   //#if not data returned just exit here.
            exit;
         end;


        //### HANDLE Differently
        result := 'Success';
        MLSDataModule.XMLPropList.Active := True;

        MLSDataModule.XMLPropList.LoadFromXML(mlsresponse.ResponseData.DataBuffer);
        //You can export the new data as xml - Use ony for Debug
//        MLSDataModule.XMLPropList.SaveToFile('c:\temp\mlsdata.xml');

        CC_MLSImport.FMLSData := mlsresponse.ResponseData.DataBuffer;
      end

    else if MLSResponse.Results.Code = 2090100 then
      begin
        result := 'No Map'
      end

    else  //some other error
      begin
        result := MLSResponse.Results.Description;
      end;
  except    //we crashed
    on E : Exception do begin
     result := E.Message;
    end;
  end;
 finally
   PopMouseCursor;
   if assigned(Buffer) then
    Buffer.Free;
 end;
end;

end.

