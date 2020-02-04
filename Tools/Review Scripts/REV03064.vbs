'Rev03064.vbs USPAP Vacant Land (CNAREA) - Centract Version Reviewer Script
'  Version: 7.2.6.8
'  Copyright 2009, 2010, 2012 Bradford Technologies, Inc.
'  All Rights Resereved
'

Sub ReviewForm
  ReviewHeader
  AddTitle ""
  ReviewClient
  AddTitle ""
  ReviewAppraiser
  AddTitle ""
  ReviewSubject
  AddTitle ""
  ReviewNeighborhood
  AddTitle ""
  ReviewSite
  AddTitle ""
  ReviewDirectComp
  AddTitle ""
  ReviewReconciliation
  AddTitle ""
End Sub


Sub ReviewHeader

  AddTitle String(5, "=") + "USPAP Vacant Land " + IDHeader + String(5, "=")
  ' Block is common to all forms
  ValidateHeaderBlock 1, 1, 0

End Sub


Sub ReviewClient

  AddTitle String(5, "=") + "USPAP Vacant Land " + IDClientSection + String(5, "=")
  ' Block is common to AIC Summary, AIC Drive-By and AIC Desktop
  ValidateCNAREAClientBlock 1, 4

End Sub


Sub ReviewAppraiser

  AddTitle String(5, "=") + "USPAP Vacant Land " + IDAppraiserSection + String(5, "=")
  ' Block is common to AIC Summary, AIC Drive-By and AIC Desktop
  ValidateCNAREAAppraiserBlock 1, 13

End Sub


Sub ReviewSubject

  AddTitle String(5, "=") + "USPAP Vacant Land " + IDSubjectSection + String(5, "=")
  ' Block is common to AIC Summary, AIC Drive-By and AIC Desktop
  ANextID = 9
  'ValidateCNAREASubjProperty 1, ANextID, 18
  Require IDSubjLegalReqd, 1, 18
  Require IDHomeownerReqd, 1, 19
  ANextID = 18
  If (not isDateOK(1, ANextID + 3, 0, False)) then
    AddRec IDSubSaleDateForm, 1, ANextID + 3
  End If
  If hasText(1, (ANextID + 4)) then
    Require IDSubjAssesTaxReqd, 1, ANextID + 5
    Require IDSubjAssesYrReqd, 1, ANextID + 6
  End If
  CheckOneOfFour 1, ANextID + 7, ANextID + 8, ANextID + 10, ANextID + 11, IDSubjRightsNoneChkd
  CheckAndComment 1, ANextID + 10, ANextID + 11, IDSubjRightsNoCmnt, IDSubjRightsCmntNoChk

End Sub


Sub ReviewNeighborhood

  AddTitle String(5, "=") + "USPAP Vacant Land " + IDNeighSection + String(5, "=")
  ' Block is common to AIC Summary and AIC Drive-By
  ANextID = 30
  CheckOneOfThree 1, ANextID, ANextID + 1, ANextID + 2, IDNeighNatureNoneChkd
  OnlyOneCheckOfThree 1, ANextID + 3, ANextID + 4, ANextID + 5, IDNeighBuiltupNoneChkd, IDNeighBuiltupManyChkd
  OnlyOneCheckOfThree 1, ANextID + 6, ANextID + 7, ANextID + 8, IDNeighGrowthRateNoneChkd, IDNeighGrowthRateManyChkd
  OnlyOneCheckOfThree 1, ANextID + 9, ANextID + 10, ANextID + 11, IDNeighPrTrndNoneChkd, IDNeighPrTrndManyChkd
  OnlyOneCheckOfThree 1, ANextID + 12, ANextID + 13, ANextID + 14, IDCompeteDemandNoneChkd, IDCompeteDemandManyChkd
  OnlyOneCheckOfThree 1, ANextID + 15, ANextID + 16, ANextID + 17, IDNeighMktgTimeNoneChkd, IDNeighMktgTimeManyChkd

  ANextID = ANextID + 18
  If (GetText(1, ANextID) = "") and _
     (GetText(1, (ANextID + 1)) = "") and _
     (GetText(1, (ANextID + 2)) = "") and _
     (GetText(1, (ANextID + 3)) = "") and _
     (GetText(1, (ANextID + 4)) = "") and _
     (GetText(1, (ANextID + 6)) = "") Then
    AddRec IDNeighCurLandUseReqd, 1, ANextID
  End If

  ANextID = ANextID + 7
  CheckOneOfThree 1, ANextID, ANextID + 1, ANextID + 2, IDNeighLandUseChgNoneChkd
  CheckOneOfFour 1, ANextID + 4, ANextID + 5, ANextID + 6, ANextID + 7, IDSubjOccupyNoneChkd
  Require IDNeighLowPrice, 1, ANextID + 8
  Require IDNeighHighPrice, 1, ANextID + 9
  Require IDNeighLowAge, 1, ANextID + 10
  Require IDNeighHighAge, 1, ANextID + 11

  ANextID = ANextID + 12
  OnlyOneCheckOfFour 1, ANextID, ANextID + 1, ANextID + 2, ANextID + 3, IDNeighEmployStableNoneChkd, IDNeighEmployStableManyChkd
  OnlyOneCheckOfFour 1, ANextID + 4, ANextID + 5, ANextID + 6, ANextID + 7, IDNeighEmploymentNoneChkd, IDNeighEmploymentManyChkd
  OnlyOneCheckOfFour 1, ANextID + 8, ANextID + 9, ANextID + 10, ANextID + 11, IDNeighShoppingNoneChkd, IDNeighShoppingManyChkd
  OnlyOneCheckOfFour 1, ANextID + 12, ANextID + 13, ANextID + 14, ANextID + 15, IDNeighSchoolsNoneChkd, IDNeighSchoolsManyChkd
  OnlyOneCheckOfFour 1, ANextID + 16, ANextID + 17, ANextID + 18, ANextID + 19, IDNeighPubTransNoneChkd, IDNeighPubTransManyChkd
  OnlyOneCheckOfFour 1, ANextID + 20, ANextID + 21, ANextID + 22, ANextID + 23, IDNeighRecFacNoneChkd, IDNeighRecFacManyChkd
  OnlyOneCheckOfFour 1, ANextID + 24, ANextID + 25, ANextID + 26, ANextID + 27, IDNeighUtilitiesNoneChkd, IDNeighUtilitiesManyChkd
  OnlyOneCheckOfFour 1, ANextID + 28, ANextID + 29, ANextID + 30, ANextID + 31, IDNeighCompatRateNoneChkd, IDNeighCompatRateManyChkd
  OnlyOneCheckOfFour 1, ANextID + 32, ANextID + 33, ANextID + 34, ANextID + 35, IDNeighCondProtectNoneChkd, IDNeighCondProtectManyChkd
  OnlyOneCheckOfFour 1, ANextID + 36, ANextID + 37, ANextID + 38, ANextID + 39, IDNeighSvcProtectNoneChkd, IDNeighSvcProtectManyChkd
  OnlyOneCheckOfFour 1, ANextID + 40, ANextID + 41, ANextID + 42, ANextID + 43, IDNeighPropAppearNoneChkd, IDNeighPropAppearManyChkd
  OnlyOneCheckOfFour 1, ANextID + 44, ANextID + 45, ANextID + 46, ANextID + 47, IDNeighMktAppealNoneChkd, IDNeighMktAppealManyChkd
End Sub


Sub ReviewSite

  AddTitle String(5, "=") + "USPAP Vacant Land " + IDSiteSection + String(5, "=")
  ' Block is common to AIC Summary (True) and AIC Drive-By (False)

  ANextID = 116
  Require IDSiteDimenReqd, 1, ANextID
  ANextID = ANextID + 1
  Require IDSiteAreaReqd, 1, ANextID
  ANextID = ANextID + 1
  Require IDSiteZoningReqd, 1, ANextID
  ANextID = ANextID + 1

  OnlyOneCheckOfTwo 1, ANextID, ANextID + 1, IDSiteCrnrLotNoneChkd, IDSiteCrnrLotManyChkd
  ANextID = ANextID + 2
  OnlyOneCheckOfTwo 1, ANextID, ANextID + 1, IDSiteZoneNoneChkd, IDSiteZoneManyChkd
  ANextID = ANextID + 2
  Require IDSubjPropUseReqd, 1, ANextID
  ANextID = ANextID + 2

  If (not IsChecked(1, ANextID)) and _
     (GetText(1, (ANextID + 1)) = "") Then
    AddRec IDSiteElectricalReqd, 1, ANextID
  End If
  ANextID = ANextID + 2

  If (not IsChecked(1, ANextID)) and _
     (GetText(1, (ANextID + 1)) = "") Then
    AddRec IDSiteGasReqd, 1, ANextID
  End If
  ANextID = ANextID + 2

  If (not IsChecked(1, ANextID)) and _
     (GetText(1, (ANextID + 1)) = "") Then
    AddRec IDSiteWaterReqd, 1, ANextID
  End If
  ANextID = ANextID + 2

  If (not IsChecked(1, ANextID)) and _
     (GetText(1, (ANextID + 1)) = "") Then
    AddRec IDSiteSanSewerReqd, 1, ANextID
  End If
  ANextID = ANextID + 2

  If (not IsChecked(1, ANextID)) and _
     (GetText(1, (ANextID + 1)) = "") Then
    AddRec IDSiteStormSewerReqd, 1, ANextID
  End If
  ANextID = ANextID + 17

  Require IDSiteTopoReqd, 1, ANextID
  ANextID = ANextID + 1
  Require IDSiteConfigReqd, 1, ANextID
  ANextID = ANextID + 1
  Require IDSiteDrainageReqd, 1, ANextID
  ANextID = ANextID + 1
  Require IDSubLandscaping, 1, ANextID
  ANextID = ANextID + 1
  Require IDSubDriveway, 1, ANextID
  ANextID = ANextID + 1
  Require IDSiteEasementReqd, 1, ANextID
  ANextID = ANextID + 1

End Sub

Sub ReviewDirectComp
Dim FldCntr, CompCntr, CompCount
  AddTitle String(5, "=") + "USPAP Vacant Land " + IDDirCompApprchSection + String(5, "=")

  Require IDSubAdd, 1, 161
  Require IDSubCity, 1, 162

  If GetValue(1, 163) Then
    Require IDSubPricePerUnit, 1, 165
  End If
  Require IDSubCostDataSrc, 1, 166
  If hasText(1, 163) and ((GetText(1, 167) = "") and (GetText(1, 168) = "")) Then
    AddRec IDSubFinConcess, 1, 167
  End If
  If (not isDateOK(1, 169, 1, False)) then
    AddRec IDSubSaleDateForm, 1, 169
  End If

  Require IDSubLoc, 1, 170
  Require IDSubSite, 1, 171

  CompCount = 0
  For CompCntr = 1 to 3
    FldCntr = ((CompCntr-1) * 26) + 178
    If (GetText(1, (FldCntr)) <> "") or (GetText(1, (FldCntr+1)) <> "") then
      CompCount = CompCount + 1
      Require FormCompNumErrStr(IDComp1Add, 0, CompCntr), 1, (FldCntr)
      Require FormCompNumErrStr(IDComp1Add2, 0, CompCntr), 1, (FldCntr+1)
      if hasText(1, FldCntr) or hasText(1, (FldCntr+1)) then
        Require FormCompNumErrStr(IDComp1SubProximity, 0, CompCntr), 1, (FldCntr+2)
      End If

      If (not Require (FormCompNumErrStr(IDComp1Sales, 0, CompCntr), 1, (FldCntr+3))) then
        If hasText(1, (FldCntr+3)) then
          num = GetValue(1, (FldCntr+3))
          If (num < GetValue(1, 63)) or (num > GetValue(1, 64)) then
            AddRec FormCompNumErrStr(IDToBeRange4, 0, CompCntr), 1, (FldCntr+3)
          End If
        End If
      End If

      Require FormCompNumErrStr(IDComp1PricePerUnit, 0, CompCntr), 1, (FldCntr+4)
      Require FormCompNumErrStr(IDComp1CostDataSrc, 0, CompCntr), 1, (FldCntr+5)
      If (GetText(1, (FldCntr+6)) = "") and (GetText(1, (FldCntr+8)) = "") Then
        AddRec FormCompNumErrStr(IDComp1FinConcess, 0, CompCntr), 1, (FldCntr+6)
      End If

      If (GetText(1, (FldCntr+10)) = "") then
        AddRec FormCompNumErrStr(IDComp1SaleDateReqd, 0, CompCntr), 1, (FldCntr+10)
      Else
        If (not isDateOK(1, (FldCntr+10), 0, False)) then
          AddRec FormCompNumErrStr(IDComp1SaleDateForm, 0, CompCntr), 1, (FldCntr+10)
        End If
      End If

      Require FormCompNumErrStr(IDComp1Loc, 0, CompCntr), 1, (FldCntr+12)
      Require FormCompNumErrStr(IDComp1SiteSize, 0, CompCntr), 1, (FldCntr+14)

    End If
  Next
  if CompCount < 3 then
    AddRec IDCompSaleQtyLow, 1, 178
  End If

  Require IDCompConclReqd, 1, 256
  If (not hasText(1, 257)) then
    AddRec IDIndValueReqd, 1, 257
  End If
End Sub

Sub ReviewReconciliation
Dim FldText
  AddTitle String(5, "=") + "USPAP Vacant Land " + IDReconcileSection + String(5, "=")

  Require IDReconReqd, 1, 259
  Require IDDateAsAt, 1, 260
  If (not isDateOK(1, 260, 0, False)) then
    AddRec IDDateAsAtForm, 1, 260
  End If
  FldText = GetText(1, 261)
  If (FldText = "") then
    AddRec IDApprEst, 1, 261
  Else
    If (not isValidNumber(FldText)) then
      AddRec IDApprEstNoNum, 1, 261
    End If
  End If

  Require IDCertApprNameReqd, 1, 263
  Require IDCertApprDesgReqd, 1, 265
  Require IDCertInspDateReqd, 1, 266
  If (not isDateOK(1, 266, 0, False)) then
    AddRec IDCertInspDateForm, 1, 266
  End If

  If hasText(1, 267) then
    Require IDCertSupvDesgReqd, 1, 269
    If (not Require(IDCertSupvInspDateReqd, 1, 270)) then
      If (not isDateOK(1, 270, 0, True)) then
        AddRec IDCertSupvInspDateForm, 1, 270
      End If
    End If
  End If
End Sub




