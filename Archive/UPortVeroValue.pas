unit UPortVeroValue;

 {  ClickForms Application                }
 {  Bradford Technologies, Inc.           }
 {  All Rights Reserved                   }
 {  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, contnrs, ComCtrls, ExtCtrls,
  StdCtrls, Rio, SOAPHTTPClient, xmldom, XMLIntf, msxmldom, XMLDoc, JPEG,
  IdAntiFreezeBase, IdAntiFreeze, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, IniFiles,
  UContainer, UCell, UPortBase, RzLabel, UForms;

 //all the following variables, constants and types until the declaration of this
 //form are used to parse the veros XML or call the WSVeroValue functions
 //property record

type
  TPropertyInfo = record
    SalePrice:    string;
    SaleDate:     string;
    PriorSalePrice: string;
    PriorSaleDate: string;
    APN:          string;
    LivingSF:     string;
    LotSF:        string;
    AssdValTotal: string;
    AssdValImprovement: string;
    AssdValLand:  string;
    YearBuilt:    string;
    Bedrooms:     string;
    Bath:         string;
    County:       string;
    LandUse:      string;
    CensusTract:  string;
    Pool:         string;
    FirePlace:    string;
    Garage:       string;
    Stories:      string;
    AC:           string;
    View:         string;
  end;

  //Subject Sales History
  TSubjectSalesHistory = record
    SaleDate:   string;
    SalePrice:  string;
    LoanAmount: string;
    Seller:     string;
    Buyer:      string;
  end;

  //Market Data Summary
  TMarketDataSummary = record
    Address:   string;
    Distance:  string;
    SalePrice: string;
    SaleDate:  string;
    LivingSF:  string;
    LotSF:     string;
    Bed:       string;
    Bath:      string;
    YearBuilt: string;
  end;

  //market details
  TMarketDataDetail = record
    Street:       string;
    Owner:        string;
    Distance:     string;
    CompPropInfo: TPropertyInfo;
  end;

  TSubjectSalesHistoryList = array[0..5] of TSubjectSalesHistory;
  TMarketDataSummaryList   = array[0..5] of TMarketDataSummary;
  TMarketDataDetailList    = array[0..5] of TMarketDataDetail;

  //------------------- TPortVeroValue declarations--------------------------//

  TPortVeroValue = class(TAdvancedForm)
    Panel1: TPanel;
    MiddelBox: TGroupBox;
    LabelStreet: TLabel;
    LabelCity: TLabel;
    LabelSt: TLabel;
    LabelZip: TLabel;
    edtStreet: TEdit;
    edtCity: TEdit;
    edtState: TEdit;
    edtZip: TEdit;
    BottomBox: TGroupBox;
    URLVeroCoverage: TRzURLLabel;
    Topbox: TGroupBox;
    AnimateProgress: TAnimate;
    lblAccessCode: TLabel;
    edtAccessCode: TEdit;
    Valuate: TButton;
    btnCancel: TButton;
    procedure ValuateClick(Sender: TObject);
    procedure edtZipKeyPress(Sender: TObject; var Key: char);
    procedure edtStateKeyPress(Sender: TObject; var Key: char);
    procedure edtSaleDateKeyPress(Sender: TObject; var Key: char);
  private
    FFileNo: string;    //comes from the user form
    FCaseNo: string;    //comes from the user form
    FReportDate: string;
    FReportNo: string;
    FSubjectStreet: string;
    FSubjectCityStateZip: string;
    FAreaZip: string;
    FSubjectPropertyValue: string;
    FOwnerOfRecord: string;
    FVeroValue: string;
    FValueRange: string;
    FConfidenceScore: string;
    FPropertyType: string;
    FLowValue: string;
    FHighValue: string;
    FMedian: string;
    FPercentile: string;
    FCA_PATH: string;
    FCB_PATH: string;
    FCA_Chart: TMemoryStream;
    FCB_Chart: TMemoryStream;
    FSubjPropInfo: TPropertyInfo;
    FSubjectSalesHistory: array[0..5] of TSubjectSalesHistory;
    FMarketDataSummary: array[0..5] of TMarketDataSummary;
    FMarketDataDetail: array[0..5] of TMarketDataDetail;
    FInAPN: string;
    FInFileNo: string;
    FInOwnerFirst: string;
    FInOwnerLast: string;
    FInBorrower: string;
    FInSalePrice: string;    //Last Known
    FInSaleDate: string;
    FHasAnimateFile: boolean;
    FCustID: integer;
    FDoc: TContainer;
    procedure ValidateUserInput;
    function GetCFDB_ValuationXML: string;
    function GetCFAW_ValuationXML: string;
    function GetAreaTrendStr: string;
    function GetNeighborhoodStr: string;
    procedure ParseVerosXML(XMLStr: string);
    procedure DownLoadVerosCharts;
    procedure TransferResults;
    function FormatVeroDollars(const S: string): string;
    //procedure CheckServiceExpiration;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property CustomerID: integer read FCustID write FCustID;
  end;


//used to launch the Veros Value service
procedure RequestVerosValue(doc: TContainer);


var
  PortVeroValue: TPortVeroValue;


implementation


uses
  Clipbrd,
  UGlobals, UStatus, UMain, UForm, UEditor,
  UUtil2, ULicUser, UDebug, UUtil1, UUtil3, UWinUtils,
  UWebConfig, VeroValueService, {UClientMessaging, UStatusService,} UWebUtils;
  //UServiceManager;

const
  cVeroValuePg1FormUID = 59;
  cVeroValuePg2FormUID = 330;
  cVeroValuePg3FormUID = 331;
  cVeroValuePg4FormUID = 332;

  //hack for detecting hacking for entering the customer ID
  HackProofPhrase      = 'W@%&2LSD1ZUP8JBVC9XM#$RQ7?A';

  OneTimeSalesMsg      =
    'To obtain your FREE VeroValue Property Analysis reports, please call Bradford Technologies at 800-622-8727 so we can activate your account.';

{$R *.dfm}



//routine for launching the Veros Valuation Service
procedure RequestVerosValue(doc: TContainer);
var
  Veros: TPortVeroValue;
begin
// - check for available units here, allow to purchase
// - UServiceManager.CheckAvailability(stVeroValue);

  if assigned(doc) then
    doc.ProcessCurCell(false);                //process any changes

// 2/18/08 - no more demos for now
//  ShowOneTime(OneTimeSalesMsg, appPref_VeroPromotion);

  Veros := TPortVeroValue.Create(Doc);        //now start the process
  try
    Veros.ShowModal;
  finally
    Veros.Free;
  end;

  //let user know how many units /time is left
  //UServiceManager.CheckServiceExpiration(stVeroValue);
end;


 {***************************************}
 { Routines for encoding the customer ID }
 { into a 10 digit character string.     }
 {***************************************}

function padit(cid: string): string;
var
  i: integer;
begin
  //randomize numbers
  randomize;

  //if length is less than 10 then pad it
  if length(cid) < 10 then
  begin
    //pad it with random numners out of the phrase
    for i := 0 to 9 - length(cid) do
    begin
      Result := Result + HackProofPhrase[random(20) + 1];
    end;
    //change the first cell with the length of the string
    Result[1] := HackProofPhrase[length(cid) + 1];
  end
  else
    Result := '';
end;

function encode(cid: integer): string;
var
  u, e: string;
  i, t: integer;
begin
  //convert the cid into string
  u := IntToStr(cid);

  //encode the string
  for i := 1 to length(u) do
  begin
    //convert each char into integer
    t := StrToInt(u[i]);
    // if the number is 0 replace with A otherwise replace with the
    //respective number in the phrase
    if t = 0 then
      e := e + 'A'
    else
      e := e + HackProofPhrase[t];
  end;
  //return the result prefixed with the pad, any string > 10 will not the padded
  Result := padit(IntToStr(cid)) + e;
end;

function decode(cid: string; var outCID: string): boolean;
var
  e, u:    string;
  i, j, k: integer;
begin
  Result := false;

  //first check: is length = 10;
  if length(cid) <> 10 then
    exit;

  //second check: Confine to character set
  for i := 1 to length(cid) do
    if (POS(cid[i], HackProofPhrase) = 0) then
      exit;

  try
    //get the length of the string from the first cell
    j := pos(cid[1], HackProofPhrase);

    if j = 0 then
    begin
      for i := 1 to length(cid) do
      begin
        if cid[i] = 'A' then
          u := u + '0'
        else
          u := u + IntToStr(pos(cid[i], HackProofPhrase));
      end;
    end
    else
    begin
      k := Length(cid) - j;
      e := copy(cid, k + 1, length(cid) - k);
      for i := 2 to length(e) do
      begin
        if e[i] = 'A' then
          u := u + '0'
        else
          u := u + IntToStr(pos(e[i], HackProofPhrase));
      end;
    end;
    outCid := u;
    Result := true;
  except
    Result := false;
    outCID := '0';
  end;
end;

 {***************************}
 {      TPortVeroValue       }
 {***************************}

constructor TPortVeroValue.Create(AOwner: TComponent);
var
  GlobePath:      string;
  state, zipCode: string;
begin
  inherited Create(nil);         //create the port

  //initialize in case there is not data for these
  FInAPN        := 'Null';
  FInFileNo     := 'Null';
  FInBorrower   := 'Null';
  FInOwnerFirst := 'Null';
  FInOwnerLast  := 'Null';
  FInSalePrice  := 'Null';
  FInSaleDate   := 'Null';

  //get data from report if there is one
  FDoc := TContainer(AOwner);
  if assigned(FDoc) then
  begin
    edtStreet.Text := FDoc.GetCellTextByID(46);
    edtCity.Text   := FDoc.GetCellTextByID(47);
    //only 2 digit state
    state          := Trim(FDoc.GetCellTextByID(48));
    edtState.Text  := copy(state, 1, 2);
    //only the 5 digit zip code
    zipCode        := FDoc.GetCellTextByID(49);
    if Length(zipCode) > 5 then
      zipCode := Copy(zipCode, 1, 5);
    edtZip.Text := zipCode;
  end;

  //get the path for displaying the spinning globe
  GlobePath       := IncludeTrailingPathDelimiter(appPref_DirCommon) + SpinningGlobe;
  FHasAnimateFile := FileExists(GlobePath);    //check if the annimation file exits
  if FHasAnimateFile then
    AnimateProgress.FileName := GlobePath;     //show annimation during the funciton call
  AnimateProgress.Active := false;

  FCA_Chart := TMemoryStream.Create;           //for holding the charts
  FCB_Chart := TMemoryStream.Create;

  CustomerID := StrToIntDef(CurrentUser.UserCustUID, 0);   //set the customer ID

  //if this is not a registered user, get their Access Code first
  if CustomerID = 0 then    //this is an unregister user
  begin
    lblAccessCode.Visible := true;
    edtAccessCode.Visible := true;
  end
  else
  begin
    lblAccessCode.Visible := false;
    edtAccessCode.Visible := false;
  end;
end;

destructor TPortVeroValue.Destroy;
begin
  if assigned(FCA_Chart) then
    FCA_Chart.Free;
  if assigned(FCB_Chart) then
    FCB_Chart.Free;

  inherited;
end;



procedure TPortVeroValue.ValidateUserInput;
var
  cid: string;
begin
  //check for customer ID
  if (FCustID = 0) then
  begin
    if Length(edtAccessCode.Text) > 0 then
    begin
      try
        if decode(edtAccessCode.Text, cid) then
          FCustID := StrToInt(cid)
        else
          raise Exception.Create('Invalid Access Code. Please try again.');
      except
        raise Exception.Create('Invalid Access Code. Please try again.');
      end;
    end
    else
      raise Exception.Create('ClickFORMS was unable to read your customer identification. ' + #10
        + 'Please make sure you have registered ClickFORMS.');
  end;

  //check if the user entered all the required information for AVM
  if (Length(edtStreet.Text) = 0) then
    raise Exception.Create('You must enter the property street address.');
  if (Length(edtCity.Text) = 0) then
    raise Exception.Create('You must enter the city where the property is located.');
  if (Length(edtState.Text) <> 2) then
    raise Exception.Create('You must enter the 2 character state abbreviation for the property.');
  if (length(edtZip.Text) = 0) then
    raise Exception.Create('You need to enter the property zip code.');
end;

function TPortVeroValue.GetCFDB_ValuationXML: string;
begin
  if IsConnectedToWeb then
  begin
    try
      //create the debug log if in debug mode
      if AppDebugLevel > 0 then
      begin
        DebugLogMsg('--------------------WSVerosValue--------------------');
        DebugLogMsg('Call Time: ' + DateTimeToStr(now()));
        DebugLogMsg('Requested Information');
        DebugLogMsg('CustID=' + IntToStr(FCUSTID));
        DebugLogMsg('Street=' + edtStreet.Text);
        DebugLogMsg('City=' + edtCity.Text);
        DebugLogMsg('State=' + edtState.Text);
        DebugLogMsg('Zip=' + edtZip.Text);
        DebugLogMsg('APN=' + FInAPN);
        DebugLogMsg('Owner First Name=' + FInOwnerFirst);
        DebugLogMsg('Owner Last Name=' + FInOwnerLast);
        DebugLogMsg('Sale Price=' + FInSalePrice);
        DebugLogMsg('Sale Date=' + FInSaleDate);
        DebugLogMsg('Borrower=' + FInBorrower);
        DebugLogMsg('FileNo=' + FInFileNo);
        DebugLogMsg('--------------------WSVerosValue--------------------');
      end;

      with GetVeroValueServiceSoap(true, UWebConfig.GetURLForVeroValuation) do
      begin
        //make the call to veros web service
        if DemoMode then
          Result := LoadDemoStringFromFile('DemoVeroReport.txt')
        else
          Result := GetPropertyValuation(FCUSTID, WSVero_Password,
            edtStreet.Text, edtCity.Text, edtState.Text, edtZip.Text, FInAPN,
            FInOwnerFirst, FInOwnerLast, FInSalePrice, FInSaleDate, FInBorrower, FInFileNo);

        //      SaveDemoStringToFile(result, 'DemoVeroReport.txt');   //DEMO
      end;

      //check for server side error
      if Copy(Result, 1, 7) <> 'Success' then
        raise Exception.Create(Result);

      //no errors, pass back the valuation xml
      Result := copy(Result, 9, length(Result));
    except
      on e: Exception do
        raise Exception.Create(FriendlyErrorMsg(e.message));  //'Please make sure you are connected to the Internet.');
    end;
  end
  else
    raise Exception.Create(
      'ClickFORMS could not connect to Veros Server. Please make sure you are connected to internet and your firewall is not blocking ClickFORMS to access the Internet.');
end;

function TPortVeroValue.GetCFAW_ValuationXML: string;
begin
  {if IsConnectedToWeb then
  begin
    try
      //create the debug log if in debug mode
      if AppDebugLevel > 0 then
      begin
        DebugLogMsg('--------------------WSVerosValue--------------------');
        DebugLogMsg('Call Time: ' + DateTimeToStr(now()));
        DebugLogMsg('Requested Information');
        DebugLogMsg('CustID=' + IntToStr(FCUSTID));
        DebugLogMsg('Street=' + edtStreet.Text);
        DebugLogMsg('City=' + edtCity.Text);
        DebugLogMsg('State=' + edtState.Text);
        DebugLogMsg('Zip=' + edtZip.Text);
        DebugLogMsg('APN=' + FInAPN);
        DebugLogMsg('Owner First Name=' + FInOwnerFirst);
        DebugLogMsg('Owner Last Name=' + FInOwnerLast);
        DebugLogMsg('Sale Price=' + FInSalePrice);
        DebugLogMsg('Sale Date=' + FInSaleDate);
        DebugLogMsg('Borrower=' + FInBorrower);
        DebugLogMsg('FileNo=' + FInFileNo);
        DebugLogMsg('--------------------WSVerosValue--------------------');
      end;

      with GetVeroValueServiceSoap(true, UWebConfig.GetURLForVeroValuation) do
      begin
        //make the call to veros web service
        if DemoMode then
          Result := LoadDemoStringFromFile('DemoVeroReport.txt')
        else
          Result := GetPropertyValuation(FCUSTID, WSVero_Password,
            edtStreet.Text, edtCity.Text, edtState.Text, edtZip.Text, FInAPN,
            FInOwnerFirst, FInOwnerLast, FInSalePrice, FInSaleDate, FInBorrower, FInFileNo);

        //      SaveDemoStringToFile(result, 'DemoVeroReport.txt');   //DEMO
      end;

      //check for server side error
      if Copy(Result, 1, 7) <> 'Success' then
        raise Exception.Create(Result);

      //no errors, pass back the valuation xml
      Result := copy(Result, 9, length(Result));
    except
      on e: Exception do
        raise Exception.Create(FriendlyErrorMsg(e.message));  //'Please make sure you are connected to the Internet.');
    end;
  end
  else
    raise Exception.Create(
      'ClickFORMS could not connect to Veros Server. Please make sure you are connected to internet and your firewall is not blocking ClickFORMS to access the Internet.');}
end;

function TPortVeroValue.FormatVeroDollars(const S: string): string;
var
  NumStyle: TFloatFormat;
  Value:    double;
begin
  try
    Value    := GetStrValue(S);
    NumStyle := ffNumber;
    Result   := FloatToStrF(Value, NumStyle, 15, 0);
  except
    Result   := S;
  end;
end;

procedure TPortVeroValue.ValuateClick(Sender: TObject);
var
  VeroReturnStr: string;
  ProductID: Integer;
begin
    // 101613 Veros Value is implemented only in BSS and usage is not tracked by PID.
    //  This is a direct call and either passes or fails.
//  if CurrentUser.OK2UseProduct(pidVeros) then
//    ProductID := 1
    // 100613 ProductID 2 is not used until Veros Value is implemented in AWSI
//  else if CurrentUser.OK2UseAWProduct(pidVeros) then
//    ProductID := 2
//  else
//    ProductID := 0;
  ProductID := 1;
  if ProductID > 0 then
    begin
      btnCancel.Enabled := false;   //cannot cancel after starting valuation
      try  //finally
        try //except
          ValidateUserInput;                  //check user input
          if FCustID = 0 then
            exit;           //has to have cust id

          //input validated, now ready for web connection
          if FHasAnimateFile then
            AnimateProgress.Active := true;
          PushMouseCursor(crHourglass);   //show wait cursor
          try
            if ProductID = 1 then
              VeroReturnStr := GetCFDB_ValuationXML   //get the valuation via CustDB
            else
              VeroReturnStr := GetCFAW_ValuationXML;   //get the valuation via AppraisalWorld
            ParseVerosXML(VeroReturnStr);       //parse, see what there
            DownloadVerosCharts;                //get the charts
            TransferResults;                    //create the report
          finally
            PopMouseCursor;
          end;
          ModalResult := mrOk;                //goodbye
        except
          on e: Exception do
          begin
            ShowAlert(atWarnAlert,'There was a problem retrieving the property valuation. Error: ' + e.message);
          end;
        end;
      finally
        if FHasAnimateFile then
          AnimateProgress.Active := false;
        btnCancel.Enabled := true;
      end;
    end;
end;

procedure TPortVeroValue.ParseVerosXML(XMLStr: string);
var
  XMLDOM: IXMLDocument;
  VEROVALUATION_Node: IXMLNode;
  PROPCHAR_Node: IXMLNode;
  COMPSLIST_Node: IXMLNode;
  COMPSITEM_Node: IXMLNode;
  SALESHISTORYINFO_Node: IXMLNode;
  SALESINFO_Node: IXMLNode;
  CHARTS_Node: IXMLNode;
  i: integer;
begin
  try
    XMLDOM := LoadXMLData(XMLStr);

    if not XMLDOM.IsEmptyDoc then
    begin
      VEROVALUATION_Node := XMLDOM.ChildNodes.FindNode('VEROVALUATION');
      if VEROVALUATION_Node <> nil then
      begin
        FReportNo := VEROVALUATION_Node.ChildNodes['REPORTNUM'].Text;

        //parse header information
        PROPCHAR_Node := VEROVALUATION_Node.ChildNodes.FindNode('PROPCHAR');

        FReportDate          := PROPCHAR_Node.ChildNodes['ESTMARKETVALUEDT'].Text;
        FSubjectStreet       := PROPCHAR_Node.ChildNodes['SUBJECTADDRSTREET'].Text;
        FSubjectCityStateZip := PROPCHAR_Node.ChildNodes['CITY'].Text + ', ' +
          PROPCHAR_Node.ChildNodes['SUBJECTADDRSTATEPROV'].Text + ' ' + PROPCHAR_Node.ChildNodes['SUBJECTADDRZIP'].Text;
        FOwnerOfRecord       := PROPCHAR_Node.ChildNodes['CURRENTOWNER'].Text;
        FVeroValue           := PROPCHAR_Node.ChildNodes['ESTMARKETVALUE'].Text;
        FValueRange          := PROPCHAR_Node.ChildNodes['ESTMARKETVALUELOW'].Text + ' to ' +
          PROPCHAR_Node.ChildNodes['ESTMARKETVALUEHIGH'].Text;
        FConfidenceScore     := PROPCHAR_Node.ChildNodes['CONFIDENCESCORE'].Text;

        //parse subject property information
        FSubjPropInfo.SalePrice      := ''; //these values not displayed in this table
        FSubjPropInfo.SaleDate       := '';
        FSubjPropInfo.PriorSalePrice := '';
        FSubjPropInfo.PriorSaleDate  := '';

        FSubjPropInfo.APN          := PROPCHAR_Node.ChildNodes['ASSESPARCELNUM'].Text;
        FSubjPropInfo.LivingSF     := PROPCHAR_Node.ChildNodes['ABOVEGRADEAREASQFT'].Text;
        FSubjPropInfo.LotSF        := PROPCHAR_Node.ChildNodes['SITEAREA'].Text;
        FSubjPropInfo.AssdValTotal := PROPCHAR_Node.ChildNodes['ASSMENTTAXRECORDS'].Text;
        FSubjPropInfo.AssdValImprovement := PROPCHAR_Node.ChildNodes['ASSMENTIMPRVALUE'].Text;
        FSubjPropInfo.AssdValLand  := PROPCHAR_Node.ChildNodes['ASSMENTLANDVALUE'].Text;
        FSubjPropInfo.YearBuilt    := PROPCHAR_Node.ChildNodes['YEARBUILT'].Text;
        FSubjPropInfo.Bedrooms     := PROPCHAR_Node.ChildNodes['ABOVEGRADEBEDROOMS'].Text;
        FSubjPropInfo.Bath         := PROPCHAR_Node.ChildNodes['ABOVEGRADEBATHS'].Text;
        FSubjPropInfo.County       := PROPCHAR_Node.ChildNodes['COUNTY'].Text;
        FSubjPropInfo.LandUse      := PROPCHAR_Node.ChildNodes['ORIGUSE'].Text;
        FSubjPropInfo.CensusTract  := PROPCHAR_Node.ChildNodes['CENSUSTRACT'].Text;
        FSubjPropInfo.Pool         := PROPCHAR_Node.ChildNodes['SUBJECTFENCEPOOL'].Text;
        FSubjPropInfo.FirePlace    := PROPCHAR_Node.ChildNodes['SUBJECTFIREPLACE'].Text;
        FSubjPropInfo.Garage       := PROPCHAR_Node.ChildNodes['CARSTORAGEATTACHEDCARS'].Text;
        FSubjPropInfo.Stories      := PROPCHAR_Node.ChildNodes['SUBJECTSTORIES'].Text;
        FSubjPropInfo.AC           := PROPCHAR_Node.ChildNodes['COOLINGCENTRAL'].Text;
        FSubjPropInfo.View         := PROPCHAR_Node.ChildNodes['SUBJECTVIEW'].Text;

        //Parse Sales History information
        //assuming that the sales history will never be more than 6 rows, otherwise the array
        //FSubjectSalesHistory will need to be made dynamic
        SALESHISTORYINFO_Node := VEROVALUATION_Node.ChildNodes.FindNode('SALESHISTORYINFO');

        for i := 0 to SALESHISTORYINFO_Node.ChildNodes.Count - 1 do
        begin
          SALESINFO_Node := SALESHISTORYINFO_Node.ChildNodes[i];
          FSubjectSalesHistory[i].SaleDate := SALESINFO_Node.ChildNodes['SUBJECTPRIOR1SALEDT'].Text;
          FSubjectSalesHistory[i].SalePrice := SALESINFO_Node.ChildNodes['SUBJECTPRIOR1SALEPRICE'].Text;
          FSubjectSalesHistory[i].LoanAmount := SALESINFO_Node.ChildNodes['SUBJECTPRIOR1LOANAMOUNT'].Text;
          FSubjectSalesHistory[i].Seller := SALESINFO_Node.ChildNodes['SUBJECTPRIOR1SELLER'].Text;
          FSubjectSalesHistory[i].Buyer := SALESINFO_Node.ChildNodes['SUBJECTPRIOR1BUYER'].Text;
        end;

        //Parse Market Data Summary
        //above array length assumtion is true for this section too
        COMPSLIST_Node := VEROVALUATION_Node.ChildNodes.FindNode('COMPSLIST');
        for i := 0 to COMPSLIST_Node.ChildNodes.Count - 1 do
        begin
          COMPSITEM_Node := COMPSLIST_Node.ChildNodes[i];
          FMarketDataSummary[i].Address := COMPSITEM_Node.ChildNodes['COMP1ADDRSTREET'].Text;
          FMarketDataSummary[i].Distance := COMPSITEM_Node.ChildNodes['COMP1DISTANCE'].Text;
          FMarketDataSummary[i].SalePrice := COMPSITEM_Node.ChildNodes['COMP1SALEPRICE'].Text;
          FMarketDataSummary[i].SaleDate := COMPSITEM_Node.ChildNodes['COMP1SALEDT'].Text;
          FMarketDataSummary[i].LivingSF := COMPSITEM_Node.ChildNodes['COMP1LIVINGSQFT'].Text;
          FMarketDataSummary[i].LotSF := COMPSITEM_Node.ChildNodes['COMP1SITE'].Text;
          FMarketDataSummary[i].Bed := COMPSITEM_Node.ChildNodes['COMP1BEDROOMS'].Text;
          FMarketDataSummary[i].Bath := COMPSITEM_Node.ChildNodes['COMP1BATH'].Text;
          FMarketDataSummary[i].YearBuilt := COMPSITEM_Node.ChildNodes['COMP1YEARBUILT'].Text;
        end;

        //Parse Market Data Details
        COMPSLIST_Node := VEROVALUATION_Node.ChildNodes.FindNode('COMPSLIST');
        for i := 0 to COMPSLIST_Node.ChildNodes.Count - 1 do
        begin
          COMPSITEM_Node := COMPSLIST_Node.ChildNodes[i];

          FMarketDataDetail[i].Street   := COMPSITEM_Node.ChildNodes['COMP1ADDRSTREET'].Text;
          FMarketDataDetail[i].Owner    := COMPSITEM_Node.ChildNodes['COMP1OWNERNAME'].Text;
          FMarketDataDetail[i].Distance := COMPSITEM_Node.ChildNodes['COMP1DISTANCE'].Text;

          FMarketDataDetail[i].CompPropInfo.SalePrice    := COMPSITEM_Node.ChildNodes['COMP1SALEPRICE'].Text;
          FMarketDataDetail[i].CompPropInfo.SaleDate     := COMPSITEM_Node.ChildNodes['COMP1SALEDT'].Text;
          FMarketDataDetail[i].CompPropInfo.PriorSalePrice := COMPSITEM_Node.ChildNodes['COMP1PRIORSALEPRICE'].Text;
          FMarketDataDetail[i].CompPropInfo.PriorSaleDate := COMPSITEM_Node.ChildNodes['COMP1PRIORSALEDT'].Text;
          FMarketDataDetail[i].CompPropInfo.APN          := COMPSITEM_Node.ChildNodes['COMP1ASSESPARCELNUM'].Text;
          FMarketDataDetail[i].CompPropInfo.LivingSF     := COMPSITEM_Node.ChildNodes['COMP1LIVINGSQFT'].Text;
          FMarketDataDetail[i].CompPropInfo.LotSF        := COMPSITEM_Node.ChildNodes['COMP1SITE'].Text;
          FMarketDataDetail[i].CompPropInfo.AssdValTotal := COMPSITEM_Node.ChildNodes['COMP1ASSMENTTOTALVALUE'].Text;
          FMarketDataDetail[i].CompPropInfo.AssdValImprovement :=
            COMPSITEM_Node.ChildNodes['COMP1ASSMENTIMPROVEMENTVALUE'].Text;
          FMarketDataDetail[i].CompPropInfo.AssdValLand  := COMPSITEM_Node.ChildNodes['COMP1ASSMENTLANDVALUE'].Text;
          FMarketDataDetail[i].CompPropInfo.YearBuilt    := COMPSITEM_Node.ChildNodes['COMP1YEARBUILT'].Text;
          FMarketDataDetail[i].CompPropInfo.Bedrooms     := COMPSITEM_Node.ChildNodes['COMP1BEDROOMS'].Text;
          FMarketDataDetail[i].CompPropInfo.Bath         := COMPSITEM_Node.ChildNodes['COMP1BATH'].Text;
          FMarketDataDetail[i].CompPropInfo.County       := COMPSITEM_Node.ChildNodes['COMP1COUNTY'].Text;
          FMarketDataDetail[i].CompPropInfo.LandUse      := COMPSITEM_Node.ChildNodes['COMP1LANDUSE'].Text;
          FMarketDataDetail[i].CompPropInfo.CensusTract  := COMPSITEM_Node.ChildNodes['COMP1CENSUSTRACT'].Text;
          FMarketDataDetail[i].CompPropInfo.Pool         := COMPSITEM_Node.ChildNodes['COMP1POOL'].Text;
          FMarketDataDetail[i].CompPropInfo.FirePlace    := COMPSITEM_Node.ChildNodes['COMP1FIREPLACE'].Text;
          FMarketDataDetail[i].CompPropInfo.Garage       := COMPSITEM_Node.ChildNodes['COMP1GARAGE'].Text;
          FMarketDataDetail[i].CompPropInfo.Stories      := COMPSITEM_Node.ChildNodes['COMP1STORIES'].Text;
          FMarketDataDetail[i].CompPropInfo.AC           := COMPSITEM_Node.ChildNodes['COMP1HEATINGCOOL'].Text;
          FMarketDataDetail[i].CompPropInfo.View         := COMPSITEM_Node.ChildNodes['COMP1VIEW'].Text;
        end;

        CHARTS_Node := VEROVALUATION_Node.ChildNodes.FindNode('CHARTS');

        //Neighborhood Price Range Chart & Comments
        FPropertyType := CHARTS_Node.ChildNodes['PROPERTYTYPE'].Text;
        FLowValue     := FormatVeroDollars(CHARTS_Node.ChildNodes['LOWVALUE'].Text);
        FHighValue    := FormatVeroDollars(CHARTS_Node.ChildNodes['HIGHVALUE'].Text);
        FMedian       := FormatVeroDollars(CHARTS_Node.ChildNodes['THE50THVALUE'].Text);
        FSubjectPropertyValue := FormatVeroDollars(FVeroValue);
        FPercentile   := CHARTS_Node.ChildNodes['SUB_PCT_RANK'].Text;
        FCA_PATH      := CHARTS_Node.ChildNodes['CA_PATH'].Text;

        //Area Trend Chart & Comments
        FAreaZip := PROPCHAR_Node.ChildNodes['SUBJECTADDRZIP'].Text;
        FCB_PATH := CHARTS_Node.ChildNodes['CB_PATH'].Text;
      end;
    end;

  except
    on e: Exception do
    begin
      raise Exception.Create('Error:' + e.Message);
    end;
  end;
end;

procedure TPortVeroValue.DownloadVerosCharts;
var
  URLStr, ResultStr: string;
  IdHTTPVeros:       TIdHTTP;
begin
  IdHTTPVeros := TIdHTTP.Create(nil);
  try
    //download Neighborhood chart
    URLStr := FCA_PATH;
    if DemoMode then
      ResultStr := LoadDemoStringFromFile('DemoVeroReportChart1.txt')
    else
      ResultStr := IdHTTPVeros.Get(URLStr);
    //    SaveDemoStringToFile(ResultStr, 'DemoVeroReportChart1.txt');   //DEMO
    FCA_Chart := TMemoryStream.Create;
    FCA_Chart.WriteBuffer(ResultStr[1], Length(ResultStr));
    FCA_Chart.Position := 0;

    //download Area Trend Chart
    URLStr := FCB_PATH;
    if DemoMode then
      ResultStr := LoadDemoStringFromFile('DemoVeroReportChart2.txt')
    else
      ResultStr := IdHTTPVeros.Get(URLStr);
    //    SaveDemoStringToFile(ResultStr, 'DemoVeroReportChart2.txt');   //DEMO
    FCB_Chart := TMemoryStream.Create;
    FCB_Chart.WriteBuffer(ResultStr[1], Length(ResultStr));
    FCB_Chart.Position := 0;
  finally
    IdHTTPVeros.Free;
  end;
end;

 //check if the form verovalue form is already open,
 //if not open add it to the doc, create doc if none there
procedure TPortVeroValue.TransferResults;
var
  Form, firstForm: TDocForm;
  Cell: TBaseCell;
  i, j: integer;
begin
  //create doc if we don't have one
  if FDoc = nil then
    FDoc := Main.NewEmptyDoc;

  try
    //LOAD VEROS VALUE REPORT PAGE 1
    Form      := FDoc.GetFormByOccurance(cVeroValuePg1FormUID, 0, true); //True = AutoLoad,0=zero based
    firstForm := Form;      //remember this so  we can go to top
    if (Form = nil) then
      ShowNotice('Veros Value form ID' + IntToStr(cVeroValuePg1FormUID) + ' was not be found in the Forms Library.')
    else
    begin
      //header informations
      Form.SetCellDataNP(1, 5, FReportDate);
      Form.SetCellDataNP(1, 6, FReportNo);
      Form.SetCellDataNP(1, 7, FSubjectStreet);
      Form.SetCellDataNP(1, 8, FSubjectCityStateZip);
      Form.SetCellDataNP(1, 9, FOwnerOfRecord);
      Form.SetCellDataNP(1, 10, FormatVeroDollars(FVeroValue));
      Form.SetCellDataNP(1, 11, FValueRange);
      Form.SetCellDataNP(1, 12, FConfidenceScore);

      //subject property information
      Form.SetCellDataNP(1, 14, FSubjPropInfo.APN);
      Form.SetCellDataNP(1, 15, FSubjPropInfo.LivingSF);
      Form.SetCellDataNP(1, 16, FSubjPropInfo.LotSF);
      Form.SetCellDataNP(1, 17, FSubjPropInfo.AssdValTotal);
      Form.SetCellDataNP(1, 18, FSubjPropInfo.AssdValImprovement);
      Form.SetCellDataNP(1, 19, FSubjPropInfo.AssdValLand);
      Form.SetCellDataNP(1, 20, FSubjPropInfo.YearBuilt);
      Form.SetCellDataNP(1, 21, FSubjPropInfo.Bedrooms);
      Form.SetCellDataNP(1, 22, FSubjPropInfo.Bath);
      Form.SetCellDataNP(1, 23, FSubjPropInfo.County);
      Form.SetCellDataNP(1, 24, FSubjPropInfo.LandUse);
      Form.SetCellDataNP(1, 25, FSubjPropInfo.CensusTract);
      Form.SetCellDataNP(1, 26, FSubjPropInfo.Pool);
      Form.SetCellDataNP(1, 27, FSubjPropInfo.FirePlace);
      Form.SetCellDataNP(1, 28, FSubjPropInfo.Garage);
      Form.SetCellDataNP(1, 29, FSubjPropInfo.Stories);
      Form.SetCellDataNP(1, 30, FSubjPropInfo.AC);
      Form.SetCellDataNP(1, 31, FSubjPropInfo.View);

      //Subject Sales History
      j := 31;   //cell seq number
      for i := 0 to 5 do
      begin
        Inc(j);
        Form.SetCellDataNP(1, j, FSubjectSalesHistory[i].SaleDate);
        Inc(j);
        Form.SetCellDataNP(1, j, FSubjectSalesHistory[i].SalePrice);
        Inc(j);
        Form.SetCellDataNP(1, j, FSubjectSalesHistory[i].LoanAmount);
        Inc(j);
        Form.SetCellDataNP(1, j, FSubjectSalesHistory[i].Seller);
        Inc(j);
        Form.SetCellDataNP(1, j, FSubjectSalesHistory[i].Buyer);
      end;

               //Market Data Summary
      j := 61; //cell seq number
      for i := 0 to 5 do
      begin
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataSummary[i].Address);
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataSummary[i].Distance);
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataSummary[i].SalePrice);
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataSummary[i].SaleDate);
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataSummary[i].LivingSF);
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataSummary[i].LotSF);
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataSummary[i].Bed);
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataSummary[i].Bath);
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataSummary[i].YearBuilt);
      end;
    end;   //------eop page 1-----------//

           //LOAD VEROS VALUE REPORT PAGE 2
    Form := FDoc.GetFormByOccurance(cVeroValuePg2FormUID, 0, true); //True = AutoLoad,0=zero based
    if (Form = nil) then
      ShowNotice('Veros Value form ID' + IntToStr(cVeroValuePg2FormUID) + ' was not be found in the Forms Library.')
    else
    begin
      Form.SetCellDataNP(1, 2, FFileNo);
      Form.SetCellDataNP(1, 4, FCaseNo);

      j := 4;
      for i := 0 to 5 do
      begin
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataDetail[i].Street);  //5
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataDetail[i].Owner); //6
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataDetail[i].Distance);//7
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataDetail[i].CompPropInfo.SalePrice); //8
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataDetail[i].CompPropInfo.SaleDate); //9
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataDetail[i].CompPropInfo.PriorSalePrice); //10
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataDetail[i].CompPropInfo.PriorSaleDate); //11

        Inc(j);
        Form.SetCellDataNP(1, j, ''); //12 blank cell
        Inc(j);
        Form.SetCellDataNP(1, j, ''); //13 blank cell
        Inc(j);
        Form.SetCellDataNP(1, j, ''); //14 blank cell
        Inc(j);
        Form.SetCellDataNP(1, j, ''); //15 blank cell

        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataDetail[i].CompPropInfo.APN); //16
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataDetail[i].CompPropInfo.LivingSF); //17
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataDetail[i].CompPropInfo.LotSF); //18
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataDetail[i].CompPropInfo.AssdValTotal); //19
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataDetail[i].CompPropInfo.AssdValImprovement); //20
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataDetail[i].CompPropInfo.AssdValLand); //21

        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataDetail[i].CompPropInfo.YearBuilt); //22
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataDetail[i].CompPropInfo.Bedrooms); //23
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataDetail[i].CompPropInfo.Bath); //24
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataDetail[i].CompPropInfo.County); //25
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataDetail[i].CompPropInfo.LandUse); //26
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataDetail[i].CompPropInfo.CensusTract); //27

        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataDetail[i].CompPropInfo.Pool); //28
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataDetail[i].CompPropInfo.FirePlace); //29
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataDetail[i].CompPropInfo.Garage); //30
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataDetail[i].CompPropInfo.Stories); //31
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataDetail[i].CompPropInfo.AC); //32
        Inc(j);
        Form.SetCellDataNP(1, j, FMarketDataDetail[i].CompPropInfo.View); //33
      end;
    end;    //-------------eop  page 2------------------

    //LOAD VEROS VALUE REPORT PAGE 3
    Form := FDoc.GetFormByOccurance(cVeroValuePg3FormUID, 0, true); //True = AutoLoad,0=zero based
    if (Form = nil) then
      ShowNotice('Veros Value form ID' + IntToStr(cVeroValuePg3FormUID) + ' was not be found in the Forms Library.')
    else
    begin
      Form.SetCellDataNP(1, 2, FFileNo);
      Form.SetCellDataNP(1, 4, FCaseNo);

      //transfer the Neighborhood chart
      try
        Cell := Form.GetCell(1, 5);
        FDoc.MakeCurCell(cell);        //make sure its active
        TGraphicEditor(FDoc.docEditor).LoadImageStream(FCA_Chart);

        //load in the comment
        cell := Form.GetCell(1, 6);
        TMLnTextCell(cell).LoadContent(GetNeighborhoodStr, false);
      except
        raise Exception.Create('There was a problem transferring the neighborhood chart.');
      end;

      //Transfer the Area Trend Chart
      try
        Cell := Form.GetCell(1, 7);
        FDoc.MakeCurCell(cell);        //make sure its active
        TGraphicEditor(FDoc.docEditor).LoadImageStream(FCB_Chart);

        //load in the comment
        cell := Form.GetCell(1, 8);
        TMLnTextCell(cell).LoadContent(GetAreaTrendStr, false);
      except
        raise Exception.Create('There was a problem transferring the area trend chart.');
      end;
    end; //eof page 3

         //LOAD VEROS VALUE REPORT PAGE 4
    Form := FDoc.GetFormByOccurance(cVeroValuePg4FormUID, 0, true); //True = AutoLoad,0=zero based
    if (Form = nil) then
      ShowNotice('Veros Value form ID' + IntToStr(cVeroValuePg4FormUID) + ' was not be found in the Forms Library.');

    //go to top of report
    if assigned(firstForm) then
      FDoc.ScrollIntoView(firstForm);
  except
    raise Exception.Create('There was a problem creating the Veros Value Report.');
  end;
end;

function TPortVeroValue.GetAreaTrendStr: string;
begin
  Result := 'Price changes for ' + FPropertyType + ' in the subject property''s zip code(' +
    FAreaZip + ') and neighborhood are shown for comparision of local and reginal trends. ' +
    'Starting on the left and normalized to zero, price changes are given on a ' +
    'periodic basis and tracked cumulatively.';
end;

function TPortVeroValue.GetNeighborhoodStr: string;
begin
  Result := 'The price range of single family residences in the subject' +
    ' property''s neighborhood is from a low of ' + FLowValue + ' to a high of ' + FHighValue +
    ', with a median price of ' + FMedian + '. The subject property is valued at ' +
    FVeroValue + ' and is ranked at the ' + FPercentile + ' percentile, meaning that ' +
    FPercentile + '% of the in the subject''s neighborhood are valued less than the subject property.';
end;

procedure TPortVeroValue.edtZipKeyPress(Sender: TObject; var Key: char);
begin
  if not (key in ['0'..'9', #8, #13]) then
    key := #0;
end;

procedure TPortVeroValue.edtStateKeyPress(Sender: TObject; var Key: char);
begin
  if not (key in ['A'..'Z', 'a'..'z', #8, #13]) then
    key := #0;
end;

procedure TPortVeroValue.edtSaleDateKeyPress(Sender: TObject; var Key: char);
begin
  if not (key in ['/', '0'..'9', #8, #13]) then
    key := #0;
end;


 ////////////////////////////////////////////////////////////////////////////////
 // this procedure checks for the service expiration status online. It also
 // checks for the expiration status of maintenance, support and AWC. 

 ////////////////////////////////////////////////////////////////////////////////
{procedure TPortVeroValue.CheckServiceExpiration;
begin
  UServiceManager.CheckServiceExpiration(stVeroValue);
end;   }

(*
var
  MsgClient: TClientMessaging;
  sVeros: string;
  IsExpired: Boolean;
begin
  if (Not DemoMode) and (Length(CurrentUser.LicInfo.UserCustID) > 0) then
    begin
      PushMouseCursor(crHourglass);   //show wait cursor
      MsgClient := TClientMessaging.Create(self);
      try
        try
          //check veros web service status
          sVeros := MsgClient.GetLiveServiceStatus(StrToInt(CurrentUser.LicInfo.UserCustID), stVeroValue, IsExpired);
          if (Length(sVeros) > 0) and (IsExpired = true) then
             UStatusService.ShowExpiredMsg(sVeros)
          else if (Length(sVeros) > 0) and (IsExpired = False) then
             UStatusService.ShowExpiringMsg(sVeros);
        except
        //show no messages
        end;
      finally
        MsgClient.Free;
        PopMouseCursor;
      end;
    end;
end;
*)
end.
