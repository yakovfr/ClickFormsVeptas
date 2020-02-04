unit UFileRelsMLSImport;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

//###PROBABLY REMOVE - ITS A SERVICE FOR MLS DATA FROM RELS
// ITS ACCESSED FROM USERVICES

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UContainer, DB, DBClient, Grids, DBGrids, xmldom,
  XMLIntf, msxmldom, XMLDoc, MSXML6_TLB, Buttons, ExtCtrls,ActiveX,
  UAMC_RELSOrder,UAMC_RELSLogin, ComCtrls, Mask, AviPlay,
  UAMC_XMLUtils, uMISMOImportExport,UMISMOInterface,uCraftXML,ControlWorkingIndicator,
  UTaskThread,UProcessingForm, RzLabel,UGridMgr,UForms;

  
type
  TRelsMLSDataImport = class(TAdvancedForm)
    btnButtClose: TButton;
    Edit_RelsOrderNum: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit_AppID: TEdit;
    Label3: TLabel;
    Edit_AppPsw: TEdit;
    OpenDialog2: TOpenDialog;
    BtnConnect: TBitBtn;
    SaveDialog: TSaveDialog;
    Image1: TImage;
    CheckBox: TCheckBox;
    PanelStatus: TPanel;
    Label4: TLabel;
    Edit_UserId: TEdit;
    procedure BtnConnectClick(Sender: TObject);
    procedure btnButtCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FRELSOrder: RELSOrderInfo;
  public
    { Public declarations }
    procedure SaveDAAXMLDataCopy(XMLData: String);
    procedure GetDAAXMLData(const Thread: TTaskThread; const Data: Pointer);
    procedure ImportDAATaskTerminated(const ErrorCode: Integer; const Message: String);
    procedure ImportCompsToTable;
    Procedure AddXCompsFormToDoc( NComps : integer);
    function  GetFileName(const fileName, filePath: String): String;
    function  VerifyUserName:Boolean;
    function  GetNumComps( XML : IXMLDomDocument2) : Integer;
  end;

TComparableType = (ctSales, ctRentals, ctListings);

procedure ImportFromRelsMLSTextFile(doc: TContainer);
function CanUseRelsService: Boolean;


var
  RelsMLSDataImport: TRelsMLSDataImport;
  UserInfo     : RELSUserUID;
  OrderId      : Integer;
  ErrCode      : Integer;
  ErrKind      : String;
  ErrMsg       : String;
  xmlDoc       : IXMLDomDocument2;
  xmlFile      : TXMLCollection;
  XmlData      : String;
  strm         : TFileStream;
  mapStr       : String;
  Doc          : TContainer;
  ProgressForm : TProcessingForm;


implementation

{$R *.dfm}
uses
  UGlobals,UUtil1, UMain, UAMC_RELSPort,UStatus, UMyClickForms,
  UFileUtils,UBase64,UBase,UForm,UEditor,UInsertPDF,UWindowsInfo,UStrings,
  UPage,UPgView,DateUtils,ULicUser,UStatusService, uServices, uCustomerServices;



Const
xmlPDF_Path         = '//VALUATION_RESPONSE/REPORT/EMBEDDED_FILE/DOCUMENT'; // not use for now.
XMLData_Adress      = '//VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE[@PropertySequenceIdentifier=&dq;0&dq;]/LOCATION/@PropertyStreetAddress';
ConnectDaa          = 'Retrieving DAA MLS Data Set... ';
BeginLoad           = 'Please wait while the data is being loaded...';
EndLoad             = 'Data loaded Successfully.';
excepErr            = 'An unexpected error has occurred.';
ImportErr           = 'DAA ImportToTable error has occurred.';
CheckNumberXComps   = 'Checking number of comparables ... ';
OrderIdAlert        = 'Please enter the Order ID.';
VendorIdAlert       = 'Please enter your User ID.';
PassWordAlert       = 'Please enter your User Password.';
InvalidXML          = 'Invalid XML Source file.';
SysException        = 'Connection with the WebService has Failed. Please try again.';



//this is the routine to launch the Rels Import Text/Data function
procedure ImportFromRelsMLSTextFile(doc: TContainer);
var
  RelsImportData: TRelsMLSDataImport;
begin
  if CanUseRelsService then
    begin
      RelsImportData := TRelsMLSDataImport.Create(doc);
      try
        RelsImportData.ShowModal;
      finally
        RelsImportData.Free;
      end;
    end;
end;

function CanUseRelsService: Boolean;
begin
  Result := CurrentUser.OK2UseCustDBOrAWProduct(pidRELSConnection, True);
end;

function TRelsMLSDataImport.VerifyUserName:Boolean;
begin
 result := True;
  if OrderId <= 0 then
   begin
    ShowAlert(atWarnAlert, OrderIdAlert );
    result := False;
   end;
  if UserInfo.VendorID = '' then
   begin
    ShowAlert(atWarnAlert, VendorIdAlert );
    result := False;
   end;
  if UserInfo.UserPSW = '' then
   begin
    ShowAlert(atWarnAlert, PassWordAlert );
    result := False;
   end;
end;

function TRelsMLSDataImport.GetFileName(const fileName, filePath: String): String;
var
  Dir: String;
begin
  result   := '';
  Dir := MyFolderPrefs.MyClickFormsDir;
  SaveDialog.InitialDir  := VerifyInitialDir(filePath, Dir);
  SaveDialog.FileName    := fileName;
  SaveDialog.DefaultExt  := 'xml';
  SaveDialog.Filter      := 'MISMO XML (*.xml)|*.xml';
  SaveDialog.FilterIndex := 1;
  if SaveDialog.Execute then result := SaveDialog.Filename;
end;

procedure TRelsMLSDataImport.SaveDAAXMLDataCopy(XMLData: String);
var
  fileName, filePath: String;
  size: Integer;
  fileStream: TFileStream;
begin
   fileName := 'DAA_XML_Copy.xml';
   filePath := GetFileName(fileName, appPref_DirLastMISMOSave);
  if fileExists(filePath) then
    DeleteFile(filePath);
  if CreateNewFile(filePath, fileStream) then
    try
      size := length(XMLData);
      fileStream.WriteBuffer(Pointer(XMLData)^, size);
    finally
      fileStream.free;
    end;
end;

procedure TRelsMLSDataImport.ImportDAaTaskTerminated(const ErrorCode: Integer; const Message: String);
begin
  case ErrorCode of
      E_FAIL:
            begin
              if (ErrMsg='Timeout Expired')then
                ShowNotice(SysException) // us
              else
                ShowNotice(ErrMsg);      // Rels
            end;
      E_ABORT:
            XmlData := 'Abort';
  end;
end;

procedure TRelsMLSDataImport.GetDAAXMLData(const Thread: TTaskThread; const Data: Pointer);
begin
 try
  ProgressForm.lblProcessing.Caption := ConnectDaa;
  XmlData := RELSGetDAA(OrderId, UserInfo, ErrCode, ErrKind, ErrMsg);
 except
  ErrMsg  := excepErr;
 end;
end;

function TRelsMLSDataImport.GetNumComps( XML : IXMLDomDocument2) : Integer;
var
 Num    : Integer;
 Value  : String;
begin
 Num := 0;
 Value := 'start';
 try
   while Value <> '' do
    begin
      Value := Xml.SelectSingleNode('//VALUATION_RESPONSE/VALUATION_METHODS/SALES_COMPARISON/COMPARABLE_SALE[@PropertySequenceIdentifier='+inttostr(Num)+']/LOCATION/@PropertyStreetAddress').Text;
      if Value <> '' then
        Num   := Num + 1;
    end;
  except
  end;
  result := Num -1;
end;

Procedure TRelsMLSDataImport.AddXCompsFormToDoc( NComps : integer);
var
 FormUID    : TFormUID;
 F,i,k,idF  : Integer;
 QuantComps : Integer;
 Add,rest   : Integer;

   const                   {FNMA     1004, 1025, 1073, 1075, 2000, 2000a, 2055, 2090, 2095, 1004c}
     Forms: array[0..9] of Integer = (340, 349,  345,  347,  357,  360,   355,  351,  353,  342);
     Comps: array[0..9] of Integer = (363, 364,  367,  367,  363,  364,   363,  366,  366,  365);
 
   function chekHasXComps(Index : Integer) : integer;
   var
    j : integer;
  
   begin

     Result := 0;
      for j := 0 to  doc.docForm.count-1 do
       begin
         if Comps[Index] = doc.docForm[j].frmInfo.fFormUID then
          begin
           result := result + 1;
          end;
       end;
   end;

begin

   for f := 0 to doc.docForm.count-1 do
    begin
     idF := doc.docForm[f].frmInfo.fFormUID;
      for i := 0 to 9 do // Looking for 10 FNMA Forms.
       begin
         if idF = Forms[i] then
          begin
           Try
            QuantComps   := chekHasXComps(i);//if has comps return the quant.
            FormUID      := TFormUID.Create;
            FormUID.ID   := Comps[i];
            FormUID.Vers := 2;
            if QuantComps = 0 then
             begin
              Add  := (NComps div 3);
              rest := (NComps mod 3);
              if rest = 0 then Add := Add-1;
              for k  := 1 to Add do
               begin
                Doc.InsertFormUID(FormUID, True,-1); //Add as last
               end;
             end
            else
             begin
              Add  := (NComps div 3)-QuantComps;
              rest := (NComps mod 3);
              if rest = 0 then Add := Add -1;
              for k  := 1 to Add do
               begin
                Doc.InsertFormUID(FormUID, True,-1); // Add as last
               end;
             end;
           Finally
            FreeAndNil(FormUID);
           end;
          end;

       end;
    end;
end;

procedure TRelsMLSDataImport.ImportCompsToTable;
begin

 if XmlData = 'Abort' then exit;

 if XmlData = '' then
   begin
     PanelStatus.Caption  := ErrKind;
     btnButtClose.Enabled := true;
     ShowNotice(ErrMsg);
     exit;
   end
 else
  begin
    //SaveDAAXMLDataCopy(XmlData); //Test Only
    xmldoc := CoDomDocument.Create;
    xmldoc.async := false;
    xmldoc.setProperty('SelectionLanguage','XPath');
    xmldoc.loadXML(XmlData);
    if xmlDoc.parseError.errorCode <> 0 then
      begin
       PanelStatus.Caption := InvalidXML;
       ErrMsg := InvalidXML;
       raise Exception.Create(ErrMsg);
       exit;
      end;
   try
    try
     Application.ProcessMessages;
     SetupMISMO;
     PanelStatus.Caption  := CheckNumberXComps;
     PanelStatus.Refresh;
     AddXCompsFormToDoc(GetNumComps(xmlDoc)); // if nedds add new Xcomps
     xmlFile := TXMLCollection.Create;
     PushMouseCursor(crHourglass);
     PanelStatus.Caption  := BeginLoad;
     PanelStatus.Refresh;
     XMLFile.CreateFrom(xmldata);
     Application.ProcessMessages;
     AddXMLDataToDocument(DOC,xmlFile,True); // if False = Comps Only , True = Comps and Subject.
    except
       on E : Exception do
          begin
           PopMouseCursor;
           PanelStatus.Caption := excepErr;
           ShowAlert(atStopAlert, E.Message);
           xmlFile.Free;
           ErrMsg := excepErr;
           exit;
          end;
    end;
   finally
    Self.BringToFront;
    PopMouseCursor;
    xmlFile.Free;
    PanelStatus.Caption  := EndLoad;
    PanelStatus.Refresh;
    btnButtClose.Enabled := true;
    ErrMsg := 'Sucess';
   end;
  end;
end;

procedure TRelsMLSDataImport.BtnConnectClick(Sender: TObject);
begin

 if CheckBox.Checked then appPref_RelsOverwriteImport := True
 else appPref_RelsOverwriteImport := False;

    OrderId                  := strtointDef(Edit_RelsOrderNum.Text,0);
    UserInfo.VendorID        := Edit_AppID.Text;
    UserInfo.UserId          := Edit_UserId.Text;
    UserInfo.UserPSW         := Edit_AppPsw.Text;
    if VerifyUserName then
     begin
      try
       try
         btnButtClose.Enabled     := false;
         btnConnect.Enabled       := false;
         PanelStatus.Caption      := '';
         ProgressForm := TProcessingForm.Create(Self);
         ProgressForm.OnTaskTerminate := ImportDAATaskTerminated;
         ProgressForm.btnCancel.Visible := false;
         ProgressForm.RunTask(GetDAAXMLData,ProgressForm);
         ImportCompsToTable;
       finally
         FreeAndNil(ProgressForm);
         if ErrMsg = 'Sucess' then
          begin
           BtnConnect.Enabled    := False;
           btnButtClose.Enabled  := True;
           BtnConnect.Visible    := False;
           btnButtClose.Caption  := 'Finish';
           btnButtClose.Hint     := 'Click here to Close';
           btnButtClose.SetFocus;
           Doc.Repaint;
          end
         else
          begin
           btnButtClose.Enabled := True;
           btnConnect.Enabled   := True;
          end;
       end;
      except on E:Exception do
        ShowAlert(atWarnAlert, errOnRelsMLSImport+' | '+E.Message);
      end;
     end;

end;

procedure TRelsMLSDataImport.btnButtCloseClick(Sender: TObject);
begin
 close;
end;

procedure TRelsMLSDataImport.FormCreate(Sender: TObject);
begin
 Doc := Main.ActiveContainer;

 if appPref_RelsOverwriteImport then
  CheckBox.Checked := True
 else
  CheckBox.Checked := False;

 FRELSOrder := ReadRELSOrderInfoFromReport(Doc);
 With FRELSOrder do
  begin
   if OrderID <> 0 then
     begin
      Edit_RelsOrderNum.Text := IntToStr(OrderID);
     end
   else
     begin
      Edit_RelsOrderNum.Text :='';
     end;
  end;
end;

procedure TRelsMLSDataImport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if CheckBox.Checked then appPref_RelsOverwriteImport := True
  else appPref_RelsOverwriteImport := False;
  CheckServiceAvailable(stRels);
end;

end.

