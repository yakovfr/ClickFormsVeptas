unit UPrefFDocOperation;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted � 1998-2011 by Bradford Technologies, Inc. }

{ This is the Frame that contains the Document Operation Preferences}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UGlobals, UContainer, ExtCtrls;

type
  TPrefDocOperation = class(TFrame)
    chkAutoComplete: TCheckBox;
    ckbAutoTrans: TCheckBox;
    ckbAutoCalc: TCheckBox;
    chkAddEditMenus: TCheckBox;
    chkEMAddUndo: TCheckBox;
    chkEMAddCut: TCheckBox;
    chkEMAddCopy: TCheckBox;
    chkEMAddCellPref: TCheckBox;
    chkEMAddClear: TCheckBox;
    chkEMAddPaste: TCheckBox;
    edtStartPage: TEdit;
    edtTotalPages: TEdit;
    ChkAutoNumPages: TCheckBox;
    chkDisplayPgNums: TCheckBox;
    ckbUseEnterAsX: TCheckBox;
    ckbAutoSelect: TCheckBox;
    chkTxUpper: TCheckBox;
    chkAutoRunReviewer: TCheckBox;
    Panel1: TPanel;
    lblPgStart: TStaticText;
    lblPgTotal: TStaticText;
    fldCommentsForm: TComboBox;
    lblCommentsForm: TStaticText;
    ckbLinkComments: TCheckBox;
    chkOptimizeImage: TCheckBox;
    ImageQualityGroup: TGroupBox;
    rdoImgQualHigh: TRadioButton;
    rdoImgQualMed: TRadioButton;
    rdoImgQualLow: TRadioButton;
    rdoImgQualVeryLow: TRadioButton;
    ckbAutoFitFont: TCheckBox;
    procedure chkAddEditMenusClick(Sender: TObject);
    procedure chkDisplayPgNumsClick(Sender: TObject);
    procedure ChkAutoNumPagesClick(Sender: TObject);
    procedure edtStartPageExit(Sender: TObject);
    procedure NumberFilter(Sender: TObject; var Key: Char);
    //procedure chkOptimizeImageClick(Sender: TObject);
  private
    FDoc: TContainer;
  private
    procedure PopulateCommentsFormList;
  public
    constructor CreateFrame(AOwner: TComponent; ADoc: TContainer);
    procedure LoadPrefs;      //loads in the prefs from the app
    procedure SavePrefs;      //saves the changes
    function CheckCompliance: Boolean;
  end;

implementation

uses
  ComCtrls, UInit, UUtil1, UStatus, UMain, UFormsLib, UBase;

{$R *.dfm}

procedure TPrefDocOperation.PopulateCommentsFormList;
var
  formID: Integer;
  index: Integer;
  node: TTreeNode;
begin
  node := nil;
  if assigned(FormsLib) then   //avoid crash if FormsLibrary folder not found
    begin
      for index := 0 to FormsLib.FormLibTree.Items.Count - 1 do
        if SameText(FormsLib.FormLibTree.Items[index].Text, 'Comments') then
          begin
            node := FormsLib.FormLibTree.Items[index];
            break;
          end;

      if Assigned(node) then
        for index := 0 to node.Count - 1 do
          begin
            formID := TFormIDInfo(node.Item[index].Data).fFormUID;
            fldCommentsForm.Items.AddObject(node.Item[index].Text, Pointer(formID));
          end;
    end;
end;

constructor TPrefDocOperation.CreateFrame(AOwner: TComponent; ADoc: TContainer);
begin
  inherited Create(AOwner);
  FDoc := ADoc;

  chkAutoRunReviewer.visible := True;  //not IsStudentVersion;
  PopulateCommentsFormList;

  LoadPrefs;
end;

procedure TPrefDocOperation.LoadPrefs;
var
  index: Integer;
begin
  //Operations
  chkAutoComplete.Checked := IsAppPrefSet(bAutoComplete);
  ckbAutoTrans.Checked := IsAppPrefSet(bAutoTransfer);
  ckbAutoCalc.checked := IsAppPrefSet(bAutoCalc);
  ckbAutoSelect.checked := IsAppPrefSet(bAutoSelect);
  chkTxUpper.checked := LongBool(appPref_PrefFlags and (1 shl bUpperCase));    //IsAppPrefSet(bUpperCase);
  chkTxUpper.Enabled := not main.ActiveDocIsUAD;
  ckbUseEnterAsX.checked := IsAppPrefSet(bUseEnterKeyAsX);
  ckbLinkComments.Checked := IsAppPrefSet(bLinkComments);

  //Operations - adding Edit Menus
  chkAddEditMenus.checked := appPref_AddEditM2Popups;
  chkEMAddUndo.Enabled := appPref_AddEditM2Popups;
  chkEMAddCut.Enabled := appPref_AddEditM2Popups;
  chkEMAddCopy.Enabled := appPref_AddEditM2Popups;
  chkEMAddPaste.Enabled := appPref_AddEditM2Popups;
  chkEMAddClear.Enabled := appPref_AddEditM2Popups;
  chkEMAddCellPref.Enabled := appPref_AddEditM2Popups;

  //set previous settings
  chkEMAddUndo.Checked := IsBitSet(appPref_AddEM2PUpPref, bAddEMUndo);
  chkEMAddCut.checked := IsBitSet(appPref_AddEM2PUpPref, bAddEMCut);
  chkEMAddCopy.checked := IsBitSet(appPref_AddEM2PUpPref, bAddEMCopy);
  chkEMAddPaste.Checked := IsBitSet(appPref_AddEM2PUpPref, bAddEMPaste);
  chkEMAddClear.Checked := IsBitSet(appPref_AddEM2PUpPref, bAddEMClear);
  chkEMAddCellPref.checked := IsBitSet(appPref_AddEM2PUpPref, bAddEMCellPref);


  //reviewer - moved from Appraiser Prefs
  chkAutoRunReviewer.checked := appPref_AppraiserAutoRunReviewer;

  // Set Document Prefs; if have Active use those, else use defaults
	if FDoc = nil then begin
    //page numbering
    chkDisplayPgNums.Checked := true;
    chkAutoNumPages.checked := true;
    chkAutoNumPages.enabled := true;
    lblPgStart.Enabled := False;
    lblPgTotal.Enabled := False;
    edtStartPage.Enabled := False;
    edtTotalPages.Enabled := False;
		end
	else begin //if doc <> nil then
  //Page numbering
  chkDisplayPgNums.checked := FDoc.DisplayPgNums;    //appPref_DisplayPgNumbers;
  if chkDisplayPgNums.checked then
    chkAutoNumPages.Enabled := True
  else
    chkAutoNumPages.Enabled := False;
  chkAutoNumPages.checked := FDoc.AutoPgNumber;      //appPref_AutoPageNumber;
  edtStartPage.text := '';
  edtTotalPages.Text := '';
  if FDoc.ManualStartPg > 0 then
    edtStartPage.text := IntToStr(FDoc.ManualStartPg);
  if FDoc.ManualTotalPg > 0 then
    edtTotalPages.Text := IntToStr(FDoc.ManualTotalPg);
  end;

  // appPref_DefaultCommentsForm
  for index := 0 to fldCommentsForm.Items.Count - 1 do
    if (Integer(fldCommentsForm.Items.Objects[index]) = appPref_DefaultCommentsForm) then
      fldCommentsForm.ItemIndex := index;

  chkOptimizeImage.Checked := appPref_ImageAutoOptimization; //github 71
  ckbAutoFitFont.Checked := appPref_AutoFitTextToCell;
  rdoImgQualHigh.Checked := False; //reset to False before we read from ini
  rdoImgQualMed.Checked  := false;
  rdoImgQualLow.Checked  := False;
  rdoImgQualVeryLow.Checked  := False;

  case appPref_ImageOptimizedQuality of
    imgQualHigh: rdoImgQualHigh.Checked := True;
    imgQualMed: rdoImgQualMed.Checked  := True;
    imgQualLow: rdoImgQualLow.Checked  := True;
    imgQualVeryLow: rdoImgQualVeryLow.Checked  := True;
  end;

end;

procedure TPrefDocOperation.SavePrefs;
var
  startPg, TotalPg: Integer;
begin
  If CheckCompliance then
    //Operations
    SetAppPref(bAutoComplete, chkAutoComplete.Checked);
    SetAppPref(bAutoTransfer, ckbAutoTrans.Checked);
    SetAppPref(bAutoCalc, ckbAutoCalc.Checked);
    SetAppPref(bAutoSelect, ckbAutoSelect.Checked);
    SetAppPref(bUpperCase, chkTxUpper.Checked);
    SetAppPref(bUseEnterKeyAsX, ckbUseEnterAsX.checked);
    SetAppPref(bLinkComments, ckbLinkComments.checked);

    appPref_AddEditM2Popups := chkAddEditMenus.checked;
    appPref_AddEM2PUpPref := SetBit2Flag(appPref_AddEM2PUpPref, bAddEMUndo, chkEMAddUndo.Checked);
    appPref_AddEM2PUpPref := SetBit2Flag(appPref_AddEM2PUpPref, bAddEMCut, chkEMAddCut.checked);
    appPref_AddEM2PUpPref := SetBit2Flag(appPref_AddEM2PUpPref, bAddEMCopy, chkEMAddCopy.checked);
    appPref_AddEM2PUpPref := SetBit2Flag(appPref_AddEM2PUpPref, bAddEMPaste, chkEMAddPaste.Checked);
    appPref_AddEM2PUpPref := SetBit2Flag(appPref_AddEM2PUpPref, bAddEMClear, chkEMAddClear.Checked);
    appPref_AddEM2PUpPref := SetBit2Flag(appPref_AddEM2PUpPref, bAddEMCellPref, chkEMAddCellPref.checked);

    //reviewer - moved from Appraiser
    appPref_AppraiserAutoRunReviewer := chkAutoRunReviewer.checked;

	  //Active Document Preferences
	  if (FDoc <> nil) then
	    begin
        //Operations - immediate change to editor
        if FDoc.docEditor <> nil then
          FDoc.docEditor.FUpperCase := chkTxUpper.checked;

        //Page numbering
        FDoc.DisplayPgNums := chkDisplayPgNums.checked;
        startPg := StrToIntDef(edtStartPage.text, 0);
        TotalPg := StrToIntDef(edtTotalPages.Text, 0);
        if (FDoc.AutoPgNumber <> chkAutoNumPages.checked) or
        (startPg <>FDoc.ManualStartPg) or (TotalPg<>FDoc.ManualTotalPg) then
          begin
            FDoc.ManualStartPg := startPg;
            FDoc.ManualTotalPg := TotalPg;
            FDoc.AutoPgNumber := chkAutoNumPages.checked;          //save this last to reset doc pages
          end;
	    end;

  // appPref_DefaultCommentsForm
  if (fldCommentsForm.ItemIndex >= 0) then
    appPref_DefaultCommentsForm := Integer(fldCommentsForm.Items.Objects[fldCommentsForm.ItemIndex]);

  //github 71:
  appPref_ImageAutoOptimization := chkOptimizeImage.Checked;
  appPref_AutoFitTextToCell := ckbAutoFitFont.Checked;

  if rdoImgQualHigh.Checked then
    appPref_ImageOptimizedQuality := imgQualHigh //High
  else if rdoImgQualMed.Checked then
          appPref_ImageOptimizedQuality := imgQualMed
        else if rdoImgQualLow.Checked then
                appPref_ImageOptimizedQuality := imgQualLow
              else if rdoImgQualVeryLow.Checked then
                appPref_ImageOptimizedQuality := imgQualVeryLow;
end;

procedure TPrefDocOperation.chkAddEditMenusClick(Sender: TObject);
var
  EnableOK: Boolean;
begin
  EnableOK := chkAddEditMenus.checked;
  chkEMAddUndo.Enabled := EnableOK;
  chkEMAddCut.Enabled := EnableOK;
  chkEMAddCopy.Enabled := EnableOK;
  chkEMAddPaste.Enabled := EnableOK;
  chkEMAddClear.Enabled := EnableOK;
  chkEMAddCellPref.Enabled := EnableOK;

end;

procedure TPrefDocOperation.chkDisplayPgNumsClick(Sender: TObject);
begin
  if chkDisplayPgNums.Checked then
    begin
      chkAutoNumPages.Enabled := True;
      if not chkAutoNumPages.checked then
        begin
          lblPgStart.Enabled := True;
          lblPgTotal.Enabled := True;
          edtStartPage.Enabled := True;
          edtTotalPages.Enabled := True;
        end;
    end
  else
    begin
      chkAutoNumPages.Enabled := False;
      lblPgStart.Enabled := False;
      lblPgTotal.Enabled := False;
      edtStartPage.Enabled := False;
      edtTotalPages.Enabled := False;
    end;
end;

procedure TPrefDocOperation.ChkAutoNumPagesClick(Sender: TObject);
begin
  if chkAutoNumPages.checked then
    begin
      lblPgStart.Enabled := False;
      lblPgTotal.Enabled := False;
      edtStartPage.Enabled := False;
      edtTotalPages.Enabled := False;
    end
  else
    begin
      lblPgStart.Enabled := True;
      lblPgTotal.Enabled := True;
      edtStartPage.Enabled := True;
      edtTotalPages.Enabled := True;
    end;
end;

procedure TPrefDocOperation.edtStartPageExit(Sender: TObject);
var
  start, total: Integer;
begin
  if assigned(FDoc) and (length(edtTotalPages.text) = 0) then
    begin
      start := StrToIntDef(edtStartPage.text, 0);
      total := start + FDoc.docForm.TotalReportPages + 1;
      edtTotalPages.text := IntToStr(total);
    end;
end;

procedure TPrefDocOperation.NumberFilter(Sender: TObject; var Key: Char);
begin
	if not (Key in [#08, '0'..'9']) then
		key := char(#0);
end;

function TPrefDocOperation.CheckCompliance: Boolean;
var
  start, total: Integer;
begin
  result := True;
  if chkAutoNumPages.Enabled and not chkAutoNumPages.checked then     //if not auto-number, check for page number compliance
    begin
      start := StrToIntDef(edtStartPage.text, 0);
      total := StrToIntDef(edtTotalPages.Text, 0);
      result := (start > 0) and (start <= total);
      if not result then
        ShowNotice('When opting for manual page numbering, a starting page number must be entered and the total number of pages must be greater or equal to the start page number.');
    end;
end;

{procedure TPrefDocOperation.chkOptimizeImageClick(Sender: TObject);
var
  EnableOK: Boolean;
begin
  EnableOK := chkOptimizeImage.checked;
  ComprQualityGroup.Visible := EnableOK;
  DPIGroup.Visible := EnableOK;
end;  }

end.
