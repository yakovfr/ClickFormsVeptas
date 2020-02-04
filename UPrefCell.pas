unit UPrefCell;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	StdCtrls, ComCtrls, ExtCtrls,
	UCell, UEditor, RzButton, RzRadChk, UForms;

type
  TCellPref = class(TAdvancedForm)
    PageMgr: TPageControl;
		General: TTabSheet;
    lbStyle: TLabel;
    lbSize: TLabel;
    cbxStyle: TComboBox;
    cbxSize: TComboBox;
    chkSkip: TCheckBox;
    chkTrans: TCheckBox;
    Number: TTabSheet;
    lbRound: TLabel;
    cbxRound: TComboBox;
    chkPlusSign: TCheckBox;
    chkDispZero: TCheckBox;
    chkComma: TCheckBox;
		Graphic: TTabSheet;
    Date: TTabSheet;
    btnOK: TButton;
    btnCancel: TButton;
    chkCalc: TCheckBox;
    chkOnlyDate: TCheckBox;
    lbScale: TLabel;
    ImageScaleBar: TTrackBar;
    ImageScaleVal: TEdit;
    lbJust: TLabel;
    cbxJust: TComboBox;
    chkOnlyNum: TCheckBox;
    chkFmtNum: TCheckBox;
    ChkOnlyShow: TCheckBox;
    radDateGrp: TRadioGroup;
    radMDY: TRadioButton;
    radMDYYYY: TRadioButton;
    radMY: TRadioButton;
    radShortM: TRadioButton;
    radLongM: TRadioButton;
    chkTransInto: TCheckBox;
    chkStretch: TRzCheckBox;
    chkAspectRatio: TRzCheckBox;
    chkCenter: TRzCheckBox;
    chkFrame: TRzCheckBox;
    chkAutoFit: TCheckBox;
    procedure ImageScaleBarChange(Sender: TObject);
    procedure chkFitClick(Sender: TObject);
    procedure chkAspectClick(Sender: TObject);
    procedure chkCntrClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
		FOrgFit: Boolean;
		FOrgAspect: Boolean;
		FOrgCntr: Boolean;
		ForgFrame: Boolean;
		FOrgScale: Integer;
	public
		FCell: TBaseCell;
		FPref: Integer;
		FFormat: Integer;
		FEditor: TEditor;

		constructor Create(AOwner: TComponent; Editor: TEditor); reintroduce;
		procedure SaveChanges;
		procedure UpdateImage;
  end;

var
	CellPref: TCellPref;

implementation

	Uses
		UGlobals, UUtil1;


{$R *.DFM}

{ TCellPref }

constructor TCellPref.Create(AOwner: TComponent; Editor: TEditor);
var
  format: ITextFormat;
begin
	inherited Create(AOwner);
   //Ticket #1283: if user has multiple monitors and bring CF to show in between of the 2 monitors bring up multiple reports and close one
   //got the pop up dialog disappear and user has to end task.
	if Editor <> nil then
	begin
		FEditor := Editor;
    FEditor.SaveChanges;
		FCell := TBaseCell(Editor.FCell);                //remember so we can save options
		FPref := TBaseCell(FCell).FCellPref;             //work with the temps
		FFormat := TBaseCell(FCell).FCellFormat;

		if (FEditor is TGraphicEditor) then
			begin
				PageMgr.ActivePage := Graphic;           //set it to the right tab

				with FEditor as TGraphicEditor do
				begin
          if FStretch then
            chkStretch.InitState(cbChecked)
          else
            chkStretch.InitState(cbUnchecked);

          if FAspRatio then
            chkAspectRatio.InitState(cbChecked)
          else
            chkAspectRatio.InitState(cbUnchecked);

          if FCenter then
            chkCenter.InitState(cbChecked)
          else
            chkCenter.InitState(cbUnchecked);

          if FPrFrame then
            chkFrame.InitState(cbChecked)
          else
            chkFrame.InitState(cbUnchecked);

 					ImageScaleVal.text := IntToStr(FEditScale);
					ImageScaleBar.Position := FEditScale;    //will redraw the image
          ImageScaleVal.Enabled := not FStretch;
				  ImageScaleBar.enabled := not FStretch;
				end;

				FOrgFit := chkStretch.checked;            //remember in case we cancel chges
				FOrgAspect := chkAspectratio.checked;
				FOrgCntr := chkCenter.checked;
				FOrgFrame := chkFrame.checked;
				FOrgScale := ImageScaleBar.Position;

				//disable the general
				chkTrans.Enabled := False;
				chkCalc.Enabled := False;
				chkOnlyNum.Enabled := False;
				chkOnlyDate.Enabled := False;
				ChkOnlyShow.Enabled := False;
				chkFmtNum.Enabled := False;
				cbxStyle.enabled := False;
				cbxSize.Enabled := False;
				cbxJust.Enabled := false;
				lbStyle.Enabled := False;
				lbSize.Enabled := false;
				lbJust.Enabled := False;

				//disable the numbers
				lbRound.enabled := false;
				cbxRound.Enabled := false;
				chkComma.Enabled := False;
				chkPlusSign.Enabled := False;
				chkDispZero.Enabled := False;

				//disable the dates
				radMY.Enabled := False;
				radMDY.Enabled := False;
				radMDYYYY.Enabled := False;
				radShortM.Enabled := False;
				radLongM.Enabled := False;
			end
		else   //its a text type cell
			begin
				ImageScaleVal.text := '100';
				ImageScaleBar.Position := 100;
				ImageScaleVal.Enabled := False;
				ImageScaleBar.enabled := False;
				chkStretch.enabled := False;
				chkAspectRatio.enabled := False;
				chkCenter.enabled := False;
				chkFrame.enabled := False;
				lbScale.Enabled := false;
        chkAutoFit.Enabled := appPref_AutoFitTextToCell and not IsAppPrefSet(bNotAutoFitTextTocell);

				PageMgr.ActivePage := General;           //set it to the right tab

			// General
				chkTrans.checked := IsBitSet(FPref, bCelTrans);
        chkTransInto.Checked := not IsBitSet(FPref,bNoTransferInto);
				chkCalc.checked := IsBitSet(FPref, bCelCalc);
        if appPref_AutoFitTextToCell then
          chkAutoFit.Checked := IsBitSet(FPref, bNotAutoFitTextTocell)
        else
           chkAutoFit.Checked := true;  //don't do auto fit font to cell
				chkOnlyNum.checked := IsBitSet(FPref, bCelNumOnly);
				chkOnlyDate.checked := IsBitSet(FPref, bCelDateOnly);
				ChkOnlyShow.checked := IsBitSet(FPref, bCelDispOnly);
				chkFmtNum.checked := IsBitSet(FPref, bCelFormat);
				chkSkip.checked := IsBitSet(FPref, bCelSkip);

        if IsBitSet(FPref, bNoChgToCPref) then begin
          chkOnlyNum.Enabled := False;
          chkOnlyDate.Enabled := False;
          ChkOnlyShow.Enabled := False;
          chkFmtNum.Enabled := False;
        end;

			//Set Style, Just and font size
      if Supports(FEditor, ITextFormat, format) then
        begin
          cbxJust.ItemIndex := format.TextJustification;
          cbxStyle.ItemIndex := format.Font.StyleBits;
          if (format.Font.Size >= 6) and (format.Font.Size <= 14) then
            cbxSize.ItemIndex := format.Font.Size - 6
          else
            cbxSize.Text := IntToStr(format.Font.Size);
        end;

			  // Number format
				chkComma.checked := IsBitSet(FFormat, bAddComma);
				chkPlusSign.checked := IsBitSet(FFormat, bAddPlus);
				chkDispZero.checked := IsBitSet(FFormat, bDisplayZero);
        // number rounding
				if IsBitSet(FFormat,bRnd1000) then
					cbxRound.itemIndex := bRnd1000;
				if IsBitSet(FFormat,bRnd500) then
					cbxRound.itemIndex := bRnd500;
				if IsBitSet(FFormat,bRnd100) then
					cbxRound.itemIndex := bRnd100;
				if IsBitSet(FFormat,bRnd1) then
					cbxRound.itemIndex := bRnd1;
				if IsBitSet(FFormat,bRnd1P1) then
					cbxRound.itemIndex := bRnd1P1;
				if IsBitSet(FFormat,bRnd1P2) then
					cbxRound.itemIndex := bRnd1P2;
				if IsBitSet(FFormat,bRnd1P3) then
					cbxRound.itemIndex := bRnd1P3;
				if IsBitSet(FFormat,bRnd1P4) then
					cbxRound.itemIndex := bRnd1P4;
				if IsBitSet(FFormat,bRnd1P5) then
					cbxRound.itemIndex := bRnd1P5;
        if IsBitSet(FFormat, bRnd5) then  //Ticket #1541  add round to 5
          cbxRound.ItemIndex := bRnd5;

        //if its a number cell, then show the Number cell prefs
        if FCell.FSubType = cKindCalc then
          PageMgr.ActivePage := Number;

				radMY.checked := IsBitSet(FFormat, bDateMY);
				radMDY.checked := IsBitSet(FFormat, bDateMDY);
				radMDYYYY.checked := IsBitSet(FFormat, bDateMD4Y);

			//### we do not yet handle long and short dates in UUtil1 conversion
				radShortM.Enabled := False;
				radLongM.Enabled := False;
				radShortM.checked := IsBitSet(FFormat, bDateShort);
				radLongM.checked := IsBitSet(FFormat, bDateLong);
			end;
	end;
end;

procedure TCellPref.SaveChanges;
var
  format: ITextFormat;
begin
	if (FEditor is TGraphicEditor) then
		with FEditor as TGraphicEditor do begin
			FStretch := chkStretch.checked;
			FAspRatio := chkAspectRatio.checked;
			FCenter := chkCenter.checked;
			FPrFrame := chkFrame.checked;
			FEditScale := ImageScaleBar.Position;
		end
	else
		begin
			FPref := SetBit2Flag(FPref, bCelTrans, chkTrans.checked);
      FPref := SetBit2Flag(FPref, bNoTransferInto, not chkTransInto.Checked); //YF 06.07.02
			FPref := SetBit2Flag(FPref, bCelCalc, chkCalc.checked);
			FPref := SetBit2Flag(FPref, bCelNumOnly, chkOnlyNum.checked);
			FPref := SetBit2Flag(FPref, bCelDispOnly, ChkOnlyShow.checked);
			FPref := SetBit2Flag(FPref, bCelDateOnly, chkOnlyDate.checked);
			FPref := SetBit2Flag(FPref, bCelFormat, chkFmtNum.checked);
			FPref := SetBit2Flag(FPref, bCelSkip, chkSkip.checked);
      if appPref_AutoFitTextToCell then
        FPref := SetBit2Flag(FPref, bNotAutoFitTextTocell, chkAutoFit.Checked)
      else
        ; //leave the cell flag unchanged if global flag set don't auto fit
		//Number Rounding
			FFormat := 0;     //clear previous settings
			FFormat := SetBit(FFormat, cbxRound.itemIndex);
      FFormat := SetBit2Flag(FFormat, bDisplayZero, chkDispZero.checked);
			FFormat := SetBit2Flag(FFormat, bAddComma, chkComma.checked);
			FFormat := SetBit2Flag(FFormat, bAddPlus, chkPlusSign.checked);

		//Dates
			FFormat := SetBit2Flag(FFormat, bDateMY, radMY.checked);
			FFormat := SetBit2Flag(FFormat, bDateMDY, radMDY.checked);
			FFormat := SetBit2Flag(FFormat, bDateMD4Y, radMDYYYY.checked);
			FFormat := SetBit2Flag(FFormat, bDateShort, radShortM.checked);
			FFormat := SetBit2Flag(FFormat, bDateLong, radLongM.checked);

		//display the Text characteristics
      if Supports(FEditor, ITextFormat, format) then
        begin
          format.TextJustification := cbxJust.ItemIndex;
          format.Font.Size := StrToInt(cbxSize.Text);
          format.Font.StyleBits := cbxStyle.ItemIndex;
        end;

    //save the changes to editor
      FEditor.SetFormat(FFormat);
      FEditor.SetPreferences(FPref);
		end;
	FEditor.FModified := true;
end;

procedure TCellPref.ImageScaleBarChange(Sender: TObject);
begin
  ImageScaleVal.Text := IntToStr(ImageScaleBar.Position);
  UpdateImage;
end;

procedure TCellPref.UpdateImage;
begin
	if (FEditor is TGraphicEditor) then
	with FEditor as TGraphicEditor do
    begin
      ResetView(chkStretch.checked, chkCenter.checked, chkAspectRatio.Checked, ImageScaleBar.position);
      DisplayCurCell;
    end;
end;

procedure TCellPref.chkFitClick(Sender: TObject);
begin
	if chkStretch.Checked then begin
		chkAspectRatio.checked := false;
		chkCenter.checked := false;
		ImageScaleVal.enabled := false;
		ImageScaleBar.enabled := false;
		end
	else begin
		ImageScaleVal.enabled := True;
		ImageScaleBar.enabled := True;
	end;
  UpdateImage;
end;

procedure TCellPref.chkAspectClick(Sender: TObject);
begin
  UpdateImage;
end;

procedure TCellPref.chkCntrClick(Sender: TObject);
begin
  if chkCenter.checked then
    chkStretch.Checked := False;
	UpdateImage;
end;

procedure TCellPref.btnCancelClick(Sender: TObject);
begin
	if (FEditor is TGraphicEditor) then
		with FEditor as TGraphicEditor do begin   //canceled so reset the original settings
			FStretch := FOrgFit;
			FAspRatio := FOrgAspect;
			FCenter := FOrgCntr;
			FPrFrame := FOrgFrame;
			FEditScale := FOrgScale;

			ResetView(FStretch, FCenter, FAspRatio, FEditScale);
		  DisplayCurCell;
		end;
end;

end.
