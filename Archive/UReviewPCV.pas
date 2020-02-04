unit UReviewPCV;

interface
uses
  UContainer, UCell, UGridMgr;

implementation
uses
  UReviewPCVRules;

procedure ReviewPCV_byForm(FDoc: TContainer);
var
  f,p,c: Integer;
  CurCell, CurCellSettle: TBaseCell;
  aComp: TCompColumn;
  CompID: Integer;
  NumSettle, formNum: Integer;
  ErrorMsg, SubjAddr: String;
begin
  {try
    NumSettle := 0;
    if FDoc.UADEnabled then
    for f := 0 to (FDoc.docForm.Count - 1) do
      for p := 0 to (FDoc.docForm[f].frmPage.count - 1) do              //and for each form page
        begin
          aComp := TCompColumn.Create;
          try
          aComp.FCX.FormID := FDoc.docForm[f].frmInfo.fFormUID;
          aComp.FCX.Form := f;
          aComp.FCX.Pg := p;
          CompID := aComp.FCompID;
          finally
           aComp.Free;
          end;
          for c := 0 to (FDoc.docForm[f].frmPage[p].pgData.Count - 1) do          //and for each page cell
            begin
              CurCell := FDoc.docForm[f].frmPage[p].pgData[c];

              case CurCell.FCellID of
                 92: if FSubjectRec.cell_92 = '' then
                       FSubjectRec.cell_92 := CurCell.Text;
                349: if FSubjectRec.cell_349 = '' then
                         FSubjectRec.cell_349 := CurCell.Text;
                355: if FSubjectRec.cell_355 = '' then
                         FSubjectRec.cell_355 := CurCell.Text;
                359: if FSubjectRec.cell_359 = '' then
                         FSubjectRec.cell_359 := CurCell.Text;
                360: if FSubjectRec.cell_360 = '' then
                         FSubjectRec.cell_360 := CurCell.Text;


                723: if FSubjectRec.cell_723 = '' then
                        FSubjectRec.cell_723 := CurCell.Text;
                724: if FSubjectRec.cell_724 = '' then
                        FSubjectRec.cell_724 := CurCell.Text;

               1016: begin  //Subject Garage/carport
                        if FSubjectRec.cell_1016 = '' then
                          FSubjectRec.cell_1016 := CurCell.Text;
                     end;
               1721: begin
                       if FSubjectRec.cell_1721 = '' then
                         FSubjectRec.cell_1721 := CurCell.Text;
                     end;
               1722: begin
                       if FSubjectRec.cell_1722 = '' then
                         FSubjectRec.cell_1722 := CurCell.Text;
                     end;
               1723: begin
                       if FSubjectRec.cell_1723 = '' then
                         FSubjectRec.cell_1723 := CurCell.Text;
                       ErrorMsg := ProcessPCVFormRules(f, CompID, CurCell, FDoc);
                       if ErrorMsg <> '' then
                         AddRecord(ErrorMsg, f, CurCell.UID.Pg+1, CUrCell.UID.Num+1);
                     end;
               1742: if FSubjectRec.cell_1742 = '' then
                        FSubjectRec.cell_1742 := CurCell.Text;
               1743: if FSubjectRec.cell_1743 = '' then
                        FSubjectRec.cell_1743 := CurCell.Text;
               1744: begin
                       if FSubjectRec.cell_1744 = '' then
                          FSubjectRec.cell_1744 := CurCell.Text;
                       ErrorMsg := ProcessPCVFormRules(f, CompID, CurCell, FDoc);
                       if ErrorMsg <> '' then
                         AddRecord(ErrorMsg, f, CurCell.UID.pg+1, CurCell.UID.Num+1);
                     end;
               2030: if FSubjectRec.cell_2030 = '' then
                       FSubjectRec.cell_2030 := CurCell.Text;
               2034: if FSubjectRec.cell_2034 = '' then
                        FSubjectRec.cell_2034 := CurCell.Text;

               2657: if FSubjectRec.cell_2657 = '' then
                        FSubjectRec.cell_2657 := CurCell.Text;

               2070: if FSubjectRec.cell_2070 = '' then
                        FSubjectRec.cell_2070 := CurCell.Text;
               2071: if FSubjectRec.cell_2071 = '' then
                        FSubjectRec.cell_2071 := CurCell.Text;
               2072: if FSubjectRec.cell_2072 = '' then
                        FSubjectRec.cell_2072 := CurCell.Text;
               918: if FSubjectRec.cell_918 = '' then
                       FSubjectRec.cell_918 := CurCell.Text;
               920: if FSubjectRec.cell_920 = '' then
                      FSubjectRec.cell_920 := CurCell.Text;
               925: //address
                 begin
                   SubjAddr := CurCell.Text;
                 end;
               960: //Handle settle date rule
                 begin
                   if SubjAddr <> '' then
                   begin
                     if POS('S', UpperCase(CurCell.Text)) > 0 then
                       begin
                         inc(NumSettle);
                       end
                       else
                       begin
                         CurCellSettle := CurCell;
                         formNum := f;
                       end;
                   end;
                 end;
               1091: //PCV Rules #198: # comps sales <> # active listings in 1004MC
                 begin
                   if FSubjectRec.cell_1091 = '' then
                     FSubjectRec.cell_1091 := CurCell.Text;
                 end;
               1092: //PCV Rules #197: low sale price < One unit Housing low Price
                 begin
                   if curCell <> nil then
                   begin
                     FSubjectRec.cell_1092 := CurCell.Text;
                     ErrorMsg := ProcessPCVFormRules(f, CompID, CurCell, FDoc);
                     if ErrorMsg <> '' then
                       AddRecord(ErrorMsg, f, CurCell.UID.pg+1, CurCell.UID.Num+1);
                   end;
                 end;

               1093: //PCV Rules #196: high sale price  > One unit Housing High Price
                 begin
                    if curCell <> nil then
                    begin
                      FSubjectRec.cell_1093 := CurCell.Text;
                      ErrorMsg := ProcessPCVFormRules(f, CompID, CurCell, FDoc);
                      if ErrorMsg <> '' then
                        AddRecord(ErrorMsg, f, CurCell.UID.pg+1, CurCell.UID.Num+1);
                    end;
                 end;
               else
                 begin
                    if (FDoc.docForm[f].frmInfo.fFormUID = 850) and (FSubjectRec.Cell_9='') then
                      FSubjectRec.cell_9 := FDoc.docForm[f].GetCellTextByID(9);    //this is a full co addr

                    ErrorMsg := ProcessPCVFormRules(f,CompID, CurCell, FDoc);
                    if (ErrorMsg <> '') and (CurCell <> nil) then
                      AddRecord(ErrorMsg, f, CurCell.UID.pg+1, CurCell.UID.Num+1);
                 end;
              end;
            end;
        end;
       //check for settle date
        if (NumSettle < 3) then
        begin
          if assigned(CurCellSettle) then
          begin
            if Fdoc.UADEnabled then
              begin
                ErrorMsg := '* Less than three settled sales were used as comparables.';
                AddRecord(ErrorMsg, formNum, CurCellSettle.UID.Pg+1, CurCellSettle.UID.Num+1);
              end;  
          end;
        end;
   except end;     }
end;

end.
