unit UWPDF3;

{  ClickForms Application               }
{  Bradford Technologies, Inc.          }
{  All Rights Reserved                  }
{  Source Code Copyrighted © 1998-2007 by Bradford Technologies, Inc. }

{ This unit is here to allow the PDF preferences to be set silently or to}
{ to display and interface and allow the user to set them.               }
{ FileName - if set, PDF is saved to it. Otherwise use is asked to save. }
{ AutoLaunch - set this if you want the PDF displayed after its created. }
{ PgList - array of pages to PDF. If NIL, BitSet(FPgFlags, bPgInPDFList) is used}
{ ShowPref - True if you want user to see this}
{ This is used in conjunction with doc.CreateReportPDFEx()                }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, Grids_ts, TSGrid, WPPDFR2,
  UGlobals, UForms;

type
  TWPDFConfigEx = class(TAdvancedForm)
    StatusBar1: TStatusBar;
    PageControl: TPageControl;
    general: TTabSheet;
    Advanced: TTabSheet;
    security: TTabSheet;
    PrListGrid: TtsGrid;
    Panel1: TPanel;
    btnCreatePDF: TButton;
    btnCancel: TButton;
    cbxThumbnails: TCheckBox;
    CompressionGroup: TRadioGroup;
    cbxEncrypt: TCheckBox;
    FontEmbedGroup: TRadioGroup;
    cbxBookmarks: TCheckBox;
    LabelViewPSW: TLabel;
    edtUserPSW: TEdit;
    cbxViewOnly: TCheckBox;
    cbxAllowPrint: TCheckBox;
    cbxAllowCopy: TCheckBox;
    cbxAllowChange: TCheckBox;
    LabelNotReqed: TLabel;
    PDFSaveDialog: TSaveDialog;
    edtAuthor: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    edtSubject: TEdit;
    cbxLaunchPDF: TCheckBox;
    procedure btnCreatePDFClick(Sender: TObject);
    procedure cbxEncryptClick(Sender: TObject);
    procedure cbxViewOnlyClick(Sender: TObject);
    procedure cbxNotViewOnlyClick(Sender: TObject);
    procedure PrListGridClickCell(Sender: TObject; DataColDown,
      DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
      UpPos: TtsClickPosition);
  private
    FDoc: TComponent;
    FPDFExport: TWPPDFPrinter;
    FShowAdvanced: Boolean;
    FOptions: Integer;
    FPgSettingChanged: Boolean;
    FPgList: BooleanArray;
    FPDFName: String;
    FAutoLaunch: Boolean;
    procedure SetPDFName(const Value: String);
    procedure SetShowAdvanced(value: Boolean);
    procedure SetAutoLaunch(const Value: Boolean);
    procedure SetConfiguration;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetOptions(Value: Integer);
    procedure GetConfiguration;
    procedure AssignPgList(APagelist: BooleanArray);
    property PgList: BooleanArray read FPgList write FPgList;
    property AutoLaunch: Boolean read FAutoLaunch write SetAutoLaunch;
    property FileName: String read FPDFName write SetPDFName;
    property ShowAdvanced: Boolean read FShowAdvanced write SetShowAdvanced;
    property Options: Integer read FOptions write SetOptions;
  end;

var
  WPDFConfigEx: TWPDFConfigEx;



implementation

uses
  DateUtils,
  UContainer, UUtil1, UStatus,ULicUser,
  WPPDFR1;

const
  bAutoLaunch = 1;      //options for presetting the PDF Dialog

{$R *.DFM}

{ TWPDFProperty }

constructor TWPDFConfigEx.Create(AOwner: TComponent);
var
  n,f,p: Integer;
  PDF_DLL: String;
begin
  inherited Create(nil);
  SettingsName := CFormSettings_WPDFConfigEx;

  PageControl.ActivePage := Security;
  FOptions := 0;
  Advanced.TabVisible := False;     //this is default

  try
    FDoc := AOwner;
    FPDFExport := TContainer(FDoc).WPPDFPrinter;   //reference the PDF printer

    PDF_DLL := IncludeTrailingPathDelimiter(appPref_DirTools)+'Imaging\IMAGE8.dll';
    if FileExists(PDF_DLL) then
      FPDFExport.DLLName := PDF_DLL
    else begin
      ShowNotice('The ClickFORMS PDF Creator was not found. Please ensure it has been installed.');
      exit;
    end;
    
    SetConfiguration;   //display the defaults
    FPgSettingChanged := False;

    //Set the doc page names in grid
    with PrListGrid do
    begin
      if AOwner <> nil then
        if AOwner is TContainer then
        with AOwner as TContainer do
          if docForm.count > 0 then
          begin
            n := 0;
            Rows := docForm.TotalPages;                //set the number of rows
            SetLength(FPgList, docForm.TotalPages);    //page array to print or not

            for f := 0 to docForm.count-1 do
              for p := 0 to docForm[f].frmPage.count-1 do
                with docForm[f].frmPage[p] do
                  begin
                    Cell[1,n+1] := cbUnchecked;    //get set to draw the inital settings
                    if IsBitSet(FPgFlags, bPgInPDFList) then
                      Cell[1,n+1] := cbChecked;
                    Cell[2,n+1] := PgTitleName;

                    inc(n);
                  end;
          end;
    end;
  except
    ShowNotice('There was a problem using the ClickFORMS PDF Creator. Please ensure it has been installed.');
  end;
end;

destructor TWPDFConfigEx.Destroy;
begin
  FPgList := Nil;

  Inherited;
end;

procedure TWPDFConfigEx.AssignPgList(APagelist: BooleanArray);
var
  n,f,p: integer;
begin
  if assigned(Pglist) then   //assign the new PgList
    with PrListGrid, FDoc as TContainer do
      begin
        if docForm.count > 0 then
          begin
            n := 0;
            Rows := docForm.TotalPages;                //set the number of rows
            SetLength(FPgList, docForm.TotalPages);    //page array to print or not

            if length(FPgList) = length(APagelist) then
              for f := 0 to docForm.count-1 do
                for p := 0 to docForm[f].frmPage.count-1 do
                  with docForm[f].frmPage[p] do
                    begin
                      FPgList[n] := APagelist[n];
                      if APagelist[n] then
                        Cell[1,n+1] := cbChecked
                      else
                        Cell[1,n+1] := cbUnchecked;
                      inc(n);
                    end;
          end;
      end;
end;

procedure TWPDFConfigEx.btnCreatePDFClick(Sender: TObject);
var
	n,f,p: Integer;
begin
	with FDoc as TContainer do
		begin
      //get the user security settings
      GetConfiguration;

      //get the pages to PDF
      n := 0;
      for f := 0 to docForm.Count-1 do
        for p := 0 to docForm[f].frmPage.Count-1 do
          with docForm[f].frmPage[p] do
            begin
              //set the doc
              FPgFlags := SetBit2Flag(FPgFlags, bPgInPDFList, (PrListGrid.Cell[1,n+1] = cbChecked));  //remember
              //set the printer spec array
              FPgList[n] := IsBitSet(FPgFlags, bPgInPDFList); //is it checked??

              if FPgSettingChanged then
                TContainer(FDoc).docDataChged := True;
              inc(n);
            end;

      //get the file name
      if length(FPDFName) > 0 then          //was it already set
        begin
          if FileExists(FPDFName) then
            DeleteFile(FPDFName);             //delete existing one

          FPDFExport.Filename := FPDFName;
          Self.ModalResult := mrOk;
        end
      else
        begin
          PDFSaveDialog.Title := 'Save PDF File As';
          //PDFSaveDialog.FileName := GetNameOnly(docFileName);
          PDFSaveDialog.FileName := ChangeFileExt(docFileName,'.pdf');
          PDFSaveDialog.DefaultExt := 'pdf';
          PDFSaveDialog.Filter := 'Adobe PDF (pdf)|*.pdf';
          PDFSaveDialog.InitialDir := VerifyInitialDir(appPref_DirPDFs, appPref_DirLastSave);

          PDFSaveDialog.Options := [ofOverwritePrompt, ofEnableSizing];
          if PDFSaveDialog.Execute then
            begin
              FPDFExport.Filename := PDFSaveDialog.FileName;
              Self.ModalResult := mrOk;
            end;
        end;
    end;
end;

procedure TWPDFConfigEx.SetOptions(Value: Integer);
begin
  FOptions := Value;
  cbxLaunchPDF.checked := IsBitSet(FOptions, bAutoLaunch);
end;

procedure TWPDFConfigEx.GetConfiguration;
begin
  if FPDFExport <> nil then
    begin
      FPDFExport.AutoLaunch := cbxLaunchPDF.checked;
      FPDFExport.Filename := FPDFName;

      //Get general
      FPDFExport.CreateThumbnails := cbxThumbnails.Checked;
      FPDFExport.CreateOutlines := cbxBookmarks.Checked;

      //Get Author
      FPDFExport.Info.Producer := 'ClickFORMS';
      FPDFExport.Info.Author   := edtAuthor.Text;
      FPDFExport.Info.Subject    := edtSubject.Text;
      FPDFExport.Info.Date := Today;

      //Get Advanced
      if ShowAdvanced then begin
        case CompressionGroup.ItemIndex of
          0: FPDFExport.CompressStreamMethod := wpCompressNone;
          1: FPDFExport.CompressStreamMethod := wpCompressFlate;
        end;
        case FontEmbedGroup.ItemIndex of
          0: FPDFExport.FontMode := wpUseTrueTypeFonts;
          1: FPDFExport.FontMode := wpEmbedSubsetTrueType_UsedChar;
        end;
      end;
      
      //Get Security
      if not cbxEncrypt.Checked then FPDFExport.Encryption := [] else
        begin
          FPDFExport.Encryption := [wpEncryptFile];
          if cbxAllowPrint.Checked then
            FPDFExport.Encryption := FPDFExport.Encryption + [wpEnablePrinting];
          if cbxAllowCopy.Checked then
            FPDFExport.Encryption := FPDFExport.Encryption + [wpEnableCopying];
          if cbxAllowChange.Checked then
            FPDFExport.Encryption := FPDFExport.Encryption + [wpEnableChanging];
         // if EncryptOpt4.Checked then
         //   FPDFExport.Encryption  := FPDFExport.Encryption + [wpEnableForms];
          FPDFExport.UserPassword  := edtUserPSW.Text;
          FPDFExport.OwnerPassword := '';
        end;

      // Use PDF Files
      FPDFExport.InputfileMode := TWPPDFInputfileMode(0);   //ignore input file
      FPDFExport.Inputfile := '';
    end;
end;

procedure TWPDFConfigEx.SetConfiguration;
begin
  with FDoc as TContainer do
    if FPDFExport <> nil then
      begin
        cbxLaunchPDF.checked := FPDFExport.AutoLaunch;
        
        //Set General
        cbxThumbnails.Checked := FPDFExport.CreateThumbnails;
        cbxBookmarks.Checked := FPDFExport.CreateOutlines;

        //Set Author & Subject
        edtAuthor.Text := CurrentUser.UserInfo.FName;
        edtSubject.Text := TContainer(FDoc).GetCellTextByID(46);

        if ShowAdvanced then begin
          //Set Advanced - compression
          case Integer(FPDFExport.CompressStreamMethod) of
            0,1 : CompressionGroup.ItemIndex := 1;         //set compression
            2 : CompressionGroup.ItemIndex := 0;           //set none
          end;

          //Set Advanced - font enbedding
          case Integer(FPDFEXport.FontMode) of
            0,1,2,3:
              FontEmbedGroup.ItemIndex := 1;
            4,5:
              FontEmbedGroup.ItemIndex := 0;
          end;
        end;
        
        //Set Security
       cbxEncrypt.Checked := wpEncryptFile in FPDFExport.Encryption;
       cbxViewOnly.checked := False;
       cbxAllowPrint.Checked  := wpEnablePrinting in FPDFExport.Encryption;
       cbxAllowCopy.Checked  := wpEnableCopying in FPDFExport.Encryption;
       cbxAllowChange.Checked  := wpEnableChanging in FPDFExport.Encryption;
       //  EncryptOpt4.Checked  := wpEnableForms in FPDFExport.Encryption;
       edtUserPSW.Text := FPDFExport.UserPassword;
      // OwnerPW.Text := FPDFExport.OwnerPassword;
      end;
end;

procedure TWPDFConfigEx.cbxEncryptClick(Sender: TObject);
begin
  if cbxEncrypt.checked then
    begin
      cbxViewOnly.enabled := True;
      cbxAllowPrint.enabled := True;
      cbxAllowCopy.enabled := True;
      cbxAllowChange.enabled := True;
      edtUserPSW.enabled := True;
      LabelViewPSW.enabled := True;
      LabelNotReqed.enabled := True;
    end
  else
    begin
      cbxViewOnly.enabled := False;
      cbxAllowPrint.enabled := False;
      cbxAllowCopy.enabled := False;
      cbxAllowChange.enabled := False;
      edtUserPSW.enabled := False;
      LabelViewPSW.enabled := False;
      LabelNotReqed.enabled := False;
    end;
end;

procedure TWPDFConfigEx.cbxViewOnlyClick(Sender: TObject);
begin
  if cbxViewOnly.checked then
    begin
      cbxAllowPrint.Checked := False;
      cbxAllowCopy.checked := False;
      cbxAllowChange.checked := False;
      cbxAllowPrint.enabled := False;
      cbxAllowCopy.enabled := False;
      cbxAllowChange.enabled := False;
    end
  else
    begin
      cbxAllowPrint.enabled := True;
      cbxAllowCopy.enabled := True;
      cbxAllowChange.enabled := True;
    end;
end;

procedure TWPDFConfigEx.cbxNotViewOnlyClick(Sender: TObject);
begin
  if TCheckBox(Sender).checked then
    cbxViewOnly.checked := False;
end;

procedure TWPDFConfigEx.PrListGridClickCell(Sender: TObject; DataColDown,
  DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
  UpPos: TtsClickPosition);
var
	i: Integer;
	checked: Boolean;
begin
//Clicking in column 2 is same as clicking in checkbox
   FPgSettingChanged := True;
   with PrListGrid do
    begin
      //handle toggle if clicked in col#2, else let chkbox do it
      if (DataColDown=2) and (DataRowDown > 0) then
        begin
          if Cell[1,DataRowDown] = cbChecked then
            Cell[1,DataRowDown] := cbUnChecked
          else
            Cell[1,DataRowDown] := cbChecked;
        end;

      //now do the extensions
      if ((DataColDown = 1) or (DataColDown=2)) and ShiftKeyDown then			//clicked in checkbox
        begin
          checked := (Cell[1,DataRowDown] = cbChecked);
          for i := DataRowDown+1 to Rows do
            begin
              if ControlKeyDown then              //if cntlKeyDown toggle current state
                begin
                  if Cell[1,i] = cbChecked then
                    Cell[1,i] := cbUnChecked
                  else
                    Cell[1,i] := cbChecked;
                end
              else   //just run same state down list
                if checked then
                  Cell[1,i] := cbChecked
                else
                  Cell[1,i] := cbUnChecked;
            end;
        end
   end;
end;

Procedure TWPDFConfigEx.SetShowAdvanced(value: Boolean);
begin
  FShowAdvanced := Value;
  Advanced.TabVisible := Value;
end;

procedure TWPDFConfigEx.SetPDFName(const Value: String);
begin
  FPDFName := Value;
  FPDFExport.Filename := FPDFName;
end;

procedure TWPDFConfigEx.SetAutoLaunch(const Value: Boolean);
begin
  if value then
    cbxLaunchPDF.State := cbChecked
  else
    cbxLaunchPDF.State := cbUnchecked;

  FAutoLaunch := Value;
end;

end.
