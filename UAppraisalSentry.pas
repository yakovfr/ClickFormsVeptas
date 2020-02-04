{////////////////////////////////////////////////////////////////////////////////
VERY IMPORTANT: Do not delete this comment section
-- Vivek 07/30/2007 ---
 When you update AppraisalSentryService.pas, please make sure this line is added
 as the third line of the initialization section in the newly generated
 AppraisalSentryService.pas file. This new service is written in .NET 2.0 and
 without this line it will not work in Delphi 7.

 InvRegistry.RegisterInvokeOptions(TypeInfo(AppraisalSentryServiceSoap), ioDocument); //Dr Bobs solution

////////////////////////////////////////////////////////////////////////////////}
unit UAppraisalSentry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls,  ExtCtrls,
  Buttons, XSBuiltIns, Types, Math,
  UContainer, UForm, AppraisalSentryService, UForms;

type
  TAppraisalSentry = class(TAdvancedForm)
    EditUserName: TEdit;
    Label1: TLabel;
    ButtonProtect: TButton;
    Label2: TLabel;
    EditPassword: TEdit;
    ButtonCancel: TButton;
    Bevel1: TBevel;
    Image1: TImage;
    SaveDialog1: TSaveDialog;
    Image2: TImage;
    Label3: TLabel;
    procedure ButtonProtectClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
  private
    FDoc: TContainer;
    //FSentryForm: TDocForm;
    //TotalSize, TotalRead : DWORD;


    //objects to hold barcode data
    FASData: ASDataRec;
    FPropertyInfo: PropertyInfo;
    FIdentityInfo: IdentityInfo;

    //FMatrixPath: String;
    FPDFPath: String;      //this is file to register
    procedure GetAppraisalData;
    procedure GetAppraiserData;
    procedure CreatePDF;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  AppraisalSentry: TAppraisalSentry;

  procedure AppraisalSentryRegistration(doc: TContainer);

implementation

{$R *.dfm}

Uses
  UGlobals, UBase, UUtil1, UStatus, UGridMgr, UCell,UEditor, UWebConfig;


const
  MatrixFolder    = 'AppraisalSentry';
  BlankMatrixBMP  = 'OrigDataMatrix.bmp';
  DataMatrixBMP   = 'DataMatrix.bmp';
  SentryFormID    = 743;

procedure AppraisalSentryRegistration(doc: TContainer);
var
  Sentry: TAppraisalSentry;
begin
  Sentry := TAppraisalSentry.Create(doc);
  try
    Sentry.ShowModal;
  finally
    Sentry.Free;
  end;
end;

//to do: these two function are defined somewhere in MapPoint code need to be
//moved to a common place
procedure ByteArrayToFIle(    const ByteArray : TByteDynArray;
const FileName : string );
var Count : integer;
 F : FIle of Byte;
 pTemp : Pointer;
begin
 AssignFile( F, FileName );
 Rewrite(F);
 try
  Count := Length( ByteArray );
  pTemp := @ByteArray[0];
  BlockWrite(F, pTemp^, Count );
 finally
  CloseFile( F );
 end;
end;

function FIleToByteArray( const FileName : string ) : TByteDynArray;
const BLOCK_SIZE=1024;
var BytesRead, BytesToWrite, Count : integer;
 F : FIle of Byte;
 pTemp : Pointer;
begin
 AssignFile( F, FileName );
 FileMode := fmOpenRead;
 Reset(F);
try
 Count := FileSize( F );
 SetLength(Result, Count );
 pTemp := @Result[0];
 BytesRead := BLOCK_SIZE;
 while (BytesRead = BLOCK_SIZE ) do
 begin
  BytesToWrite := Min(Count, BLOCK_SIZE);
  BlockRead(F, pTemp^, BytesToWrite , BytesRead );
   pTemp := Pointer(LongInt(pTemp) + BLOCK_SIZE);
  Count := Count-BytesRead;
 end;
finally
  CloseFile( F );
 end;
end;

constructor TAppraisalSentry.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FDoc := TContainer(AOwner);

  //create the barcode objects
  FASData := ASDataRec.Create;
  FPropertyInfo := PropertyInfo.Create;
  FIdentityInfo := IdentityInfo.Create;
end;

destructor TAppraisalSentry.Destroy;
begin

  //distroy barcode objects
  //FPropertyInfo.Free;
  //FIdentityInfo.Free;
  FASData.Free;

  inherited;
end;

procedure TAppraisalSentry.ButtonProtectClick(Sender: TObject);
var
  sToken, sMsg, sNewFile: widestring;
  OverageFee: TXsDecimal;
  UploadReportBytes, UploadLicBytes: TByteDynArray;
  DownloadBytes : TByteDynArray;
begin
    try

      if (Length(EditUserName.Text) = 0) or  (Length(EditPassword.Text) = 0) then
      begin
       ShowAlert(atInfoAlert, 'Please enter your User Name and Password.');
       Exit;
      end;

      Image2.Visible := True;
      Label1.Visible := True;
      Label1.Caption := 'Gathering Report Data...';
      Application.ProcessMessages;

      //build barcode objects and pdf file
      GetAppraisalData;
      GetAppraiserData;
      CreatePDF;

      Label1.Caption := 'Finished Gathering Report Data...';
      Application.ProcessMessages;


      //now register the report to AppraisalSentry
      if (Length(FPDFPath) = 0) then
      begin
       ShowAlert(atInfoAlert, 'ClickFORMS cannot access the PDF file to register.');
       Exit;
      end;
      //call the AppraisalSentry service now
      with GetAppraisalSentryServiceSoap(true,'',nil) do
      begin

        Label1.Caption := 'Requesting Security Token...';
        Application.ProcessMessages;

        //get the security token and find out if any overage will be applied to the next call.
        GetSecurityToken(EditUserName.Text, EditPassword.Text, sToken, OverageFee, sMsg);
        if (CompareText(sMsg, 'Success') = 0) then
        begin

          //if overage applies to the next registration call then verify with user if its ok
          //if (Decimal(OverageFee) > 0) then
          //begin
            //show appropriate message here and verify, exit if user doesnt want to get charged for overage
          //end;

          UploadReportBytes := FileToByteArray(FPDFPath);
          UploadLicBytes := FileToByteArray(IncludeTrailingPathDelimiter(appPref_DirPref) + 'AppraisalSentry.lic');

          //procedure RegisterReport(const ipSecurityToken: WideString; const ipUserName: WideString; const ipPassword: WideString; const strFileName: WideString; const ipReportFile: TByteDynArray; const ASData: ASDataRec; out RegisterReportResult: TByteDynArray; out opMessage: WideString); stdcall;
          sMsg := '';

          Label1.Caption := 'Registering Report..';
          Application.ProcessMessages;

          RegisterReport(sToken,EditUserName.Text, EditPassword.Text, ExtractFileName(FPDFPath), UploadReportBytes, UploadLicBytes, FASData, DownloadBytes, sMsg);
          if (CompareText(sMsg, 'Success') = 0)  then
          begin
            Label1.Caption := 'Finished Registering Report..';
            Application.ProcessMessages;

            Label1.Caption := 'Saving Report Locally..';
            Application.ProcessMessages;

            sNewFile :=  ExtractFilePath(FPDFPath) + 'New_'+ ExtractFileName(FPDFPath);

            if FileExists(sNewFile) then DeleteFile(sNewFile);

            ByteArrayToFile(DownloadBytes,sNewFile);
            ShowAlert(atInfoAlert, 'Your appraisal report was successfully registered on AppraisalSentry.');
          end;

        end;
      end;


    except
      ShowAlert(atWarnAlert, 'Problems were encountered attempting to secure your appraisal report.');
    end;
    Close;
end;

procedure TAppraisalSentry.GetAppraisalData;
var
  TR,BR,BA: String;
  GridMgr: TGridMgr;
begin
  FPropertyInfo.Address := FDoc.GetCellTextByID(46);
  FPropertyInfo.City := FDoc.GetCellTextByID(47);
  FPropertyInfo.State := FDoc.GetCellTextByID(48);
  FPropertyInfo.Zip := FDoc.GetCellTextByID(49);

  GridMgr := TGridMgr.Create;
  try
    GridMgr.BuildGrid(FDoc, gtSales);

    TR := GridMgr.Comp[0].GetCellTextbyID(1041);
    BR := GridMgr.Comp[0].GetCellTextbyID(1042);
    BA := GridMgr.Comp[0].GetCellTextbyID(1043);
    FPropertyInfo.TotalBedBathRooms := TR +'/'+ BR + '/' + BA;

    FPropertyInfo.EffectiveAppraisalDate := FDoc.GetCellTextByID(1132);
    FPropertyInfo.EstimatedMarketValue := '$' + FDoc.GetCellTextByID(1131);
    FPropertyInfo.GrossLivingArea := GridMgr.Comp[0].GetCellTextbyID(1004);
    FPropertyInfo.BorrowerName := '';
    FPropertyInfo.LenderName := FDoc.GetCellTextByID(35);
    FPropertyInfo.ReportPages := IntToStr(FDoc.docForm.count);
    FPropertyInfo.ReportSignedOn := FDoc.GetCellTextByID(5);
  finally
    GridMgr.Free;
  end;
  FASData.PropertyFacts := FPropertyInfo;
end;

procedure TAppraisalSentry.GetAppraiserData;
begin
  FIdentityInfo.AppraiserName := FDoc.GetCellTextByID(7);
  FIdentityInfo.CompanyName := FDoc.GetCellTextByID(8);
  FIdentityInfo.Address := FDoc.GetCellTextByID(9);
  FIdentityInfo.City := FDoc.GetCellTextByID(41);
  FIdentityInfo.State := '';
  FIdentityInfo.Zip := '';
  FIdentityInfo.AppraiserLicNo := FDoc.GetCellTextByID(20) + ' | '+ FDoc.GetCellTextByID(18);
  FIdentityInfo.LicCertExpirationDate := FDoc.GetCellTextByID(17);
  FIdentityInfo.LicCertIssuingState := FDoc.GetCellTextByID(2098);

  FASData.AppraiserIdentity := FIdentityInfo;
end;


procedure TAppraisalSentry.CreatePDF;
begin
  FPDFPath := FDoc.CreateReportPDF(2);
end;

procedure TAppraisalSentry.ButtonCancelClick(Sender: TObject);
begin
  Close;
end;

end.
