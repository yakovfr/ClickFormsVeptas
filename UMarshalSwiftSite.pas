unit UMarshalSwiftSite;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 2008 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Menus, ComCtrls, OleCtrls, Buttons, ToolWin, Isp3,
  ActnList, ImgList, UGlobals, SHDocVw, MSHTML, SHDocVw_TLB,
  UMarshalSwiftMgr, UForms;

type
  TMarshalSwiftSite = class(TAdvancedForm)
    WebBrowser1: TWebBrowser;
    procedure WebBrowser1DocumentComplete(ASender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FHomeURL: string;
    FManager: TSwiftEstimator;
    procedure FindAddress;
    function ReadEventCodeOnForm(Document: IHTMLDocument2): string;
    function CheckEventCode:String;
    function GetResultXML(Document: IHTMLDocument2): string;
    //procedure CheckServiceExpiration;
  public
    property HomeURL: string read FHomeURL write FHomeURL;
    property Manager: TSwiftEstimator read FManager write FManager;
  end;

//  procedure LaunchMarshalSwiftSite(sToken: string);

var
  MarshalSwiftSite: TMarshalSwiftSite;

implementation

{$R *.dfm}


uses
  UWebUtils, UStatus, uServices, UCustomerServices;// UServiceManager;


{TMarshalSwiftSite}

procedure TMarshalSwiftSite.FormShow(Sender: TObject);
begin
  FindAddress;
end;

procedure TMarshalSwiftSite.FindAddress;
var
  Flags: OLEVariant;
begin
  Flags := 0;
  WebBrowser1.Navigate(WideString(FHomeURL), Flags, Flags, Flags, Flags);
end;

procedure TMarshalSwiftSite.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Manager.ProcessResults;
  Manager.ShowHowToRedoEstimate;    //tell user how to redo this estimate
  Manager.Free;                     //free the manager

  //CheckServiceExpiration;           //check units expiration

  CheckServiceAvailable(stMarshalAndSwift);

  Action := caFree;
end;

{procedure TMarshalSwiftSite.CheckServiceExpiration;
begin
  UServiceManager.CheckServiceExpiration(stMarshalAndSwift);
end;  }

//extracts the XML from the result HTML page
function TMarshalSwiftSite.GetResultXML(Document: IHTMLDocument2): string;
var
  eleElement: IHTMLElement;
  docAll: IHTMLElementCollection;
  i: Integer;
begin
  if not Assigned(Document) then
    Exit;
  docAll := Document.all;
  if not Assigned(docAll) then
    Exit;

  for i:=0 to docAll.length - 1 do
    begin
      eleElement := docAll.Item(i, '') as IHTMLElement;
      if (eleElement.tagName = 'xml')then
      begin
        result := eleElement.innerHTML;
        break;
      end;
    end;
end;

//checks the event code in the HTML source
function TMarshalSwiftSite.CheckEventCode(): String;
var
  MainDoc, DocumentInFrame: IHTMLDocument2;
  FrameName: OleVariant;
  i:integer;
  docAll: IHTMLElementCollection;
  topElement: IHTMLElement;
  resStr: string;
begin
  MainDoc := WebBrowser1.Document as IHTMLDocument2; //get the HTML Doc
  if not Assigned(MainDoc) then exit;

  if MainDoc.all.length > 0 then
  begin
    docAll := MainDoc.all;
    for i:=0 to docAll.length - 1 do  //loop through all the top level elements
    begin
      topElement := docAll.Item(i, '') as IHTMLElement;
      if CompareText(topelement.tagName,'FRAME')= 0 then   //if its a frame
      begin
        if length(topElement.id) > 0 then
        begin
          FrameName := topElement.id;
          DocumentInFrame := (IDispatch(MainDoc.Get_frames.item(FrameName)) as IHTMLWindow2).document;

          resStr := ReadEventCodeOnForm(DocumentInFrame); //loop through the frame to find the event code
          if length(resStr) > 0 then
          begin
            result := resStr;
            break;
          end;
        end;
      end;
    end;
  end;
end;

//read the event code in a frame
function TMarshalSwiftSite.ReadEventCodeOnForm(Document: IHTMLDocument2): string;
var
  topElement, formElement: IHTMLElement;
  docAll,childAll: IHTMLElementCollection;
  i,j : Integer;
begin
  if not Assigned(Document) then Exit;

  docAll := Document.all;
  if not Assigned(docAll) then Exit;

  for i:=0 to docAll.length - 1 do
  begin
    topElement := docAll.Item(i, '') as IHTMLElement;
    if CompareText(topElement.tagName,'Form') = 0 then
    begin
      childAll := topElement.children as IHTMLElementCollection;
      for j:=0 to childAll.length -1 do
      begin
        formElement := childAll.Item(j, '') as IHTMLElement;
        if CompareText(formElement.id, 'eventCode')=0 then
        begin
          Result := formElement.getAttribute('value',0);
          if Length(Result)>0 then break;
        end;
      end;
    end;
    if Length(Result)>0 then break;
  end;
end;

procedure TMarshalSwiftSite.WebBrowser1DocumentComplete(ASender: TObject;
          const pDisp: IDispatch; var URL: OleVariant);
var
  sEC, sRetXml: string;
begin
  {
  Charge - indicates that a calculation was charged to view this page
  Free - indicated a calculation happened to view this page, but it was free
  Fail - indicated a calculation happened to view this page, but it failed
  None - appears on the reports page to indicate no calculation happened for this view
  SessionError - indicates that there was some error retriveing the user's session. This should most often indicate that the session cookie has not been set.
  SessionTimedOut - indicates that the user's session has timed out
  SessionLoggedOut - indicates an attempt to view a page for a session that has already been logged out of.
  }
  try
    sEC := CheckEventCode;   //what happened?
  except
    sec := '';
  end;
  if Length(sEC) > 0 then
    begin
      //need to check where we are getting these message, right now i have not seen
      // the charge or free message. // should appear on the transfer page
      if CompareText(sEC, 'Charge') = 0 then
        begin
          Manager.ChargeUsage := True;
        end
      else if CompareText(sEC, 'Free') = 0  then
        begin
          Manager.ResultXML :=  sRetXML;
        end
      else if CompareText(sEC, 'Fail') = 0  then
        begin
          Manager.ErrorMsg := 'ClickFORMS received a failure notification from the Marshall & Swift site.';
          Close;
        end
      else if CompareText(sEC, 'None') = 0  then
        begin
          //do nothing
        end
      else if CompareText(sEC, 'SessionError') = 0  then
        begin
          Manager.ErrorMsg := 'ClickFORMS received a Session Error message from Marshall & Swift site.';
          Close;
        end
      else if CompareText(sEC, 'SessionTimeOut') = 0  then
        begin
          Manager.ErrorMsg := 'ClickFORMS received a Session Error message from Marshall & Swift site.';
          Close;
        end
      else if CompareText(sEC, 'SessionLoggedOut') = 0  then
        begin
          Manager.ErrorMsg := 'ClickFORMS received a Session Logged Out message from Marshall & Swift site.';
          Close;
        end;
    end
  else
    begin
      //check the xml
      sRetXml := GetResultXML(WebBrowser1.Document as IHTMLDocument2);
      if length(sRetXml)>0 then
        begin
          Manager.ResultXML :=  sRetXML;
          Close;
        end;
    end;
end;

end.
