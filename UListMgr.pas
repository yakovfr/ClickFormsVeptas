unit UListMgr;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2006 by Bradford Technologies, Inc. }

{  This unit manages the lists or databases. It is the manager for  }
{  displaying all the list editors.                                 }

interface

uses
  Classes,dialogs;


  procedure ListMgrDisplay(ListID: Integer; doc: TComponent);


implementation


Uses
  SysUtils, Forms,
  UGlobals, UContainer,
  UListComps, UListCompsSave, UListReports, UListClients,
  UListNeighbors, UListOrders, UApprWorldOrders,
  UListComps2, UUADConsistency,UListComps3, uWinUtils, uUtil3{, uGeoCodeThread};



procedure ListMgrDisplay(ListID: Integer; doc: TComponent);
begin
  Case ListID of
    cmdListClients:
      ShowClientsList(doc);

    cmdListReports:
      ShowReportList;

    cmdListOrders:                 //List := TOrdersList.create(nil);
      LaunchAWOrders;

    cmdListComps:
       begin
//         ShowCompsDBList(Application.MainForm, 0);
//For Professional, based on the setting in database to run either apprentice or professional
      //   if AWMemberShipLevel <= lApprentice then ShowCompsDBList(Application.MainForm, 0)
         if not IsAWMemberActive then ShowCompsDBList(Application.MainForm, 0)
         else if IsAWMemberActive then
         begin
           if appPref_UseCompDBOption <= lApprentice then
            ShowCompsDBList(Application.MainForm, 0)
           else
            ShowCompsDBList2(Application.MainForm, 0);
         end;
       end;

    cmdListSaveSubj:
      SaveSubjToCompsList(doc);

    cmdListSaveComps:
      SaveAllCompToCompsList(doc);

    cmdListNeighbors:
      ShowNeighborhoodsList(doc);

    cmListUADConsistency:
      ShowUADConsistency(doc);

    cmListGeoCodeAll:
      begin
//        if appPref_DBGeoCoded then exit;
//        try
//          if GeoCodeThread<>nil then
//            raise Exception.Create('GeoCode thread have already been started!');
//          GeoCodeThread := TGeoCodeThread.Create(false);
//        finally
//        end;
      end;

  end;
end;


end.
