unit uServiceStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, uForms,uVerificationAddress, //ticket #1051 Remove addr verification
  UCC_Progress, UGlobals,
  UFileTmpSelect,UGridMgr,UBase, UCell, UForm,
  uContainer, ComCtrls, ULicUser,MSXML6_TLB, WinHTTP_TLB,XMLDoc;

type
  TSrvStatusDialog = class(TAdvancedForm)
    Memo: TMemo;
    StatusBar: TStatusBar;
    procedure btnContinueClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FAbort: Boolean;
    FIncludeFloodMap: Boolean;
    FIncludeBuildFax: Boolean;
    AddrInfo: AddrInfoRec;
    procedure GetServices(doc: TContainer);
  public
    { Public declarations }
    property IncludeFloodMap: boolean read FIncludeFloodMap write FIncludeFloodMap;
    property IncludeBuildFax: boolean read FIncludeBuildFax write FIncludeBuildFax;

  end;

var
  SrvStatusDialog: TSrvStatusDialog;
  
//Ticket #1051: Remove Addr Verif
  function StartNewAppraisal: Boolean;
  function StartNewTemplate(templateFile:String):Boolean;

implementation

{$R *.dfm}
  uses
    uMain,UFloodMap, UBuildFax, UPictometry, UPortCensusNew, uWebUtils, uStrings,
    uStatus;



function StartNewAppraisal:Boolean;
var
  SrvStatus : TSrvStatusDialog;
  AddrVerf : TAddrVerification;
  tmpSelect: TSelectTemplate;
  msg: String;
  ModalResult: TModalResult;
  thisForm: TDocForm;
begin
  result := True;
  SrvStatus := TSrvStatusDialog.Create(Application);
  SrvStatus.KeyPreview := True;
  SrvStatus.FAbort := False;
  if not IsConnectedToWeb  then
    begin
      msg := Format('%s  Would you like to continue to create new appraisal now?',[msgInterNetNotConnected]);
      if OK2Continue(msg) then
        main.NewTemplateClick(nil);  //bring up template for user to pick
      PostMessage(srvStatus.Handle, WM_CLOSE, 0, 0);
    end
//Github #139: do not check for AW login name here.
//  else if CurrentUser.AWUserInfo.FLoginName = '' then  //if no connection or not AW member
//    begin
//      msg := Format('%s.  Would you like to continue to create new appraisal now?',[msgNotAWMember]);
//      if OK2Continue(msg) then
//        main.NewTemplateClick(nil);  //bring up template for user to pick
//      main.NewTemplateClick(nil);  //bring up template for user to pick
//      PostMessage(srvStatus.Handle, WM_CLOSE, 0, 0);
//    end
  else
    begin
      AddrVerf := TAddrVerification.Create(nil);
      try
          tmpSelect := TSelectTemplate.Create(nil);          //create the dialog
          AddrVerf.UserName := CurrentUser.AWUserInfo.UserLoginEmail;
          AddrVerf.Password := CurrentUser.AWUserInfo.UserPassWord;
          AddrVerf.FileTree.Items.Assign(tmpSelect.FileTree.Items);
          AddrVerf.StatusBar.SimpleText := tmpSelect.StatusBar.SimpleText;
          AddrVerf.btnStart.Enabled := False;
          ModalResult := AddrVerf.ShowModal;
          if ModalResult = mrOK then
          begin
            AddrVerf.ProgressBar := TCCProgress.Create(AddrVerf.doc, False, 0, 4, 1, 'Loading');
            try
              AddrVerf.ProgressBar.SetProgressNote(Format('Open Template: %s ...',[AddrVerf.FileName]));
              AddrVerf.ProgressBar.IncrementProgress;
              Main.OpenThisFile(AddrVerf.FileName, True, True, False);
              with AddrVerf do
              begin
                doc := Main.ActiveContainer;
                if assigned(doc) and (FileName <> '') then
                  begin
                    //Create Order form #4135 if not in the TContainer
                    thisForm := doc.GetFormByOccurance(4135, 0, True);  //add form #4135 to TContainer if not exist
                    AddrVerf.ExportSubjectInfoToReport;
                    AddrVerf.ProgressBar.SetProgressNote('Loading Subject Aerial View...');
                    AddrVerf.ProgressBar.IncrementProgress;
                    AddrVerf.LoadSubjectGoogleStreetView(doc,SrvStatus.AddrInfo);  //Ticket #1667
                    SrvStatus.AddrInfo.StreetAddr := edtVerfAddress.Text;
                    SrvStatus.AddrInfo.City := edtVerfCity.Text;
                    SrvStatus.AddrInfo.State := edtVerfState.Text;
                    SrvStatus.AddrInfo.Zip := edtVerfZip.Text;
                    SrvStatus.AddrInfo.Lat := edtLat.Text;
                    SrvStatus.AddrInfo.Lon := edtLon.Text;
                    SrvStatus.FIncludeFloodMap := ckIncludeFloodMap.Checked;
                    SrvStatus.FIncludeBuildFax := ckIncludeBuildFax.Checked;
                    SrvStatus.GetServices(Main.Activecontainer);
                    PostMessage(SrvStatus.Handle, WM_CLOSE, 0, 0);
                 end;
              end;
                finally
                  if assigned(AddrVerf.ProgressBar) then
                    AddrVerf.ProgressBar.Free;
                end;
          end
          else
          begin
            PostMessage(srvStatus.Handle, WM_CLOSE, 0, 0);
          end;
      finally
        tmpSelect.Free;
        AddrVerf.Free;
      end;
    end;
end;


function StartNewTemplate(templateFile:String):Boolean;
var
  SrvStatus : TSrvStatusDialog;
  AddrVerf : TAddrVerification;
  tmpSelect: TSelectTemplate;
  msg: String;
  ModalResult: TModalResult;
  thisForm: TDocForm;
begin
  result := True;
  SrvStatus := TSrvStatusDialog.Create(Application);
  SrvStatus.KeyPreview := True;
  SrvStatus.FAbort := False;
  AddrVerf := TAddrVerification.Create(nil);
  try
      AddrVerf.UserName := CurrentUser.AWUserInfo.UserLoginEmail;
      AddrVerf.Password := CurrentUser.AWUserInfo.UserPassWord;
      tmpSelect := TSelectTemplate.Create(nil);          //create the dialog
      AddrVerf.FileTree.Items.Assign(tmpSelect.FileTree.Items);
      AddrVerf.StatusBar.SimpleText := tmpSelect.StatusBar.SimpleText;
      AddrVerf.btnStart.Enabled := False;
      AddrVerf.FileName := templateFile;    //Use the template file
      AddrVerf.FileTree.Enabled := False;  //Disable the file tree box
      ModalResult := AddrVerf.ShowModal;
      if ModalResult = mrOK then
      begin
        AddrVerf.ProgressBar := TCCProgress.Create(AddrVerf.doc, False, 0, 4, 1, 'Loading');
        try
          AddrVerf.ProgressBar.SetProgressNote(Format('Open Template: %s ...',[AddrVerf.FileName]));
          AddrVerf.ProgressBar.IncrementProgress;
          Main.OpenThisFile(AddrVerf.FileName, True, True, False);
        finally
          if assigned(AddrVerf.ProgressBar) then
            AddrVerf.ProgressBar.Free;
        end;
          with AddrVerf do
          begin
            doc := Main.ActiveContainer;
            if assigned(doc) and (FileName <> '') then
              begin
                //Create Order form #4135 if not in the TContainer
                thisForm := doc.GetFormByOccurance(4135, 0, True);  //add form #4135 to TContainer if not exist
//                AddrVerf.ExportOrderInfoToReport;

                AddrVerf.ExportSubjectInfoToReport;

                //Load Address
                SrvStatus.AddrInfo.StreetAddr := edtVerfAddress.Text;
                SrvStatus.AddrInfo.City := edtVerfCity.Text;
                SrvStatus.AddrInfo.State := edtVerfState.Text;
                SrvStatus.AddrInfo.Zip := edtVerfZip.Text;
                SrvStatus.AddrInfo.Lat := edtLat.Text;
                SrvStatus.AddrInfo.Lon := edtLon.Text;
                SrvStatus.FIncludeFloodMap := ckIncludeFloodMap.Checked;
                SrvStatus.FIncludeBuildFax := ckIncludeBuildFax.Checked;
                SrvStatus.GetServices(Main.Activecontainer);
                PostMessage(SrvStatus.Handle, WM_CLOSE, 0, 0);
             end;
          end;
      end
      else
      begin
        PostMessage(srvStatus.Handle, WM_CLOSE, 0, 0);
      end;
  finally
    tmpSelect.Free;
    AddrVerf.Free;
  end;
end;


procedure TSrvStatusDialog.btnContinueClick(Sender: TObject);
begin
  FAbort := False;
end;

procedure TSrvStatusDialog.btnCancelClick(Sender: TObject);
begin
  FAbort := True;
  Close;
end;

procedure TSrvStatusDialog.GetServices(doc:TContainer);
var
  msg: STring;
  ProgressBar: TCCProgress;
  sl: TStringList;
begin
    ProgressBar := TCCProgress.Create(doc, False, 0, 2, 1, 'Loading');
    ProgressBar.BringToFront;
    try
      Application.ProcessMessages;
      memo.Lines.Clear;
      if FIncludeFloodMap then
      begin
        msg := 'Getting Flood Map';
        memo.Lines.Add(msg);
        ProgressBar.SetProgressNote('Getting Flood Map ...');
        ProgressBar.IncrementProgress;
      end;
      sl := TStringList.Create;
      try
        sl.Clear;
        if FIncludeFloodMap then
        begin
          LoadFloodMap(doc, AddrInfo, FAbort, sl);
          memo.Lines.Add(sl.Text);
        end;
        //Load Build Fax
        Application.ProcessMessages;
        if FIncludeBuildFax then
          begin
            msg := 'Getting Property Permit Data ...';
            ProgressBar.SetProgressNote(msg);
            memo.Lines.Add(msg);
            ProgressBar.IncrementProgress;
            sl.Clear;
            LoadBuildFax(doc, AddrInfo, FAbort, sl);
            memo.Lines.Add(sl.Text);
            if FAbort then exit;
          end;
        //Load Census Tract
        //if doc.GetCellTextByID(599) = '' then
        //  begin
            msg := 'Getting Census Tract ...';
            ProgressBar.SetProgressNote(msg);
            ProgressBar.IncrementProgress;
            memo.Lines.Add(msg);
            GetCensusTract(doc);
            msg := 'Census Tract = '+doc.GetCellTextByID(599);
            memo.Lines.Add(msg);
        //  end;

        finally
          sl.Free;
        end;

    finally
      ProgressBar.Free;
      //For Testing only
//      memo.Lines.SaveToFile('VerfAddr_LOG.Txt');
    end;
end;

procedure TSrvStatusDialog.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := True;
end;

procedure TSrvStatusDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE:
        begin
           FAbort := True;
           StatusBar.SimpleText := 'ESC key is hit';
           StatusBar.Refresh;
        end;
  end;
end;


end.
