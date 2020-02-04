unit UActiveForms;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This unit manages the Active Forms that are displayed in the }
{ containers. It is smart about only keeping one form in memory}
{ even though many instances of the same form are displayed.   }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


interface

  uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Commctrl,
  UGlobals, UBase;

type

	TActiveFormItem = class(TObject)
		FFormUseCount: Integer;              //how many containers are using this form
		FFormID: LongInt;                    //quick way to id this item
		FFormDefChged: Boolean;              //was the formatting modified
		FFormRspsChged: Boolean;             //were responses added/changed on any pages
		FormDetails: TFormDesc;              //holds all the form description details
    FInArchive: Boolean;                 //indicates if the form was in Archive
    constructor Create;
		destructor Destroy; override;
    function GetFormRspStatus: Boolean;
    property DefinitionChanged: Boolean read FFormDefChged write FFormDefChged;
    property ResponsesChanged: Boolean read GetFormRspStatus write FFormRspsChged;
	end;


  TActiveFormMgr = class(TList)
    constructor Create(Owner: TObject);
    destructor Destroy; override;
//private or protected
		function FindFormInList(FormID: LongInt; var theIndex: Integer):Boolean;
		procedure AddFormToList(FormID: LongInt; FormDef: TFormDesc; inArchive: Boolean);  //adds the form to active form mgr list
		function LoadFormDefinition(FormID: LongInt): TFormDesc;
    function VerifyUserAccess(FormDef: TFormDesc): Boolean;   //loads the form to the active mgr list
// public
		function GetFormDefinition(FormUID: TFormUID): TFormDesc; //used to request a form definition
		function GetFormPlaceHolder(frmID, frmVers: LongInt; frmNumPages: Integer): TFormDesc;
		function GetFormPgRsps(CUID: CellUID): TStringList;
   {function SaveOriginalFormDefinition(Form: TFormDesc): Boolean;   //Removed Functionality}
   {procedure SaveFormDefinitions;                                   //Removed Functionality}
		procedure SaveAllFormResponses;
    function IsArchivedForm(FormID: LongInt): Boolean;
	end;


Var
	ActiveFormsMgr: TActiveFormMgr;     //these are forms currently in use by a container in the app




implementation

uses
  UFormsLib, UFiles, UFileUtils, UUtil1, UUtil2, UStdRspUtil, UStatus;


constructor TActiveFormMgr.Create(Owner: TObject);
begin
  inherited Create;             //create ourselves
  Capacity := 200;              //handle 200 forms to start with
end;


destructor TActiveFormMgr.Destroy;
var
	i: Integer;
begin
	//free all the memory in the list
	for i := 0 to count-1 do
		TActiveFormItem(Items[i]).Free;

  inherited Destroy;
end;

function TActiveFormMgr.VerifyUserAccess(FormDef: TFormDesc): Boolean;
const
  ToolBoxFormsUID = 1112822348;       //this is the ToolBox forms id seed
  FreeFormsUID    = 1179796805;       //this is the FreeForms forms id seed
  StudentFormsUID = 1398030672;       //this is the Student forms id seed
begin
  result := True;   //assume access is ok until proven otherwise.
  //### normally look at user product licensing, code/decode seed
  //### in this case just use simple comparison
  if FormDef <> nil then
    begin
      if TestVersion then
        result := True
      else if FormDef.Info.fLockSeed = FreeFormsUID then  //test for free forms first
        result := True
      else if AppIsClickForms and IsAmericanVersion then
        begin
            result := FormDef.Info.fLockSeed = ToolBoxFormsUID
        end
      else  //unknow app - fall on OK side
        result := True;

      if not result then
        begin
          ShowNotice('Form "'+FormDef.Info.fFormName+'" cannot be loaded because you do not have access privileges. Please ensure you have the correct product license.');
          Abort;
        end;
    end;
end;

procedure TActiveFormMgr.AddFormToList(FormID: LongInt; FormDef: TFormDesc; inArchive: Boolean);
var
  Item: TActiveFormItem;
begin
	Item := TActiveFormItem.create;
	Item.FFormUseCount := 1;
	Item.FFormID := FormID;
	Item.FormDetails := FormDef;
  Item.FormDetails.FOwner := Item;     //so we can ref back and set flags
	Item.FFormDefChged := False;
	Item.FFormRspsChged := False;
  Item.FInArchive := inArchive;

  Add(Item);          // add the new form to the active list
end;

// Finds the index to the formUID that is in the Active Forms List
function TActiveFormMgr.FindFormInList(FormID: Integer; var theIndex: Integer):Boolean;
var
  n: Integer;
  foundIt: Boolean;
begin
  theIndex := -1;
  FoundIt := False;
  if count > 0 then
  begin
    n := 0;
    while not FoundIt and (n < count) do
    begin
      if (Items[n] <> nil) then
				if (TActiveFormItem(Items[n]).FFormID = FormID) then
          begin
            foundIt := True;
            theIndex := n;
          end;
      n := n + 1;
     end;
  end;
  result := foundIt;
end;

function TActiveFormMgr.IsArchivedForm(formID: Integer): Boolean;
var
  N: Integer;
begin
  if FindFormInList(formID, N) then
    result := TActiveFormItem(Items[N]).FInArchive
  else
    result := False;
end;

//use this to load a form into the activeForm list
function TActiveFormMgr.LoadFormDefinition(FormID: LongInt): TFormDesc;
var
  filePath: String;
  theForm: TFormDesc;
  isOldForm: Boolean;
begin
  theForm := nil;

	if FormsLib.GetFormFilePath(FormID, filePath)then      //find the form in the labrary
    begin
			theForm := ReadFormDefinition(filePath);           // now read the form data
      isOldForm := (POS('Archive', filePath)>0);         //did it come out of Archives?
      if theForm <> nil then
        if VerifyUserAccess(theForm) then
		    	AddFormToList(FormID, theForm, isOldForm)
        else
          FreeAndNil(theForm);
    end
  else
    begin
      //error message, this form is not in the forms library.
    end;
  //
  result := theForm;         // pass it back to who ever was requesting it
end;

//searches for the specified FormUID. If not active, looks in Library and
//if found will load it into the activeForms List. The forms rsps are also
//loaded in the first time the form is requested.
//This is generally called by a container who neds the form
function TActiveFormMgr.GetFormDefinition(FormUID: TFormUID): TFormDesc;
var
	theIndex: integer;
	FormDef: TFormDesc;
	theFormID: LongInt;
begin
  //just get form with same ID, version differences will be handled when when reading
  theIndex := 0;
	theFormID := FormUID.ID;

  //hack to cure URAR-2005 having ID=0 in 3.1 release
  if (FormUID.ID = 0) and (FormUID.Vers = 1) then
    theFormID := 341;

	if FindFormInList(theFormID,theIndex) then                       //first check in list
		begin
			FormDef := TActiveFormItem(Items[theIndex]).FormDetails;
			inc(TActiveFormItem(Items[theIndex]).FFormUseCount);         //inc use count, when zero free the form
    end
  else
    begin
			FormDef := LoadFormDefinition(theFormID);                   //else read from file and load in to Active List
			LoadFormResponses(FormDef);                                 //load in its responsess, store with each pg
		end;

	result := FormDef;
end;

// this routine is used to create a placeholder form, so that a report's data will
//not be lost even though its form cannot be found. The form belongs to the ActiveFormMgr
function TActiveFormMgr.GetFormPlaceHolder(frmID, frmVers: LongInt; frmNumPages: Integer): TFormDesc;
var
	FormDef: TFormDesc;
begin
	FormDef := TFormDesc.Create;    // create the form place holder

	FormDef.Info := TFormIDInfo.Create;
	With FormDef.Info do
	begin
		fFormIsMac := false;          // what format are the numbers in
		fFormUID := -frmID;		      // Unique identifier if a form, 0 is other type
		fFormVers := -frmVers;		    // revision number of this form
		fFormPgCount := frmNumPages;  // number of pages in the form
		fFormFilePath := '';          // where the file is located
		fFormName := '';              // Industry Name of this form
		fFormIndustryName := '';    	// industry classification  (ie apraisal..)
		fFormCategoryName := '';    	// classification within the industry  (ie residential appraising
		fFormKindName := '';        	// kind within the classification  (ie URAR residential appraising
		fCreateDate := '';          	// date the form or file was created
		fLastUpdate := '';         		// date this form or file was updated
		fLockSeed  := 0;           		// the seed for creating unique registration and unlocking numbers
		fFormAtts := 0;           		// 32 attributes of this form
		fFormIndustryCode[1] := '';   // holds industry standard codes for forms
		fFormIndustryCode[2] := '';   // holds industry standard codes for forms
		fFormIndustryDate :='';				// industry date of the form
	end;

	FormDef.Specs := TFormSpec.Create;
	with FormDef.Specs do
	begin
		fFormUID := -frmID;							{unique form identifer}
		fFormVers := -frmVers;					{revision no. of this form}
		fFormWidth := cPageWidthLetter;
    fFormName := 'Missing Form';
		fNumPages := frmNumPages;				{number of pages in form}
		fFormFlags := 0;								{32 flags to indicate what data is in file}
	end;

	FormDef.PgDefs := Nil;      //###this is were we have to do something

  FormDef.Free;               //### for now

	result := nil;              //####
end;

function TActiveFormMgr.GetFormPgRsps(CUID: CellUID): TStringList;
var
	theIndex: integer;
	FormDef: TFormDesc;
begin
//#### need to add the code to check for the version number
//		FormID: LongInt;       	//forms unique ID
//    Form: Integer;          //form index in formList
//    Pg: Integer;            //page index in form's pageList
//    Num: Integer;           //cell index in page's cellList

	result := nil;
	if FindFormInList(CUID.FormID,theIndex) then                       //first check in list
		begin
			FormDef := TActiveFormItem(Items[theIndex]).FormDetails;
			result := FormDef.PgDefs[CUID.Pg].PgRsps;
		end;
end;

(*
//REMOVED this functionality for Vista Compatibility
function TActiveFormMgr.SaveOriginalFormDefinition(Form: TFormDesc): Boolean;
var
  formName, curFormPath, backupPath: String;
begin
  result := true;
  formName := ExtractFileName(Form.Info.fFormFilePath);
  curFormPath := Form.Info.fFormFilePath;
  try
    if not VerifyFolder(appPref_DirFormsBackup) then
      FindLocalFolder(appPref_DirFormsBackup, dirOrigForms, True);
    backupPath := IncludeTrailingPathDelimiter(appPref_DirFormsBackup) + formName;

    CopyFile(PChar(curFormPath), PChar(backupPath), false);       //False=delete if file exists
  except
    ShowNotice('Could not backup the Form Definition file: '+ ExtractFileName(curFormPath));
    result := False;
  end;
end;
*)

(*
//REMOVED this functionality for Vista Compatibility
procedure TActiveFormMgr.SaveFormDefinitions;
var
	i: Integer;
  userModified: Boolean;
  formStream: TFileStream;
  formName, tempPath, formPath: String;
begin
	for i := 0 to Count-1 do
    with TActiveFormItem(Items[i]) do           //for each FormDef Item
		  if FFormDefChged then                     //if changed
        try
          //has form been modified by user previously (so we have previously backed it up)
          userModified := IsBitSet(FormDetails.Info.fFormAtts, bUserModified);

          //first write modified form def to temp dir
          formName := FormDetails.Specs.fFormName;          //name of form
          tempPath := CreateTempFilePath(formName);         //form 'temp' name in temp folder
          if CreateNewFile(tempPath, formStream) then       //create and open
            begin
              FormDetails.Info.fFormAtts := SetBit(FormDetails.Info.fFormAtts, bUserModified);
              WriteFormDefinition(formStream, FormDetails);
              formStream.Free;                              //close the file
            end;

          //decide to backup original or not
          if not userModified then                         //if user modified, already backed up
            SaveOriginalFormDefinition(FormDetails);       //if not, backup the original form def file

          //overwrite old form def with new one 
          formPath := FormDetails.Info.fFormFilePath;         //path to Forms Lib
          CopyFile(PChar(tempPath), PChar(formPath), false);  //copy it there, overwrite old

          //delete the temp file
          DeleteFile(TempPath);                             //delete the temp file

          FFormDefChged := False;                           //reset the flag
        except
          ShowNotice('The Form Definition file '+formName+ ' could not be updated.');
          FFormDefChged := False;                           //reset the flag
        end;
end;
*)

procedure TActiveFormMgr.SaveAllFormResponses;
var
	i: Integer;
begin
	for i := 0 to Count-1 do
		with TActiveFormItem(Items[i]) do
      if ResponsesChanged then
				SaveFormResponses(FormDetails);        //calls routine in UStdRspUtil
end;


{ TActiveFormItem }

constructor TActiveFormItem.Create;
begin
  inherited;

  FFormUseCount := 0;              //how many containers are using this form
  FFormID := 0;                    //quick way to id this item
  FormDetails := nil;              //all the form description details
  FFormDefChged := False;          //was it modified
  FFormRspsChged := False;         //were responses added/changed
  FInArchive := False;             //Indicates form is archived
end;

destructor TActiveFormItem.Destroy;
begin
  if assigned(FormDetails) then
	  FormDetails.Free;

	inherited Destroy;
end;

function TActiveFormItem.GetFormRspStatus: Boolean;
var
  i: integer;
begin
  result := False;
  with FormDetails do
    for i := 0 to Specs.fNumPages-1 do
      if TPageRspList(PgDefs[i].PgRsps).FModified then
        result := True;
end;

end.
