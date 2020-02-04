unit UWPDF2;

{  ClickForms Application               }
{  Bradford Technologies, Inc.          }
{  All Rights Reserved                  }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, Grids_ts, TSGrid, WPPDFR2,
  UGlobals, UForms;


type
  TWPDFConfig2 = class(TAdvancedForm)
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
  protected
    Procedure SetShowAdvanced(value: Boolean);
  public
    PgSpec: Array of PagePrintSpecRec;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetOptions(Value: Integer);
    procedure SetConfiguration;
    procedure GetConfiguration;
    property ShowAdvanced: Boolean read FShowAdvanced write SetShowAdvanced;
    property Options: Integer read FOptions write SetOptions;
  end;

var
  WPDFConfig2: TWPDFConfig2;

implementation

uses
  DateUtils,
  UContainer, UUtil1, UStatus,ULicUser,
  WPPDFR1;


const
  bAutoLaunch = 1;      //options for presetting the PDF Dialog


  
{$R *.DFM}

{ TWPDFProperty }

constructor TWPDFConfig2.Create(AOwner: TComponent);
var
  n,f,p: Integer;
  PDF_DLL: String;
begin
  inherited Create(nil);
  SettingsName := CFormSettings_WPDFConfig2;

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
            FDoc := AOwner;
            n := 0;
            Rows := docForm.TotalPages;                //set the number of rows
            SetLength(PgSpec, docForm.TotalPages);    //array to store the printer spec for each pg

            for f := 0 to docForm.count-1 do
              for p := 0 to docForm[f].frmPage.count-1 do
                with docForm[f].frmPage[p] do
                  begin
                    Cell[1,n+1] := cbUnchecked;                     //get set to draw the inital settings
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

destructor TWPDFConfig2.Destroy;
begin
  PgSpec := Nil;

  Inherited;
end;

procedure TWPDFConfig2.btnCreatePDFClick(Sender: TObject);
var
	n,f,p: Integer;
begin
	with FDoc as TContainer do
		begin
      GetConfiguration;        //get all the settings

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

          n := 0;
          for f := 0 to docForm.Count-1 do
            for p := 0 to docForm[f].frmPage.Count-1 do
              with docForm[f].frmPage[p] do
                begin
                  //set the doc
                  FPgFlags := SetBit2Flag(FPgFlags, bPgInPDFList, (PrListGrid.Cell[1,n+1] = cbChecked));  //remember
                  //set the printer spec array
                  PgSpec[n].PrIndex := 1;   //always use pr #1 (we only have one PDF)
                  PgSpec[n].Copies := 1;    //only one copy per page
                  PgSpec[n].Ok2Print := IsBitSet(FPgFlags, bPgInPDFList); //is it checked??
                  if FPgSettingChanged then
                    TContainer(FDoc).docDataChged := True;
                  inc(n);
                end;
                
          Self.ModalResult := mrOk;
        end;
    end;
end;

procedure TWPDFConfig2.SetOptions(Value: Integer);
begin
  FOptions := Value;
  cbxLaunchPDF.checked := IsBitSet(FOptions, bAutoLaunch);
end;

procedure TWPDFConfig2.GetConfiguration;
begin
  if FPDFExport <> nil then
    begin
      FPDFExport.AutoLaunch := cbxLaunchPDF.checked;

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

procedure TWPDFConfig2.SetConfiguration;
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

procedure TWPDFConfig2.cbxEncryptClick(Sender: TObject);
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

procedure TWPDFConfig2.cbxViewOnlyClick(Sender: TObject);
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

procedure TWPDFConfig2.cbxNotViewOnlyClick(Sender: TObject);
begin
  if TCheckBox(Sender).checked then
    cbxViewOnly.checked := False;
end;

procedure TWPDFConfig2.PrListGridClickCell(Sender: TObject; DataColDown,
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

Procedure TWPDFConfig2.SetShowAdvanced(value: Boolean);
begin
  FShowAdvanced := Value;
  Advanced.TabVisible := Value;
end;


end.
