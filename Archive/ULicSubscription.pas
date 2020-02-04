unit ULicSubscription;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2008 by Bradford Technologies, Inc. }

{This unit makes a webservice call to check a users subscription status}


interface


function GetUserHasValidSubscription(CustID: Integer; var serverDate: TDateTime): Boolean;


implementation

uses
  SysUtils, Classes, XSBuiltIns, DateUtils,
  UGlobals, ULicUser, UUtil3, UStatus, UWebUtils, UWebConfig, RegistrationService;

const
  defaultInt = 0;
  dateFormat = 'mm/dd/yyyy';


  
function GetUserHasValidSubscription(CustID: Integer; var serverDate: TDateTime): Boolean;
var
  xsUpdDate: TXSDateTime;
  resCode: Integer;
begin
  result := false;
  try
    xsUpdDate :=  TXSDateTime.Create;
    try
      if custID = defaultInt then  //this should never show, since only valid licenses are checked
        raise Exception.Create('You need to register ClickFORMS before you can use it.');

      with GetRegistrationServiceSoap(True,GetURLForServiceReg) do
        IsClickFormSubscriptionValid(CustID, WSServiceReg_Password, resCode, xsUpdDate);

      serverDate := xsUpdDate.AsDateTime;     //our real date
      result := (resCode = 1);                //they are on subscription
    finally
      xsUpdDate.Free;
    end;
  except
    on E:Exception do
      begin
        ShowNotice(E.Message);
      end;
  end;
end;

end.
