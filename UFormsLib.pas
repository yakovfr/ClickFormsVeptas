unit UFormsLib;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Classes, ComCtrls, Commctrl, Controls, ExtCtrls, Forms, ImgList, StdCtrls,
  UBase, UForms;

type
  TFormsLib = class(TVistaAdvancedForm)
		FormLibTree: TTreeView;
		FormLibImages: TImageList;
		stbrTreeView: TStatusBar;
    PanelSearch: TPanel;
    edtFind: TEdit;
    btnFind: TButton;
    procedure FormLibTreeExpanded(Sender: TObject; Node: TTreeNode);
    procedure FormLibTreeCollapsed(Sender: TObject; Node: TTreeNode);
    procedure FormLibTreeDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormLibTreeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
		procedure FormLibTreeStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure FormLibTreeCompare(Sender: TObject; Node1, Node2: TTreeNode;
      Data: Integer; var Compare: Integer);
    procedure edtFindKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnFindClick(Sender: TObject);
    procedure FormLibTreeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormLibTreeEndDrag(Sender, Target : TObject; X, Y : Integer);
    procedure PanelSearchResize(Sender: TObject);
  private
		FormsLibIndex: TList;                  //straight list of forms in tree
    FFoundFormsList: TStringList;          //list of found forms during a find
    FFoundIndex: Integer;
    FFoundCount: Integer;
    FNewSearch: Boolean;
  private
    procedure EnableThemes;
    procedure InitTreeView;
    procedure UpdateFormCountDisplay;
  protected
    procedure DestroyWindowHandle; override;
    function AddSelectedFormToContainer(useNewDoc: Boolean): Boolean;
    procedure GatherAllFormInfoSpecs(FormSpecList: TStringList);
    function AskForFileName(var AFileName: String): Boolean;
  public
    FormCount: Integer;
    PageCount: Integer;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AfterConstruction; override;
		function AddNewNode(var first: Boolean; lastNode: TTreeNode; name: String): TTreeNode;
    procedure ClearTree;
    procedure FillTree(dirPath: String;  LastNode: TTreeNode);
		procedure BuildTree(sender: TObject);
    procedure RemovePriorityNumbersFromFolders;
		function GetFormFilePath(FormUID: LongInt; var filePath: String): Boolean;
    function GetFormInfo(FormUID: LongInt): TFormIDInfo;
    procedure FindFirstForm;  //uses find in FormLib
    procedure FindNextForm;
    function FindForms(keyWords: String; matchAll: Boolean; var resultList: TStringList): Boolean;
    procedure WriteDebugFormInfo;
    procedure GatherAllFormWithSummaryAndRestricted(FormSpecList: TStringList);
    procedure WriteOutFormsWithSummaryAndRestricted;
 end;

 type
   TFindFormInfo = class(TObject)
    FNode : TTreeNode;
    FHits : integer;
  end;

// this is a record struc for holding an index list of formID to FormLib Nodes to actually get to the files
	FormLibIndxRec = record       //used for quick index into the forms library tree
		FormUID: LongInt;           //the form unique identifier
		NodeUID: HTreeItem;         //the node holding the form's file info
	end;
	pFormLibIndxRec = ^FormLibIndxRec;    //ptr to the index rec

var
  FormsLib: TFormsLib;

implementation

{$R *.DFM}

uses
  Windows,
  Dialogs,
  Registry,
  RzSplit,
  StrUtils,
  SysUtils,
  Contnrs,
  UContainer,
  UDrag,
  UFiles,
  UForm,
  UPage,
  UGlobals,
  UMain,
  UStatus,
  UUtil1,
  UUtil2,
  UVersion,
  UWordProcessor,
  UWindowsInfo,
  UxTheme;

const
  /// summary: The name of the setting that describes where the form is docked.
  CSettingName_DockControl = 'DockControl';

  /// summary: The name of the setting that describes the width of the dock host control.
  CSettingName_DockWidth = 'DockWidth';

  imgDocReg       = 0;
  imgDocSelected  = 1;
	imgFolderClosed = 4;
  imgFolderOpen   = 2;
  NoMatchStr      = 'No Match Found';
  
(*
type
// this is a record struc for holding an index list of formID to FormLib Nodes to actually get to the files
	FormLibIndxRec = record       //used for quick index into the forms library tree
		FormUID: LongInt;           //the form unique identifier
		NodeUID: HTreeItem;         //reference to node holding the form's file info
	end;
	pFormLibIndxRec = ^FormLibIndxRec;    //ptr to the index rec
*)


constructor TFormsLib.Create(AOwner: TComponent);
var
  Control: TControl;
  dpiX: Integer;
  dpiY: Integer;
begin
  FormsLibIndex := TList.Create;
  inherited Create(AOwner);
  SettingsName := CFormSettings_FormsLib;

  if Assigned(Owner) and (Owner is TControl) then
    begin
      Control := Owner as TControl;
      dpiX := GetDeviceCaps(Canvas.Handle, LOGPIXELSX);
      dpiY := GetDeviceCaps(Canvas.Handle, LOGPIXELSY);
      Left := Control.Left + Control.Width - Trunc(dpiX * 2.5) - (dpiX div 2);
      Top := Control.Top + dpiY;
      Width := Trunc(dpiX * 2.5);
      Height := Control.Height - dpiY * 2;
    end;

  Caption := 'Forms Library';

  FNewSearch := True;
  FFoundFormsList := nil;            //empty found list
  btnFind.Enabled := false;
end;

destructor TFormsLib.Destroy;
begin
  inherited;
  FreeAndNil(FormsLibIndex);
end;

/// summary: Restores the dock state after construction.
procedure TFormsLib.AfterConstruction;
begin
  if (FormsLibIndex.Count = 0) then
    InitTreeView;

  inherited;
end;
// just determines whether to add a child or straight add
function TFormsLib.AddNewNode(var first: Boolean; lastNode: TTreeNode; name: String): TTreeNode;
begin
  if first then
    begin
			result := FormLibTree.Items.AddChild(LastNode, Name);   //add a new folder
      first := False;
    end
  else
		result := FormLibTree.Items.Add(LastNode, Name);
end;

/// summary: Clears the forms library tree and releases memory.
procedure TFormsLib.ClearTree;
begin
  FormCount := 0;
  PageCount := 0;
  UpdateFormCountDisplay;
  FormLibTree.Items.Clear;
  while (FormsLibIndex.Count > 0) do
    Dispose(FormsLibIndex.Extract(FormsLibIndex.First));
end;

// Fill Tree uses recursion to fill the nodes of the library tree
// always enter filltree after finding a folder, so last node is the folder node
//### need to handle sys hidden and volume files
procedure TFormsLib.FillTree(dirPath: String; LastNode: TTreeNode);
var
  foundFile: TSearchRec;
  firstChild : Boolean;
  filePath: String;
  pIndex: pFormLibIndxRec;
  formInfo: TFormIDInfo;
begin
  FormLibTree.AlphaSort;				//sort this directory
  firstChild := True;
  filePath := dirPath + '\*.*';
  if FindFirst(filePath, faAnyFile, foundFile) = 0 then   //found something in folder
    try
      repeat                                              //iterate because we may find '.' files
        If (foundFile.Name <> '.') and (foundFile.Name <> '..') then     //only good names
          begin
            if ((foundFile.attr and faHidden)= 0) and
               ((foundFile.attr and faSysFile)= 0) and
               ((foundFile.attr and faVolumeID)= 0) then

                If ((foundFile.Attr and faDirectory) >0) then            // if its a deirectory, need to search again
                  begin
                    LastNode := AddNewNode(firstChild, LastNode, foundFile.Name);
                    LastNode.ImageIndex := imgFolderClosed;              // show this directory in tree
                    LastNode.SelectedIndex := imgFolderClosed;

                    FillTree(dirPath + '\' + foundFile.Name , lastNode);   //start filling the tree with new dir path
                  end
                else  // found a file, if ours, catalog it
                  begin
                    formInfo := GetFileInfo(dirPath, foundFile);  //we have to check if found file is a form before (!) adding new node to tree
                    if assigned(formInfo) then
                      begin
                        LastNode := AddNewNode(firstChild, LastNode, foundFile.Name);
                        LastNode.ImageIndex := imgDocReg;                        //set the image index
                        LastNode.SelectedIndex := imgDocSelected;
                        LastNode.Data := TObject(formInfo);     // Get file header info, nil if none
                        //we already check if LastNode.Data <> nil then              // it was one of ours so index it
                        //  begin
                        New(pIndex);                                              //get a new index record
                        pIndex^.FormUID := TFormIDInfo(LastNode.Data).fFormUID;   //unique id of this form
                        pIndex^.NodeUID := LastNode.ItemID;                       //unique if this node
                        FormsLibIndex.Add(pIndex);                                //add the rec to the index list

                        FormCount := FormCount +1;
                        PageCount := PageCount + TFormIDInfo(LastNode.Data).fFormPgCount;
                         // end;
                      end;
                  end;
          end;
       until FindNext(foundFile) <> 0;
    finally
      FindClose(foundFile);     //free findRec memory
    end;
end;

procedure TFormsLib.RemovePriorityNumbersFromFolders;
var
  n: Integer;
  Node: TTreeNode;
begin
  for n := 0 to FormLibTree.Items.count-1 do
    begin
      Node:= FormLibTree.Items[n];
      Node.Text := TrimNumbersLeft(Node.text);
    end;

  if visible then
    FormLibTree.rePaint;
end;

// Start building the forms library tree for display
procedure TFormsLib.BuildTree(sender: TObject);
  var
  dirRec: TSearchRec;
	LastNode: TTreeNode;
	startPath: String;
begin
	startPath := appPref_DirFormLibrary;

	If FindFirst(startPath, faDirectory, dirRec) =0 then   //found the library dir}
    begin
      lastNode := nil;
      FillTree(startPath, lastNode);                  //start filling the tree
    end
  else
    begin
			ShowNotice('The Forms Library could not be found.');      //### use browse alert
    end;

	FindClose(dirRec);

  FormLibTree.SortType := stNone;        //no more sorting
  RemovePriorityNumbersFromFolders;      //remove User Priority Numbers from File Names
end;

//expand a node on the tree
procedure TFormsLib.FormLibTreeExpanded(Sender: TObject; Node: TTreeNode);
begin
  Node.ImageIndex := imgFolderOpen;
  Node.SelectedIndex := imgFolderOpen;
  FormLibTree.rePaint;
end;

//collaspe a node on the tree
procedure TFormsLib.FormLibTreeCollapsed(Sender: TObject; Node: TTreeNode);
begin
  Node.ImageIndex := imgFolderClosed;
  Node.SelectedIndex := imgFolderClosed;
  FormLibTree.rePaint;
end;

//when double click on form append to current window
//or if controlKey is down insert into new window
procedure TFormsLib.FormLibTreeDblClick(Sender: TObject);
begin
  AddSelectedFormToContainer(ControlKeyDown);
  if ShiftKeyDown then Self.Close;
end;

//when keydown = Insert, add to doc, if Cntl pressed, add into new window
procedure TFormsLib.FormLibTreeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN:
      begin
        if (ssCtrl in Shift) then   //control key down
          begin
            if AddSelectedFormToContainer(False) then
              begin
                MessageBeep(MB_ICONEXCLAMATION);
                if (ssShift in Shift) then Self.Close;
              end;
          end
        else if not assigned(FFoundFormsList) then
          FindFirstForm
        else
          FindNextForm;

        Key := 0;    //eat the key
      end;

    VK_INSERT:
      begin
        if AddSelectedFormToContainer(ssCtrl in Shift) then  //if Cntl down, create a new doc
          begin
            MessageBeep(MB_ICONEXCLAMATION);
            if (ssShift in Shift) then Self.Close;            //if Shift down, hide the window
          end;
        Key := 0;
      end;
  end;
end;

/// summary: Enables Windows themes on the tree control.
procedure TFormsLib.EnableThemes;
var
  Version: TWindowsVersion;
begin
  // set vista theme
  Version := TWindowsVersion.Create(nil);
  try
    if (Ord(version.Product) >= Ord(wpWinVista)) then
      SetWindowTheme(FormLibTree.Handle, 'explorer', nil);
  except;
  end;
  FreeAndNil(Version);
end;

procedure TFormsLib.InitTreeView;
var
  SavedEnabled: Boolean;
begin
  // build tree
  SavedEnabled := Enabled;
  LockWindowUpdate(Handle);
  try
    Enabled := False;
    FormLibTree.ReadOnly := True;
    FormLibTree.SortType := stText;
    EnableThemes;

    ClearTree;
    BuildTree(nil);
    UpdateFormCountDisplay;
  finally
    LockWindowUpdate(0);
    Enabled := SavedEnabled;
  end;
end;

/// summary: Updates the form and page count displayed on the status bar.
procedure TFormsLib.UpdateFormCountDisplay;
begin
  stbrTreeView.Panels[0].Text := IntToStr(FormCount) + ' Forms';
  stbrTreeView.Panels[1].Text := IntToStr(PageCount) + ' Pages';
end;

/// summary: Destroys the window handle and clears the tree view.
procedure TFormsLib.DestroyWindowHandle;
begin
  ClearTree;
  inherited;
end;

function TFormsLib.AddSelectedFormToContainer(useNewDoc: Boolean): Boolean;
var
  AForm: TDocForm;
	AFormIndex: Integer;
	Node: TTReeNode;
	FormUID: TFormUID;
	topDoc: TContainer;
  FormIsSelected: Boolean;
begin
  FormIsSelected := False;
  with FormLibTree do
    begin
      Node := Selected;
      if Node.Data <> nil then
        begin
          FormUID := TFormUID.Create;                 //create identifier object
          try
            FormUID.ID := TFormIDInfo(Node.Data).fFormUID;          // this is form ID
            FormUID.Vers := TFormIDInfo(Node.Data).fFormVers;       // its version number
            if useNewDoc then
              begin
                Main.FileNewDoc(FormUID);         //create new window to display it
              end
            else   //default is to add to open window, if not one create one
              begin
                if (GetTopMostContainer is TContainer) then
                  begin
                    topDoc := GetTopMostContainer as TContainer;
                    if not topDoc.Locked then
                      begin
                        AForm := topDoc.InsertFormUID(FormUID, True,-1);  //add to current window
                        AFormIndex := topDoc.docForm.IndexOf(AForm);
                        if (AFormIndex > 0) and topDoc.PromptLinkWordProcessorPages(topDoc.docForm[AFormIndex - 1], AForm) then
                          topDoc.LinkWordProcessorPages(topDoc.docForm[AFormIndex - 1], AForm);
                      end
                    else
                      Main.FileNewDoc(FormUID);                       //do this if doc is locked
                  end
                else
                  Main.FileNewDoc(FormUID);                       //do this if no window is open
              end;
            FormIsSelected := True;
          finally
            FormUID.Free;                            //free the identifier object
          end;
        end;
    end;
  Result := FormIsSelected;
end;

//handle mouseDown to check for start of a drag operation
procedure TFormsLib.FormLibTreeMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	HT: THitTests;
	Node: TTReeNode;
begin
	if (sender is TTreeView) then
		with sender as TTReeView do
			begin
        if ssDouble in Shift then
          begin
            if AddSelectedFormToContainer(ssCtrl in Shift) then
              //special for Richard
              if testVersion and (ssShift in Shift) then
                Self.Close;
          end
        else
          begin
            HT := GetHitTestInfoAt(X, Y);
            if (htOnItem in HT) or (HtOnIcon in HT) or (HtOnLabel in HT) then
              begin
                Node := GetNodeAt(X, Y);
                if Node.data <> nil then      //a valid has been made, start dragging it
                  begin
                    BeginDrag(False, 5);      //system call
                  end;
              end;
          end;
			end;
end;

//Build the special Drag object
procedure TFormsLib.FormLibTreeStartDrag(Sender: TObject; var DragObject: TDragObject);
var
	Node: TTReeNode;
	FormUID: TFormUID;
	DragForm: TDragFormObject;
begin
	if (sender is TTreeView) then
		with sender as TTReeView do
			begin
				Node := Selected;
        if Node.Data <> nil then
					begin
  					FormUID := TFormUID.Create;                 //create identifier object
						FormUID.ID := TFormIDInfo(Node.Data).fFormUID;          // this is form ID
            FormUID.Vers := TFormIDInfo(Node.Data).fFormVers;       // its version number

            DragForm := TDragFormObject.Create;
            DragForm.FForm    := FormUID;
            DragForm.hasData  := False;				 //no data at this point
            DragForm.theForm  := nil;					 //docForm where the data is located
            DragForm.theDoc   := nil;						 //so we make sure we dont' drag onto ourselves

            DragObject := DragForm;
					end;
      end;
end;

procedure TFormsLib.FormLibTreeEndDrag(Sender, Target: TObject; X, Y : Integer);
begin
  if ShiftKeyDown and (Target <> nil) then      //  Target accepted the drag
    Self.Close;                                 //  just like a Shift-Enter or Shift-DoubleClick
end;

/// summary: Manually resizes and positions the search panel controls.
procedure TFormsLib.PanelSearchResize(Sender: TObject);
begin
  // as originally designed
  edtFind.Left := 3;
  edtFind.Top := 4;
  edtFind.Width := PanelSearch.Width - 82;
  btnFind.Left := PanelSearch.Width - 70;
  btnFind.Top := 2;
end;

// This is a helper routine for other objects that need to get to
// a file from the forms library
function TFormsLib.GetFormFilePath(FormUID: Integer; var filePath: String): Boolean;
var
  n: Integer;
  foundIt: Boolean;
  NodeUID: HTreeItem;
  Node: TTreeNode;
begin
  filePath := '';
  if FormsLibIndex.count > 0 then
  begin
    n := 0;
    FoundIt := False;
    while (not FoundIt) and (n < FormsLibIndex.count) do
    begin
      if (FormsLibIndex.Items[n] <> nil) then
        if (pFormLibIndxRec(FormsLibIndex.Items[n])^.FormUID = FormUID) then
          begin
            foundIt := True;
            NodeUID := pFormLibIndxRec(FormsLibIndex.Items[n])^.NodeUID;
            Node:= FormLibTree.Items.GetNode(NodeUID);

            if Node <> nil then
              filePath := TFormIDInfo(Node.Data).fFormFilePath;
          end;
      n := n + 1;
     end;
  end;
  result := length(filePath) > 0;     // do we actually have a filePath
end;

//THis is a helper routine to get the Form's Info
Function TFormsLib.GetFormInfo(FormUID: LongInt): TFormIDInfo;
var
  n: Integer;
  foundIt: Boolean;
  NodeUID: HTreeItem;
  Node: TTreeNode;
begin
  result := nil;
  if FormsLibIndex.count > 0 then
  begin
    n := 0;
    FoundIt := False;
    while (not FoundIt) and (n < FormsLibIndex.count) do
    begin
      if (FormsLibIndex.Items[n] <> nil) then
        if (pFormLibIndxRec(FormsLibIndex.Items[n])^.FormUID = FormUID) then
          begin
            foundIt := True;
            NodeUID := pFormLibIndxRec(FormsLibIndex.Items[n])^.NodeUID;
            Node:= FormLibTree.Items.GetNode(NodeUID);
            if Node <> nil then
              begin
                result := TFormIDInfo.Create;

                //### eventually build an Assign for this
                result.fFormIsMac := TFormIDInfo(Node.Data).fFormIsMac;                 // what format are the numbers in
                result.fFormUID := TFormIDInfo(Node.Data).fFormUID;                     // Unique identifier if a form, 0 is other type
                result.fFormVers := TFormIDInfo(Node.Data).fFormVers;                   // revision number of this form
                result.fFormPgCount := TFormIDInfo(Node.Data).fFormPgCount;             // number of pages in the form
                result.fFormFilePath := TFormIDInfo(Node.Data).fFormFilePath;           // where the file is located
                result.fFormName := TFormIDInfo(Node.Data).fFormName;                   // Industry Name of this form
                result.fFormIndustryName := TFormIDInfo(Node.Data).fFormIndustryName;   // industry classification  (ie apraisal..)
                result.fFormCategoryName := TFormIDInfo(Node.Data).fFormCategoryName;   // classification within the industry  (ie residential appraising
                result.fFormKindName := TFormIDInfo(Node.Data).fFormKindName;           // kind within the classification  (ie URAR residential appraising
                result.fCreateDate := TFormIDInfo(Node.Data).fCreateDate;               // date the form or file was created
                result.fLastUpdate := TFormIDInfo(Node.Data).fLastUpdate;               // date this form or file was updated
                result.fLockSeed := TFormIDInfo(Node.Data).fLockSeed;                   // the seed for creating unique registration and unlocking numbers
                result.fFormAtts := TFormIDInfo(Node.Data).fFormAtts;                   // 32 attributes of this form
                result.fFormIndustryCode[1]  := TFormIDInfo(Node.Data).fFormIndustryCode[1];   // holds industry standard codes for forms
                result.fFormIndustryCode[2]  := TFormIDInfo(Node.Data).fFormIndustryCode[2];
                result.fFormIndustryDate  := TFormIDInfo(Node.Data).fFormIndustryDate;		// industry date of the form
              end;
          end;
      n := n + 1;
     end;
  end;
end;

function TFormsLib.FindForms(keyWords: String; matchAll: Boolean; var resultList: TStringList): Boolean;
type
  strArray = array[1..7] of string;
var
  Node: TTreeNode;
  NodeUID: HTreeItem;
  fInfo: TFindFormInfo;
  done: boolean;
  nTokens, nHits: Integer;
  i,m,n,c: Integer;
  kwStr, SStr: String;
  fName, code1, code2: String;
  tokens : array[0..9] of string;    //we can search on 9 key words at a time

  {search for the tokens in the searchStr}
  function FoundTokensIn(searchStr : string; var hits: Integer): boolean;
  var
    foundToken: boolean;
    ind: integer;
  begin
    searchStr := UpperCase(searchStr);
    if matchAll then
      begin
        foundToken := true;
        for ind := 0 to nTokens - 1 do             //test all tokens in searchStr
          if Pos(tokens[ind], searchStr) = 0 then
            foundToken := false;

        if foundToken then      //if all matched then inc hit count
          inc(hits);
      end
    else
      begin
        foundToken := false;
        for ind := 0 to nTokens - 1 do
          if Pos(tokens[ind], searchStr) > 0 then
            begin
              foundToken := true;       //got a hit
              inc(hits);                //Increment hit count
            end; // if
      end;
    Result := foundToken;
  end;

begin
  result := False;
  try
    if not assigned(resultList) then         //make sure we have a place for results
      resultList := TStringList.Create

    else while resultList.Count > 0 do begin //were sent a list, make sure its clean
      resultList.Objects[0].Free;
      resultList.Delete(0);
    end;

    //filter what we have to search on
    kwStr := Trim(keyWords);
    if (kwStr = '') or (kwStr = noMatchStr) then
      Exit;     //no exceptions - just beep

    for i := 0 to 9 do                        // Clear token holder
      tokens[i] := '';

    nTokens := 0;                             //identify the tokens & count then
    while Length(kwStr) > 0 do
    begin
      c := Pos(' ', kwStr);
      if c > 0 then
        begin
          tokens[nTokens] := UpperCase(LeftStr(kwStr, c - 1));
          Delete(kwStr, 1, c);
          kwStr := TrimLeft(kwStr);
        end
      else
        begin
          tokens[nTokens] := UpperCase(kwStr);
          kwStr := '';
        end; // if
      inc(nTokens);
    end; // while

    n := 0;
    if FormsLibIndex.count > 0 then
      while n < FormsLibIndex.count do
        begin
          if FormsLibIndex.Items[n] <> nil then
            begin
              NodeUID := pFormLibIndxRec(FormsLibIndex.Items[n])^.NodeUID;
              Node:= FormLibTree.Items.GetNode(NodeUID);
              if (node <> nil) then
                begin
                  nHits := 0;
                  fName := TFormIDInfo(Node.Data).fFormFilePath;
                  fName := ExtractFileName(fName);

                  with TFormIDInfo(Node.Data) do
                    SStr :=  fName + ' ' +
                            IntToStr(fFormUID) + ' ' +
                            fFormName + ' ' +
                            FFormIndustryName + ' ' +
                            fFormIndustryDate + ' ' +
                            fFormCategoryName + ' ' +
                            fFormKindName + ' ' +
                            fFormIndustryCode[1] + ' ' +
                            fFormIndustryCode[2];

                  {$BOOLEVAL ON}
                  If FoundTokensIn(SStr, nHits) then
                  begin
                    {We had a match with nHits of matches on the tokens}
                    fInfo := TFindFormInfo.Create;
                    fInfo.fHits := nHits;
                    fInfo.fNode := node;

                    //compose form display name
                    code1 := TFormIDInfo(Node.Data).fFormIndustryCode[1];
                    code2 := TFormIDInfo(Node.Data).fFormIndustryCode[2];
                    if (length(code1)>0) or (length(code2)>0) then
                      fName := fName + '  ---- ' + code1;
                    if (length(code2)>0) then
                      if (length(code1)>0) then
                        fName := fName + ' / ' + Code2
                      else
                        fName := fName + Code2;

                    {now sort, put forms with most matche hits at top}
                    m := 0;
                    done := false;
                    while not done and (m < resultList.Count) do begin
                      if TFindFormInfo(resultList.Objects[m]).fHits < nHits then
                        begin
                          resultList.InsertObject(m, fName, fInfo);
                          done := true;
                        end
                      else
                        inc(m);
                    end; // while

                    if not done then
                      resultList.AddObject(fName, fInfo);

                    result := True;
                  end; // if found match
                  {$BOOLEVAL OFF}

                end; //if node <> nil
              end; // if item <>nil

          inc(n);   //check next form
        end; // while
  except
    result := False;
  end
end;

procedure TFormsLib.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Application.Terminated then
    Action := caFree
	else
    Action := caHide;

  Main.FormsLibraryMItem.caption := 'Show Forms Library';
end;

procedure TFormsLib.FormLibTreeCompare(Sender: TObject; Node1,
	Node2: TTreeNode; Data: Integer; var Compare: Integer);
begin
	compare := CompareText(Node1.text, Node2.text);
end;

//click to start the search
procedure TFormsLib.btnFindClick(Sender: TObject);
begin
  if FNewSearch then
    begin
      //clear out previous results before starting
      if assigned(FFoundFormsList) then         //delete old find if any
        begin
          while FFoundFormsList.Count > 0 do    // Loop to free all objects
            begin
              FFoundFormsList.Objects[0].Free;
              FFoundFormsList.Delete(0);
            end;
          FreeAndNil(FFoundFormsList);
        end;
      FNewSearch := False;
    end;

  if edtFind.Text = '' then
    edtFind.SetFocus
  else if (not assigned(FFoundFormsList)) or (FFoundFormsList.Count = 0) then
    FindFirstForm
  else
    FindNextForm;
end;

//enter search text and start the find here
procedure TFormsLib.edtFindKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key <> VK_RETURN then
    begin
      btnFind.Enabled := True;
      btnFind.Caption := 'Find';
      FNewSearch := True;
    end;

  //the first search starts here in edtFind then transfers to TreeComponent
  if Key = VK_RETURN then
    begin
      //clear out previous results before starting
      if assigned(FFoundFormsList) then         //delete old find if any
        begin
          while FFoundFormsList.Count > 0 do    // Loop to free all objects
            begin
              FFoundFormsList.Objects[0].Free;
              FFoundFormsList.Delete(0);
            end;
          FreeAndNil(FFoundFormsList);
        end;

      FindFirstForm;
      Key := 0;
    end;
end;

procedure TFormsLib.FindFirstForm;
begin
  if FindForms(edtFind.Text, False, FFoundFormsList) then
    begin
      FFoundIndex := 0;
      FFoundCount := FFoundFormsList.Count;
      if FFoundCount > 1 then btnFind.Caption := 'Find Again';
      FormLibTree.SetFocus;
      FormLibTree.Select(TFindFormInfo(FFoundFormsList.Objects[FFoundIndex]).fNode);
    end
  else
    begin
      edtFind.Text := NoMatchStr;
      edtFind.SelectAll;
      edtFind.SetFocus;
    end;
end;

procedure TFormsLib.FindNextForm;
begin
  if FFoundCount > 0 then
    begin
      FFoundIndex := CycleForward(FFoundIndex, 0, FFoundCount-1);
      FormLibTree.SetFocus;
      FormLibTree.Select(TFindFormInfo(FFoundFormsList.Objects[FFoundIndex]).fNode);
    end;
end;

function TFormsLib.AskForFileName(var AFileName: String): Boolean;
var
  SaveFile: TSaveDialog;
begin
  if (length(AFileName) > 0) then
    begin
      if FileExists(AFileName) then
        DeleteFile(AFileName);
      result := true;
    end
  else begin
    result := False;
    SaveFile := TSaveDialog.Create(nil);
    try
      //why are we saving debug files to appPref_DirLastMISMOSave ??
      SaveFile.Title := 'Specify a file name for the Debug Report';
      saveFile.InitialDir := appPref_DirLastMISMOSave;
      SaveFile.DefaultExt := 'csv';
      SaveFile.Filter := 'CSV File(.csv)|*.csv';
      SaveFile.FilterIndex := 1;
      SaveFile.Options := SaveFile.Options + [ofOverwritePrompt];
      if SaveFile.Execute then
        begin
          AFileName := SaveFile.FileName;
          appPref_DirLastMISMOSave := ExtractFilePath(AFileName);
          result := True;
        end;
    finally
      SaveFile.Free;
    end;
  end;
end;

procedure TFormsLib.GatherAllFormInfoSpecs(FormSpecList: TStringList);
var
  Node: TTreeNode;
  NodeUID: HTreeItem;
  n: Integer;
  fName,InfoStr: String;
begin
  n := 0;
  if FormsLibIndex.count > 0 then
    while n < FormsLibIndex.count do
      begin
        if FormsLibIndex.Items[n] <> nil then
          begin
            NodeUID := pFormLibIndxRec(FormsLibIndex.Items[n])^.NodeUID;
            Node:= FormLibTree.Items.GetNode(NodeUID);
            if (node <> nil) then
              begin
                fName := TFormIDInfo(Node.Data).fFormFilePath;
                fName := ExtractFileName(fName);

                with TFormIDInfo(Node.Data) do
                  InfoStr :=  fName + ',' +
                              fFormName + ',' +
                              IntToStr(fFormUID) + ',' +
                              IntToStr(fFormVers) + ',' +
                              IntToStr(fFormPgCount) + ',' +
                              IntToStr(fFormCategoryID) + ',' +
                              fFormCategoryName + ',' +
                              IntToStr(fFormKindID) + ',' +
                              fFormKindName + ',' +
                              fCreateDate + ',' +
                              fLastUpdate + ',' +
                              IntToStr(fLockSeed) + ',' +
                              IntToStr(fFormIndustryID) + ',' +
                              FFormIndustryName + ',' +
                              fFormIndustryDate + ',' +
                              fFormIndustryCode[1] + ',' +
                              fFormIndustryCode[2];
               FormSpecList.add(InfoStr);
              end;
          end;
        inc(n);   //check next form
      end; // while
end;

procedure TFormsLib.WriteDebugFormInfo;
var
  AFileName: String;
  SpecList: TStringList;
  titleStr: String;
begin
  if AskForFileName(AFileName) then
    begin
      SpecList := TStringList.Create;
      titleStr := 'FileName,'+
                  'FormName,'+
                  'FormUID,'+
                  'FormVers,'+
                  'PgCount,'+
                  'CategoryID,'+
                  'CategoryName,'+
                  'KindID,'+
                  'KindName,'+
                  'CreateDate,'+
                  'LastUpdate,'+
                  'LockSeed,'+
                  'IndustryID,'+
                  'IndustryName,'+
                  'IndustryDate,'+
                  'IndustryCode1,'+
                  'IndustryCode2,';
      SpecList.Add(titleStr);
      try
        GatherAllFormInfoSpecs(SpecList);
        SpecList.SaveToFile(AFileName);
      finally
        SpecList.Free;
      end;
    end;
end;

procedure TFormsLib.GatherAllFormWithSummaryAndRestricted(FormSpecList: TStringList);
var
  fPath: String;
  doc: TContainer;
  AForm: TDocForm;
  FTList: TObjectList;
  fuid: TFormUID;
  index, n, pg: integer;
  Summary, SummaryAppr, Restricted, RestrictedUse: Integer;
begin
  Main.FileNewCmd.Execute;
  doc := Main.ActiveContainer;

  fuid := TFormUID.Create;
  PushMouseCursor(crHourGlass);
  try
    //load each form to search text
    for index := 0 to FormsLib.FormLibTree.Items.Count - 1 do
      begin
        if Assigned(FormsLib.FormLibTree.Items[index].Data) then
          begin
            fPath := TFormIDInfo(FormsLib.FormLibTree.Items[index].Data).fFormFilePath;
            fuid.ID := TFormIDInfo(FormsLib.FormLibTree.Items[index].Data).fFormUID;
            fuid.Vers := TFormIDInfo(FormsLib.FormLibTree.Items[index].Data).fFormVers;
            AForm := doc.InsertBlankUID(fuid, True, -1);
//            AForm := doc.InsertFormUID(fuid, true, -1);
            Application.ProcessMessages;

            Summary := 0;
            SummaryAppr := 0;
            Restricted := 0;
            RestrictedUse := 0;

//            if fuid.ID = 1305 then
//              beep;

            for pg := 0 to AForm.frmPage.Count -1 do
              begin
                FTList := TDocPage(AForm.frmPage[pg]).pgDesc.PgFormText;
                if assigned(FTList) then
                  for n := 0 to FTList.count-1 do
                    begin
                      if POS('SUMMARY APPRAISAL', Uppercase(TPgFormTextItem(FTList[n]).StrText)) > 0 then
                        begin
                          SummaryAppr := SummaryAppr +1;
                        end
                      else if POS('SUMMARY', UpperCase(TPgFormTextItem(FTList[n]).StrText)) > 0 then
                        begin
                          Summary := Summary +1;
                        end;

                      if POS('RESTRICTED USE', Uppercase(TPgFormTextItem(FTList[n]).StrText)) > 0 then
                        begin
                          RestrictedUse := RestrictedUse +1;
                        end
                      else if POS('RESTRICTED', Uppercase(TPgFormTextItem(FTList[n]).StrText)) > 0 then
                        begin
                          Restricted := Restricted +1;
                        end;
                    end;
              end;
            if Summary > 0 then
              FormSpecList.Add(IntToStr(fuid.ID) + ':  ' + 'check for Summary:   ' + fPath);
            if SummaryAppr > 0 then
              FormSpecList.Add(IntToStr(fuid.ID) + ':  ' + 'Summary Appraisal:   ' + fPath);
            if Restricted > 0 then
              FormSpecList.Add(IntToStr(fuid.ID) + ':  ' + 'check for Restricted:   ' + fPath);
            if RestrictedUse > 0 then
              FormSpecList.Add(IntToStr(fuid.ID) + ':  ' + 'Restricted Use:   ' + fPath);

            if (SummaryAppr > 0) or (RestrictedUse > 0) or (Restricted > 0) or (Summary > 0) then
              beep
            else
              FormSpecList.Add(IntToStr(fuid.ID) + ':  ' + 'Form is USPAP Ok:');
          end;
      end;
  finally
    PopMouseCursor;
    fuid.free;
  end;
end;

procedure TFormsLib.WriteOutFormsWithSummaryAndRestricted;
var
  AFileName: String;
  SpecList: TStringList;
begin
  if AskForFileName(AFileName) then
    begin
      SpecList := TStringList.Create;
      try
        GatherAllFormWithSummaryAndRestricted(SpecList);
        SpecList.SaveToFile(AFileName);
      finally
        SpecList.Free;
      end;
    end;
end;

end.


