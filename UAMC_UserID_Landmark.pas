unit UAMC_UserID_Landmark;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Registry,
  WinHTTP_TLB, uLkJSON,
  UAMC_Base, UAMC_WorkflowBaseFrame, Grids_ts, TSGrid, osAdvDbGrid;

const
  LandmarkRegKey  = '\AMC\Landmark';

  colOrderID    = 1;
  colOrderDate  = 2;
  colAddress    = 3;
  colCity       = 4;
  colState      = 5;
  colZip        = 6;

type
  TAMC_UserID_Landmark = class(TWorkflowBaseFrame)
    btnLogin: TButton;
    sttTitle: TStaticText;
    StaticText1: TStaticText;
    sttAddress: TStaticText;
    edtUserID: TEdit;
    stxUserID: TStaticText;
    edtUserPassword: TEdit;
    stxSelectedOrderID: TStaticText;
    StaticText2: TStaticText;
    tgPendingOrders: TosAdvDbGrid;
    stxOrderID: TStaticText;
    StaticText3: TStaticText;
    procedure Login(Sender: TObject);
    procedure tgPendingOrdersClickCell(Sender: TObject; DataColDown,
      DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
      UpPos: TtsClickPosition);
    procedure tgPendingOrdersSelectChanged(Sender: TObject;
      SelectType: TtsSelectType; ByUser: Boolean);
    procedure LoginEntered(Sender: TObject);
  private
    { Private declarations }
    FOrderSelected: Boolean;
    FOrderID: String;
    procedure SetPackageContents(thisOrder: Integer);              //sets the package contents
    procedure AutoSelectOrderID;
    procedure DisplayPendingOrders(jsonOrders: String);
    function GetLandmarkUserRegistryInfo: String;
    procedure SetLandmarkUserRegistryInfo(aUserID: String);
  public
    { Public declarations }
    procedure InitPackageData; override;
    procedure DoProcessData; override;
  end;

  function ConvertLandmarkDateTime(origDate: String): String;

implementation
uses
   UStatus, UWindowsInfo, UAMC_Globals, UGlobals, UWebConfig;

{$R *.dfm}

function ConvertLandmarkDateTime(origDate: String): String;
var
  dt: TDateTime;
  fs: TFormatSettings;
begin
  result := origDate;
  fs.DateSeparator := '-';
  fs.TimeSeparator := ':';
  fs.ShortDateFormat := 'yyyy-mm-dd';
  fs.ShortTimeFormat := 'hh:mm:ss';
  if TryStrToDateTime(origDate,dt,fs) then
    result := FormatDateTime('mm/dd/yyyy',dt);
end;

procedure TAMC_UserID_Landmark.Login(Sender: TObject);
const
  fnOrderList = 'order/vendor-list/key/%s?user_email=%s&user_password=%s';
  fnUserAuthentication = 'user/auth/key/%s/email/%s/password/%s';
var
  url: String;
  httpRequest: IWinHTTPRequest;
begin
  if edtUserID.Text<>'' then
    SetLandmarkUserRegistryInfo(edtUserID.Text);
  //check user login
  url := LandmarkAPIentry + format(fnUserAuthentication,[LandmarkOurVendorKey,edtUserID.Text,edtUserPassword.Text]);
  httpRequest := CoWinHTTPRequest.Create;
  with httpRequest do
    begin
      Open('GET',url,False);
      SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
      PushMouseCursor(crHourGlass);
      try
        try
          HTTPRequest.send('');
        except
          on e:Exception do
            ShowAlert(atWarnAlert, e.Message);
        end;

        if Status <> httpRespOK then
          begin
            ShowAlert(atWarnAlert, 'Cannot login. The server returned error code '+ IntToStr(status) + ':'+ResponseText);
            exit;
          end;
      finally
        PopMouseCursor;
      end;
    end;
  //get orders
  url := LandmarkAPIentry + format(fnOrderList,[LandmarkOurVendorKey,edtUserID.Text,edtUserPassword.Text]);
  httpRequest := CoWinHTTPRequest.Create;
  with httpRequest do
    begin
      Open('GET',url,False);
      SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
      PushMouseCursor(crHourGlass);
      try
        try
          HTTPRequest.send('');
        except
          on e:Exception do
            ShowAlert(atWarnAlert, e.Message);
        end;

        if Status <> httpRespOK then
          ShowAlert(atWarnAlert, 'Cannot login. The server returned error code '+ IntToStr(status) + ':'+ResponseText)
        else
          DisplayPendingOrders(responseText);
      finally
        PopMouseCursor;
      end;
    end;
end;

procedure TAMC_UserID_Landmark.InitPackageData;
begin
  inherited;
  //init vars
  sttAddress.Caption := PackageData.SubjectAddress;  //display the subject address to user
  FOrderSelected := False;
  FOrderID := '';
  btnLogin.Enabled := False;
    //defaults for Landmark
  PackageData.FForceContents := True;    //user can change package contents
  PackageData.FNeedPDF := False;          //PDF is not necessarily a separate file
  PackageData.FEmbbedPDF := True;         //PDF is always imbedded

   edtUserID.Text := GetLandmarkUserRegistryInfo;
end;

procedure TAMC_UserID_LandMark.DoProcessData;
begin
  inherited;

  PackageData.FGoToNextOk := FOrderSelected;
  PackageData.FHardStop := not FOrderSelected;

  PackageData.FAlertMsg := '';
  if not FOrderSelected then
    if tgPendingOrders.Rows > 0 then
      PackageData.FAlertMsg := 'You need to select the Order ID associated with this appraisal.'
    else
      PackageData.FAlertMsg := 'You cannot proceed. There are no pending orders to associate with this appraisal.';
      
end;

procedure TAMC_UserID_Landmark.tgPendingOrdersClickCell(Sender: TObject;
  DataColDown, DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
  UpPos: TtsClickPosition);
begin
  if DataRowDown > 0 then
    begin
      tgPendingOrders.RowSelected[DataRowDown] := True;
      stxOrderID.caption := tgPendingOrders.Cell[colOrderID, DataRowDown];
      FOrderID := tgPendingOrders.Cell[colOrderID, DataRowDown];
      SetPackageContents(DataRowDown);
      FOrderSelected := True;
    end;
end;

procedure TAMC_UserID_Landmark.tgPendingOrdersSelectChanged(
  Sender: TObject; SelectType: TtsSelectType; ByUser: Boolean);
var
  selectedRow: Integer;
begin
  selectedRow := tgPendingOrders.SelectedRows.First;
  stxOrderID.caption := tgPendingOrders.Cell[colOrderID, selectedRow];
  FOrderID := tgPendingOrders.Cell[colOrderID, selectedRow];
  SetPackageContents(selectedRow);
  FOrderSelected := True;
end;

procedure TAMC_UserID_Landmark.SetPackageContents(thisOrder: Integer); //thisOrder is the row the order is in
var
  dataFile: TDataFile;
  AMCData: TAMCData_Landmark;
Begin
  PackageData.FDataFiles.Clear;   //delete all previous DataObjs
  if FDoc.UADEnabled then                //send just the report with embedded PDF
    dataFile := TDataFile.Create(fTypXML26GSE)
  else
    dataFile := TDataFile.Create(fTypXML26);
  PackageData.FDataFiles.add(dataFile);

  dataFile := TDataFile.Create(fTypPDF);
  PackageData.FDataFiles.add(dataFile);
  
  if Assigned(PackageData.FAMCData) then        //Init the AMC Specific data object
    PackageData.FAMCData.free;

  AMCData := TAMCData_Landmark.Create;         //Create the new TitleSource Data Object
  AMCData.FOrderID := tgPendingOrders.Cell[colOrderID,thisOrder];                 //set the order identifier
  AMCData.FUserID := edtUserID.Text;
  AMCData.FPassword := edtUserPassword.Text;
  PackageData.FAMCData := AMCData;      
end;

procedure TAMC_UserID_Landmark.AutoSelectOrderID;
var
  N: Integer;
begin
  if tgPendingOrders.Rows > 0 then
    with tgPendingOrders do
      for N := 1 to tgPendingOrders.Rows do
        begin
          if CompareText(FData.FZip, Cell[colZip, N]) = 0 then             //match zip
            if CompareText(FData.FAddress, Cell[colAddress, N]) = 0 then   //match address
              begin
                RowSelected[N] := True;
                stxOrderID.caption := Cell[colOrderID, N];
                FOrderID := Cell[colOrderID, N];
                SetPackageContents(N);
                FOrderSelected := True;
                break;
              end;
        end;
end;

procedure TAMC_UserID_Landmark.DisplayPendingOrders(jsonOrders: String);
var
  orders: TlkJSONbase;
  order: TlkJSONObject;
  index: Integer;
  orderDate: String;
begin
  orders := TlkJSON.ParseText(jsonOrders);
  if orders is TlkJSONNull then
    begin
      ShowAlert(atWarnAlert, 'There are no open or pending orders. Please contact Landmark to activate your orders.');
      exit;
    end;
  //always start clean
  tgPendingOrders.GridData.Clear;
  tgPendingOrders.Rows := 0;
  if orders.Count = 0 then
    ShowAlert(atWarnAlert, 'There are no open or pending orders. Please contact Landmark to activate your orders.')
  else
    for index := 0 to orders.Count - 1 do
      with tgPendingOrders do
        begin
          order := TlkJSONobjectmethod(orders.child[index]).objValue as TlkJSONobject;
          Rows := Rows + 1;
          Cell[colOrderID, Rows] := VarToStr(order.Field['id'].Value);
          Cell[colAddress, Rows] := VarToStr(order.Field['propaddress1'].Value);
          Cell[colCity, Rows] := VarToStr(order.Field['propcity'].Value);
          Cell[colState, Rows] := VarToStr(order.Field['propstate'].Value);
          Cell[colZip, Rows] := VarToStr(order.Field['propzip'].Value);
          orderDate := VarToStr(order.Field['ordereddate'].Value);
          Cell[colOrderDate,Rows] := ConvertLandMarkDateTime(orderDate);
        end;
  //attempt to preselect the order ID for user
  AutoSelectOrderID;
end;

procedure TAMC_UserID_Landmark.LoginEntered(Sender: TObject);
begin
 if(length(edtUserPassword.text)> 0) and (Length(edtUserID.Text) > 0) then
  btnLogin.Enabled := true
 else
  btnLogin.Enabled := false;
end;

function TAMC_UserID_Landmark.GetLandmarkUserRegistryInfo: String;
var
  reg: TRegistry;
  regKey: String;
begin
  result := '';
  reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    regKey := LocMachClickFormBaseSection + LandmarkRegKey;
    if reg.OpenKey(regKey, False) then
      result := reg.ReadString('UserID');
  finally
    reg.Free;
  end;
end;

procedure TAMC_UserID_Landmark.SetLandmarkUserRegistryInfo(aUserID: String);
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if reg.OpenKey(LocMachClickFormBaseSection + LandmarkRegKey, True) then
      begin
        reg.WriteString('UserID', aUserID);
      end;
  finally
    reg.Free;
  end;
end;

end.
