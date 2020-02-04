unit UCC_USPostal;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }                                                                    
{  All Rights Reserved                   }
{  Source Code Copyrighted � 1998-2013 by Bradford Technologies, Inc. }


////////////////////////////////////////////////////////////////////////////////
{ How this form works:
  -When this form is created the address information is set before showing this
   form.
  -When the form is shown the getCensusTract() is automatically called, which is
   navigates to the FFIEC website.
  -as soon as the FFIEC webpage downloads TempWebBrowserDownloadComplete() event
   kicks in, iterates throught the DOM to populate all the required address fields
   on the web page. It then clicks submit button and get the result web page...
  -as soon as the FFIEC result page with censustract downloads
   TempWebBrowserDownloadComplete() event fires once more and parses the
   censustract information from the web page, which is stored into FCensusTract.
}
{
08/24/2006:
NOTE: Install MS HTML ActiveX Object, MS Script Control before compiling this project
}
////////////////////////////////////////////////////////////////////////////////


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,ComObj, ComCtrls, OleCtrls, StdCtrls, SHDocVw,
  UContainer, ExtCtrls, MSHTML_TLB, UForms;

type
  TUSPostalService = class(TAdvancedForm)
    Panel1: TPanel;
    TempWebBrowser: TWebBrowser;
    Panel3: TPanel;
    LabelMsg: TLabel;
    btnCancel: TButton;
    btnOK: TButton;
    procedure TempWebBrowserDownloadComplete(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FStreet: String;
    FCity: String;
    FState: String;
    FZip: String;
    FCensusTract: string;
    FSubmitCount : integer;
    FResultCode: integer;
    function PopulateWebForm: boolean;
    function ParseCensusTract: boolean;
    function GetCensusTract: boolean;
    function validateInput: boolean;
  public
    { Public declarations }
    property Street: String read FStreet write FStreet;
    property City: String read FCity write FCity;
    property State: String read FState write FState;
    property Zip: String read FZip write FZip;
    property CensusTract: String read FCensusTract write FCensusTract;
    property ResultCode: Integer read FResultCode write FResultCode;
  end;

var
  USPostalService: TUSPostalService;



implementation


uses
  UGlobals, UWebUtils, UStatus, UStrings;

{$R *.dfm}


const
//New URLS
  FFIEC_URL         = 'http://www.ffiec.gov/geocode/default.aspx';
  FFIEC_RESULT_URL  = 'http://www.ffiec.gov/geocode/Geocodesearch.aspx?';
  strToFind         = '<SPAN id=UcGeoResult11_lbTractCode style="FONT-WEIGHT: bold; COLOR: red; HEIGHT: 14px">';
  strToFind1        ='UcGeoResult11_lbTractCode';
  ecSuccess         = 0;
  ecFail            = -1;




procedure TUSPostalService.FormShow(Sender: TObject);
begin
  if validateInput then
    begin
      FResultCode := ecSuccess;
      if not GetCensusTract then
        begin
          FresultCode := ecFail;
          LabelMsg.Caption := 'Could not connect to Server. Check your internet connection...';
        end;
    end;
end;

procedure TUSPostalService.TempWebBrowserDownloadComplete(Sender: TObject);
var
  s: String;
begin
  try
    s := (TempWebBrowser.Document as IHTMLDocument2).body.innerHTML;
  except
  end;

  if (TempWebBrowser.OleObject.Document.Url = FFIEC_URL) and
     (pos(StrToFind1, s)<1) and (pos(StrToFind, s)<1) then
  begin
//    LabelMsg.Caption := 'Querying Server...';
    if not PopulateWebForm then
      begin
        LabelMsg.Caption := 'Error preparing query...';
      end;
  end;
  if (FSubmitCount>3) or (CompareText( Copy(TempWebBrowser.OleObject.Document.Url,1,Length(FFIEC_RESULT_URL)),  FFIEC_RESULT_URL) = 0) or
     (pos(strtofind,s)>0) or (pos(strtofind1,s)>0) then
    begin
      FSubmitCount := 0;
      LabelMsg.Caption := 'parsing query result...';
      if ParseCensusTract = false then
        begin
          LabelMsg.Caption := 'Address not found...';
        end
      else
        begin
           LabelMsg.Caption := Format('Address: %s, %s, %s %s Verified.',[Street,City,State,Zip]);
///          LabelMsg.Caption := 'Done...';
///          Close;
        end;
    end
  else
    PopulateWebForm;
end;

function TUSPostalService.GetCensusTract: boolean;
var
  Flags: OleVariant;
  TargetFrameName: OleVariant;
  PostData: OleVariant;
begin
  Result := True;
  try
    Flags := 12;
    TargetFrameName := null;
    PostData := null;

//    LabelMsg.Caption := 'Connecting to server...';
//    TempWebBrowser.Navigate (FFIEC_URL, Flags, TargetFrameName, PostData);
    TempWebBrowser.Navigate (FFIEC_URL,Flags);
  except
    Result := False
  end;
end;

function TUSPostalService.PopulateWebForm: boolean;
var
  Document:  variant;
  m,i: Integer;
  ovElements: OleVariant;
begin
  Result := True;
  Document := TempWebBrowser.Document;
//  LabelMsg.Caption := 'Preparing for query...';

  for m := 0 to Document.forms.Length - 1 do
  begin
    ovElements := Document.forms.Item(m).elements;
    // iterate through elements
    for i := 0 to ovElements.Length - 1 do
    begin
      // when input fieldname is found, try to fill out
      try
        if (CompareText(ovElements.item(i).tagName, 'INPUT') = 0) and
          (CompareText(ovElements.item(i).type, 'text') = 0) and
          (CompareText(ovElements.item(i).name, 'txtAddress') = 0)
          then
        begin
          ovElements.item(i).Value := FStreet;
        end;

        if (CompareText(ovElements.item(i).tagName, 'INPUT') = 0) and
          (CompareText(ovElements.item(i).type, 'text') = 0) and
          (CompareText(ovElements.item(i).name, 'txtCity') = 0)
          then
        begin
          ovElements.item(i).Value := FCity;
        end;

        if (CompareText(ovElements.item(i).tagName, 'select') = 0) and
          (CompareText(ovElements.item(i).name, 'ddlbState') = 0)
          then
        begin
          ovElements.item(i).Value := FState;
        end;

        if (CompareText(ovElements.item(i).tagName, 'INPUT') = 0) and
          (CompareText(ovElements.item(i).type, 'text') = 0) and
          (CompareText(ovElements.item(i).name, 'txtZipCode') = 0)
          then
        begin
          ovElements.item(i).Value := FZip;
        end;

      except
        begin
          LabelMsg.Caption := 'Error: There were errors building the query.';
          Result := False;
          exit;
        end;
      end;
      // when Submit button is found, try to click
      try
        if (CompareText(ovElements.item(i).tagName, 'INPUT') = 0) and
          (CompareText(ovElements.item(i).type, 'SUBMIT') = 0) and
          (ovElements.item(i).Value = 'Search') then
        begin
          ovElements.item(i).Click;
          FSubmitCount := FSubmitCount + 1;
        end;
      except
        begin
          LabelMsg.Caption := 'Error: There were errors submitting the query.';
          Result := False;
          exit;
        end;
      end;
    end;
  end;
end;

function TUSPostalService.ParseCensusTract: boolean;
const
  tagToFind = '</SPAN>';
var
  S,T: string;
  P: integer;
  aMsg: String;
begin
  Result := True;
  try
    S := (TempWebBrowser.Document as IHTMLDocument2).body.innerHTML;
    //check if the address was not found
    P := Pos('Address Not Found', S);
    if P > 0 then
    begin
      LabelMsg.Caption := 'Error: Address Not Found...';
      result := True;  //we want to close the dialog here
      ShowAlert(atWarnAlert, 'Address Not Found.  Please check your property address again.');
      exit;
    end;

    P := Pos(strToFind, S); // finds the SPAN with  id=UcGeoResult11_lbTractCode
    if p>0 then
       begin
        T := Copy(S,P+Length(strToFind), Length(S)-P+Length(strToFind)); //copies the string begining after SPAN tag
        P := Pos(tagToFind, uppercase(T)); // finds the </SPAN> tag
        FCensusTract := Copy(T, 0, P-1); //copies everything before </SPAN> tag
       end
       else
       begin
        P := Pos(strToFind1, S);
        s := copy(s,p,length(s));
        p := pos('>',s);
        s := copy(s,p+1,length(s));
        p := pos('<',s);
        s := copy(s,1,p-1);
        FCensusTract := s; //copies everything before </SPAN> tag
        aMsg:=Format('Address is found with Census Tract # = %s',[FCensusTract]);
        LabelMsg.Caption := aMsg;
        //        ShowNotice(aMsg);
       end;
  except
    LabelMsg.Caption := 'Error: There were error parsing the query result';
    result := false;
    exit;
  end;

  //locate the first element with ID attribute = "main" and show its tag

  if Length(FCensusTract) = 0 then
  begin
    LabelMsg.Caption := 'Error: Address not found...';
    Result := False;
  end;
end;

function TUSPostalService.validateInput: boolean;
begin
  Result := True;
  if (Length(FStreet) = 0) or (Length(FCity) = 0) or (Length(FState) = 0) or
     (Length(FState) <> 2) or (Length(FZip) = 0) or (Length(FZip) < 5) then
  begin
    if Length(FStreet) = 0  then
      LabelMsg.Caption := 'Street';

    if Length(FCity) = 0  then
    begin
      if Length(LabelMsg.Caption) > 0 then
        LabelMsg.Caption := LabelMsg.Caption + ', City'
      else
        LabelMsg.Caption := 'City';
    end;

    if (Length(FState) = 0) or (Length(FState) <> 2) then
    begin
      if Length(LabelMsg.Caption) > 0 then
        LabelMsg.Caption := LabelMsg.Caption + ', State'
      else
        LabelMsg.Caption := 'State';
    end;

    if (Length(FZip) = 0) or (Length(FZip) < 5) then
    begin
      if Length(LabelMsg.Caption) > 0 then
        LabelMsg.Caption := LabelMsg.Caption + ', Zip'
      else
        LabelMsg.Caption := 'Zip';
    end;

    if Length(LabelMsg.Caption) > 0 then
    begin
      LabelMsg.Caption := LabelMsg.Caption + ' is incorrect or missing...';
    end
    else
    begin
      LabelMsg.Caption := ' is incorrect or missing...';
    end;
  end
  else
  begin
    //check is zip is 5 digits
    if Length(FZip) > 5 then
    begin
      FZip := Copy(FZip,0,5);
    end;
  end;
end;

end.
