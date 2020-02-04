unit UDemoCode;

interface

implementation

        string GetAMCOrder(
            string baseUrl,
            string appIdentity, string appPassword,
            int orderNumber, string VID, string VPsw, string UID, string UPsw,
            out bool relsSuccess, out string relsErrorMessage, out string relsErrorKind);

 

        string GetAMCData(
            string baseUrl,
            string appIdentity, string appPassword,
            int orderNumber, bool declined, string VID, string VPsw, string UID, string UPsw,
            out bool relsSuccess, out string relsErrorMessage, out string relsErrorKind);

 

        string GetAMCValidation(
            string baseUrl,
            string appIdentity, string appPassword,
            int orderNumber, string xmlData, string VID, string VPsw, string UID, string UPsw,
            out bool relsSuccess, out string relsErrorMessage, out string relsErrorKind);

 

        string SubmitAMCReport(
            string baseUrl,
            string appIdentity, string appPassword,
            int orderNumber, string xmlData, string VID, string VPsw, string UID, string UPsw,
            out bool relsSuccess, out string relsErrorMessage, out string relsErrorKind);



 procedure LaunchRELSAcknowledgementPage(AcknowledgementURL: String);


 
procedure TUploadUADXML.bbtnSendXMLClick(Sender: TObject);
var
  ValulinkServResponse: String;
  KyliptixServResponse: WebOrderResponse;
  xmlVers: String;
begin
  case portalID of
    amcPortalAMC_1:
      begin
        if cmbAMCList.ItemIndex < 0 then
          begin
            ShowNotice('You must select an AMC to proceed.');
            exit;
          end;
         xmlVers := '';  //  ComposeGSEAppraisalXMLReport substitutes it with 2_6 or 2_6GSE
         try
          with GetAMC_1ServiceSoap(true, GetURLForamcPortalAMC_1Service) do
          begin
            amcPortalAMC_1ServResponse := PostAppraisalFiles(amcPortalAMC_1BTID,amcPortalAMC_1BTPassword,cmbAMCList.Text,FReportXML);
            if comparestr(ValulinkServResponse,'SUCCESS') <> 0 then
              begin  //servResponse contents the error server returns. Do we want to show it to the end user?
                ShowNotice('The report XML cannot be uploaded using AMC Portal Server #1.');
                exit;
              end
            else
              begin
                ShowNotice('You successfully uploaded your report using AMC Portal Server #1.');
                bbtnSendXML.Enabled := false;
              end;
          end;
          except
            begin
              ShowNotice('The report XML cannot be uploaded using AMC Portal Server #1.');
                exit;
              end;
          end;
      end;
    amcPortalAMC_2:
      try
        with GetWebOrderPortType(false, GetURLForKyliptixService) do
          begin
            amcPortalAMC_2ServResponse := post(amcPortalAMC_2BTID,amcPortalAMC_2BTPassword,FReportXML);
            if StrToIntDef(amcPortalAMC_2ServResponse.statusCode,-1) = 0 then
              begin
                ShowNotice('You successfully uploaded your report using AMC Portal Server #2.');
                 bbtnSendXML.Enabled := false;
              end
            else
              begin //we can get the service error description from amcPortalAMC_2ServResponse.status and amcPortalAMC_2ServResponse.detail
                ShowNotice('The report XML cannot be uploaded using AMC Portal Server #2.');
                exit;
              end
          end;
        except
          begin
            ShowNotice('The report XML cannot be uploaded using AMC Portal Server #2.');
            exit;
          end;
        end;
  end;
end;


end.
