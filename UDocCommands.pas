unit UDocCommands;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted 2003-2012 by Bradford Technologies, Inc.}

{ This is for processing commands the user initiates, like pressing a}
{ Transfer button on the form.}

interface

uses
	UGlobals, UContainer;


  procedure ProcessDocCommand(doc: TContainer; CX: CellUID; CmdID: Integer);



implementation

Uses
  Controls,Forms,Classes,SysUtils,Dialogs,
  UStatus, UForm, UPage, UCell, UFileTmpSelect,
  UFileUtils, UFileGlobals, UUtil1, UStrings,
  UTools, UWinUtils, UExportAppraisalPort, UApprWorldOrders,
  UAMC_RELSOrder, UUADUtils;

const
  {Command IDs}
  cTransferPage       = 1;
  cMergeTemplate      = 2;
  cMergeClone         = 3;
  cUploadFNCReport    = 4;
  cUploadAWReport     = 12;
  cRELSAcceptOrder    = 20;

  cUADTransferSubj    = 21;
  cUADTransferComp    = 22;


  ORDER_ACCEPT_BUTTON_ID = 100;
  ORDER_DECLINE_BUTTON_ID = 101;
  ORDER_SCHEDULED_BUTTON_ID = 102;
  ORDER_INSPECTED_BUTTON_ID = 103;
  ORDER_COMPLETED_BUTTON_ID = 104;
  ORDER_REVIEWED_BUTTON_ID = 105;
  ORDER_DELIVERED_BUTTON_ID = 107;
  ORDER_ONHOLD_BUTTON_ID = 106;
  ORDER_QUERY_BUTTON_ID = 108;
  ORDER_CANCELED_BUTTON_ID = 109;

//form IDs
  fmAppraisalPortOrder  = 789;



//This rountine will transfer the contents from the designated page
//on a form to rest of the report. The transfer is coordinated by
//matching cell IDs. Once the data is transfered into a cell, the
//cells math, local transfers are executed to further process the data
procedure TransferPageData(doc: TContainer; CX: CellUID);
var
  toForm: TDocForm;
  fromPage, toPage: TDocPage;
  fromCell, toCell: TBaseCell;
  fromCellID, XCount: Integer;
	f,p,c,i: Integer;
begin
  PushMouseCursor(crHourglass);
  XCount := 0;
  try
    XCount := 0;
    fromPage := doc.docForm[CX.form].frmPage[CX.pg];

    for f := 0 to doc.docForm.Count-1 do
      if (f <> CX.form) and (doc.docForm[f].FormID <> CX.FormID) then  //not this one or of same type
        begin
          Inc(XCount);
          toForm := doc.docForm[f];                         //populate this form
          for p := 0 to toForm.frmPage.count-1 do           //all pages of it
            begin
              toPage := toForm.frmPage[p];                  //shortcut to it
              for i := 0 to fromPage.pgData.count-1 do      //for every cell in formPage
                if (fromPage.pgData[i].FCellID > 0) and     //if it has an ID
                   (length(fromPage.pgData[i].Text) >0) then   //and something to transfer
                  begin
                    fromCell := fromPage.pgData[i];
                    fromCellID := fromCell.FCellID;
                    for c := 0 to toPage.pgData.count-1 do    //try all the cells on this page
                      begin
                        toCell := toPage.pgData[c];           //shortcut to the cell
                        if toCell.FCellID = fromCellID then
                          begin
                            doc.StartProcessLists;
                            toCell.SetText(fromCell.Text);
                            toCell.Display;
                            toCell.ProcessMath;
                            toCell.ReplicateLocal(True);
                            if toCell.FContextID > 0 then
                              doc.LoadCellMunger(toCell.FContextID, fromCell.Text);
                            doc.ClearProcessLists;
                          end;
                      end;
                  end;
            end;
        end;
  finally
    PopMouseCursor;
    if XCount = 0 then
      ShowNotice('There were no available forms to transfer the data into.');
  end;
end;

procedure MergeTemplate(doc: TContainer; CX: CellUID);
var
  fileSelect: TSelectTemplate;
  docStream: TFileStream;
  orderForm: TDocForm;
  Version: Integer;
begin
  fileSelect := TSelectTemplate.Create(nil);          //create the dialog
  try
    if fileSelect.showModal = mrOK then
      begin
        docStream := TFileStream.Create(fileSelect.FileName, fmOpenRead or fmShareDenyWrite);
        try
          if VerifyFileType3(docStream, cDATAType, Version) then
            begin
              doc.MergeContainer(docStream, False, False, Version);
              //### why do we assume there is an order form when we merge with a template??
              orderForm := doc.GetFormByOccurance(CX.FormID, 0, False);  //broadcast data in order
              doc.SetupUserProfile(true);                   //insert current User profile, insert CO
              doc.BroadcastFormContext(orderForm);
              doc.ScrollIntoView(orderForm);
            end;
        finally
          docStream.Free;
        end;
      end;
  finally
    fileSelect.Free;   
  end;
end;

procedure MergeCloneReport(doc: TContainer; CX: CellUID);
var
  OpenDialog: TOpenDialog;
  docStream: TFileStream;
  orderForm: TDocForm;
  version: Integer;
begin
  OpenDialog := TOpenDialog.Create(nil);
  try
    OpenDialog.InitialDir := VerifyInitialDir(appPref_DirReports, appPref_DirLastOpen);
	  OpenDialog.FileName := '';
 	  OpenDialog.DefaultExt := 'clk';
	  OpenDialog.Filter := cOpenFileFilter;
  	OpenDialog.FilterIndex := 1;

    if OpenDialog.execute then
      begin
        docStream := TFileStream.Create(OpenDialog.FileName, fmOpenRead or fmShareDenyWrite);
        try
          if VerifyFileType3(docStream, cDATAType, Version) then
            begin
              doc.MergeContainer(docStream, False, False, Version);
              orderForm := doc.GetFormByOccurance(CX.FormID, 0, False);   //broadcast data in order
              doc.BroadcastFormContext(orderForm);
              doc.ScrollIntoView(orderForm);
            end
          else
            ShowAlert(atWarnAlert, errFileNotVerified);
        finally
          docStream.Free;
        end;
      end;
  finally
    OpenDialog.Free;
  end;
end;

procedure ProcessDocCommand(doc: TContainer; CX: CellUID; CmdID: Integer);
begin
  Case CmdID of
    cTransferPage:
      TransferPageData(doc, CX);

    cMergeTemplate:
      begin
        MergeTemplate(doc, CX);
      end;

    cMergeClone:
      begin
        MergeCloneReport(doc, CX);
      end;

    cUploadFNCReport:
      ExportReportToAppraisalPort(doc);

    cUploadAWReport:
      ExportToAppraisalWorld(doc);

    5:
      LaunchGPSConnector(doc);   //Subject Property GPS
    6:
      LaunchGPSConnector(doc);   //comp 1 GPS
    7:
      LaunchGPSConnector(doc);   //comp 2 GPS
    8:
      LaunchGPSConnector(doc);   //Comp 3 GPS
    9:
      LaunchGPSConnector(doc);   //Comp 4 GPS
    10:
      LaunchGPSConnector(doc);   //Comp 5 GPS
    11:
      LaunchGPSConnector(doc);   //Comp 6 GPS

    cRELSAcceptOrder:
      LaunchRELSOrderAcknowledgementWebsite(doc);

    cUADTransferSubj:
//      TransferPageData(doc, CX);
      TransferUADSubjectDataToReport(doc, CX);

    cUADTransferComp:
      ShowNotice('Command 22');

//    13: ShowNotice('Command 13');

    ORDER_ACCEPT_BUTTON_ID : begin end; {uAppraisalWorldInterface.SendStatus(doc, etsAcceptedByAppraiser);}
    ORDER_DECLINE_BUTTON_ID : begin end; {uAppraisalWorldInterface.SendStatus(doc, etsDeclinedByAppraiser);}
    ORDER_SCHEDULED_BUTTON_ID : begin end; {uAppraisalWorldInterface.SendStatus(doc, etsScheduled);}
    ORDER_INSPECTED_BUTTON_ID : begin end; {uAppraisalWorldInterface.SendStatus(doc, etsInspected);}
    ORDER_COMPLETED_BUTTON_ID : begin end; {uAppraisalWorldInterface.SendStatus(doc, etsCompleted); }
    ORDER_REVIEWED_BUTTON_ID : begin end; {uAppraisalWorldInterface.SendStatus(doc, etsReviewed);}
    ORDER_DELIVERED_BUTTON_ID : begin end; {uAppraisalWorldInterface.SendReport(doc);}
    ORDER_ONHOLD_BUTTON_ID : begin end; {uAppraisalWorldInterface.SendStatus(doc, etsOnHold);}
    ORDER_CANCELED_BUTTON_ID : begin end; {uAppraisalWorldInterface.SendStatus(doc, etsCanceled);}
    ORDER_QUERY_BUTTON_ID : begin end; {uAppraisalWorldInterface.SendQuery(doc);}

  else
    ShowNotice(IntToStr(CmdID) + ' command has not been assigned.');
  end;
end;

end.
