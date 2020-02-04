unit UDebug;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted 1998 - 2011 by Bradford Technologies, Inc. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  UContainer, UForm, ExtCtrls, Mask, UForms;

type
  TDebugFormSpecs = class(TAdvancedForm)
    btnOK: TButton;
    btnCancel: TButton;
    cbxOptCellID: TCheckBox;
    cbxOptContextID: TCheckBox;
    cbxOptMathID: TCheckBox;
    cbxOptLocContextID: TCheckBox;
    cbxOptRspID: TCheckBox;
    cbxOptSampleData: TCheckBox;
    cbxOptFormInfo: TCheckBox;
    cbxOptCellSeqNum: TCheckBox;
    cbxPrintFirstForm: TRadioButton;
    cbxPrintContainerForms: TRadioButton;
    cbxOptPageIdentifier: TCheckBox;
    cbxSetPage: TCheckBox;
    cbxPrintAllForms: TRadioButton;
    medtPageNo: TMaskEdit;
    cbxOptXmlID: TCheckBox;
    procedure btnOKClick(Sender: TObject);
    procedure cbxPrintFirstFormClick(Sender: TObject);
    procedure cbxPrintContainerFormsClick(Sender: TObject);
  private
    FDoc: TContainer;
  public
    constructor Create(AOwner: TComponent); override;
    procedure PrintFirstFormInContainer;
    procedure PrintAllFormsInContainer;
    procedure PrintAllFormsInFormsLib;
    function  SetPrinterSpecs: Boolean;
    procedure PrintSelectedFormSpecs(form: TDocForm; nForms, thisPgOnly: Integer);
    procedure PrintFormHeaderInfo(form: TDocForm; nForms: Integer);
    procedure PrintPageIdentifier(form: TDocForm; Page: Integer);
    property Doc: TContainer read FDoc write FDoc;
  end;

  //interface to Main
  Procedure DebugPrintFormSpecs(doc: TContainer);
  procedure DebugLogMsg(Msg: String);
  procedure SetDebugLevel(Sender: TObject);



var
  DebugFormSpecs: TDebugFormSpecs;



implementation

{$R *.dfm}
Uses
  Printers, Menus,
  UGlobals,  UPage, UDraw, UUtil1;


Procedure DebugPrintFormSpecs(doc: TContainer);
var
  PrintFormSpecs: TDebugFormSpecs;
begin
  PrintFormSpecs := TDebugFormSpecs.create(doc);
  try
    PrintFormSpecs.ShowModal;
  finally
    PrintFormSpecs.Free;
  end;
end;

{ TDebugFormSpecs }

constructor TDebugFormSpecs.Create(AOwner: TComponent);
begin
  inherited Create(nil);

  FDoc := TContainer(AOwner);

  cbxPrintFirstForm.Enabled := (FDoc <> nil);
  cbxPrintContainerForms.Enabled := (FDoc <> nil);
  cbxPrintFirstForm.Checked := (FDoc <> nil);
  cbxPrintAllForms.Checked := (FDoc = nil);

  if cbxPrintFirstForm.Enabled then
    begin
      cbxSetPage.Enabled := True;
      medtPageNo.Enabled := True;
    end;
end;

procedure TDebugFormSpecs.btnOKClick(Sender: TObject);
begin
  if cbxPrintFirstForm.checked then
    PrintFirstFormInContainer

  else if cbxPrintContainerForms.checked then
    PrintAllFormsInContainer
    
  else if cbxPrintAllForms.checked then
    PrintAllFormsInFormsLib;
end;

procedure TDebugFormSpecs.PrintFormHeaderInfo(form: TDocForm; nForms: Integer);
var
  x,x2,y,dy: Integer;
  Num, vers: String;
begin
  if nForms > 0 then Printer.NewPage;

  with Printer.Canvas do
    begin
      With form.frmInfo do
        begin
          x := 400;
          x2 := 1500;
          Font.Size := 20;
          Font.Style := [fsBold];
          Num := 'No. '+ IntToStr(fFormUID);
          vers := 'v '+ IntToStr(fFormVers);

          //print form name, number and version
          TextOut(x,300, fFormName);
          TextOut(printer.PageWidth-TextWidth(Num)-100, 300, Num);
          TextOut(x, 500, 'Page #1');
          TextOut(printer.PageWidth-TextWidth(vers)-100, 500, vers);
          Font.Size := 12;
          Font.Style := [];

          y := 1000;
          dy := 200;
          TextOut(x,y,'Number of Pages:');  TextOut(x2, y, IntToStr(fFormPgCount));
          inc(y,dy);
          TextOut(x,y,'Form SEED:');  TextOut(x2, y, NumXChg(fLockSeed).Seed[4]);
                                        TextOut(x2+100, y, NumXChg(fLockSeed).Seed[3]);
                                        TextOut(x2+200, y, NumXChg(fLockSeed).Seed[2]);
                                        TextOut(x2+300, y, NumXChg(fLockSeed).Seed[1]);

          inc(y,dy);
          TextOut(x,y,'Form SEED (Number):');  TextOut(x2, y, IntToStr(fLockSeed));
          inc(y,dy);
          TextOut(x,y,'Create Date:');  TextOut(x2, y, fCreateDate);
          inc(y,dy);
          TextOut(x,y,'Last Modified Date:');  TextOut(x2, y, fLastUpdate);
          inc(y,dy);
          TextOut(x,y,'Name of Industry:');  TextOut(x2, y, fFormIndustryName);
          inc(y,dy);
          TextOut(x,y,'Industry Classification:');  TextOut(x2, y, fFormCategoryName);
          inc(y,dy);
          TextOut(x,y,'Form Kind:');  TextOut(x2, y, fFormKindName);
          inc(y,dy);
          TextOut(x,y,'Form Industry Code (1):');  TextOut(x2, y, fFormIndustryCode[1]);
          inc(y,dy);
          TextOut(x,y,'Form Industry Code (2):');  TextOut(x2, y, fFormIndustryCode[2]);
          inc(y,dy);
          TextOut(x,y,'Form Industry Date:');  TextOut(x2, y, fFormIndustryDate);


          inc(y,dy);
          TextOut(300,y,'Form Attributes:');  TextOut(x2, y, IntToStr(fFormAtts));
          inc(y,dy);
          TextOut(300,y,'Form Flags:');  TextOut(x2, y, IntToStr(form.frmSpecs.fFormFlags));
        end;
    end;
end;


procedure TDebugFormSpecs.PrintPageIdentifier(form: TDocForm; Page: Integer);
var
  x: Integer;
  Num, vers: String;
begin
  with Printer.Canvas do
    if Page > 0 then
    begin
      Printer.NewPage;
      With form.frmInfo do
        begin
          x := 400;
          Font.Size := 20;
          Font.Style := [fsBold];
          Num := 'No. '+ IntToStr(fFormUID);
          vers := 'v '+ IntToStr(fFormVers);

          //print form name, number and version
          TextOut(x,300, fFormName);
          TextOut(printer.PageWidth-TextWidth(Num)-100, 300, Num);
          TextOut(x, 500, 'Page #'+IntToStr(Page+1));
          TextOut(printer.PageWidth-TextWidth(vers)-100, 500, vers);
          Font.Size := 12;
          Font.Style := [];
        end;
    end;
end;


function TDebugFormSpecs.SetPrinterSpecs: Boolean;
var
  PrintDialog: TPrintDialog;
begin
  PrintDialog := TPrintDialog.Create(nil);
  try
    PrintDialog.MinPage := 1;
    PrintDialog.MaxPage := 1;
    PrintDialog.Options := [poPageNums,poWarning];
    PrintDialog.Copies := 1;       //causes crash if printer not installed
    PrintDialog.FromPage := 1;
    PrintDialog.ToPage := 1;
    PrintDialog.Collate := False;

    result := PrintDialog.execute;
  finally
    PrintDialog.Free;      //lets say bye
  end;
end;

procedure TDebugFormSpecs.PrintSelectedFormSpecs(form: TDocForm; nForms, thisPgOnly: Integer);
var
  pg, NumPs: Integer;
  fmPage: TDocPage;
  hdlDC: HDC;
  DCPixels,POY,POX,PW,PH: Integer;
  viewR, printR: TRect;
  PrOrg: TPoint;
  PrScale: Integer;

  procedure PrintHeading(Heading: String);
  begin
    Printer.NewPage;
    with printer.canvas do
      begin
        Font.Name := 'Arial';
        Font.Size := 10;
        Font.Style := [fsBold];
        TextOut(printer.PageWidth - TextWidth(Heading), 25, Heading);
        Font.Style := [];
      end;
  end;

  procedure PrintPage(formPage: TDocPage);
  begin
    PrScale := DCPixels;
    formPage.GetPagePrintFactors(printR, PrOrg, PrScale);
    SetViewportOrgEx(hdlDC, -PrOrg.x, -PrOrg.y, nil);
    PrintFormPage(Doc, Printer.Canvas, viewR, formPage, 72, PrScale);
  end;

  procedure ShowChanges;
  begin
    doc.Invalidate;
    application.ProcessMessages;
    application.ProcessMessages;
    application.ProcessMessages;
    application.ProcessMessages;
    application.ProcessMessages;
    application.ProcessMessages;
    application.ProcessMessages;
    application.ProcessMessages;
    application.ProcessMessages;
    application.ProcessMessages;
    application.ProcessMessages;
    application.ProcessMessages;
    application.ProcessMessages;
    application.ProcessMessages;
  end;
  
  procedure SetupPageTpPrint(p: Integer);
  begin
    fmPage := Form.frmPage[p];
    fmPage.ClearPageText;

    if cbxOptPageIdentifier.checked then
      PrintPageIdentifier(form, p);         //New Page if page > 0

  //PrintChcekList

    if cbxOptCellSeqNum.Checked then
      begin
        fmPage.DebugDisplayCellAttribute(dbugShowCellNum);
        ShowChanges;
        PrintHeading('CELL SEQUENCE');      //New Page
        PrintPage(fmPage);
        fmPage.ClearPageText;
      end;
    if cbxOptMathID.Checked then
      begin
        fmPage.DebugDisplayCellAttribute(dbugShowMathID);
        ShowChanges;
        PrintHeading('CELL MATH IDS');
        PrintPage(fmPage);
        fmPage.ClearPageText;
      end;
    if cbxOptCellID.Checked then
      begin
        fmPage.DebugDisplayCellAttribute(dbugShowCellID);
        ShowChanges;
        PrintHeading('CELL IDS');
        PrintPage(fmPage);
        fmPage.ClearPageText;
      end;
    if cbxOptContextID.Checked then
      begin
        fmPage.DebugDisplayCellAttribute(dbugShowContext);
        ShowChanges;
        PrintHeading('CELL CONTEXT IDS');
        PrintPage(fmPage);
        fmPage.ClearPageText;
      end;
    if cbxOptLocContextID.Checked then
      begin
        fmPage.DebugDisplayCellAttribute(dbugShowLocContxt);
        ShowChanges;
        PrintHeading('CELL LOCAL CONTEXT IDS');
        PrintPage(fmPage);
        fmPage.ClearPageText;
      end;
    if cbxOptRspID.Checked then
      begin
        fmPage.DebugDisplayCellAttribute(dbugShowRspID);
        ShowChanges;
        PrintHeading('CELL RESPONSE IDS');
        PrintPage(fmPage);
        fmPage.ClearPageText;
      end;
    if cbxOptXmlID.Checked then
      begin
        fmPage.DebugDisplayCellAttribute(dbugShowXMLID);
        ShowChanges;
        PrintHeading('CELL XML IDS');
        PrintPage(fmPage);
        fmPage.ClearPageText;
      end;
    if cbxOptSampleData.Checked then
      begin
        fmPage.DebugDisplayCellAttribute(dbugShowSample);
        ShowChanges;
        PrintHeading('CELL SAMPLE DATA');
        PrintPage(fmPage);
        fmPage.ClearPageText;
      end;
  end;

begin
  NumPs := Form.GetNumPages;

  with Printer do
    begin
      Title := doc.docFileName;          //Windows print mgr title
      hdlDC := Printer.Canvas.Handle;
      DCPixels := GetDeviceCaps(hdlDC, LogPixelsX);			//assume square pixels on printer
      PW := GetDeviceCaps(hdlDC, PhysicalWidth);
      PH := GetDeviceCaps(hdlDC, PhysicalHeight);
      POY := GetDeviceCaps(hdlDC, PhysicalOffsetY);
      POX := GetDeviceCaps(hdlDC, PhysicalOffsetX);
      viewR := Rect(0,0,PW,PH);
      printR := Bounds(POX, POY, PW-POX-POX, PH-POY-POY);

      SetMapMode(hdlDC, MM_TEXT);                                 //make sure we are 1 for 1

      //Print the Form Specifications
      if cbxOptFormInfo.Checked then
        PrintFormHeaderInfo(form, nForms);     //newpage if nForms > 0

      //Print the page ID overlays
      if thisPgOnly > -1 then
        SetupPageTpPrint(thisPgOnly)
        
      else for pg := 0 to NumPs-1 do
        SetupPageTpPrint(pg);
    end;
end;

procedure TDebugFormSpecs.PrintFirstFormInContainer;
var
  P: Integer;
begin
  if (Doc <> nil) and (Doc.docForm.count > 0) then
    if SetPrinterSpecs then
      begin
        p := -1;
        if cbxSetPage.checked and (length(medtPageNo.Text) > 0) then
          p := StrToInt(medtPageNo.Text);
        Printer.BeginDoc;
        PrintSelectedFormSpecs(doc.docForm[0], 0, P);
        Printer.EndDoc;
      end;
end;

procedure TDebugFormSpecs.PrintAllFormsInContainer;
var
  f: Integer;
begin
  if (Doc <> nil) and (Doc.docForm.count > 0) then
    if SetPrinterSpecs then
      begin
        Printer.BeginDoc;
        for f := 0 to Doc.docForm.count-1 do
          PrintSelectedFormSpecs(doc.docForm[f], f, -1);
        Printer.EndDoc;
      end;
end;

procedure TDebugFormSpecs.PrintAllFormsInFormsLib;
begin
end;

procedure TDebugFormSpecs.cbxPrintFirstFormClick(Sender: TObject);
begin
  cbxSetPage.Enabled := True;
  medtPageNo.Enabled := True;
end;

procedure TDebugFormSpecs.cbxPrintContainerFormsClick(Sender: TObject);
begin
  cbxSetPage.Enabled := False;
  medtPageNo.Text := '';
  medtPageNo.Enabled := False;
end;


{****************************}
{   DebugLog Messaging       }
{****************************}

//This will toggle the DebugLog On or Off
//it will also set the DebugLog Menu item to On or Off
procedure SetDebugLevel(Sender: TObject);
begin
  if TMenuItem(Sender).checked then   //its on, so turn off
    begin
      TMenuItem(Sender).checked := False;
      TMenuItem(Sender).caption := 'Service Log Off';
      AppDebugLevel := 0;
    end
  else                                //its off, so turn it on
    begin
      TMenuItem(Sender).checked := True;
      TMenuItem(Sender).caption := 'Service Log On';
      AppDebugLevel := 1;
    end;
end;

procedure DebugLogMsg(Msg: String);
var
  F: TextFile;
  DebugFile: string;

begin
  //check if the application is running in debug mode.
  if AppDebugLevel > 0 then
  begin
    //check if the debug folder exists
    if not DirectoryExists(IncludeTrailingPathDelimiter(appPref_DirMyClickFORMS) + 'Debug') then
      //try to create the debug folder
      if not ForceDirectories(IncludeTrailingPathDelimiter(appPref_DirMyClickFORMS) + 'Debug') then
         raise exception.create('ClickFORM encountered problem creating the "Debug" folder. No debug file will be created.');

    try
      //build the debug file name
      DebugFile := IncludeTrailingPathDelimiter(appPref_DirMyClickFORMS) + 'Debug\'+ FormatDateTime('"DebugLog_"ddmmyyyy".txt"',Now());

      //open the file
      AssignFile(F,DebugFile);

      //if exists open it and append else create a new one
      if FileExists(DebugFile) then
        begin
          Reset(F);
          Append(F);
        end
      else
        Rewrite(F);

      //write the debug text to the file and close it
      Writeln(F, Msg);
      CloseFile(F);
    except
      on e: exception do raise exception.create('There were error writting to the Debug File.' + #13 + e.message);
    end;
  end;
end;



end.


