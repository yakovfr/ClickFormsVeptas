unit UTools;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2017 by Bradford Technologies, Inc. }


interface


uses
  UGlobals, UContainer, UCell, UWinUtils, UCellMetaData, Dialogs, StdCtrls,classes,UBase,
  UToolSketchMgr, UAreaSketchForm, {UAreaSketchSEForm,} UApexExForm, UApex6ExForm, URapidSketchForm, UPhoenixSketchForm,
  UForm, Forms;


  procedure LaunchGPSConnector(doc: TContainer);
  //procedure LaunchClickNOTES(doc: TContainer);
  procedure LaunchPhotoSheet;
  procedure LaunchCompEditor(doc: TContainer);
  procedure LaunchPlugInTool(ToolID: Integer; doc: TContainer; cell: TBaseCell);

  procedure LaunchApex(Doc: TContainer; DestCell: TBaseCell; toolVers: Integer);
  //procedure LaunchJDBSketch(Doc: TContainer; DestCell: TBaseCell);
  procedure LaunchAreaSketchPro(Doc: TContainer; DestCell: TBaseCell);
  //procedure LaunchAreaSketchSE(Doc: TContainer; DestCell: TBaseCell);
  procedure LaunchRapidSketch(Doc: TContainer; DestCell: TBaseCell);
  procedure LaunchPhoenixSketch(doc: TContainer; sketchCell: TBaseCell);
//  Procedure LaunchWinSketch(Doc: TContainer; DestCell: TBaseCell);
  function CreateDeleteSketchDialog(pgcount: integer): TForm;
implementation

uses
  SysUtils, Controls, UMain,
  UStatus, UCompEditor, UUtil1, UUtil2,
  UToolMapMgr, UPhotoSheet, //UClickNOTES,
  UGPSConnector, UMapPortalMapMgr;

function CreateDeleteSketchDialog(pgcount: integer): TForm;
var
  s: string;
  Dlg: TForm;
  haschildpages: boolean;
begin

  haschildpages := pgcount>1;
  if haschildpages = false then
    begin
      s := 'You have chosen to delete this sketch.' + chr(13) + chr(13);
      s := s + 'This will PERMANENTLY DELETE the existing sketch AND image!' + chr(13) + chr(13);
      s := s + 'The page on which this sketch is displayed will remain,' + chr(13);
      s := s + 'but will be without an image and can be used for a new sketch.' + chr(13) + chr(13);
      s := s + 'Are you sure you want to delete this sketch?'
    end
    else
    begin
      s := 'You have chosen to delete this sketch.' + chr(13) + chr(13);
      s := s + 'This will PERMANENTLY DELETE the existing sketch AND image!' + chr(13) + chr(13);
      s := s + 'Select "DELETE ALL" if you want to delete the sketch and ALL images.' + chr(13);
      s := s + 'The FIRST PAGE of this sketch file will remain, but will be without' + chr(13);
      s := s + 'an image and will be available for a NEW sketch to be created.' + chr(13) + chr(13);
      s := s + 'Select "Only This Page" if you wish to delete ONLY the current sketch page' + chr(13);
      s := s + 'but NOT remove the sketch file and other sketch images. The sketch will' + chr(13);
      s := s + 'still be available for editing UNLESS the page you are deleting is' + chr(13);
      s := s + 'the FIRST page of the sketch, in which case the remaining sketch images' + chr(13);
      s := s + 'will still be displayed, but will NOT BE EDITABLE!' + chr(13) + chr(13);
      s := s + 'It is recommended that you either delete all OR use your' + chr(13);
      s := s + 'Sketch Program to edit the pages within the sketch file since' + chr(13);
      s := s + 'deleting a single page may make the sketch ineditable in the future.';
    end;

  Dlg := CreateMessageDialog(s, mtConfirmation, [mbYes, mbNo, mbCancel]);
  Dlg.Caption := 'Please Confirm';
  if haschildpages = true then
    TButton(Dlg.FindComponent('Yes')).Caption := 'Delete All';
  TButton(Dlg.FindComponent('Yes')).Left := 75;
  TButton(Dlg.FindComponent('Yes')).Width := 100;

  if haschildpages = true then
    TButton(Dlg.FindComponent('No')).Caption := 'Only This Page'
  else
    TButton(Dlg.FindComponent('No')).Visible := false;
  TButton(Dlg.FindComponent('No')).Left := 200;
  TButton(Dlg.FindComponent('No')).Width := 125;

  TButton(Dlg.FindComponent('Cancel')).Left := 350;
  TButton(Dlg.FindComponent('Cancel')).Width := 75;
  dlg.Canvas.MoveTo(200,TButton(Dlg.FindComponent('No')).Top);
  dlg.Canvas.LineTo(300,TButton(Dlg.FindComponent('No')).BoundsRect.Bottom);
  dlg.Canvas.TextOut(200,TButton(Dlg.FindComponent('No')).BoundsRect.Bottom+3,'DELETES SKETCH');
  Dlg.Width := 500;

  result := Dlg;

end;

procedure HandleMapInterface(ToolID: String; doc: TContainer; cell: TBaseCell; const AppName, AppPath: String; UseAWService: Boolean=False);
begin
  if Assigned(doc) then
    begin
      //there could be a cell data that is yet to be processed
      doc.ProcessCurCell(False);

      //try to get the active sketch cells if there is one
      if not Assigned(Cell) then
        if assigned(doc.docActiveCell) and doc.docActiveCell.classNameIs('TMapLocCell') then
          cell := doc.docActiveCell;

      if Assigned(cell) then
        doc.MapPortalManager.LaunchMapTool(ToolID, cell.InstanceID, UseAWService)
      else
        doc.MapPortalManager.LaunchMapTool(ToolID, GUID_NULL, UseAWService)
    end;
end;

procedure HandleSketcherInterface(ToolID: Integer; doc: TContainer; cell: TBaseCell; const AppName, AppPath: String);
{var
  SketchDataMgr: TSketchDataMgr;}
begin
  //there could be a cell data that is yet to be processed
  if assigned(doc) then
    doc.ProcessCurCell(False);

  //try to get the active sketch cells if there is one
  if assigned(doc) and not assigned(Cell) then
    if assigned(doc.docActiveCell) and doc.docActiveCell.classNameIs('TSketchCell') then
      cell := doc.docActiveCell;

      SketchDataMgr := TSketchDataMgr.CreateSketchMgr(ToolID, doc, cell, AppName, AppPath);
      try
        SketchDataMgr.Execute;  //this object will free itself when tool get Completed Event
      except
        SketchDataMgr.Free;
      end;

end;

procedure LaunchPlugInTool(ToolID: Integer; doc: TContainer; cell: TBaseCell); //, CUID: CellUID);
var
  s,appName, appPath: String;
  index, toolVers: Integer;
  strToolVers: String;
begin
  appName := appPref_PlugTools[ToolID-cPlugInCmdStartNo].AppName;
  appPath := appPref_PlugTools[ToolID-cPlugInCmdStartNo].appPath;

  if Length(appName)>0 then
    case ToolID of
      //sketcher tools
      cmdToolWinSketch{,
      cmdToolPhoenixSketch,
      cmdToolJDBSketcher,
      cmdToolAreaSketch,
      cmdToolApex}:
        HandleSketcherInterface(ToolID, Doc, Cell, appName, appPath);

{      cmdToolWinSketch:
        LaunchWinSketch(Doc, Cell);
}

      //cmdToolAreaSketchSE:
        //LaunchAreaSketchSE(Doc, Cell);

      cmdToolAreaSketch:
        LaunchAreaSketchPro(Doc, Cell);

      cmdToolApex:
        begin //we need to know apex version on the computer
          // appName format := appName + 'v' + vers#
          toolVers := 0;
          index := Pos(' ',trim(appName));
          if Index > 0 then
            begin
              strToolVers := Copy(appName,index + 1, length(appName));
              if strToolVers[1] = 'v' then
                toolVers := StrToIntDef(Copy(strToolVers,2,length(strToolvers)),0);
            end;
          LaunchApex(Doc, Cell, toolVers);
        end;

      cmdToolRapidSketch:
        LaunchRapidSketch(Doc, Cell);

      cmdToolPhoenixSketch:
        LaunchPhoenixSketch(Doc, Cell);

     //location map tools
      cmdToolGeoLocator:
        HandleMapInterface(CGeoLocatorMapPortal, Doc, Cell, appName, appPath);

      cmdToolMapPro:
        HandleMapInterface(CMapProMapPortal, Doc, Cell, appName, appPath);

      cmdToolDelorme:
        HandleMapInterface(CDelormeMapPortal, Doc, Cell, appName, appPath);

      cmdToolStreetNMaps:
        HandleMapInterface(CStreetNMapsMapPortal, Doc, Cell, appName, appPath);

    end //case
  else
    if ToolID in [cmdToolApex, cmdToolAreaSketch, cmdToolRapidSketch, cmdToolWinSketch, cmdToolPhoenixSketch] then
      begin
        appName := 'AreaSketch';
        case ToolID of
          207: appName := 'AreaSketch Pro';
          205: appName := 'Apex';
          201: appName := 'WinSketch';
          208: appName := 'RapidSketch';
          //209: appName := 'AreaSketch Special Edition';
          209: appName := 'PhoenixSketcher';
        end;
        s := 'The selected tool has not been specified in Preferences' + chr(13);
        s := s + 'or is not available on your system.' + chr(13) + chr(13);
        s := s + 'Please be sure you have ' + appName + ' installed properly.';
        application.MessageBox(pchar(s),pchar('Unable to Launch Sketch'),0);
      end;
end;


procedure LaunchApex(Doc: TContainer; DestCell: TBaseCell; toolVers: Integer);
var
  id, frmIndex: integer;
  xSkCell: TSketchCell;
  //xCell: TBaseCell;
  Dlg: TForm;
  DForm: TDocForm;
  FormUID: TFormUID;
  skData: TMemoryStream;
begin
  frmIndex := -1;
  if doc=nil then
    Doc := Main.NewEmptyDoc;
  if not assigned(doc) then
    exit;
  if doc.docActiveCell is TSketchCell then
    xSkCell := (Doc.docActiveCell as TSketchCell)
  else
    //xSkCell := Doc.GetAreaSketchCell;
    xSkCell := TsketchCell(Doc.GetCellByID(cidSketchImage));
//    if xSkCell.Text='' then
//      begin
  if (doc.docForm.Count<>0) and (xSkCell<>nil) then
    begin
      //frmIndex := xSkcell.UID.Occur;
      //need to get 1st sketch cell in the report where metadata stored doesnt meta what cell clicked
      frmIndex := Doc.GetFormIndexByOccur2(xSkCell.UID.FormID, 0,cidSketchImage, xSkCell.text);
    end
  else
    begin
      FormUID := TFormUID.create;
      try
        FormUID.ID := cSkFormLegalUID;
        FormUID.Vers := 1;
        dForm := Doc.InsertFormUID(FormUID, True, frmIndex);
        xSkCell := TSketchCell(dForm.GetCellByID(cidSketchImage));
        //frmIndex := Doc.GetFormIndexByOccur2(cSkFormLegalUID, 0,cidSketchImage, xSkCell.text);
        frmIndex := xSkcell.UID.Form;
      except
        showNotice('The form ID# '+IntToStr(cSkFormLegalUID)+' was not be found in the Forms Library.');
      end;
    end;

//         frmIndex := -1;
  if frmIndex<>-1 then
    begin
      dForm := Doc.docForm[frmIndex];
      xSkCell := TSketchCell(dForm.GetCellByID(cidSketchImage));
    end;
//      end;
    if not assigned(xSkCell) then
      exit;

    if TContainer(Doc).docData.FindData('AREASKETCH') <> nil then
       begin
         TSketchCell(xSkCell).FMetaData := TSketchData.Create(mdAreaSketchData,1,mdNameAreaSketch); //create meta storage
         TSketchCell(xSkCell).FMetaData.FUID := mdAreaSketchData;
         TSketchCell(xSkCell).FMetaData.FVersion := 1;
         TSketchCell(xSkCell).FMetaData.FData := TMemoryStream.Create;      //create new data storage
         TSketchCell(xSkCell).FMetaData.FData.CopyFrom(Doc.docData.FindData('AREASKETCH'), 0);  //save to cells metaData
       end;
    if TContainer(Doc).docData.FindData('APEXSKETCH') <> nil then
       begin
         TSketchCell(xSkCell).FMetaData := TSketchData.Create(mdApexSketchData,1,mdNameApexSketch); //create meta storage
         TSketchCell(xSkCell).FMetaData.FUID := mdApexSketchData;
         TSketchCell(xSkCell).FMetaData.FVersion := 1;
         TSketchCell(xSkCell).FMetaData.FData := TMemoryStream.Create;      //create new data storage
         TSketchCell(xSkCell).FMetaData.FData.CopyFrom(Doc.docData.FindData('APEXSKETCH'), 0);  //save to cells metaData
       end;
    if TContainer(Doc).docData.FindData('WINSKETCH') <> nil then
        begin
         TSketchCell(xSkCell).FMetaData := TSketchData.Create(mdWinSketchData,1,mdNameWinSketch); //create meta storage
         TSketchCell(xSkCell).FMetaData.FUID := mdWinSketchData;
         TSketchCell(xSkCell).FMetaData.FVersion := 1;
         TSketchCell(xSkCell).FMetaData.FData := TMemoryStream.Create;      //create new data storage
         TSketchCell(xSkCell).FMetaData.FData.CopyFrom(Doc.docData.FindData('WINSKETCH'), 0);  //save to cells metaData
        end;
    if TContainer(Doc).docData.FindData('RAPIDKETCH') <> nil then
        begin
         TSketchCell(xSkCell).FMetaData := TSketchData.Create(mdRapidSketchData,1,mdNameRapidSketch); //create meta storage
         TSketchCell(xSkCell).FMetaData.FUID := mdRapidSketchData;
         TSketchCell(xSkCell).FMetaData.FVersion := 1;
         TSketchCell(xSkCell).FMetaData.FData := TMemoryStream.Create;      //create new data storage
         TSketchCell(xSkCell).FMetaData.FData.CopyFrom(Doc.docData.FindData('RAPIDSKETCH'), 0);  //save to cells metaData
        end;

    if (xSkCell.GetMetaData<>-1) and (xSkCell.GetMetaData<>mdApexSketchData) then
      begin
        {Create a dialog with appropriate buttons}
        //Customised buttons' caption: btnYes - sketcher already used in the report, btnNo sketcher selected by user through menu
        Dlg := CreateSketchDialog(mdSketchName[xSkCell.GetMetaData], mdSketchName[mdApexSketchData]);
        id := Dlg.ShowModal;
        case id of
          mrYes: //user selected sketcher used in the report
            begin
              LaunchPlugInTool(mdSketchTool[xSkCell.GetMetaData],Doc, xSkCell); //relaunch  toll with used sketcher
              exit;
            end;
          mrNo:    //user selects to keep sketcher selected in menu  so he will lost sketch data; the different sketcher cannot read the other sketcher data
            begin
              xSkCell.FMetaData.FData.Clear;     //delete meta data
              FreeAndNil(xSkCell.FMetaData);
            end;
          else    //cancel
            exit;
        end;
      end;
    try
      PushMouseCursor;
      case toolVers of
        6, 7:
          begin
            Application.CreateForm(TApex6ExForm, Apex6ExForm);
            Apex6ExForm.FDoc := Doc;
            //get sketch data
            skData := nil;
            if xSkCell.FMetaData <>nil then
              begin
                xSkCell.FMetaData.FData.Position := 0;
                skData := TSketchCell(xSkCell).FMetaData.FData;
              end;
            if not assigned(skData) then    //try old doc data
              skData := Doc.docData.FindData('APEXSKETCH');

            Apex6ExForm.LoadData(skData);
          end;
        else
          begin
            Application.CreateForm(TApexExForm, ApexExForm);
            ApexExForm.FDoc:=Doc;
            ApexExForm.LoadData(ApexExForm.SketchFileData2(xSkCell));     //filename and filedata
          end;
      end;
    except
      ShowMessage('Unable to launch Apex.' + chr(13) + chr(13) + 'Please check the installation of Apex.');
    end;

end;

procedure LaunchRapidSketch(Doc: TContainer; DestCell: TBaseCell);
var
  id, frmIndex: integer;
  xSkCell: TSketchCell;
  xCell: TBaseCell;
  Dlg: TForm;
  DForm: TDocForm;
  FormUID: TFormUID;
begin
  frmIndex := -1;
  if doc=nil then
    Doc := Main.NewEmptyDoc;
  if (Doc <> nil) then
    begin
    if doc.docActiveCell is TSketchCell then
       xSkCell := (Doc.docActiveCell as TSketchCell)
      else
       //xSkCell := Doc.GetAreaSketchCell;
       xSkCell := TSketchCell(Doc.GetCellByID(cidSketchImage));
      if (doc.docForm.Count<>0) and (xSkCell<>nil) then
        begin
         frmIndex := Doc.GetFormIndexByOccur2(xSkcell.UID.FormID, 0,cidSketchImage, xSkCell.text);
        end
        else
        begin
              FormUID := TFormUID.create;
              try
                FormUID.ID := cSkFormLegalUID;
                FormUID.Vers := 1;
                dForm := Doc.InsertFormUID(FormUID, True, frmIndex);
                xCell := dForm.GetCellByID(cidSketchImage);
                xSkCell := TSketchCell(xCell);
                frmIndex := Doc.GetFormIndexByOccur2(xSkCell.UID.FormID, 0,cidSketchImage, xSkCell.text);

              except
                showNotice('The form ID# '+IntToStr(cSkFormLegalUID)+' was not be found in the Forms Library.');
              end;
        end;

         if frmIndex<>-1 then
           begin
              dForm := Doc.docForm[frmIndex];
              xCell := dForm.GetCellByID(cidSketchImage);
              xSkCell := TSketchCell(xCell);
           end;
//      end;
    if xSkCell<>nil then
      begin
    if TContainer(Doc).docData.FindData('APEXSKETCH') <> nil then
       begin
         TSketchCell(xSkCell).FMetaData := TSketchData.Create(mdApexSketchData,1,mdNameApexSketch); //create meta storage
         TSketchCell(xSkCell).FMetaData.FUID := mdApexSketchData;
         TSketchCell(xSkCell).FMetaData.FVersion := 1;
         TSketchCell(xSkCell).FMetaData.FData := TMemoryStream.Create;      //create new data storage
         TSketchCell(xSkCell).FMetaData.FData.CopyFrom(Doc.docData.FindData('APEXSKETCH'), 0);  //save to cells metaData
       end;
    if TContainer(Doc).docData.FindData('WINSKETCH') <> nil then
        begin
         TSketchCell(xSkCell).FMetaData := TSketchData.Create(mdWinSketchData,1,mdNameWinSketch); //create meta storage
         TSketchCell(xSkCell).FMetaData.FUID := mdWinSketchData;
         TSketchCell(xSkCell).FMetaData.FVersion := 1;
         TSketchCell(xSkCell).FMetaData.FData := TMemoryStream.Create;      //create new data storage
         TSketchCell(xSkCell).FMetaData.FData.CopyFrom(Doc.docData.FindData('WINSKETCH'), 0);  //save to cells metaData
        end;
    if TContainer(Doc).docData.FindData('RAPIDKETCH') <> nil then
        begin
         TSketchCell(xSkCell).FMetaData := TSketchData.Create(mdRapidSketchData,1,mdNameRapidSketch); //create meta storage
         TSketchCell(xSkCell).FMetaData.FUID := mdRapidSketchData;
         TSketchCell(xSkCell).FMetaData.FVersion := 1;
         TSketchCell(xSkCell).FMetaData.FData := TMemoryStream.Create;      //create new data storage
         TSketchCell(xSkCell).FMetaData.FData.CopyFrom(Doc.docData.FindData('RAPIDSKETCH'), 0);  //save to cells metaData
        end;

        if (xSkCell.GetMetaData <>-1) and (xSkCell.GetMetaData<>mdRapidSketchData) then
          begin
            {Create a dialog with appropriate buttons}
            Dlg := CreateSketchDialog(mdSketchName[xSkCell.GetMetaData], mdSketchName[mdRapidSketchData]);
            id := Dlg.ShowModal;
            if id=6 then
              begin
                  LaunchPlugInTool(mdSketchTool[xSkCell.GetMetaData],Doc, xSkCell);
              end;
            if id=7 then
              begin
                xSkCell.FMetaData.FData.Clear;     //delete meta data
                FreeAndNil(xSkCell.FMetaData);
                try
                  begin
                    try
                      Application.CreateForm(TRapidSketchForm, RapidSketchForm);
                      PushMouseCursor;
                      RapidSketchForm.FDoc:=Doc;
                      RapidSketchForm.LoadData(RapidSketchForm.SketchFilePath('.rs'), RapidSketchForm.SketchFileData2(xSkCell));     //filename and filedata}
                    except
                      ShowMessage('Unable to launch RapidSketch.' + chr(13) + chr(13) + 'Please check the installation of RapidSketch.');
                    end;
                  end;
                except
              end;
            end;
          end
          else
          begin
            try
              Application.CreateForm(TRapidSketchForm, RapidSketchForm);
              PushMouseCursor;
              RapidSketchForm.FDoc:=Doc;
              RapidSketchForm.LoadData(RapidSketchForm.SketchFilePath('.rs'), RapidSketchForm.SketchFileData2(xSkCell));     //filename and filedata}
            except
              ShowMessage('Unable to launch RapidSketch.' + chr(13) + chr(13) + 'Please check the installation of RapidSketch.');
            end;
        end;
      end
      else
        try
          Application.CreateForm(TRapidSketchForm, RapidSketchForm);
          PushMouseCursor;
          RapidSketchForm.FDoc:=Doc;
          RapidSketchForm.LoadData(RapidSketchForm.SketchFilePath('.rs'), RapidSketchForm.SketchFileData2(xSkCell));     //filename and filedata}
        except
          ShowMessage('Unable to launch RapidSketch.' + chr(13) + chr(13) + 'Please check the installation of RapidSketch.');
        end;
    end;
end;

procedure LaunchAreaSketchPro(Doc: TContainer; DestCell: TBaseCell);
var
  id, frmIndex: integer;
  xSkCell: TSketchCell;
  xCell: TBaseCell;
  Dlg: TForm;
  DForm: TDocForm;
  FormUID: TFormUID;
begin
  frmIndex := -1;
  if doc=nil then
    Doc := Main.NewEmptyDoc;

  if (Doc <> nil) then
    begin
      if doc.docActiveCell is TSketchCell then
        xSkCell := (Doc.docActiveCell as TSketchCell)
      else
        //xSkCell := Doc.GetAreaSketchCell;
        xSkCell := TSketchCell(Doc.GetCellByID(cidSketchImage));
      if (doc.docForm.Count<>0) and (xSkCell<>nil) then
        begin
         frmIndex := Doc.GetFormIndexByOccur2(xSkCell.UID.FormID, 0,cidSketchImage, xSkCell.text);
        end
      else
        begin
          FormUID := TFormUID.create;
          try
            FormUID.ID := cSkFormLegalUID;
            FormUID.Vers := 1;
            dForm := Doc.InsertFormUID(FormUID, True, frmIndex);
            xCell := dForm.GetCellByID(cidSketchImage);
            xSkCell := TSketchCell(xCell);
            frmIndex := Doc.GetFormIndexByOccur2(xSkCell.UID.FormID, 0,cidSketchImage, xSkCell.text);

          except
            showNotice('The form ID# '+IntToStr(cSkFormLegalUID)+' was not be found in the Forms Library.');
          end;
        end;
      if frmIndex<>-1 then
        begin
          dForm := Doc.docForm[frmIndex];
          xCell := dForm.GetCellByID(cidSketchImage);
          xSkCell := TSketchCell(xCell);
        end;
      if xSkCell<>nil then
        begin
          if TContainer(Doc).docData.FindData('APEXSKETCH') <> nil then
            begin
              TSketchCell(xSkCell).FMetaData := TSketchData.Create(mdApexSketchData,1,mdNameApexSketch); //create meta storage
              TSketchCell(xSkCell).FMetaData.FUID := mdApexSketchData;
              TSketchCell(xSkCell).FMetaData.FVersion := 1;
              TSketchCell(xSkCell).FMetaData.FData := TMemoryStream.Create;      //create new data storage
              TSketchCell(xSkCell).FMetaData.FData.CopyFrom(Doc.docData.FindData('APEXSKETCH'), 0);  //save to cells metaData
            end;
          if TContainer(Doc).docData.FindData('WINSKETCH') <> nil then
            begin
             TSketchCell(xSkCell).FMetaData := TSketchData.Create(mdWinSketchData,1,mdNameWinSketch); //create meta storage
             TSketchCell(xSkCell).FMetaData.FUID := mdWinSketchData;
             TSketchCell(xSkCell).FMetaData.FVersion := 1;
             TSketchCell(xSkCell).FMetaData.FData := TMemoryStream.Create;      //create new data storage
             TSketchCell(xSkCell).FMetaData.FData.CopyFrom(Doc.docData.FindData('WINSKETCH'), 0);  //save to cells metaData
            end;
          if TContainer(Doc).docData.FindData('RAPIDKETCH') <> nil then
            begin
             TSketchCell(xSkCell).FMetaData := TSketchData.Create(mdRapidSketchData,1,mdNameRapidSketch); //create meta storage
             TSketchCell(xSkCell).FMetaData.FUID := mdRapidSketchData;
             TSketchCell(xSkCell).FMetaData.FVersion := 1;
             TSketchCell(xSkCell).FMetaData.FData := TMemoryStream.Create;      //create new data storage
             TSketchCell(xSkCell).FMetaData.FData.CopyFrom(Doc.docData.FindData('RAPIDSKETCH'), 0);  //save to cells metaData
            end;
          if (xSkCell.GetMetaData <>-1) and (xSkCell.GetMetaData<>mdAreaSketchData) then
            begin
              {Create a dialog with appropriate buttons}
              Application.Minimize;
              Dlg := CreateSketchDialog(mdSketchName[xSkCell.GetMetaData], mdSketchName[mdAreaSketchData]);
              Dlg.BringToFront;
              id := Dlg.ShowModal;
              Application.Restore;
              if id=6 then
                begin
                  LaunchPlugInTool(mdSketchTool[xSkCell.GetMetaData],Doc, xSkCell);
                end;
              if id=7 then
                begin
                  xSkCell.FMetaData.FData.Clear;     //delete meta data
                  FreeAndNil(xSkCell.FMetaData);
                  try
                    begin
                      try
                        LaunchAreaSketch(xSkCell);//(Doc, DestCell);
                      except
                        ShowMessage('Unable to launch AreaSketch.' + chr(13) + chr(13) + 'Please check the installation of AreaSketch.');
                      end;
                    end;
                  except
                  end;
                end;
            end
            else
            begin
              try
                LaunchAreaSketch(xSkCell);//(Doc, DestCell);
              except
                ShowMessage('Unable to launch AreaSketch.' + chr(13) + chr(13) + 'Please check the installation of AreaSketch.');
              end;
            end;
        end
        else
          LaunchAreaSketch(xSkCell);//(Doc, DestCell);
    end;
end;

{procedure LaunchAreaSketchSE(Doc: TContainer; DestCell: TBaseCell);        not Used
var
  id, frmIndex: integer;
  xSkCell: TSketchCell;
  xCell: TBaseCell;
  Dlg: TForm;
  DForm: TDocForm;
  FormUID: TFormUID;
begin
  frmIndex := -1;
  if doc=nil then
    Doc := Main.NewEmptyDoc;
  if (Doc <> nil) then
    begin
    if doc.docActiveCell is TSketchCell then
       xSkCell := (Doc.docActiveCell as TSketchCell)
      else
       xSkCell := Doc.GetAreaSketchCell;
//    if xSkCell.Text='' then
//      begin
      if (doc.docForm.Count<>0) and (xSkCell<>nil) then
        begin
         frmIndex := Doc.GetFormIndexByOccur2(cSkFormLegalUID, 0,cidSketchImage, xSkCell.text);
        end
        else
        begin
              FormUID := TFormUID.create;
              try
                FormUID.ID := cSkFormLegalUID;
                FormUID.Vers := 1;
                dForm := Doc.InsertFormUID(FormUID, True, frmIndex);
                xCell := dForm.GetCellByID(cidSketchImage);
                xSkCell := TSketchCell(xCell);
                frmIndex := Doc.GetFormIndexByOccur2(cSkFormLegalUID, 0,cidSketchImage, xSkCell.text);

              except
                showNotice('The form ID# '+IntToStr(cSkFormLegalUID)+' was not be found in the Forms Library.');
              end;
        end;
         if frmIndex<>-1 then
           begin
              dForm := Doc.docForm[frmIndex];
              xCell := dForm.GetCellByID(cidSketchImage);
              xSkCell := TSketchCell(xCell);
           end;
//      end;
    if xSkCell<>nil then
      begin
    if TContainer(Doc).docData.FindData('APEXSKETCH') <> nil then
       begin
         TSketchCell(xSkCell).FMetaData := TSketchData.Create(mdApexSketchData,1,mdNameApexSketch); //create meta storage
         TSketchCell(xSkCell).FMetaData.FUID := mdApexSketchData;
         TSketchCell(xSkCell).FMetaData.FVersion := 1;
         TSketchCell(xSkCell).FMetaData.FData := TMemoryStream.Create;      //create new data storage
         TSketchCell(xSkCell).FMetaData.FData.CopyFrom(Doc.docData.FindData('APEXSKETCH'), 0);  //save to cells metaData
       end;
    if TContainer(Doc).docData.FindData('WINSKETCH') <> nil then
        begin
         TSketchCell(xSkCell).FMetaData := TSketchData.Create(mdWinSketchData,1,mdNameWinSketch); //create meta storage
         TSketchCell(xSkCell).FMetaData.FUID := mdWinSketchData;
         TSketchCell(xSkCell).FMetaData.FVersion := 1;
         TSketchCell(xSkCell).FMetaData.FData := TMemoryStream.Create;      //create new data storage
         TSketchCell(xSkCell).FMetaData.FData.CopyFrom(Doc.docData.FindData('WINSKETCH'), 0);  //save to cells metaData
        end;
    if TContainer(Doc).docData.FindData('RAPIDKETCH') <> nil then
        begin
         TSketchCell(xSkCell).FMetaData := TSketchData.Create(mdApexSketchData,1,mdNameRapidSketch); //create meta storage
         TSketchCell(xSkCell).FMetaData.FUID := mdRapidSketchData;
         TSketchCell(xSkCell).FMetaData.FVersion := 1;
         TSketchCell(xSkCell).FMetaData.FData := TMemoryStream.Create;      //create new data storage
         TSketchCell(xSkCell).FMetaData.FData.CopyFrom(Doc.docData.FindData('RAPIDSKETCH'), 0);  //save to cells metaData
        end;

        if (xSkCell.GetMetaData<>-1) and (xSkCell.GetMetaData<>mdAreaSketchSEData) then
          begin
            //Create a dialog with appropriate buttons
            Dlg := CreateSketchDialog(mdSketchName[xSkCell.GetMetaData], mdSketchName[mdAreaSketchSEData]);
            id := Dlg.ShowModal;
            if id=6 then
              begin
                  LaunchPlugInTool(mdSketchTool[xSkCell.GetMetaData],Doc, xSkCell);
              end;
            if id=7 then
              begin
                if xSkCell.GetMetaData<>mdAreaSketchData then
                  begin
                    xSkCell.FMetaData.FData.Clear;     //delete meta data
                    FreeAndNil(xSkCell.FMetaData);
                  end;
                try
                  begin
                    try
                      Application.CreateForm(TAreaSketchSEForm, AreaSketchSEForm);
                      PushMouseCursor;
                      AreaSketchSEForm.FDoc:=Doc;
                      AreaSketchSEForm.LoadData(AreaSketchSEForm.SketchFilePath('.XML'), AreaSketchSEForm.SketchFileData2(xSkCell));     //filename and filedata
                    except
                      ShowMessage('Unable to launch AreaSketch Special Edition.' + chr(13) + chr(13) + 'Please check the installation of AreaSketch Special Edition.');
                    end;
                  end;
                except
                end;
              end;
          end
          else
          begin
            try
              Application.CreateForm(TAreaSketchSEForm, AreaSketchSEForm);
              PushMouseCursor;
              AreaSketchSEForm.FDoc:=Doc;
              AreaSketchSEForm.LoadData(AreaSketchSEForm.SketchFilePath('.ASX'), AreaSketchSEForm.SketchFileData2(xSkCell));     //filename and filedata
            except
              ShowMessage('Unable to launch AreaSketch Special Edition.' + chr(13) + chr(13) + 'Please check the installation of AreaSketch Special Edition.');
            end;
          end;
      end
      else
        try
          Application.CreateForm(TAreaSketchSEForm, AreaSketchSEForm);
          PushMouseCursor;
          AreaSketchSEForm.FDoc:=Doc;
          AreaSketchSEForm.LoadData(AreaSketchSEForm.SketchFilePath('.ASX'), AreaSketchSEForm.SketchFileData2(xSkCell));     //filename and filedata
        except
          ShowMessage('Unable to launch AreaSketch Special Edition.' + chr(13) + chr(13) + 'Please check the installation of AreaSketch Special Edition.');
        end;
    end;

end;  }

procedure LaunchPhotoSheet;
begin
  //on close, the photosheet is just hidden
  if PhotoSheet = nil then
    PhotoSheet := TPhotoSheet.Create(Application);
  try
    PhotoSheet.Show;
  except
    ShowNotice('The imaging module has not been installed properly. Please re-install the application.');
  end;
end;

procedure LaunchCompEditor(doc: TContainer);
var
  CmpEditor: TCompEditor;
begin
  if assigned(doc) then doc.SaveCurCell;    //get last edits
//  CmpEditor := TCompEditor.Create(doc);
  CmpEditor := TCompEditor.Create(Application);
  try
    try
   //   CmpEditor.ShowModal;
      CmpEditor.Show;
    except
      ShowNotice('There was a problem displaying the Comparables Editor.');
    end;
  finally
//    FreeAndNil(CmpEditor);
  end;
end;
{
procedure LaunchClickNOTES(doc: TContainer);
var
  clkNotes: TClickNotes;
begin
  clkNotes := TClickNotes.Create(doc);
  try
    clkNotes.ShowModal;
  finally
    clkNotes.free;
  end;
end;                 }

procedure LaunchGPSConnector(doc: TContainer);
begin
  if not assigned(GPSConnection) then
    GPSConnection := TGPSConnection.Create(application);

  GPSConnection.Show;
end;

procedure LaunchPhoenixSketch(doc: TContainer; sketchCell: TBaseCell);
var
  docSketchType: Integer;
  Dlg: TForm;
  id: Integer;
begin
   docSketchType := -1;
   if assigned(doc) then
    docSketchType := doc.GetDocSketchType(sketchCell); //the function can change sketch Cell if the other cell has data file in metadata
   try
    if (docsketchType >= 0) and (docSketchType <> mdPhoenixSketchData) then
      begin
        Dlg := CreateSketchDialog(mdSketchName[docSketchType], mdSketchName[mdPhoenixSketchData]);
        id := Dlg.ShowModal;
        if id=6 then  //1st button, existing sketch
          LaunchPlugInTool(mdSketchTool[docSketchType],Doc, sketchCell)
        else
          if id = 7 then  //2nd button, PhoenixSketch
            try
              Application.CreateForm(TPhoenixSketchForm, PhoenixSketchForm);
              PhoenixSketchForm.LoadData(doc, sketchCell);
            except
              ShowNotice('Cannot load PhoenixSketch');
            end
          else
            exit; //user click cancel
      end
    else
      try
        Application.CreateForm(TPhoenixSketchForm, PhoenixSketchForm);
        PhoenixSketchForm.LoadData(doc, sketchCell);
      except
        ShowNotice('Cannot load PhoenixSketch');
      end;
   finally
    {if assigned(PhoenixSketchForm) then
        FreeAndNil(Phoenixsketchform);}
   end;
end;

end.
