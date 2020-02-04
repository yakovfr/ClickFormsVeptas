unit UAMC_CheckUAD_SAXWrapper;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc. }

interface

uses
  classes, MSXML6_TLB, ComCtrls, StdCtrls, Gauges,osAdvDbGrid;

type
  // primary handler
  TXMLSaxHandler = class (TInterfacedObject, IVBSAXContentHandler)
  protected
  public
    constructor Create(UILog: TosAdvDbGrid; UIGauge: TGauge; FormTypeStr: String);
    destructor Destroy; override;
  private
    XPath: TStringList; // Element Stack
    Gauge: TGauge;
    Log: TosAdvDbGrid;
    ProgressCounter: Word;
    FormType: String;

    // IDispatch
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;

    // IVBSAXContentHandler
    procedure _Set_documentLocator(const Param1: IVBSAXLocator); virtual; safecall;
    procedure startDocument; safecall;
    procedure endDocument; safecall;
    procedure startPrefixMapping(var strPrefix: WideString; var strURI: WideString); virtual; safecall;
    procedure endPrefixMapping(var strPrefix: WideString); virtual; safecall;
    procedure startElement(var strNamespaceURI: WideString; var strLocalName: WideString;
                           var strQName: WideString; const oAttributes: IVBSAXAttributes);  safecall;
    procedure endElement(var strNamespaceURI: WideString; var strLocalName: WideString;
                         var strQName: WideString);  safecall;
    procedure characters(var strChars: WideString); virtual; safecall;
    procedure ignorableWhitespace(var strChars: WideString); virtual; safecall;
    procedure processingInstruction(var strTarget: WideString; var strData: WideString); virtual; safecall;
    procedure skippedEntity(var strName: WideString); virtual; safecall;
  end;

  // primary error handler
  TXMLSaxErrorHandler = class (TInterfacedObject, IVBSAXErrorHandler)
  public
    constructor Create(UILog: TLabel);
    destructor Destroy; override;
  private
    Log:  TLabel;

    // IDispatch
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;

    // IVBSAXErrorHandler
    procedure error(const oLocator: IVBSAXLocator; var strErrorMessage: WideString;
                    nErrorCode: Integer); safecall;
    procedure fatalError(const oLocator: IVBSAXLocator; var strErrorMessage: WideString;
                         nErrorCode: Integer); safecall;
    procedure ignorableWarning(const oLocator: IVBSAXLocator; var strErrorMessage: WideString;
                               nErrorCode: Integer); safecall;
  end;



var
  UADReviewCycleNumber: Byte;
  UADReviewErrors: Word;


implementation

uses
  SysUtils, Forms,
  UAMC_CheckUAD_Rules;



constructor TXMLSaxErrorHandler.Create(UILog: TLabel);
begin
  Log := UILog;
end;

destructor TXMLSaxErrorHandler.Destroy;
begin
  inherited;
end;

function TXMLSaxErrorHandler.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TXMLSaxErrorHandler.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Result := E_NOTIMPL;
end;

function TXMLSaxErrorHandler.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TXMLSaxErrorHandler.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
begin
  Result := E_NOTIMPL;
end;


// Three types of errors

procedure TXMLSaxErrorHandler.error(const oLocator: IVBSAXLocator;
  var strErrorMessage: WideString; nErrorCode: Integer);
begin
    //Log.AddItem(');
    //Log.Add(strErrorMessage + ' at Line:' + InttoStr(oLocator.lineNumber) + '  Column:' + InttoStr(oLocator.columnNumber));
end;

procedure TXMLSaxErrorHandler.fatalError(const oLocator: IVBSAXLocator;
  var strErrorMessage: WideString; nErrorCode: Integer);
begin
 Log.Caption := '';

 Log.Caption := strErrorMessage + #13;
 Log.Caption := Log.Caption + 'Line: ' + InttoStr(oLocator.lineNumber) + '  Column: ' + InttoStr(oLocator.columnNumber) + #13 + #13;

 Log.Caption := Log.Caption + 'Compliance Checking aborted.';
end;

procedure TXMLSaxErrorHandler.ignorableWarning(
  const oLocator: IVBSAXLocator; var strErrorMessage: WideString;
  nErrorCode: Integer);
begin
  //Log.Add(strErrorMessage + ' at Line:' + InttoStr(oLocator.lineNumber) + '  Column:' + InttoStr(oLocator.columnNumber));
end;

//------------------------------------------- XML SAX Event Handler


constructor TXMLSaxHandler.Create(UILog: TosAdvDbGrid; UIGauge: TGauge; FormTypeStr: String);
begin
  Log := UILog;   // connect the memo in user interface
  Gauge := UIGauge;
  FormType := FormTypeStr;

  XPath := TStringList.Create;
end;

destructor TXMLSaxHandler.Destroy;
begin
  XPath.Free;

  inherited;
end;

function TXMLSaxHandler.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TXMLSaxHandler.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Result := E_NOTIMPL;
end;

function TXMLSaxHandler.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TXMLSaxHandler.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
begin
  Result := E_NOTIMPL;
end;

procedure TXMLSaxHandler.processingInstruction(var strTarget,
  strData: WideString);
begin

end;

procedure TXMLSaxHandler._Set_documentLocator(const Param1: IVBSAXLocator);
begin

end;

procedure TXMLSaxHandler.skippedEntity(var strName: WideString);
begin

end;

procedure TXMLSaxHandler.startPrefixMapping(var strPrefix,
  strURI: WideString);
begin

end;

procedure TXMLSaxHandler.endPrefixMapping(var strPrefix: WideString);
begin

end;

procedure TXMLSaxHandler.ignorableWhitespace(var strChars: WideString);
begin

end;





procedure TXMLSaxHandler.startDocument;
begin
  UADReviewErrors := 0;
  XPath.Clear;
  LoadIniFile;
  InitCounters;
  Gauge.MaxValue := ProgressCounter;

  if UADReviewCycleNumber = 1 then
    LoadXpathSchema;
end;

procedure TXMLSaxHandler.endDocument;
begin
  if UADReviewCycleNumber = 2 then
  begin
    ProgressCounter := 0;
    // 060612 Following is disabled until messages can be made human-readable
    //  or an alternate method is implemented.
    // CheckXPathSchema(Log);
  end;


  FreeIniFile;
end;

procedure TXMLSaxHandler.startElement(var strNamespaceURI, strLocalName,
  strQName: WideString; const oAttributes: IVBSAXAttributes);
begin
  XPath.Add(strLocalName);

  if UADReviewCycleNumber = 1 then
    begin
   CollectAttributes(strNameSpaceURI, strLocalName, strQName, oAttributes, Log, XPath, FormType);
     ProgressCounter := ProgressCounter + 1;
    end
  else if UADReviewCycleNumber = 2 then
    begin
      UADReviewErrors := UADReviewErrors + ProcessElement(strNamespaceURI, strLocalName, strQName, oAttributes, Log, XPath);
      Gauge.Progress := Gauge.Progress + 1;
    end;

  Log.Update;
  Application.ProcessMessages;
end;

procedure TXMLSaxHandler.endElement(var strNamespaceURI, strLocalName,
  strQName: WideString);
begin
  if UADReviewCycleNumber = 2 then
    UADReviewErrors := UADReviewErrors + ProcessEndElement(XPath, Log); // processiong it before the XPath stack poping is neccessary

  XPath.Delete(XPath.Count - 1);
end;

procedure TXMLSaxHandler.characters(var strChars: WideString);
begin
 //if Elements[Elements.Count - 1] <> 'DOCUMENT' then
 // Log.Add(strChars);
end;

end.
