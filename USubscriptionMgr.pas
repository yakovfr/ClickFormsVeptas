unit USubscriptionMgr;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }


{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface
  uses
    Classes,
    UCustomLists,
    UServiceCustomerSubscription,
    WSI_Server_MarketConditions;

type
  TServiceLoginCredentials = packed record
    FUsername: ShortString;
    FPassword: ShortString;
    FPublicKey: ShortString;
  end;
  PServiceLoginCredentials = ^TServiceLoginCredentials;

  TServiceFeeEvent = procedure (Sender: TObject; const Amount: Currency; var Authorize: Boolean) of object;
  TServiceTicket = clsTransactionData;

  TEntryPointList = class(TCustomList)
    public
      procedure PopulateList; override;
  end;

  TSubscriptionService = class(TPersistent)
    private
      FEntrypoints: TEntryPointList;
      FOnServiceFee: TServiceFeeEvent;
      FService: CustomerSubscriptionServiceSoap;
    private
      function GetOnServiceFee: TServiceFeeEvent;
      procedure SetOnServiceFee(const Value: TServiceFeeEvent);
    protected
      procedure DoServiceFee(const Amount: Currency; var Authorize: Boolean); virtual;
    public
      constructor Create; virtual;
      destructor Destroy; override;
      function GetSecurityToken(const Login: TServiceLoginCredentials; const ServiceName: String): WideString;
      class procedure Authorize(const Login: TServiceLoginCredentials; const ServiceName: string; out Ticket: TServiceTicket; OnServiceFee: TServiceFeeEvent = nil);
    public
      property OnServiceFee: TServiceFeeEvent read GetOnServiceFee write SetOnServiceFee;
  end;

implementation

uses
  FMTBcd, Forms, RIO, SoapHTTPClient, SysUtils,
  UDebugTools, UExceptions, UGlobals, UPaths, XSBuiltIns;

// --- TEntryPointList --------------------------------------------------------

procedure TEntryPointList.PopulateList;
begin
  Values['Pictometry']      := 'a17c5bdaf7760f06b6af3f24c4222675';
  Values['MapPoint']        := '512682ffc7f7c49ddc12ef23ca770fea';
  Values['FloodMap']        := '1282d70c0d3dce4f80dca3e3457c1056';
  Values['Veros']           := '940b53d6fcf512a3547010ca44f8c97f';
  Values['Fidelity']        := 'f6fa56fc10de625398167c7bbb928edf';
  Values['VirtualEarth']    := '0c598d6200ddd64437df5eaca30cbc68';
  Values['AppraisalSentry'] := '467527ef2d766ba78cc36aac8c095b4d';
  Values['MarketAnalysis']  := 'f9036be82bcaa067575914b5908bd687';
end;

// --- TSubscriptionService ---------------------------------------------------

function TSubscriptionService.GetOnServiceFee: TServiceFeeEvent;
begin
  Result := FOnServiceFee
end;

procedure TSubscriptionService.SetOnServiceFee(const Value: TServiceFeeEvent);
begin
  FOnServiceFee := Value;
end;

procedure TSubscriptionService.DoServiceFee(const Amount: Currency; var Authorize: Boolean);
begin
  if Assigned(FOnServiceFee) then
    FOnServiceFee(Self, Amount, Authorize);
end;

constructor TSubscriptionService.Create;
begin
  FEntrypoints := TEntryPointList.Create;
  FService := GetCustomerSubscriptionServiceSoap(true, TWebPaths.CustomerSubscriptionServerWSDL);

  if debugMode then
    TDebugTools.Debugger.DebugSOAPService(((Fservice as IRIOAccess).RIO as THTTPRIO));

  inherited;
end;

destructor TSubscriptionService.Destroy;
begin
  FService := nil;
  FreeAndNil(FEntrypoints);
  inherited;
end;

function TSubscriptionService.GetSecurityToken(const Login: TServiceLoginCredentials; const ServiceName: String): WideString;
var
  amount: Currency;
  authorize: Boolean;
  fee: TXSDecimal;
  msg: WideString;
  token: WideString;
begin
  fee := nil;
  msg := '';
  token := FService.GetSecurityToken(Login.FUsername, Login.FPassword, Fentrypoints.Values[ServiceName], fee, msg);
  try
    BcdToCurr(fee.AsBcd, amount);
    if (amount <> 0) then
      begin
        authorize := false;
        DoServiceFee(amount, authorize);
        if not authorize then
          raise EInformationalError.Create('Authorization declined');
      end;

    if (Pos('ERROR', UpperCase(token)) <> 0) then
      msg := token;
    if (token = '') and (msg = '') then
      msg := 'Unknown error';
    if (Pos('ERROR', UpperCase(msg)) <> 0) then
      raise EInformationalError.Create(msg);
  finally
    FreeAndNil(fee);
  end;

  Result := token;
end;

class procedure TSubscriptionService.Authorize(const Login: TServiceLoginCredentials; const ServiceName: String; out Ticket: TServiceTicket; OnServiceFee: TServiceFeeEvent);
var
  subscription: TSubscriptionService;
begin
  subscription := nil;
  Ticket := nil;
  try
    subscription := TSubscriptionService.Create;
    subscription.OnServiceFee := OnServiceFee;
    ticket := TServiceTicket.Create;
    ticket.Username := Login.FUsername;
    ticket.Password := subscription.GetSecurityToken(Login, ServiceName);
    ticket.TransactionType := 1;
    ticket.OrderNum := Application.Title;
    FreeAndNil(subscription);
  except
    FreeAndNil(Ticket);
    FreeAndNil(subscription);
    raise;
  end;
end;

end.
