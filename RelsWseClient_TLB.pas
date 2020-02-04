unit RelsWseClient_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// $Rev: 52393 $
// File generated on 3/18/2018 7:26:31 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\RellsWseClient\RelsWseClient.NetVers4\out\RelsWseClient.tlb (1)
// LIBID: {26B844E5-47E8-4592-852B-35401564F300}
// LCID: 0
// Helpfile: 
// HelpString: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
//   (2) v2.4 mscorlib, (C:\Windows\Microsoft.NET\Framework\v4.0.30319\mscorlib.tlb)
//   (3) v2.4 System, (C:\Windows\Microsoft.NET\Framework\v4.0.30319\System.tlb)
// SYS_KIND: SYS_WIN32
// Errors:
//   Hint: TypeInfo 'Type' changed to 'Type_'
//   Error creating palette bitmap of (TRelsConnectionToCLF) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TValidateAppraisalResponse) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TValidateAppraisalResponseRequest) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TRelsWseClient_ValidateResponse_STATUS) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TValidateAppraisalResponseResponse) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TValidateAppraisalDataCompletedEventHandler) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TValidateAppraisalDataCompletedEventArgs) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TSubmitAppraisal) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TSubmitAppraisalRequest) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TRelsWseClient_RelsSubmit_STATUS) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TSubmitAppraisalResponse) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TSubmitCompletedEventHandler) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TSubmitCompletedEventArgs) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TOrderInformationService) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TGetOrderInfoRequest) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TGetOrderDataResponse) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TRelsWseClient_RelsOrderXML_STATUS) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TGetOrderDataRequest) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TGetOrderInfoResponse) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TGetOrderInformationCompletedEventHandler) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TGetOrderInformationCompletedEventArgs) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TGetOrderDataRequestCompletedEventHandler) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TGetOrderDataRequestCompletedEventArgs) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TRelsData) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TRelsDataRequest) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TRelsWseClient_RelsData_STATUS) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TRelsDataResponse) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TGetRelsDataCompletedEventHandler) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TGetRelsDataCompletedEventArgs) : Server mscoree.dll contains no icons
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Windows, mscorlib_TLB, Classes, Variants, StdVCL, System_TLB, Graphics, OleServer,
ActiveX;


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  RelsWseClientMajorVersion = 3;
  RelsWseClientMinorVersion = 0;

  LIBID_RelsWseClient: TGUID = '{26B844E5-47E8-4592-852B-35401564F300}';

  IID_IConnection: TGUID = '{F95C0405-D0D5-3B83-A043-6812ADFC5911}';
  IID__RelsConnectionToCLF: TGUID = '{841F4604-8953-3FDE-B37F-913E9C9B86AF}';
  IID__ValidateAppraisalResponse: TGUID = '{99FBF9EB-3CC5-3730-825B-5C9006046E94}';
  IID__ValidateAppraisalResponseRequest: TGUID = '{719DE911-47B8-388C-8F35-1E5B1DE2D5AF}';
  IID__RelsWseClient_ValidateResponse_STATUS: TGUID = '{E4084E50-6131-32C8-BCB5-4FDB8E3CCD12}';
  IID__ValidateAppraisalResponseResponse: TGUID = '{F64BD1AA-B18E-393A-8458-5746A8A86696}';
  IID__ValidateAppraisalDataCompletedEventHandler: TGUID = '{66F33E4A-29D7-3432-80DB-0EBE1012371E}';
  IID__ValidateAppraisalDataCompletedEventArgs: TGUID = '{9B061D3B-D5DB-36F6-B4E2-57B9D0192B41}';
  IID__SubmitAppraisal: TGUID = '{9A8B9960-E2E1-3CEC-BC28-048AEC390E6E}';
  IID__SubmitAppraisalRequest: TGUID = '{BF02696B-DA1D-3F20-97BB-D99E562C3EA9}';
  IID__RelsWseClient_RelsSubmit_STATUS: TGUID = '{D304739B-7127-345C-8B29-7C524B4F77B0}';
  IID__SubmitAppraisalResponse: TGUID = '{F3B986F2-182C-3551-801E-DABB27DE1154}';
  IID__SubmitCompletedEventHandler: TGUID = '{785AB5F4-416B-3E02-B148-B0D6081F5917}';
  IID__SubmitCompletedEventArgs: TGUID = '{E7E3A565-9691-35AC-A321-4B5641B156C4}';
  IID__OrderInformationService: TGUID = '{403DB63A-D82A-3625-9266-6A8E6249598E}';
  IID__GetOrderInfoRequest: TGUID = '{225D4E9B-2F45-3ED8-925B-79104D71DFFF}';
  IID__GetOrderDataResponse: TGUID = '{824FE989-208A-3C08-B168-27ADB73987DC}';
  IID__RelsWseClient_RelsOrderXML_STATUS: TGUID = '{0A54E045-4AE3-3435-91B1-2FBC0D1B2FAE}';
  IID__GetOrderDataRequest: TGUID = '{FB8A8C6B-7142-3B62-B657-3A1CA9C23BF3}';
  IID__GetOrderInfoResponse: TGUID = '{C78FC9A0-FB32-34B8-B8E6-80299D19CC96}';
  IID__GetOrderInformationCompletedEventHandler: TGUID = '{2717F985-F2C3-3A6C-B25B-64405E3D7755}';
  IID__GetOrderInformationCompletedEventArgs: TGUID = '{F01438E1-DF2E-36A2-BA62-C673C18548CE}';
  IID__GetOrderDataRequestCompletedEventHandler: TGUID = '{EF908A65-2D60-3AB1-84AC-E924215FEE94}';
  IID__GetOrderDataRequestCompletedEventArgs: TGUID = '{6E997525-4043-3323-B2E4-51BC86ACB829}';
  IID__RelsData: TGUID = '{E695C7D9-8828-3ED6-AA0D-39C0D690001F}';
  IID__RelsDataRequest: TGUID = '{B45F5E2B-2835-3300-82C2-ABAC888F2278}';
  IID__RelsWseClient_RelsData_STATUS: TGUID = '{C0E8D9F0-B997-3365-8F2B-B3675C7A7AC7}';
  IID__RelsDataResponse: TGUID = '{DF62020D-5E55-39BE-9293-B217D142B40E}';
  IID__GetRelsDataCompletedEventHandler: TGUID = '{2DC18F87-F30E-3186-A592-41BB853E3A9A}';
  IID__GetRelsDataCompletedEventArgs: TGUID = '{8C082FFE-874F-3D92-A699-7A557ED5A620}';
  CLASS_RelsConnectionToCLF: TGUID = '{15D94F5C-254A-34F0-9553-F71F266AD4C8}';
  CLASS_ValidateAppraisalResponse: TGUID = '{68F34EAA-20A1-380F-92C1-5B27573B9D65}';
  CLASS_ValidateAppraisalResponseRequest: TGUID = '{62D8AF06-CA61-35EC-B3E5-9B335FE0313E}';
  CLASS_RelsWseClient_ValidateResponse_STATUS: TGUID = '{794BE79D-0ADA-371A-B18A-EDAD092F37FD}';
  CLASS_ValidateAppraisalResponseResponse: TGUID = '{A1AF60FA-3790-306A-9ACF-50418822D7C0}';
  CLASS_ValidateAppraisalDataCompletedEventHandler: TGUID = '{FA7D2F34-9DBE-3909-9D7D-071790046124}';
  CLASS_ValidateAppraisalDataCompletedEventArgs: TGUID = '{17138DF9-4FB7-3FA0-A1D8-9F688F6FC67E}';
  CLASS_SubmitAppraisal: TGUID = '{069CD4C1-7EE4-3E87-B06F-69133A29A0D9}';
  CLASS_SubmitAppraisalRequest: TGUID = '{631BE2D5-8194-32D8-A967-B697FDFF1205}';
  CLASS_RelsWseClient_RelsSubmit_STATUS: TGUID = '{C83A69D1-5879-30B5-9BC1-6A255ED1B5A3}';
  CLASS_SubmitAppraisalResponse: TGUID = '{E2D49AF5-90D6-396B-9FF9-90620AB6F710}';
  CLASS_SubmitCompletedEventHandler: TGUID = '{639D5151-0F40-3CA4-B84C-246F940CA1B9}';
  CLASS_SubmitCompletedEventArgs: TGUID = '{1F619E17-BF20-3043-B554-6DB3726856AF}';
  CLASS_OrderInformationService: TGUID = '{3E1BFD68-C11C-31AD-8424-6665155335AA}';
  CLASS_GetOrderInfoRequest: TGUID = '{A7699613-930B-36E2-933F-ADD19E2548EF}';
  CLASS_GetOrderDataResponse: TGUID = '{E871E262-06A6-394B-BEE7-7AED33DBBACC}';
  CLASS_RelsWseClient_RelsOrderXML_STATUS: TGUID = '{689456E7-5224-36BF-BC70-A1B8E64B6AF6}';
  CLASS_GetOrderDataRequest: TGUID = '{EE7D8CCC-21DA-3DD7-9BAD-4BE807197222}';
  CLASS_GetOrderInfoResponse: TGUID = '{2DB65B7D-C9BE-39AB-AF88-91B43F7FF4F1}';
  CLASS_GetOrderInformationCompletedEventHandler: TGUID = '{2BECBC30-E7A3-38B6-9434-84B986C63FE9}';
  CLASS_GetOrderInformationCompletedEventArgs: TGUID = '{5857FC51-C7DC-3B24-BA05-78E49F2EBCF5}';
  CLASS_GetOrderDataRequestCompletedEventHandler: TGUID = '{21246F59-F2D9-3BBF-8F94-E02174E0CA46}';
  CLASS_GetOrderDataRequestCompletedEventArgs: TGUID = '{05175917-B893-3A37-B5A0-31840E7DC2F9}';
  CLASS_RelsData: TGUID = '{C1385DDD-6440-32F6-8B33-C09B11AF8C64}';
  CLASS_RelsDataRequest: TGUID = '{0E371E7B-57BC-3D03-88B0-AFA8E36726D5}';
  CLASS_RelsWseClient_RelsData_STATUS: TGUID = '{F6933CF1-3A0A-3980-B99F-EC00358C775E}';
  CLASS_RelsDataResponse: TGUID = '{078F7822-04FD-3412-A7F0-06775BE762C9}';
  CLASS_GetRelsDataCompletedEventHandler: TGUID = '{9959CBB5-45FD-3167-9F2E-975CC31BC051}';
  CLASS_GetRelsDataCompletedEventArgs: TGUID = '{83757244-B969-3746-9388-798B996A636C}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum RelsWseClient_ValidateResponse__Status
type
  RelsWseClient_ValidateResponse__Status = TOleEnum;
const
  RelsWseClient_ValidateResponse__Status_Error = $00000000;
  RelsWseClient_ValidateResponse__Status_Success = $00000001;

// Constants for enum RelsWseClient_ValidateResponse__ErrorClass
type
  RelsWseClient_ValidateResponse__ErrorClass = TOleEnum;
const
  RelsWseClient_ValidateResponse__ErrorClass_Business = $00000000;
  RelsWseClient_ValidateResponse__ErrorClass_System = $00000001;
  RelsWseClient_ValidateResponse__ErrorClass_None = $00000002;

// Constants for enum RelsWseClient_ValidateResponse__ErrorType
type
  RelsWseClient_ValidateResponse__ErrorType = TOleEnum;
const
  RelsWseClient_ValidateResponse__ErrorType_RequiredFieldsMissing = $00000000;
  RelsWseClient_ValidateResponse__ErrorType_AuthenticationFailed = $00000001;
  RelsWseClient_ValidateResponse__ErrorType_UnauthorizedUser = $00000002;
  RelsWseClient_ValidateResponse__ErrorType_RetriesExceeded = $00000003;
  RelsWseClient_ValidateResponse__ErrorType_InvalidData = $00000004;
  RelsWseClient_ValidateResponse__ErrorType_ValidationError = $00000005;
  RelsWseClient_ValidateResponse__ErrorType_ValidationWarning = $00000006;
  RelsWseClient_ValidateResponse__ErrorType_ValidationInfo = $00000007;
  RelsWseClient_ValidateResponse__ErrorType_Success = $00000008;
  RelsWseClient_ValidateResponse__ErrorType_Other = $00000009;
  RelsWseClient_ValidateResponse__ErrorType_SystemException = $0000000A;

// Constants for enum RelsWseClient_RelsSubmit__Status
type
  RelsWseClient_RelsSubmit__Status = TOleEnum;
const
  RelsWseClient_RelsSubmit__Status_Error = $00000000;
  RelsWseClient_RelsSubmit__Status_Success = $00000001;

// Constants for enum RelsWseClient_RelsSubmit__ErrorClass
type
  RelsWseClient_RelsSubmit__ErrorClass = TOleEnum;
const
  RelsWseClient_RelsSubmit__ErrorClass_Business = $00000000;
  RelsWseClient_RelsSubmit__ErrorClass_System = $00000001;
  RelsWseClient_RelsSubmit__ErrorClass_None = $00000002;

// Constants for enum RelsWseClient_RelsSubmit__ErrorType
type
  RelsWseClient_RelsSubmit__ErrorType = TOleEnum;
const
  RelsWseClient_RelsSubmit__ErrorType_RequiredFieldsMissing = $00000000;
  RelsWseClient_RelsSubmit__ErrorType_AuthenticationFailed = $00000001;
  RelsWseClient_RelsSubmit__ErrorType_UnauthorizedUser = $00000002;
  RelsWseClient_RelsSubmit__ErrorType_RetriesExceeded = $00000003;
  RelsWseClient_RelsSubmit__ErrorType_InvalidData = $00000004;
  RelsWseClient_RelsSubmit__ErrorType_ValidationError = $00000005;
  RelsWseClient_RelsSubmit__ErrorType_ValidationWarning = $00000006;
  RelsWseClient_RelsSubmit__ErrorType_ValidationInfo = $00000007;
  RelsWseClient_RelsSubmit__ErrorType_Success = $00000008;
  RelsWseClient_RelsSubmit__ErrorType_Other = $00000009;
  RelsWseClient_RelsSubmit__ErrorType_SystemException = $0000000A;

// Constants for enum RelsWseClient_RelsOrderXML__Status
type
  RelsWseClient_RelsOrderXML__Status = TOleEnum;
const
  RelsWseClient_RelsOrderXML__Status_Error = $00000000;
  RelsWseClient_RelsOrderXML__Status_Success = $00000001;

// Constants for enum RelsWseClient_RelsOrderXML__ErrorClass
type
  RelsWseClient_RelsOrderXML__ErrorClass = TOleEnum;
const
  RelsWseClient_RelsOrderXML__ErrorClass_Business = $00000000;
  RelsWseClient_RelsOrderXML__ErrorClass_System = $00000001;
  RelsWseClient_RelsOrderXML__ErrorClass_None = $00000002;

// Constants for enum RelsWseClient_RelsOrderXML__ErrorType
type
  RelsWseClient_RelsOrderXML__ErrorType = TOleEnum;
const
  RelsWseClient_RelsOrderXML__ErrorType_RequiredFieldsMissing = $00000000;
  RelsWseClient_RelsOrderXML__ErrorType_AuthenticationFailed = $00000001;
  RelsWseClient_RelsOrderXML__ErrorType_UnauthorizedUser = $00000002;
  RelsWseClient_RelsOrderXML__ErrorType_RetriesExceeded = $00000003;
  RelsWseClient_RelsOrderXML__ErrorType_InvalidData = $00000004;
  RelsWseClient_RelsOrderXML__ErrorType_ValidationError = $00000005;
  RelsWseClient_RelsOrderXML__ErrorType_ValidationWarning = $00000006;
  RelsWseClient_RelsOrderXML__ErrorType_ValidationInfo = $00000007;
  RelsWseClient_RelsOrderXML__ErrorType_Success = $00000008;
  RelsWseClient_RelsOrderXML__ErrorType_Other = $00000009;
  RelsWseClient_RelsOrderXML__ErrorType_SystemException = $0000000A;

// Constants for enum Type_
type
  Type_ = TOleEnum;
const
  Type_DeclineReason = $00000000;
  Type_PredefinedComment = $00000001;

// Constants for enum RelsWseClient_RelsData__Status
type
  RelsWseClient_RelsData__Status = TOleEnum;
const
  RelsWseClient_RelsData__Status_Error = $00000000;
  RelsWseClient_RelsData__Status_Success = $00000001;

// Constants for enum RelsWseClient_RelsData__ErrorClass
type
  RelsWseClient_RelsData__ErrorClass = TOleEnum;
const
  RelsWseClient_RelsData__ErrorClass_Business = $00000000;
  RelsWseClient_RelsData__ErrorClass_System = $00000001;
  RelsWseClient_RelsData__ErrorClass_None = $00000002;

// Constants for enum RelsWseClient_RelsData__ErrorType
type
  RelsWseClient_RelsData__ErrorType = TOleEnum;
const
  RelsWseClient_RelsData__ErrorType_RequiredFieldsMissing = $00000000;
  RelsWseClient_RelsData__ErrorType_AuthenticationFailed = $00000001;
  RelsWseClient_RelsData__ErrorType_UnauthorizedUser = $00000002;
  RelsWseClient_RelsData__ErrorType_RetriesExceeded = $00000003;
  RelsWseClient_RelsData__ErrorType_InvalidData = $00000004;
  RelsWseClient_RelsData__ErrorType_ValidationError = $00000005;
  RelsWseClient_RelsData__ErrorType_ValidationWarning = $00000006;
  RelsWseClient_RelsData__ErrorType_ValidationInfo = $00000007;
  RelsWseClient_RelsData__ErrorType_Success = $00000008;
  RelsWseClient_RelsData__ErrorType_Other = $00000009;
  RelsWseClient_RelsData__ErrorType_SystemException = $0000000A;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IConnection = interface;
  IConnectionDisp = dispinterface;
  _RelsConnectionToCLF = interface;
  _RelsConnectionToCLFDisp = dispinterface;
  _ValidateAppraisalResponse = interface;
  _ValidateAppraisalResponseDisp = dispinterface;
  _ValidateAppraisalResponseRequest = interface;
  _ValidateAppraisalResponseRequestDisp = dispinterface;
  _RelsWseClient_ValidateResponse_STATUS = interface;
  _RelsWseClient_ValidateResponse_STATUSDisp = dispinterface;
  _ValidateAppraisalResponseResponse = interface;
  _ValidateAppraisalResponseResponseDisp = dispinterface;
  _ValidateAppraisalDataCompletedEventHandler = interface;
  _ValidateAppraisalDataCompletedEventHandlerDisp = dispinterface;
  _ValidateAppraisalDataCompletedEventArgs = interface;
  _ValidateAppraisalDataCompletedEventArgsDisp = dispinterface;
  _SubmitAppraisal = interface;
  _SubmitAppraisalDisp = dispinterface;
  _SubmitAppraisalRequest = interface;
  _SubmitAppraisalRequestDisp = dispinterface;
  _RelsWseClient_RelsSubmit_STATUS = interface;
  _RelsWseClient_RelsSubmit_STATUSDisp = dispinterface;
  _SubmitAppraisalResponse = interface;
  _SubmitAppraisalResponseDisp = dispinterface;
  _SubmitCompletedEventHandler = interface;
  _SubmitCompletedEventHandlerDisp = dispinterface;
  _SubmitCompletedEventArgs = interface;
  _SubmitCompletedEventArgsDisp = dispinterface;
  _OrderInformationService = interface;
  _OrderInformationServiceDisp = dispinterface;
  _GetOrderInfoRequest = interface;
  _GetOrderInfoRequestDisp = dispinterface;
  _GetOrderDataResponse = interface;
  _GetOrderDataResponseDisp = dispinterface;
  _RelsWseClient_RelsOrderXML_STATUS = interface;
  _RelsWseClient_RelsOrderXML_STATUSDisp = dispinterface;
  _GetOrderDataRequest = interface;
  _GetOrderDataRequestDisp = dispinterface;
  _GetOrderInfoResponse = interface;
  _GetOrderInfoResponseDisp = dispinterface;
  _GetOrderInformationCompletedEventHandler = interface;
  _GetOrderInformationCompletedEventHandlerDisp = dispinterface;
  _GetOrderInformationCompletedEventArgs = interface;
  _GetOrderInformationCompletedEventArgsDisp = dispinterface;
  _GetOrderDataRequestCompletedEventHandler = interface;
  _GetOrderDataRequestCompletedEventHandlerDisp = dispinterface;
  _GetOrderDataRequestCompletedEventArgs = interface;
  _GetOrderDataRequestCompletedEventArgsDisp = dispinterface;
  _RelsData = interface;
  _RelsDataDisp = dispinterface;
  _RelsDataRequest = interface;
  _RelsDataRequestDisp = dispinterface;
  _RelsWseClient_RelsData_STATUS = interface;
  _RelsWseClient_RelsData_STATUSDisp = dispinterface;
  _RelsDataResponse = interface;
  _RelsDataResponseDisp = dispinterface;
  _GetRelsDataCompletedEventHandler = interface;
  _GetRelsDataCompletedEventHandlerDisp = dispinterface;
  _GetRelsDataCompletedEventArgs = interface;
  _GetRelsDataCompletedEventArgsDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  RelsConnectionToCLF = _RelsConnectionToCLF;
  ValidateAppraisalResponse = _ValidateAppraisalResponse;
  ValidateAppraisalResponseRequest = _ValidateAppraisalResponseRequest;
  RelsWseClient_ValidateResponse_STATUS = _RelsWseClient_ValidateResponse_STATUS;
  ValidateAppraisalResponseResponse = _ValidateAppraisalResponseResponse;
  ValidateAppraisalDataCompletedEventHandler = _ValidateAppraisalDataCompletedEventHandler;
  ValidateAppraisalDataCompletedEventArgs = _ValidateAppraisalDataCompletedEventArgs;
  SubmitAppraisal = _SubmitAppraisal;
  SubmitAppraisalRequest = _SubmitAppraisalRequest;
  RelsWseClient_RelsSubmit_STATUS = _RelsWseClient_RelsSubmit_STATUS;
  SubmitAppraisalResponse = _SubmitAppraisalResponse;
  SubmitCompletedEventHandler = _SubmitCompletedEventHandler;
  SubmitCompletedEventArgs = _SubmitCompletedEventArgs;
  OrderInformationService = _OrderInformationService;
  GetOrderInfoRequest = _GetOrderInfoRequest;
  GetOrderDataResponse = _GetOrderDataResponse;
  RelsWseClient_RelsOrderXML_STATUS = _RelsWseClient_RelsOrderXML_STATUS;
  GetOrderDataRequest = _GetOrderDataRequest;
  GetOrderInfoResponse = _GetOrderInfoResponse;
  GetOrderInformationCompletedEventHandler = _GetOrderInformationCompletedEventHandler;
  GetOrderInformationCompletedEventArgs = _GetOrderInformationCompletedEventArgs;
  GetOrderDataRequestCompletedEventHandler = _GetOrderDataRequestCompletedEventHandler;
  GetOrderDataRequestCompletedEventArgs = _GetOrderDataRequestCompletedEventArgs;
  RelsData = _RelsData;
  RelsDataRequest = _RelsDataRequest;
  RelsWseClient_RelsData_STATUS = _RelsWseClient_RelsData_STATUS;
  RelsDataResponse = _RelsDataResponse;
  GetRelsDataCompletedEventHandler = _GetRelsDataCompletedEventHandler;
  GetRelsDataCompletedEventArgs = _GetRelsDataCompletedEventArgs;


// *********************************************************************//
// Interface: IConnection
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F95C0405-D0D5-3B83-A043-6812ADFC5911}
// *********************************************************************//
  IConnection = interface(IDispatch)
    ['{F95C0405-D0D5-3B83-A043-6812ADFC5911}']
    function GetRELSOrder(const baseUrl: WideString; const appIdentity: WideString; 
                          const appPassword: WideString; orderNumber: Integer; 
                          const VID: WideString; const VPsw: WideString; const UID: WideString; 
                          const UPsw: WideString; out relsSuccess: WordBool; 
                          out relsErrorMessage: WideString; out relsErrorKind: WideString): WideString; safecall;
    function GetRELSData(const baseUrl: WideString; const appIdentity: WideString; 
                         const appPassword: WideString; orderNumber: Integer; declined: WordBool; 
                         const VID: WideString; const VPsw: WideString; const UID: WideString; 
                         const UPsw: WideString; out relsSuccess: WordBool; 
                         out relsErrorMessage: WideString; out relsErrorKind: WideString): WideString; safecall;
    function GetRELSValidation(const baseUrl: WideString; const version: WideString; 
                               const appIdentity: WideString; const appPassword: WideString; 
                               orderNumber: Integer; const xmlData: WideString; 
                               const VID: WideString; const VPsw: WideString; 
                               const UID: WideString; const UPsw: WideString; 
                               out relsSuccess: WordBool; out relsErrorMessage: WideString; 
                               out relsErrorKind: WideString): WideString; safecall;
    function SubmitRelsReport(const baseUrl: WideString; const version: WideString; 
                              const appIdentity: WideString; const appPassword: WideString; 
                              orderNumber: Integer; const xmlData: WideString; 
                              const VID: WideString; const VPsw: WideString; const UID: WideString; 
                              const UPsw: WideString; out relsSuccess: WordBool; 
                              out relsErrorMessage: WideString; out relsErrorKind: WideString): WideString; safecall;
    function GetRelsDAA(const baseUrl: WideString; const fileType: WideString; 
                        const appIndentity: WideString; const appPassword: WideString; 
                        orderNumber: Integer; const VID: WideString; const VPsw: WideString; 
                        const UID: WideString; const UPsw: WideString; out relsSucess: WordBool; 
                        out relsErrorMessage: WideString; out relsErrorKind: WideString): WideString; safecall;
    function GetAcceptPageURL(const baseUrl: WideString; const token: WideString; 
                              out relsSuccess: WordBool; out relsErrorMessage: WideString): WideString; safecall;
  end;

// *********************************************************************//
// DispIntf:  IConnectionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F95C0405-D0D5-3B83-A043-6812ADFC5911}
// *********************************************************************//
  IConnectionDisp = dispinterface
    ['{F95C0405-D0D5-3B83-A043-6812ADFC5911}']
    function GetRELSOrder(const baseUrl: WideString; const appIdentity: WideString; 
                          const appPassword: WideString; orderNumber: Integer; 
                          const VID: WideString; const VPsw: WideString; const UID: WideString; 
                          const UPsw: WideString; out relsSuccess: WordBool; 
                          out relsErrorMessage: WideString; out relsErrorKind: WideString): WideString; dispid 1610743808;
    function GetRELSData(const baseUrl: WideString; const appIdentity: WideString; 
                         const appPassword: WideString; orderNumber: Integer; declined: WordBool; 
                         const VID: WideString; const VPsw: WideString; const UID: WideString; 
                         const UPsw: WideString; out relsSuccess: WordBool; 
                         out relsErrorMessage: WideString; out relsErrorKind: WideString): WideString; dispid 1610743809;
    function GetRELSValidation(const baseUrl: WideString; const version: WideString; 
                               const appIdentity: WideString; const appPassword: WideString; 
                               orderNumber: Integer; const xmlData: WideString; 
                               const VID: WideString; const VPsw: WideString; 
                               const UID: WideString; const UPsw: WideString; 
                               out relsSuccess: WordBool; out relsErrorMessage: WideString; 
                               out relsErrorKind: WideString): WideString; dispid 1610743810;
    function SubmitRelsReport(const baseUrl: WideString; const version: WideString; 
                              const appIdentity: WideString; const appPassword: WideString; 
                              orderNumber: Integer; const xmlData: WideString; 
                              const VID: WideString; const VPsw: WideString; const UID: WideString; 
                              const UPsw: WideString; out relsSuccess: WordBool; 
                              out relsErrorMessage: WideString; out relsErrorKind: WideString): WideString; dispid 1610743811;
    function GetRelsDAA(const baseUrl: WideString; const fileType: WideString; 
                        const appIndentity: WideString; const appPassword: WideString; 
                        orderNumber: Integer; const VID: WideString; const VPsw: WideString; 
                        const UID: WideString; const UPsw: WideString; out relsSucess: WordBool; 
                        out relsErrorMessage: WideString; out relsErrorKind: WideString): WideString; dispid 1610743812;
    function GetAcceptPageURL(const baseUrl: WideString; const token: WideString; 
                              out relsSuccess: WordBool; out relsErrorMessage: WideString): WideString; dispid 1610743813;
  end;

// *********************************************************************//
// Interface: _RelsConnectionToCLF
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {841F4604-8953-3FDE-B37F-913E9C9B86AF}
// *********************************************************************//
  _RelsConnectionToCLF = interface(IDispatch)
    ['{841F4604-8953-3FDE-B37F-913E9C9B86AF}']
  end;

// *********************************************************************//
// DispIntf:  _RelsConnectionToCLFDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {841F4604-8953-3FDE-B37F-913E9C9B86AF}
// *********************************************************************//
  _RelsConnectionToCLFDisp = dispinterface
    ['{841F4604-8953-3FDE-B37F-913E9C9B86AF}']
  end;

// *********************************************************************//
// Interface: _ValidateAppraisalResponse
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {99FBF9EB-3CC5-3730-825B-5C9006046E94}
// *********************************************************************//
  _ValidateAppraisalResponse = interface(IDispatch)
    ['{99FBF9EB-3CC5-3730-825B-5C9006046E94}']
  end;

// *********************************************************************//
// DispIntf:  _ValidateAppraisalResponseDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {99FBF9EB-3CC5-3730-825B-5C9006046E94}
// *********************************************************************//
  _ValidateAppraisalResponseDisp = dispinterface
    ['{99FBF9EB-3CC5-3730-825B-5C9006046E94}']
  end;

// *********************************************************************//
// Interface: _ValidateAppraisalResponseRequest
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {719DE911-47B8-388C-8F35-1E5B1DE2D5AF}
// *********************************************************************//
  _ValidateAppraisalResponseRequest = interface(IDispatch)
    ['{719DE911-47B8-388C-8F35-1E5B1DE2D5AF}']
  end;

// *********************************************************************//
// DispIntf:  _ValidateAppraisalResponseRequestDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {719DE911-47B8-388C-8F35-1E5B1DE2D5AF}
// *********************************************************************//
  _ValidateAppraisalResponseRequestDisp = dispinterface
    ['{719DE911-47B8-388C-8F35-1E5B1DE2D5AF}']
  end;

// *********************************************************************//
// Interface: _RelsWseClient_ValidateResponse_STATUS
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {E4084E50-6131-32C8-BCB5-4FDB8E3CCD12}
// *********************************************************************//
  _RelsWseClient_ValidateResponse_STATUS = interface(IDispatch)
    ['{E4084E50-6131-32C8-BCB5-4FDB8E3CCD12}']
  end;

// *********************************************************************//
// DispIntf:  _RelsWseClient_ValidateResponse_STATUSDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {E4084E50-6131-32C8-BCB5-4FDB8E3CCD12}
// *********************************************************************//
  _RelsWseClient_ValidateResponse_STATUSDisp = dispinterface
    ['{E4084E50-6131-32C8-BCB5-4FDB8E3CCD12}']
  end;

// *********************************************************************//
// Interface: _ValidateAppraisalResponseResponse
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {F64BD1AA-B18E-393A-8458-5746A8A86696}
// *********************************************************************//
  _ValidateAppraisalResponseResponse = interface(IDispatch)
    ['{F64BD1AA-B18E-393A-8458-5746A8A86696}']
  end;

// *********************************************************************//
// DispIntf:  _ValidateAppraisalResponseResponseDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {F64BD1AA-B18E-393A-8458-5746A8A86696}
// *********************************************************************//
  _ValidateAppraisalResponseResponseDisp = dispinterface
    ['{F64BD1AA-B18E-393A-8458-5746A8A86696}']
  end;

// *********************************************************************//
// Interface: _ValidateAppraisalDataCompletedEventHandler
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {66F33E4A-29D7-3432-80DB-0EBE1012371E}
// *********************************************************************//
  _ValidateAppraisalDataCompletedEventHandler = interface(IDispatch)
    ['{66F33E4A-29D7-3432-80DB-0EBE1012371E}']
  end;

// *********************************************************************//
// DispIntf:  _ValidateAppraisalDataCompletedEventHandlerDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {66F33E4A-29D7-3432-80DB-0EBE1012371E}
// *********************************************************************//
  _ValidateAppraisalDataCompletedEventHandlerDisp = dispinterface
    ['{66F33E4A-29D7-3432-80DB-0EBE1012371E}']
  end;

// *********************************************************************//
// Interface: _ValidateAppraisalDataCompletedEventArgs
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {9B061D3B-D5DB-36F6-B4E2-57B9D0192B41}
// *********************************************************************//
  _ValidateAppraisalDataCompletedEventArgs = interface(IDispatch)
    ['{9B061D3B-D5DB-36F6-B4E2-57B9D0192B41}']
  end;

// *********************************************************************//
// DispIntf:  _ValidateAppraisalDataCompletedEventArgsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {9B061D3B-D5DB-36F6-B4E2-57B9D0192B41}
// *********************************************************************//
  _ValidateAppraisalDataCompletedEventArgsDisp = dispinterface
    ['{9B061D3B-D5DB-36F6-B4E2-57B9D0192B41}']
  end;

// *********************************************************************//
// Interface: _SubmitAppraisal
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {9A8B9960-E2E1-3CEC-BC28-048AEC390E6E}
// *********************************************************************//
  _SubmitAppraisal = interface(IDispatch)
    ['{9A8B9960-E2E1-3CEC-BC28-048AEC390E6E}']
  end;

// *********************************************************************//
// DispIntf:  _SubmitAppraisalDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {9A8B9960-E2E1-3CEC-BC28-048AEC390E6E}
// *********************************************************************//
  _SubmitAppraisalDisp = dispinterface
    ['{9A8B9960-E2E1-3CEC-BC28-048AEC390E6E}']
  end;

// *********************************************************************//
// Interface: _SubmitAppraisalRequest
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {BF02696B-DA1D-3F20-97BB-D99E562C3EA9}
// *********************************************************************//
  _SubmitAppraisalRequest = interface(IDispatch)
    ['{BF02696B-DA1D-3F20-97BB-D99E562C3EA9}']
  end;

// *********************************************************************//
// DispIntf:  _SubmitAppraisalRequestDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {BF02696B-DA1D-3F20-97BB-D99E562C3EA9}
// *********************************************************************//
  _SubmitAppraisalRequestDisp = dispinterface
    ['{BF02696B-DA1D-3F20-97BB-D99E562C3EA9}']
  end;

// *********************************************************************//
// Interface: _RelsWseClient_RelsSubmit_STATUS
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D304739B-7127-345C-8B29-7C524B4F77B0}
// *********************************************************************//
  _RelsWseClient_RelsSubmit_STATUS = interface(IDispatch)
    ['{D304739B-7127-345C-8B29-7C524B4F77B0}']
  end;

// *********************************************************************//
// DispIntf:  _RelsWseClient_RelsSubmit_STATUSDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D304739B-7127-345C-8B29-7C524B4F77B0}
// *********************************************************************//
  _RelsWseClient_RelsSubmit_STATUSDisp = dispinterface
    ['{D304739B-7127-345C-8B29-7C524B4F77B0}']
  end;

// *********************************************************************//
// Interface: _SubmitAppraisalResponse
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {F3B986F2-182C-3551-801E-DABB27DE1154}
// *********************************************************************//
  _SubmitAppraisalResponse = interface(IDispatch)
    ['{F3B986F2-182C-3551-801E-DABB27DE1154}']
  end;

// *********************************************************************//
// DispIntf:  _SubmitAppraisalResponseDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {F3B986F2-182C-3551-801E-DABB27DE1154}
// *********************************************************************//
  _SubmitAppraisalResponseDisp = dispinterface
    ['{F3B986F2-182C-3551-801E-DABB27DE1154}']
  end;

// *********************************************************************//
// Interface: _SubmitCompletedEventHandler
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {785AB5F4-416B-3E02-B148-B0D6081F5917}
// *********************************************************************//
  _SubmitCompletedEventHandler = interface(IDispatch)
    ['{785AB5F4-416B-3E02-B148-B0D6081F5917}']
  end;

// *********************************************************************//
// DispIntf:  _SubmitCompletedEventHandlerDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {785AB5F4-416B-3E02-B148-B0D6081F5917}
// *********************************************************************//
  _SubmitCompletedEventHandlerDisp = dispinterface
    ['{785AB5F4-416B-3E02-B148-B0D6081F5917}']
  end;

// *********************************************************************//
// Interface: _SubmitCompletedEventArgs
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {E7E3A565-9691-35AC-A321-4B5641B156C4}
// *********************************************************************//
  _SubmitCompletedEventArgs = interface(IDispatch)
    ['{E7E3A565-9691-35AC-A321-4B5641B156C4}']
  end;

// *********************************************************************//
// DispIntf:  _SubmitCompletedEventArgsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {E7E3A565-9691-35AC-A321-4B5641B156C4}
// *********************************************************************//
  _SubmitCompletedEventArgsDisp = dispinterface
    ['{E7E3A565-9691-35AC-A321-4B5641B156C4}']
  end;

// *********************************************************************//
// Interface: _OrderInformationService
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {403DB63A-D82A-3625-9266-6A8E6249598E}
// *********************************************************************//
  _OrderInformationService = interface(IDispatch)
    ['{403DB63A-D82A-3625-9266-6A8E6249598E}']
  end;

// *********************************************************************//
// DispIntf:  _OrderInformationServiceDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {403DB63A-D82A-3625-9266-6A8E6249598E}
// *********************************************************************//
  _OrderInformationServiceDisp = dispinterface
    ['{403DB63A-D82A-3625-9266-6A8E6249598E}']
  end;

// *********************************************************************//
// Interface: _GetOrderInfoRequest
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {225D4E9B-2F45-3ED8-925B-79104D71DFFF}
// *********************************************************************//
  _GetOrderInfoRequest = interface(IDispatch)
    ['{225D4E9B-2F45-3ED8-925B-79104D71DFFF}']
  end;

// *********************************************************************//
// DispIntf:  _GetOrderInfoRequestDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {225D4E9B-2F45-3ED8-925B-79104D71DFFF}
// *********************************************************************//
  _GetOrderInfoRequestDisp = dispinterface
    ['{225D4E9B-2F45-3ED8-925B-79104D71DFFF}']
  end;

// *********************************************************************//
// Interface: _GetOrderDataResponse
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {824FE989-208A-3C08-B168-27ADB73987DC}
// *********************************************************************//
  _GetOrderDataResponse = interface(IDispatch)
    ['{824FE989-208A-3C08-B168-27ADB73987DC}']
  end;

// *********************************************************************//
// DispIntf:  _GetOrderDataResponseDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {824FE989-208A-3C08-B168-27ADB73987DC}
// *********************************************************************//
  _GetOrderDataResponseDisp = dispinterface
    ['{824FE989-208A-3C08-B168-27ADB73987DC}']
  end;

// *********************************************************************//
// Interface: _RelsWseClient_RelsOrderXML_STATUS
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0A54E045-4AE3-3435-91B1-2FBC0D1B2FAE}
// *********************************************************************//
  _RelsWseClient_RelsOrderXML_STATUS = interface(IDispatch)
    ['{0A54E045-4AE3-3435-91B1-2FBC0D1B2FAE}']
  end;

// *********************************************************************//
// DispIntf:  _RelsWseClient_RelsOrderXML_STATUSDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0A54E045-4AE3-3435-91B1-2FBC0D1B2FAE}
// *********************************************************************//
  _RelsWseClient_RelsOrderXML_STATUSDisp = dispinterface
    ['{0A54E045-4AE3-3435-91B1-2FBC0D1B2FAE}']
  end;

// *********************************************************************//
// Interface: _GetOrderDataRequest
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {FB8A8C6B-7142-3B62-B657-3A1CA9C23BF3}
// *********************************************************************//
  _GetOrderDataRequest = interface(IDispatch)
    ['{FB8A8C6B-7142-3B62-B657-3A1CA9C23BF3}']
  end;

// *********************************************************************//
// DispIntf:  _GetOrderDataRequestDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {FB8A8C6B-7142-3B62-B657-3A1CA9C23BF3}
// *********************************************************************//
  _GetOrderDataRequestDisp = dispinterface
    ['{FB8A8C6B-7142-3B62-B657-3A1CA9C23BF3}']
  end;

// *********************************************************************//
// Interface: _GetOrderInfoResponse
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {C78FC9A0-FB32-34B8-B8E6-80299D19CC96}
// *********************************************************************//
  _GetOrderInfoResponse = interface(IDispatch)
    ['{C78FC9A0-FB32-34B8-B8E6-80299D19CC96}']
  end;

// *********************************************************************//
// DispIntf:  _GetOrderInfoResponseDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {C78FC9A0-FB32-34B8-B8E6-80299D19CC96}
// *********************************************************************//
  _GetOrderInfoResponseDisp = dispinterface
    ['{C78FC9A0-FB32-34B8-B8E6-80299D19CC96}']
  end;

// *********************************************************************//
// Interface: _GetOrderInformationCompletedEventHandler
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {2717F985-F2C3-3A6C-B25B-64405E3D7755}
// *********************************************************************//
  _GetOrderInformationCompletedEventHandler = interface(IDispatch)
    ['{2717F985-F2C3-3A6C-B25B-64405E3D7755}']
  end;

// *********************************************************************//
// DispIntf:  _GetOrderInformationCompletedEventHandlerDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {2717F985-F2C3-3A6C-B25B-64405E3D7755}
// *********************************************************************//
  _GetOrderInformationCompletedEventHandlerDisp = dispinterface
    ['{2717F985-F2C3-3A6C-B25B-64405E3D7755}']
  end;

// *********************************************************************//
// Interface: _GetOrderInformationCompletedEventArgs
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {F01438E1-DF2E-36A2-BA62-C673C18548CE}
// *********************************************************************//
  _GetOrderInformationCompletedEventArgs = interface(IDispatch)
    ['{F01438E1-DF2E-36A2-BA62-C673C18548CE}']
  end;

// *********************************************************************//
// DispIntf:  _GetOrderInformationCompletedEventArgsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {F01438E1-DF2E-36A2-BA62-C673C18548CE}
// *********************************************************************//
  _GetOrderInformationCompletedEventArgsDisp = dispinterface
    ['{F01438E1-DF2E-36A2-BA62-C673C18548CE}']
  end;

// *********************************************************************//
// Interface: _GetOrderDataRequestCompletedEventHandler
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {EF908A65-2D60-3AB1-84AC-E924215FEE94}
// *********************************************************************//
  _GetOrderDataRequestCompletedEventHandler = interface(IDispatch)
    ['{EF908A65-2D60-3AB1-84AC-E924215FEE94}']
  end;

// *********************************************************************//
// DispIntf:  _GetOrderDataRequestCompletedEventHandlerDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {EF908A65-2D60-3AB1-84AC-E924215FEE94}
// *********************************************************************//
  _GetOrderDataRequestCompletedEventHandlerDisp = dispinterface
    ['{EF908A65-2D60-3AB1-84AC-E924215FEE94}']
  end;

// *********************************************************************//
// Interface: _GetOrderDataRequestCompletedEventArgs
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {6E997525-4043-3323-B2E4-51BC86ACB829}
// *********************************************************************//
  _GetOrderDataRequestCompletedEventArgs = interface(IDispatch)
    ['{6E997525-4043-3323-B2E4-51BC86ACB829}']
  end;

// *********************************************************************//
// DispIntf:  _GetOrderDataRequestCompletedEventArgsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {6E997525-4043-3323-B2E4-51BC86ACB829}
// *********************************************************************//
  _GetOrderDataRequestCompletedEventArgsDisp = dispinterface
    ['{6E997525-4043-3323-B2E4-51BC86ACB829}']
  end;

// *********************************************************************//
// Interface: _RelsData
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {E695C7D9-8828-3ED6-AA0D-39C0D690001F}
// *********************************************************************//
  _RelsData = interface(IDispatch)
    ['{E695C7D9-8828-3ED6-AA0D-39C0D690001F}']
  end;

// *********************************************************************//
// DispIntf:  _RelsDataDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {E695C7D9-8828-3ED6-AA0D-39C0D690001F}
// *********************************************************************//
  _RelsDataDisp = dispinterface
    ['{E695C7D9-8828-3ED6-AA0D-39C0D690001F}']
  end;

// *********************************************************************//
// Interface: _RelsDataRequest
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {B45F5E2B-2835-3300-82C2-ABAC888F2278}
// *********************************************************************//
  _RelsDataRequest = interface(IDispatch)
    ['{B45F5E2B-2835-3300-82C2-ABAC888F2278}']
  end;

// *********************************************************************//
// DispIntf:  _RelsDataRequestDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {B45F5E2B-2835-3300-82C2-ABAC888F2278}
// *********************************************************************//
  _RelsDataRequestDisp = dispinterface
    ['{B45F5E2B-2835-3300-82C2-ABAC888F2278}']
  end;

// *********************************************************************//
// Interface: _RelsWseClient_RelsData_STATUS
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {C0E8D9F0-B997-3365-8F2B-B3675C7A7AC7}
// *********************************************************************//
  _RelsWseClient_RelsData_STATUS = interface(IDispatch)
    ['{C0E8D9F0-B997-3365-8F2B-B3675C7A7AC7}']
  end;

// *********************************************************************//
// DispIntf:  _RelsWseClient_RelsData_STATUSDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {C0E8D9F0-B997-3365-8F2B-B3675C7A7AC7}
// *********************************************************************//
  _RelsWseClient_RelsData_STATUSDisp = dispinterface
    ['{C0E8D9F0-B997-3365-8F2B-B3675C7A7AC7}']
  end;

// *********************************************************************//
// Interface: _RelsDataResponse
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {DF62020D-5E55-39BE-9293-B217D142B40E}
// *********************************************************************//
  _RelsDataResponse = interface(IDispatch)
    ['{DF62020D-5E55-39BE-9293-B217D142B40E}']
  end;

// *********************************************************************//
// DispIntf:  _RelsDataResponseDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {DF62020D-5E55-39BE-9293-B217D142B40E}
// *********************************************************************//
  _RelsDataResponseDisp = dispinterface
    ['{DF62020D-5E55-39BE-9293-B217D142B40E}']
  end;

// *********************************************************************//
// Interface: _GetRelsDataCompletedEventHandler
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {2DC18F87-F30E-3186-A592-41BB853E3A9A}
// *********************************************************************//
  _GetRelsDataCompletedEventHandler = interface(IDispatch)
    ['{2DC18F87-F30E-3186-A592-41BB853E3A9A}']
  end;

// *********************************************************************//
// DispIntf:  _GetRelsDataCompletedEventHandlerDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {2DC18F87-F30E-3186-A592-41BB853E3A9A}
// *********************************************************************//
  _GetRelsDataCompletedEventHandlerDisp = dispinterface
    ['{2DC18F87-F30E-3186-A592-41BB853E3A9A}']
  end;

// *********************************************************************//
// Interface: _GetRelsDataCompletedEventArgs
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {8C082FFE-874F-3D92-A699-7A557ED5A620}
// *********************************************************************//
  _GetRelsDataCompletedEventArgs = interface(IDispatch)
    ['{8C082FFE-874F-3D92-A699-7A557ED5A620}']
  end;

// *********************************************************************//
// DispIntf:  _GetRelsDataCompletedEventArgsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {8C082FFE-874F-3D92-A699-7A557ED5A620}
// *********************************************************************//
  _GetRelsDataCompletedEventArgsDisp = dispinterface
    ['{8C082FFE-874F-3D92-A699-7A557ED5A620}']
  end;

// *********************************************************************//
// The Class CoRelsConnectionToCLF provides a Create and CreateRemote method to          
// create instances of the default interface _RelsConnectionToCLF exposed by              
// the CoClass RelsConnectionToCLF. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRelsConnectionToCLF = class
    class function Create: _RelsConnectionToCLF;
    class function CreateRemote(const MachineName: string): _RelsConnectionToCLF;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TRelsConnectionToCLF
// Help String      : 
// Default Interface: _RelsConnectionToCLF
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TRelsConnectionToCLF = class(TOleServer)
  private
    FIntf: _RelsConnectionToCLF;
    function GetDefaultInterface: _RelsConnectionToCLF;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _RelsConnectionToCLF);
    procedure Disconnect; override;
    property DefaultInterface: _RelsConnectionToCLF read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoValidateAppraisalResponse provides a Create and CreateRemote method to          
// create instances of the default interface _ValidateAppraisalResponse exposed by              
// the CoClass ValidateAppraisalResponse. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoValidateAppraisalResponse = class
    class function Create: _ValidateAppraisalResponse;
    class function CreateRemote(const MachineName: string): _ValidateAppraisalResponse;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TValidateAppraisalResponse
// Help String      : 
// Default Interface: _ValidateAppraisalResponse
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TValidateAppraisalResponse = class(TOleServer)
  private
    FIntf: _ValidateAppraisalResponse;
    function GetDefaultInterface: _ValidateAppraisalResponse;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _ValidateAppraisalResponse);
    procedure Disconnect; override;
    property DefaultInterface: _ValidateAppraisalResponse read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoValidateAppraisalResponseRequest provides a Create and CreateRemote method to          
// create instances of the default interface _ValidateAppraisalResponseRequest exposed by              
// the CoClass ValidateAppraisalResponseRequest. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoValidateAppraisalResponseRequest = class
    class function Create: _ValidateAppraisalResponseRequest;
    class function CreateRemote(const MachineName: string): _ValidateAppraisalResponseRequest;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TValidateAppraisalResponseRequest
// Help String      : 
// Default Interface: _ValidateAppraisalResponseRequest
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TValidateAppraisalResponseRequest = class(TOleServer)
  private
    FIntf: _ValidateAppraisalResponseRequest;
    function GetDefaultInterface: _ValidateAppraisalResponseRequest;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _ValidateAppraisalResponseRequest);
    procedure Disconnect; override;
    property DefaultInterface: _ValidateAppraisalResponseRequest read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoRelsWseClient_ValidateResponse_STATUS provides a Create and CreateRemote method to          
// create instances of the default interface _RelsWseClient_ValidateResponse_STATUS exposed by              
// the CoClass RelsWseClient_ValidateResponse_STATUS. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRelsWseClient_ValidateResponse_STATUS = class
    class function Create: _RelsWseClient_ValidateResponse_STATUS;
    class function CreateRemote(const MachineName: string): _RelsWseClient_ValidateResponse_STATUS;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TRelsWseClient_ValidateResponse_STATUS
// Help String      : 
// Default Interface: _RelsWseClient_ValidateResponse_STATUS
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TRelsWseClient_ValidateResponse_STATUS = class(TOleServer)
  private
    FIntf: _RelsWseClient_ValidateResponse_STATUS;
    function GetDefaultInterface: _RelsWseClient_ValidateResponse_STATUS;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _RelsWseClient_ValidateResponse_STATUS);
    procedure Disconnect; override;
    property DefaultInterface: _RelsWseClient_ValidateResponse_STATUS read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoValidateAppraisalResponseResponse provides a Create and CreateRemote method to          
// create instances of the default interface _ValidateAppraisalResponseResponse exposed by              
// the CoClass ValidateAppraisalResponseResponse. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoValidateAppraisalResponseResponse = class
    class function Create: _ValidateAppraisalResponseResponse;
    class function CreateRemote(const MachineName: string): _ValidateAppraisalResponseResponse;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TValidateAppraisalResponseResponse
// Help String      : 
// Default Interface: _ValidateAppraisalResponseResponse
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TValidateAppraisalResponseResponse = class(TOleServer)
  private
    FIntf: _ValidateAppraisalResponseResponse;
    function GetDefaultInterface: _ValidateAppraisalResponseResponse;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _ValidateAppraisalResponseResponse);
    procedure Disconnect; override;
    property DefaultInterface: _ValidateAppraisalResponseResponse read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoValidateAppraisalDataCompletedEventHandler provides a Create and CreateRemote method to          
// create instances of the default interface _ValidateAppraisalDataCompletedEventHandler exposed by              
// the CoClass ValidateAppraisalDataCompletedEventHandler. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoValidateAppraisalDataCompletedEventHandler = class
    class function Create: _ValidateAppraisalDataCompletedEventHandler;
    class function CreateRemote(const MachineName: string): _ValidateAppraisalDataCompletedEventHandler;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TValidateAppraisalDataCompletedEventHandler
// Help String      : 
// Default Interface: _ValidateAppraisalDataCompletedEventHandler
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (0)
// *********************************************************************//
  TValidateAppraisalDataCompletedEventHandler = class(TOleServer)
  private
    FIntf: _ValidateAppraisalDataCompletedEventHandler;
    function GetDefaultInterface: _ValidateAppraisalDataCompletedEventHandler;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _ValidateAppraisalDataCompletedEventHandler);
    procedure Disconnect; override;
    property DefaultInterface: _ValidateAppraisalDataCompletedEventHandler read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoValidateAppraisalDataCompletedEventArgs provides a Create and CreateRemote method to          
// create instances of the default interface _ValidateAppraisalDataCompletedEventArgs exposed by              
// the CoClass ValidateAppraisalDataCompletedEventArgs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoValidateAppraisalDataCompletedEventArgs = class
    class function Create: _ValidateAppraisalDataCompletedEventArgs;
    class function CreateRemote(const MachineName: string): _ValidateAppraisalDataCompletedEventArgs;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TValidateAppraisalDataCompletedEventArgs
// Help String      : 
// Default Interface: _ValidateAppraisalDataCompletedEventArgs
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (0)
// *********************************************************************//
  TValidateAppraisalDataCompletedEventArgs = class(TOleServer)
  private
    FIntf: _ValidateAppraisalDataCompletedEventArgs;
    function GetDefaultInterface: _ValidateAppraisalDataCompletedEventArgs;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _ValidateAppraisalDataCompletedEventArgs);
    procedure Disconnect; override;
    property DefaultInterface: _ValidateAppraisalDataCompletedEventArgs read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoSubmitAppraisal provides a Create and CreateRemote method to          
// create instances of the default interface _SubmitAppraisal exposed by              
// the CoClass SubmitAppraisal. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSubmitAppraisal = class
    class function Create: _SubmitAppraisal;
    class function CreateRemote(const MachineName: string): _SubmitAppraisal;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TSubmitAppraisal
// Help String      : 
// Default Interface: _SubmitAppraisal
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TSubmitAppraisal = class(TOleServer)
  private
    FIntf: _SubmitAppraisal;
    function GetDefaultInterface: _SubmitAppraisal;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _SubmitAppraisal);
    procedure Disconnect; override;
    property DefaultInterface: _SubmitAppraisal read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoSubmitAppraisalRequest provides a Create and CreateRemote method to          
// create instances of the default interface _SubmitAppraisalRequest exposed by              
// the CoClass SubmitAppraisalRequest. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSubmitAppraisalRequest = class
    class function Create: _SubmitAppraisalRequest;
    class function CreateRemote(const MachineName: string): _SubmitAppraisalRequest;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TSubmitAppraisalRequest
// Help String      : 
// Default Interface: _SubmitAppraisalRequest
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TSubmitAppraisalRequest = class(TOleServer)
  private
    FIntf: _SubmitAppraisalRequest;
    function GetDefaultInterface: _SubmitAppraisalRequest;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _SubmitAppraisalRequest);
    procedure Disconnect; override;
    property DefaultInterface: _SubmitAppraisalRequest read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoRelsWseClient_RelsSubmit_STATUS provides a Create and CreateRemote method to          
// create instances of the default interface _RelsWseClient_RelsSubmit_STATUS exposed by              
// the CoClass RelsWseClient_RelsSubmit_STATUS. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRelsWseClient_RelsSubmit_STATUS = class
    class function Create: _RelsWseClient_RelsSubmit_STATUS;
    class function CreateRemote(const MachineName: string): _RelsWseClient_RelsSubmit_STATUS;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TRelsWseClient_RelsSubmit_STATUS
// Help String      : 
// Default Interface: _RelsWseClient_RelsSubmit_STATUS
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TRelsWseClient_RelsSubmit_STATUS = class(TOleServer)
  private
    FIntf: _RelsWseClient_RelsSubmit_STATUS;
    function GetDefaultInterface: _RelsWseClient_RelsSubmit_STATUS;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _RelsWseClient_RelsSubmit_STATUS);
    procedure Disconnect; override;
    property DefaultInterface: _RelsWseClient_RelsSubmit_STATUS read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoSubmitAppraisalResponse provides a Create and CreateRemote method to          
// create instances of the default interface _SubmitAppraisalResponse exposed by              
// the CoClass SubmitAppraisalResponse. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSubmitAppraisalResponse = class
    class function Create: _SubmitAppraisalResponse;
    class function CreateRemote(const MachineName: string): _SubmitAppraisalResponse;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TSubmitAppraisalResponse
// Help String      : 
// Default Interface: _SubmitAppraisalResponse
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TSubmitAppraisalResponse = class(TOleServer)
  private
    FIntf: _SubmitAppraisalResponse;
    function GetDefaultInterface: _SubmitAppraisalResponse;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _SubmitAppraisalResponse);
    procedure Disconnect; override;
    property DefaultInterface: _SubmitAppraisalResponse read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoSubmitCompletedEventHandler provides a Create and CreateRemote method to          
// create instances of the default interface _SubmitCompletedEventHandler exposed by              
// the CoClass SubmitCompletedEventHandler. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSubmitCompletedEventHandler = class
    class function Create: _SubmitCompletedEventHandler;
    class function CreateRemote(const MachineName: string): _SubmitCompletedEventHandler;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TSubmitCompletedEventHandler
// Help String      : 
// Default Interface: _SubmitCompletedEventHandler
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (0)
// *********************************************************************//
  TSubmitCompletedEventHandler = class(TOleServer)
  private
    FIntf: _SubmitCompletedEventHandler;
    function GetDefaultInterface: _SubmitCompletedEventHandler;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _SubmitCompletedEventHandler);
    procedure Disconnect; override;
    property DefaultInterface: _SubmitCompletedEventHandler read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoSubmitCompletedEventArgs provides a Create and CreateRemote method to          
// create instances of the default interface _SubmitCompletedEventArgs exposed by              
// the CoClass SubmitCompletedEventArgs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSubmitCompletedEventArgs = class
    class function Create: _SubmitCompletedEventArgs;
    class function CreateRemote(const MachineName: string): _SubmitCompletedEventArgs;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TSubmitCompletedEventArgs
// Help String      : 
// Default Interface: _SubmitCompletedEventArgs
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (0)
// *********************************************************************//
  TSubmitCompletedEventArgs = class(TOleServer)
  private
    FIntf: _SubmitCompletedEventArgs;
    function GetDefaultInterface: _SubmitCompletedEventArgs;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _SubmitCompletedEventArgs);
    procedure Disconnect; override;
    property DefaultInterface: _SubmitCompletedEventArgs read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoOrderInformationService provides a Create and CreateRemote method to          
// create instances of the default interface _OrderInformationService exposed by              
// the CoClass OrderInformationService. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoOrderInformationService = class
    class function Create: _OrderInformationService;
    class function CreateRemote(const MachineName: string): _OrderInformationService;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TOrderInformationService
// Help String      : 
// Default Interface: _OrderInformationService
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TOrderInformationService = class(TOleServer)
  private
    FIntf: _OrderInformationService;
    function GetDefaultInterface: _OrderInformationService;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _OrderInformationService);
    procedure Disconnect; override;
    property DefaultInterface: _OrderInformationService read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoGetOrderInfoRequest provides a Create and CreateRemote method to          
// create instances of the default interface _GetOrderInfoRequest exposed by              
// the CoClass GetOrderInfoRequest. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoGetOrderInfoRequest = class
    class function Create: _GetOrderInfoRequest;
    class function CreateRemote(const MachineName: string): _GetOrderInfoRequest;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TGetOrderInfoRequest
// Help String      : 
// Default Interface: _GetOrderInfoRequest
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TGetOrderInfoRequest = class(TOleServer)
  private
    FIntf: _GetOrderInfoRequest;
    function GetDefaultInterface: _GetOrderInfoRequest;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _GetOrderInfoRequest);
    procedure Disconnect; override;
    property DefaultInterface: _GetOrderInfoRequest read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoGetOrderDataResponse provides a Create and CreateRemote method to          
// create instances of the default interface _GetOrderDataResponse exposed by              
// the CoClass GetOrderDataResponse. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoGetOrderDataResponse = class
    class function Create: _GetOrderDataResponse;
    class function CreateRemote(const MachineName: string): _GetOrderDataResponse;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TGetOrderDataResponse
// Help String      : 
// Default Interface: _GetOrderDataResponse
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TGetOrderDataResponse = class(TOleServer)
  private
    FIntf: _GetOrderDataResponse;
    function GetDefaultInterface: _GetOrderDataResponse;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _GetOrderDataResponse);
    procedure Disconnect; override;
    property DefaultInterface: _GetOrderDataResponse read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoRelsWseClient_RelsOrderXML_STATUS provides a Create and CreateRemote method to          
// create instances of the default interface _RelsWseClient_RelsOrderXML_STATUS exposed by              
// the CoClass RelsWseClient_RelsOrderXML_STATUS. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRelsWseClient_RelsOrderXML_STATUS = class
    class function Create: _RelsWseClient_RelsOrderXML_STATUS;
    class function CreateRemote(const MachineName: string): _RelsWseClient_RelsOrderXML_STATUS;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TRelsWseClient_RelsOrderXML_STATUS
// Help String      : 
// Default Interface: _RelsWseClient_RelsOrderXML_STATUS
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TRelsWseClient_RelsOrderXML_STATUS = class(TOleServer)
  private
    FIntf: _RelsWseClient_RelsOrderXML_STATUS;
    function GetDefaultInterface: _RelsWseClient_RelsOrderXML_STATUS;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _RelsWseClient_RelsOrderXML_STATUS);
    procedure Disconnect; override;
    property DefaultInterface: _RelsWseClient_RelsOrderXML_STATUS read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoGetOrderDataRequest provides a Create and CreateRemote method to          
// create instances of the default interface _GetOrderDataRequest exposed by              
// the CoClass GetOrderDataRequest. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoGetOrderDataRequest = class
    class function Create: _GetOrderDataRequest;
    class function CreateRemote(const MachineName: string): _GetOrderDataRequest;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TGetOrderDataRequest
// Help String      : 
// Default Interface: _GetOrderDataRequest
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TGetOrderDataRequest = class(TOleServer)
  private
    FIntf: _GetOrderDataRequest;
    function GetDefaultInterface: _GetOrderDataRequest;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _GetOrderDataRequest);
    procedure Disconnect; override;
    property DefaultInterface: _GetOrderDataRequest read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoGetOrderInfoResponse provides a Create and CreateRemote method to          
// create instances of the default interface _GetOrderInfoResponse exposed by              
// the CoClass GetOrderInfoResponse. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoGetOrderInfoResponse = class
    class function Create: _GetOrderInfoResponse;
    class function CreateRemote(const MachineName: string): _GetOrderInfoResponse;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TGetOrderInfoResponse
// Help String      : 
// Default Interface: _GetOrderInfoResponse
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TGetOrderInfoResponse = class(TOleServer)
  private
    FIntf: _GetOrderInfoResponse;
    function GetDefaultInterface: _GetOrderInfoResponse;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _GetOrderInfoResponse);
    procedure Disconnect; override;
    property DefaultInterface: _GetOrderInfoResponse read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoGetOrderInformationCompletedEventHandler provides a Create and CreateRemote method to          
// create instances of the default interface _GetOrderInformationCompletedEventHandler exposed by              
// the CoClass GetOrderInformationCompletedEventHandler. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoGetOrderInformationCompletedEventHandler = class
    class function Create: _GetOrderInformationCompletedEventHandler;
    class function CreateRemote(const MachineName: string): _GetOrderInformationCompletedEventHandler;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TGetOrderInformationCompletedEventHandler
// Help String      : 
// Default Interface: _GetOrderInformationCompletedEventHandler
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (0)
// *********************************************************************//
  TGetOrderInformationCompletedEventHandler = class(TOleServer)
  private
    FIntf: _GetOrderInformationCompletedEventHandler;
    function GetDefaultInterface: _GetOrderInformationCompletedEventHandler;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _GetOrderInformationCompletedEventHandler);
    procedure Disconnect; override;
    property DefaultInterface: _GetOrderInformationCompletedEventHandler read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoGetOrderInformationCompletedEventArgs provides a Create and CreateRemote method to          
// create instances of the default interface _GetOrderInformationCompletedEventArgs exposed by              
// the CoClass GetOrderInformationCompletedEventArgs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoGetOrderInformationCompletedEventArgs = class
    class function Create: _GetOrderInformationCompletedEventArgs;
    class function CreateRemote(const MachineName: string): _GetOrderInformationCompletedEventArgs;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TGetOrderInformationCompletedEventArgs
// Help String      : 
// Default Interface: _GetOrderInformationCompletedEventArgs
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (0)
// *********************************************************************//
  TGetOrderInformationCompletedEventArgs = class(TOleServer)
  private
    FIntf: _GetOrderInformationCompletedEventArgs;
    function GetDefaultInterface: _GetOrderInformationCompletedEventArgs;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _GetOrderInformationCompletedEventArgs);
    procedure Disconnect; override;
    property DefaultInterface: _GetOrderInformationCompletedEventArgs read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoGetOrderDataRequestCompletedEventHandler provides a Create and CreateRemote method to          
// create instances of the default interface _GetOrderDataRequestCompletedEventHandler exposed by              
// the CoClass GetOrderDataRequestCompletedEventHandler. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoGetOrderDataRequestCompletedEventHandler = class
    class function Create: _GetOrderDataRequestCompletedEventHandler;
    class function CreateRemote(const MachineName: string): _GetOrderDataRequestCompletedEventHandler;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TGetOrderDataRequestCompletedEventHandler
// Help String      : 
// Default Interface: _GetOrderDataRequestCompletedEventHandler
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (0)
// *********************************************************************//
  TGetOrderDataRequestCompletedEventHandler = class(TOleServer)
  private
    FIntf: _GetOrderDataRequestCompletedEventHandler;
    function GetDefaultInterface: _GetOrderDataRequestCompletedEventHandler;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _GetOrderDataRequestCompletedEventHandler);
    procedure Disconnect; override;
    property DefaultInterface: _GetOrderDataRequestCompletedEventHandler read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoGetOrderDataRequestCompletedEventArgs provides a Create and CreateRemote method to          
// create instances of the default interface _GetOrderDataRequestCompletedEventArgs exposed by              
// the CoClass GetOrderDataRequestCompletedEventArgs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoGetOrderDataRequestCompletedEventArgs = class
    class function Create: _GetOrderDataRequestCompletedEventArgs;
    class function CreateRemote(const MachineName: string): _GetOrderDataRequestCompletedEventArgs;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TGetOrderDataRequestCompletedEventArgs
// Help String      : 
// Default Interface: _GetOrderDataRequestCompletedEventArgs
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (0)
// *********************************************************************//
  TGetOrderDataRequestCompletedEventArgs = class(TOleServer)
  private
    FIntf: _GetOrderDataRequestCompletedEventArgs;
    function GetDefaultInterface: _GetOrderDataRequestCompletedEventArgs;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _GetOrderDataRequestCompletedEventArgs);
    procedure Disconnect; override;
    property DefaultInterface: _GetOrderDataRequestCompletedEventArgs read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoRelsData provides a Create and CreateRemote method to          
// create instances of the default interface _RelsData exposed by              
// the CoClass RelsData. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRelsData = class
    class function Create: _RelsData;
    class function CreateRemote(const MachineName: string): _RelsData;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TRelsData
// Help String      : 
// Default Interface: _RelsData
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TRelsData = class(TOleServer)
  private
    FIntf: _RelsData;
    function GetDefaultInterface: _RelsData;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _RelsData);
    procedure Disconnect; override;
    property DefaultInterface: _RelsData read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoRelsDataRequest provides a Create and CreateRemote method to          
// create instances of the default interface _RelsDataRequest exposed by              
// the CoClass RelsDataRequest. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRelsDataRequest = class
    class function Create: _RelsDataRequest;
    class function CreateRemote(const MachineName: string): _RelsDataRequest;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TRelsDataRequest
// Help String      : 
// Default Interface: _RelsDataRequest
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TRelsDataRequest = class(TOleServer)
  private
    FIntf: _RelsDataRequest;
    function GetDefaultInterface: _RelsDataRequest;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _RelsDataRequest);
    procedure Disconnect; override;
    property DefaultInterface: _RelsDataRequest read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoRelsWseClient_RelsData_STATUS provides a Create and CreateRemote method to          
// create instances of the default interface _RelsWseClient_RelsData_STATUS exposed by              
// the CoClass RelsWseClient_RelsData_STATUS. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRelsWseClient_RelsData_STATUS = class
    class function Create: _RelsWseClient_RelsData_STATUS;
    class function CreateRemote(const MachineName: string): _RelsWseClient_RelsData_STATUS;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TRelsWseClient_RelsData_STATUS
// Help String      : 
// Default Interface: _RelsWseClient_RelsData_STATUS
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TRelsWseClient_RelsData_STATUS = class(TOleServer)
  private
    FIntf: _RelsWseClient_RelsData_STATUS;
    function GetDefaultInterface: _RelsWseClient_RelsData_STATUS;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _RelsWseClient_RelsData_STATUS);
    procedure Disconnect; override;
    property DefaultInterface: _RelsWseClient_RelsData_STATUS read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoRelsDataResponse provides a Create and CreateRemote method to          
// create instances of the default interface _RelsDataResponse exposed by              
// the CoClass RelsDataResponse. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRelsDataResponse = class
    class function Create: _RelsDataResponse;
    class function CreateRemote(const MachineName: string): _RelsDataResponse;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TRelsDataResponse
// Help String      : 
// Default Interface: _RelsDataResponse
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TRelsDataResponse = class(TOleServer)
  private
    FIntf: _RelsDataResponse;
    function GetDefaultInterface: _RelsDataResponse;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _RelsDataResponse);
    procedure Disconnect; override;
    property DefaultInterface: _RelsDataResponse read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoGetRelsDataCompletedEventHandler provides a Create and CreateRemote method to          
// create instances of the default interface _GetRelsDataCompletedEventHandler exposed by              
// the CoClass GetRelsDataCompletedEventHandler. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoGetRelsDataCompletedEventHandler = class
    class function Create: _GetRelsDataCompletedEventHandler;
    class function CreateRemote(const MachineName: string): _GetRelsDataCompletedEventHandler;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TGetRelsDataCompletedEventHandler
// Help String      : 
// Default Interface: _GetRelsDataCompletedEventHandler
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (0)
// *********************************************************************//
  TGetRelsDataCompletedEventHandler = class(TOleServer)
  private
    FIntf: _GetRelsDataCompletedEventHandler;
    function GetDefaultInterface: _GetRelsDataCompletedEventHandler;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _GetRelsDataCompletedEventHandler);
    procedure Disconnect; override;
    property DefaultInterface: _GetRelsDataCompletedEventHandler read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoGetRelsDataCompletedEventArgs provides a Create and CreateRemote method to          
// create instances of the default interface _GetRelsDataCompletedEventArgs exposed by              
// the CoClass GetRelsDataCompletedEventArgs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoGetRelsDataCompletedEventArgs = class
    class function Create: _GetRelsDataCompletedEventArgs;
    class function CreateRemote(const MachineName: string): _GetRelsDataCompletedEventArgs;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TGetRelsDataCompletedEventArgs
// Help String      : 
// Default Interface: _GetRelsDataCompletedEventArgs
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (0)
// *********************************************************************//
  TGetRelsDataCompletedEventArgs = class(TOleServer)
  private
    FIntf: _GetRelsDataCompletedEventArgs;
    function GetDefaultInterface: _GetRelsDataCompletedEventArgs;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _GetRelsDataCompletedEventArgs);
    procedure Disconnect; override;
    property DefaultInterface: _GetRelsDataCompletedEventArgs read GetDefaultInterface;
  published
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

class function CoRelsConnectionToCLF.Create: _RelsConnectionToCLF;
begin
  Result := CreateComObject(CLASS_RelsConnectionToCLF) as _RelsConnectionToCLF;
end;

class function CoRelsConnectionToCLF.CreateRemote(const MachineName: string): _RelsConnectionToCLF;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RelsConnectionToCLF) as _RelsConnectionToCLF;
end;

procedure TRelsConnectionToCLF.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{15D94F5C-254A-34F0-9553-F71F266AD4C8}';
    IntfIID:   '{841F4604-8953-3FDE-B37F-913E9C9B86AF}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TRelsConnectionToCLF.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _RelsConnectionToCLF;
  end;
end;

procedure TRelsConnectionToCLF.ConnectTo(svrIntf: _RelsConnectionToCLF);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TRelsConnectionToCLF.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TRelsConnectionToCLF.GetDefaultInterface: _RelsConnectionToCLF;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TRelsConnectionToCLF.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TRelsConnectionToCLF.Destroy;
begin
  inherited Destroy;
end;

class function CoValidateAppraisalResponse.Create: _ValidateAppraisalResponse;
begin
  Result := CreateComObject(CLASS_ValidateAppraisalResponse) as _ValidateAppraisalResponse;
end;

class function CoValidateAppraisalResponse.CreateRemote(const MachineName: string): _ValidateAppraisalResponse;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ValidateAppraisalResponse) as _ValidateAppraisalResponse;
end;

procedure TValidateAppraisalResponse.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{68F34EAA-20A1-380F-92C1-5B27573B9D65}';
    IntfIID:   '{99FBF9EB-3CC5-3730-825B-5C9006046E94}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TValidateAppraisalResponse.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _ValidateAppraisalResponse;
  end;
end;

procedure TValidateAppraisalResponse.ConnectTo(svrIntf: _ValidateAppraisalResponse);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TValidateAppraisalResponse.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TValidateAppraisalResponse.GetDefaultInterface: _ValidateAppraisalResponse;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TValidateAppraisalResponse.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TValidateAppraisalResponse.Destroy;
begin
  inherited Destroy;
end;

class function CoValidateAppraisalResponseRequest.Create: _ValidateAppraisalResponseRequest;
begin
  Result := CreateComObject(CLASS_ValidateAppraisalResponseRequest) as _ValidateAppraisalResponseRequest;
end;

class function CoValidateAppraisalResponseRequest.CreateRemote(const MachineName: string): _ValidateAppraisalResponseRequest;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ValidateAppraisalResponseRequest) as _ValidateAppraisalResponseRequest;
end;

procedure TValidateAppraisalResponseRequest.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{62D8AF06-CA61-35EC-B3E5-9B335FE0313E}';
    IntfIID:   '{719DE911-47B8-388C-8F35-1E5B1DE2D5AF}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TValidateAppraisalResponseRequest.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _ValidateAppraisalResponseRequest;
  end;
end;

procedure TValidateAppraisalResponseRequest.ConnectTo(svrIntf: _ValidateAppraisalResponseRequest);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TValidateAppraisalResponseRequest.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TValidateAppraisalResponseRequest.GetDefaultInterface: _ValidateAppraisalResponseRequest;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TValidateAppraisalResponseRequest.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TValidateAppraisalResponseRequest.Destroy;
begin
  inherited Destroy;
end;

class function CoRelsWseClient_ValidateResponse_STATUS.Create: _RelsWseClient_ValidateResponse_STATUS;
begin
  Result := CreateComObject(CLASS_RelsWseClient_ValidateResponse_STATUS) as _RelsWseClient_ValidateResponse_STATUS;
end;

class function CoRelsWseClient_ValidateResponse_STATUS.CreateRemote(const MachineName: string): _RelsWseClient_ValidateResponse_STATUS;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RelsWseClient_ValidateResponse_STATUS) as _RelsWseClient_ValidateResponse_STATUS;
end;

procedure TRelsWseClient_ValidateResponse_STATUS.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{794BE79D-0ADA-371A-B18A-EDAD092F37FD}';
    IntfIID:   '{E4084E50-6131-32C8-BCB5-4FDB8E3CCD12}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TRelsWseClient_ValidateResponse_STATUS.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _RelsWseClient_ValidateResponse_STATUS;
  end;
end;

procedure TRelsWseClient_ValidateResponse_STATUS.ConnectTo(svrIntf: _RelsWseClient_ValidateResponse_STATUS);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TRelsWseClient_ValidateResponse_STATUS.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TRelsWseClient_ValidateResponse_STATUS.GetDefaultInterface: _RelsWseClient_ValidateResponse_STATUS;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TRelsWseClient_ValidateResponse_STATUS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TRelsWseClient_ValidateResponse_STATUS.Destroy;
begin
  inherited Destroy;
end;

class function CoValidateAppraisalResponseResponse.Create: _ValidateAppraisalResponseResponse;
begin
  Result := CreateComObject(CLASS_ValidateAppraisalResponseResponse) as _ValidateAppraisalResponseResponse;
end;

class function CoValidateAppraisalResponseResponse.CreateRemote(const MachineName: string): _ValidateAppraisalResponseResponse;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ValidateAppraisalResponseResponse) as _ValidateAppraisalResponseResponse;
end;

procedure TValidateAppraisalResponseResponse.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{A1AF60FA-3790-306A-9ACF-50418822D7C0}';
    IntfIID:   '{F64BD1AA-B18E-393A-8458-5746A8A86696}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TValidateAppraisalResponseResponse.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _ValidateAppraisalResponseResponse;
  end;
end;

procedure TValidateAppraisalResponseResponse.ConnectTo(svrIntf: _ValidateAppraisalResponseResponse);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TValidateAppraisalResponseResponse.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TValidateAppraisalResponseResponse.GetDefaultInterface: _ValidateAppraisalResponseResponse;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TValidateAppraisalResponseResponse.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TValidateAppraisalResponseResponse.Destroy;
begin
  inherited Destroy;
end;

class function CoValidateAppraisalDataCompletedEventHandler.Create: _ValidateAppraisalDataCompletedEventHandler;
begin
  Result := CreateComObject(CLASS_ValidateAppraisalDataCompletedEventHandler) as _ValidateAppraisalDataCompletedEventHandler;
end;

class function CoValidateAppraisalDataCompletedEventHandler.CreateRemote(const MachineName: string): _ValidateAppraisalDataCompletedEventHandler;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ValidateAppraisalDataCompletedEventHandler) as _ValidateAppraisalDataCompletedEventHandler;
end;

procedure TValidateAppraisalDataCompletedEventHandler.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{FA7D2F34-9DBE-3909-9D7D-071790046124}';
    IntfIID:   '{66F33E4A-29D7-3432-80DB-0EBE1012371E}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TValidateAppraisalDataCompletedEventHandler.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _ValidateAppraisalDataCompletedEventHandler;
  end;
end;

procedure TValidateAppraisalDataCompletedEventHandler.ConnectTo(svrIntf: _ValidateAppraisalDataCompletedEventHandler);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TValidateAppraisalDataCompletedEventHandler.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TValidateAppraisalDataCompletedEventHandler.GetDefaultInterface: _ValidateAppraisalDataCompletedEventHandler;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TValidateAppraisalDataCompletedEventHandler.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TValidateAppraisalDataCompletedEventHandler.Destroy;
begin
  inherited Destroy;
end;

class function CoValidateAppraisalDataCompletedEventArgs.Create: _ValidateAppraisalDataCompletedEventArgs;
begin
  Result := CreateComObject(CLASS_ValidateAppraisalDataCompletedEventArgs) as _ValidateAppraisalDataCompletedEventArgs;
end;

class function CoValidateAppraisalDataCompletedEventArgs.CreateRemote(const MachineName: string): _ValidateAppraisalDataCompletedEventArgs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ValidateAppraisalDataCompletedEventArgs) as _ValidateAppraisalDataCompletedEventArgs;
end;

procedure TValidateAppraisalDataCompletedEventArgs.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{17138DF9-4FB7-3FA0-A1D8-9F688F6FC67E}';
    IntfIID:   '{9B061D3B-D5DB-36F6-B4E2-57B9D0192B41}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TValidateAppraisalDataCompletedEventArgs.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _ValidateAppraisalDataCompletedEventArgs;
  end;
end;

procedure TValidateAppraisalDataCompletedEventArgs.ConnectTo(svrIntf: _ValidateAppraisalDataCompletedEventArgs);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TValidateAppraisalDataCompletedEventArgs.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TValidateAppraisalDataCompletedEventArgs.GetDefaultInterface: _ValidateAppraisalDataCompletedEventArgs;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TValidateAppraisalDataCompletedEventArgs.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TValidateAppraisalDataCompletedEventArgs.Destroy;
begin
  inherited Destroy;
end;

class function CoSubmitAppraisal.Create: _SubmitAppraisal;
begin
  Result := CreateComObject(CLASS_SubmitAppraisal) as _SubmitAppraisal;
end;

class function CoSubmitAppraisal.CreateRemote(const MachineName: string): _SubmitAppraisal;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SubmitAppraisal) as _SubmitAppraisal;
end;

procedure TSubmitAppraisal.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{069CD4C1-7EE4-3E87-B06F-69133A29A0D9}';
    IntfIID:   '{9A8B9960-E2E1-3CEC-BC28-048AEC390E6E}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TSubmitAppraisal.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _SubmitAppraisal;
  end;
end;

procedure TSubmitAppraisal.ConnectTo(svrIntf: _SubmitAppraisal);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TSubmitAppraisal.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TSubmitAppraisal.GetDefaultInterface: _SubmitAppraisal;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TSubmitAppraisal.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TSubmitAppraisal.Destroy;
begin
  inherited Destroy;
end;

class function CoSubmitAppraisalRequest.Create: _SubmitAppraisalRequest;
begin
  Result := CreateComObject(CLASS_SubmitAppraisalRequest) as _SubmitAppraisalRequest;
end;

class function CoSubmitAppraisalRequest.CreateRemote(const MachineName: string): _SubmitAppraisalRequest;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SubmitAppraisalRequest) as _SubmitAppraisalRequest;
end;

procedure TSubmitAppraisalRequest.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{631BE2D5-8194-32D8-A967-B697FDFF1205}';
    IntfIID:   '{BF02696B-DA1D-3F20-97BB-D99E562C3EA9}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TSubmitAppraisalRequest.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _SubmitAppraisalRequest;
  end;
end;

procedure TSubmitAppraisalRequest.ConnectTo(svrIntf: _SubmitAppraisalRequest);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TSubmitAppraisalRequest.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TSubmitAppraisalRequest.GetDefaultInterface: _SubmitAppraisalRequest;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TSubmitAppraisalRequest.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TSubmitAppraisalRequest.Destroy;
begin
  inherited Destroy;
end;

class function CoRelsWseClient_RelsSubmit_STATUS.Create: _RelsWseClient_RelsSubmit_STATUS;
begin
  Result := CreateComObject(CLASS_RelsWseClient_RelsSubmit_STATUS) as _RelsWseClient_RelsSubmit_STATUS;
end;

class function CoRelsWseClient_RelsSubmit_STATUS.CreateRemote(const MachineName: string): _RelsWseClient_RelsSubmit_STATUS;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RelsWseClient_RelsSubmit_STATUS) as _RelsWseClient_RelsSubmit_STATUS;
end;

procedure TRelsWseClient_RelsSubmit_STATUS.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{C83A69D1-5879-30B5-9BC1-6A255ED1B5A3}';
    IntfIID:   '{D304739B-7127-345C-8B29-7C524B4F77B0}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TRelsWseClient_RelsSubmit_STATUS.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _RelsWseClient_RelsSubmit_STATUS;
  end;
end;

procedure TRelsWseClient_RelsSubmit_STATUS.ConnectTo(svrIntf: _RelsWseClient_RelsSubmit_STATUS);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TRelsWseClient_RelsSubmit_STATUS.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TRelsWseClient_RelsSubmit_STATUS.GetDefaultInterface: _RelsWseClient_RelsSubmit_STATUS;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TRelsWseClient_RelsSubmit_STATUS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TRelsWseClient_RelsSubmit_STATUS.Destroy;
begin
  inherited Destroy;
end;

class function CoSubmitAppraisalResponse.Create: _SubmitAppraisalResponse;
begin
  Result := CreateComObject(CLASS_SubmitAppraisalResponse) as _SubmitAppraisalResponse;
end;

class function CoSubmitAppraisalResponse.CreateRemote(const MachineName: string): _SubmitAppraisalResponse;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SubmitAppraisalResponse) as _SubmitAppraisalResponse;
end;

procedure TSubmitAppraisalResponse.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{E2D49AF5-90D6-396B-9FF9-90620AB6F710}';
    IntfIID:   '{F3B986F2-182C-3551-801E-DABB27DE1154}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TSubmitAppraisalResponse.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _SubmitAppraisalResponse;
  end;
end;

procedure TSubmitAppraisalResponse.ConnectTo(svrIntf: _SubmitAppraisalResponse);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TSubmitAppraisalResponse.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TSubmitAppraisalResponse.GetDefaultInterface: _SubmitAppraisalResponse;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TSubmitAppraisalResponse.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TSubmitAppraisalResponse.Destroy;
begin
  inherited Destroy;
end;

class function CoSubmitCompletedEventHandler.Create: _SubmitCompletedEventHandler;
begin
  Result := CreateComObject(CLASS_SubmitCompletedEventHandler) as _SubmitCompletedEventHandler;
end;

class function CoSubmitCompletedEventHandler.CreateRemote(const MachineName: string): _SubmitCompletedEventHandler;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SubmitCompletedEventHandler) as _SubmitCompletedEventHandler;
end;

procedure TSubmitCompletedEventHandler.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{639D5151-0F40-3CA4-B84C-246F940CA1B9}';
    IntfIID:   '{785AB5F4-416B-3E02-B148-B0D6081F5917}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TSubmitCompletedEventHandler.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _SubmitCompletedEventHandler;
  end;
end;

procedure TSubmitCompletedEventHandler.ConnectTo(svrIntf: _SubmitCompletedEventHandler);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TSubmitCompletedEventHandler.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TSubmitCompletedEventHandler.GetDefaultInterface: _SubmitCompletedEventHandler;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TSubmitCompletedEventHandler.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TSubmitCompletedEventHandler.Destroy;
begin
  inherited Destroy;
end;

class function CoSubmitCompletedEventArgs.Create: _SubmitCompletedEventArgs;
begin
  Result := CreateComObject(CLASS_SubmitCompletedEventArgs) as _SubmitCompletedEventArgs;
end;

class function CoSubmitCompletedEventArgs.CreateRemote(const MachineName: string): _SubmitCompletedEventArgs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SubmitCompletedEventArgs) as _SubmitCompletedEventArgs;
end;

procedure TSubmitCompletedEventArgs.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{1F619E17-BF20-3043-B554-6DB3726856AF}';
    IntfIID:   '{E7E3A565-9691-35AC-A321-4B5641B156C4}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TSubmitCompletedEventArgs.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _SubmitCompletedEventArgs;
  end;
end;

procedure TSubmitCompletedEventArgs.ConnectTo(svrIntf: _SubmitCompletedEventArgs);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TSubmitCompletedEventArgs.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TSubmitCompletedEventArgs.GetDefaultInterface: _SubmitCompletedEventArgs;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TSubmitCompletedEventArgs.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TSubmitCompletedEventArgs.Destroy;
begin
  inherited Destroy;
end;

class function CoOrderInformationService.Create: _OrderInformationService;
begin
  Result := CreateComObject(CLASS_OrderInformationService) as _OrderInformationService;
end;

class function CoOrderInformationService.CreateRemote(const MachineName: string): _OrderInformationService;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_OrderInformationService) as _OrderInformationService;
end;

procedure TOrderInformationService.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{3E1BFD68-C11C-31AD-8424-6665155335AA}';
    IntfIID:   '{403DB63A-D82A-3625-9266-6A8E6249598E}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TOrderInformationService.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _OrderInformationService;
  end;
end;

procedure TOrderInformationService.ConnectTo(svrIntf: _OrderInformationService);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TOrderInformationService.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TOrderInformationService.GetDefaultInterface: _OrderInformationService;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TOrderInformationService.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TOrderInformationService.Destroy;
begin
  inherited Destroy;
end;

class function CoGetOrderInfoRequest.Create: _GetOrderInfoRequest;
begin
  Result := CreateComObject(CLASS_GetOrderInfoRequest) as _GetOrderInfoRequest;
end;

class function CoGetOrderInfoRequest.CreateRemote(const MachineName: string): _GetOrderInfoRequest;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_GetOrderInfoRequest) as _GetOrderInfoRequest;
end;

procedure TGetOrderInfoRequest.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{A7699613-930B-36E2-933F-ADD19E2548EF}';
    IntfIID:   '{225D4E9B-2F45-3ED8-925B-79104D71DFFF}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TGetOrderInfoRequest.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _GetOrderInfoRequest;
  end;
end;

procedure TGetOrderInfoRequest.ConnectTo(svrIntf: _GetOrderInfoRequest);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TGetOrderInfoRequest.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TGetOrderInfoRequest.GetDefaultInterface: _GetOrderInfoRequest;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TGetOrderInfoRequest.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TGetOrderInfoRequest.Destroy;
begin
  inherited Destroy;
end;

class function CoGetOrderDataResponse.Create: _GetOrderDataResponse;
begin
  Result := CreateComObject(CLASS_GetOrderDataResponse) as _GetOrderDataResponse;
end;

class function CoGetOrderDataResponse.CreateRemote(const MachineName: string): _GetOrderDataResponse;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_GetOrderDataResponse) as _GetOrderDataResponse;
end;

procedure TGetOrderDataResponse.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{E871E262-06A6-394B-BEE7-7AED33DBBACC}';
    IntfIID:   '{824FE989-208A-3C08-B168-27ADB73987DC}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TGetOrderDataResponse.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _GetOrderDataResponse;
  end;
end;

procedure TGetOrderDataResponse.ConnectTo(svrIntf: _GetOrderDataResponse);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TGetOrderDataResponse.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TGetOrderDataResponse.GetDefaultInterface: _GetOrderDataResponse;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TGetOrderDataResponse.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TGetOrderDataResponse.Destroy;
begin
  inherited Destroy;
end;

class function CoRelsWseClient_RelsOrderXML_STATUS.Create: _RelsWseClient_RelsOrderXML_STATUS;
begin
  Result := CreateComObject(CLASS_RelsWseClient_RelsOrderXML_STATUS) as _RelsWseClient_RelsOrderXML_STATUS;
end;

class function CoRelsWseClient_RelsOrderXML_STATUS.CreateRemote(const MachineName: string): _RelsWseClient_RelsOrderXML_STATUS;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RelsWseClient_RelsOrderXML_STATUS) as _RelsWseClient_RelsOrderXML_STATUS;
end;

procedure TRelsWseClient_RelsOrderXML_STATUS.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{689456E7-5224-36BF-BC70-A1B8E64B6AF6}';
    IntfIID:   '{0A54E045-4AE3-3435-91B1-2FBC0D1B2FAE}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TRelsWseClient_RelsOrderXML_STATUS.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _RelsWseClient_RelsOrderXML_STATUS;
  end;
end;

procedure TRelsWseClient_RelsOrderXML_STATUS.ConnectTo(svrIntf: _RelsWseClient_RelsOrderXML_STATUS);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TRelsWseClient_RelsOrderXML_STATUS.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TRelsWseClient_RelsOrderXML_STATUS.GetDefaultInterface: _RelsWseClient_RelsOrderXML_STATUS;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TRelsWseClient_RelsOrderXML_STATUS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TRelsWseClient_RelsOrderXML_STATUS.Destroy;
begin
  inherited Destroy;
end;

class function CoGetOrderDataRequest.Create: _GetOrderDataRequest;
begin
  Result := CreateComObject(CLASS_GetOrderDataRequest) as _GetOrderDataRequest;
end;

class function CoGetOrderDataRequest.CreateRemote(const MachineName: string): _GetOrderDataRequest;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_GetOrderDataRequest) as _GetOrderDataRequest;
end;

procedure TGetOrderDataRequest.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{EE7D8CCC-21DA-3DD7-9BAD-4BE807197222}';
    IntfIID:   '{FB8A8C6B-7142-3B62-B657-3A1CA9C23BF3}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TGetOrderDataRequest.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _GetOrderDataRequest;
  end;
end;

procedure TGetOrderDataRequest.ConnectTo(svrIntf: _GetOrderDataRequest);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TGetOrderDataRequest.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TGetOrderDataRequest.GetDefaultInterface: _GetOrderDataRequest;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TGetOrderDataRequest.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TGetOrderDataRequest.Destroy;
begin
  inherited Destroy;
end;

class function CoGetOrderInfoResponse.Create: _GetOrderInfoResponse;
begin
  Result := CreateComObject(CLASS_GetOrderInfoResponse) as _GetOrderInfoResponse;
end;

class function CoGetOrderInfoResponse.CreateRemote(const MachineName: string): _GetOrderInfoResponse;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_GetOrderInfoResponse) as _GetOrderInfoResponse;
end;

procedure TGetOrderInfoResponse.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{2DB65B7D-C9BE-39AB-AF88-91B43F7FF4F1}';
    IntfIID:   '{C78FC9A0-FB32-34B8-B8E6-80299D19CC96}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TGetOrderInfoResponse.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _GetOrderInfoResponse;
  end;
end;

procedure TGetOrderInfoResponse.ConnectTo(svrIntf: _GetOrderInfoResponse);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TGetOrderInfoResponse.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TGetOrderInfoResponse.GetDefaultInterface: _GetOrderInfoResponse;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TGetOrderInfoResponse.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TGetOrderInfoResponse.Destroy;
begin
  inherited Destroy;
end;

class function CoGetOrderInformationCompletedEventHandler.Create: _GetOrderInformationCompletedEventHandler;
begin
  Result := CreateComObject(CLASS_GetOrderInformationCompletedEventHandler) as _GetOrderInformationCompletedEventHandler;
end;

class function CoGetOrderInformationCompletedEventHandler.CreateRemote(const MachineName: string): _GetOrderInformationCompletedEventHandler;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_GetOrderInformationCompletedEventHandler) as _GetOrderInformationCompletedEventHandler;
end;

procedure TGetOrderInformationCompletedEventHandler.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{2BECBC30-E7A3-38B6-9434-84B986C63FE9}';
    IntfIID:   '{2717F985-F2C3-3A6C-B25B-64405E3D7755}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TGetOrderInformationCompletedEventHandler.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _GetOrderInformationCompletedEventHandler;
  end;
end;

procedure TGetOrderInformationCompletedEventHandler.ConnectTo(svrIntf: _GetOrderInformationCompletedEventHandler);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TGetOrderInformationCompletedEventHandler.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TGetOrderInformationCompletedEventHandler.GetDefaultInterface: _GetOrderInformationCompletedEventHandler;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TGetOrderInformationCompletedEventHandler.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TGetOrderInformationCompletedEventHandler.Destroy;
begin
  inherited Destroy;
end;

class function CoGetOrderInformationCompletedEventArgs.Create: _GetOrderInformationCompletedEventArgs;
begin
  Result := CreateComObject(CLASS_GetOrderInformationCompletedEventArgs) as _GetOrderInformationCompletedEventArgs;
end;

class function CoGetOrderInformationCompletedEventArgs.CreateRemote(const MachineName: string): _GetOrderInformationCompletedEventArgs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_GetOrderInformationCompletedEventArgs) as _GetOrderInformationCompletedEventArgs;
end;

procedure TGetOrderInformationCompletedEventArgs.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{5857FC51-C7DC-3B24-BA05-78E49F2EBCF5}';
    IntfIID:   '{F01438E1-DF2E-36A2-BA62-C673C18548CE}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TGetOrderInformationCompletedEventArgs.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _GetOrderInformationCompletedEventArgs;
  end;
end;

procedure TGetOrderInformationCompletedEventArgs.ConnectTo(svrIntf: _GetOrderInformationCompletedEventArgs);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TGetOrderInformationCompletedEventArgs.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TGetOrderInformationCompletedEventArgs.GetDefaultInterface: _GetOrderInformationCompletedEventArgs;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TGetOrderInformationCompletedEventArgs.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TGetOrderInformationCompletedEventArgs.Destroy;
begin
  inherited Destroy;
end;

class function CoGetOrderDataRequestCompletedEventHandler.Create: _GetOrderDataRequestCompletedEventHandler;
begin
  Result := CreateComObject(CLASS_GetOrderDataRequestCompletedEventHandler) as _GetOrderDataRequestCompletedEventHandler;
end;

class function CoGetOrderDataRequestCompletedEventHandler.CreateRemote(const MachineName: string): _GetOrderDataRequestCompletedEventHandler;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_GetOrderDataRequestCompletedEventHandler) as _GetOrderDataRequestCompletedEventHandler;
end;

procedure TGetOrderDataRequestCompletedEventHandler.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{21246F59-F2D9-3BBF-8F94-E02174E0CA46}';
    IntfIID:   '{EF908A65-2D60-3AB1-84AC-E924215FEE94}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TGetOrderDataRequestCompletedEventHandler.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _GetOrderDataRequestCompletedEventHandler;
  end;
end;

procedure TGetOrderDataRequestCompletedEventHandler.ConnectTo(svrIntf: _GetOrderDataRequestCompletedEventHandler);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TGetOrderDataRequestCompletedEventHandler.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TGetOrderDataRequestCompletedEventHandler.GetDefaultInterface: _GetOrderDataRequestCompletedEventHandler;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TGetOrderDataRequestCompletedEventHandler.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TGetOrderDataRequestCompletedEventHandler.Destroy;
begin
  inherited Destroy;
end;

class function CoGetOrderDataRequestCompletedEventArgs.Create: _GetOrderDataRequestCompletedEventArgs;
begin
  Result := CreateComObject(CLASS_GetOrderDataRequestCompletedEventArgs) as _GetOrderDataRequestCompletedEventArgs;
end;

class function CoGetOrderDataRequestCompletedEventArgs.CreateRemote(const MachineName: string): _GetOrderDataRequestCompletedEventArgs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_GetOrderDataRequestCompletedEventArgs) as _GetOrderDataRequestCompletedEventArgs;
end;

procedure TGetOrderDataRequestCompletedEventArgs.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{05175917-B893-3A37-B5A0-31840E7DC2F9}';
    IntfIID:   '{6E997525-4043-3323-B2E4-51BC86ACB829}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TGetOrderDataRequestCompletedEventArgs.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _GetOrderDataRequestCompletedEventArgs;
  end;
end;

procedure TGetOrderDataRequestCompletedEventArgs.ConnectTo(svrIntf: _GetOrderDataRequestCompletedEventArgs);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TGetOrderDataRequestCompletedEventArgs.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TGetOrderDataRequestCompletedEventArgs.GetDefaultInterface: _GetOrderDataRequestCompletedEventArgs;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TGetOrderDataRequestCompletedEventArgs.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TGetOrderDataRequestCompletedEventArgs.Destroy;
begin
  inherited Destroy;
end;

class function CoRelsData.Create: _RelsData;
begin
  Result := CreateComObject(CLASS_RelsData) as _RelsData;
end;

class function CoRelsData.CreateRemote(const MachineName: string): _RelsData;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RelsData) as _RelsData;
end;

procedure TRelsData.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{C1385DDD-6440-32F6-8B33-C09B11AF8C64}';
    IntfIID:   '{E695C7D9-8828-3ED6-AA0D-39C0D690001F}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TRelsData.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _RelsData;
  end;
end;

procedure TRelsData.ConnectTo(svrIntf: _RelsData);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TRelsData.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TRelsData.GetDefaultInterface: _RelsData;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TRelsData.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TRelsData.Destroy;
begin
  inherited Destroy;
end;

class function CoRelsDataRequest.Create: _RelsDataRequest;
begin
  Result := CreateComObject(CLASS_RelsDataRequest) as _RelsDataRequest;
end;

class function CoRelsDataRequest.CreateRemote(const MachineName: string): _RelsDataRequest;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RelsDataRequest) as _RelsDataRequest;
end;

procedure TRelsDataRequest.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{0E371E7B-57BC-3D03-88B0-AFA8E36726D5}';
    IntfIID:   '{B45F5E2B-2835-3300-82C2-ABAC888F2278}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TRelsDataRequest.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _RelsDataRequest;
  end;
end;

procedure TRelsDataRequest.ConnectTo(svrIntf: _RelsDataRequest);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TRelsDataRequest.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TRelsDataRequest.GetDefaultInterface: _RelsDataRequest;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TRelsDataRequest.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TRelsDataRequest.Destroy;
begin
  inherited Destroy;
end;

class function CoRelsWseClient_RelsData_STATUS.Create: _RelsWseClient_RelsData_STATUS;
begin
  Result := CreateComObject(CLASS_RelsWseClient_RelsData_STATUS) as _RelsWseClient_RelsData_STATUS;
end;

class function CoRelsWseClient_RelsData_STATUS.CreateRemote(const MachineName: string): _RelsWseClient_RelsData_STATUS;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RelsWseClient_RelsData_STATUS) as _RelsWseClient_RelsData_STATUS;
end;

procedure TRelsWseClient_RelsData_STATUS.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{F6933CF1-3A0A-3980-B99F-EC00358C775E}';
    IntfIID:   '{C0E8D9F0-B997-3365-8F2B-B3675C7A7AC7}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TRelsWseClient_RelsData_STATUS.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _RelsWseClient_RelsData_STATUS;
  end;
end;

procedure TRelsWseClient_RelsData_STATUS.ConnectTo(svrIntf: _RelsWseClient_RelsData_STATUS);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TRelsWseClient_RelsData_STATUS.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TRelsWseClient_RelsData_STATUS.GetDefaultInterface: _RelsWseClient_RelsData_STATUS;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TRelsWseClient_RelsData_STATUS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TRelsWseClient_RelsData_STATUS.Destroy;
begin
  inherited Destroy;
end;

class function CoRelsDataResponse.Create: _RelsDataResponse;
begin
  Result := CreateComObject(CLASS_RelsDataResponse) as _RelsDataResponse;
end;

class function CoRelsDataResponse.CreateRemote(const MachineName: string): _RelsDataResponse;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RelsDataResponse) as _RelsDataResponse;
end;

procedure TRelsDataResponse.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{078F7822-04FD-3412-A7F0-06775BE762C9}';
    IntfIID:   '{DF62020D-5E55-39BE-9293-B217D142B40E}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TRelsDataResponse.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _RelsDataResponse;
  end;
end;

procedure TRelsDataResponse.ConnectTo(svrIntf: _RelsDataResponse);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TRelsDataResponse.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TRelsDataResponse.GetDefaultInterface: _RelsDataResponse;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TRelsDataResponse.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TRelsDataResponse.Destroy;
begin
  inherited Destroy;
end;

class function CoGetRelsDataCompletedEventHandler.Create: _GetRelsDataCompletedEventHandler;
begin
  Result := CreateComObject(CLASS_GetRelsDataCompletedEventHandler) as _GetRelsDataCompletedEventHandler;
end;

class function CoGetRelsDataCompletedEventHandler.CreateRemote(const MachineName: string): _GetRelsDataCompletedEventHandler;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_GetRelsDataCompletedEventHandler) as _GetRelsDataCompletedEventHandler;
end;

procedure TGetRelsDataCompletedEventHandler.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{9959CBB5-45FD-3167-9F2E-975CC31BC051}';
    IntfIID:   '{2DC18F87-F30E-3186-A592-41BB853E3A9A}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TGetRelsDataCompletedEventHandler.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _GetRelsDataCompletedEventHandler;
  end;
end;

procedure TGetRelsDataCompletedEventHandler.ConnectTo(svrIntf: _GetRelsDataCompletedEventHandler);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TGetRelsDataCompletedEventHandler.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TGetRelsDataCompletedEventHandler.GetDefaultInterface: _GetRelsDataCompletedEventHandler;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TGetRelsDataCompletedEventHandler.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TGetRelsDataCompletedEventHandler.Destroy;
begin
  inherited Destroy;
end;

class function CoGetRelsDataCompletedEventArgs.Create: _GetRelsDataCompletedEventArgs;
begin
  Result := CreateComObject(CLASS_GetRelsDataCompletedEventArgs) as _GetRelsDataCompletedEventArgs;
end;

class function CoGetRelsDataCompletedEventArgs.CreateRemote(const MachineName: string): _GetRelsDataCompletedEventArgs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_GetRelsDataCompletedEventArgs) as _GetRelsDataCompletedEventArgs;
end;

procedure TGetRelsDataCompletedEventArgs.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{83757244-B969-3746-9388-798B996A636C}';
    IntfIID:   '{8C082FFE-874F-3D92-A699-7A557ED5A620}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TGetRelsDataCompletedEventArgs.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _GetRelsDataCompletedEventArgs;
  end;
end;

procedure TGetRelsDataCompletedEventArgs.ConnectTo(svrIntf: _GetRelsDataCompletedEventArgs);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TGetRelsDataCompletedEventArgs.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TGetRelsDataCompletedEventArgs.GetDefaultInterface: _GetRelsDataCompletedEventArgs;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TGetRelsDataCompletedEventArgs.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TGetRelsDataCompletedEventArgs.Destroy;
begin
  inherited Destroy;
end;

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TRelsConnectionToCLF, TValidateAppraisalResponse, TValidateAppraisalResponseRequest, TRelsWseClient_ValidateResponse_STATUS, 
    TValidateAppraisalResponseResponse, TValidateAppraisalDataCompletedEventHandler, TValidateAppraisalDataCompletedEventArgs, TSubmitAppraisal, TSubmitAppraisalRequest, 
    TRelsWseClient_RelsSubmit_STATUS, TSubmitAppraisalResponse, TSubmitCompletedEventHandler, TSubmitCompletedEventArgs, TOrderInformationService, 
    TGetOrderInfoRequest, TGetOrderDataResponse, TRelsWseClient_RelsOrderXML_STATUS, TGetOrderDataRequest, TGetOrderInfoResponse, 
    TGetOrderInformationCompletedEventHandler, TGetOrderInformationCompletedEventArgs, TGetOrderDataRequestCompletedEventHandler, TGetOrderDataRequestCompletedEventArgs, TRelsData, 
    TRelsDataRequest, TRelsWseClient_RelsData_STATUS, TRelsDataResponse, TGetRelsDataCompletedEventHandler, TGetRelsDataCompletedEventArgs]);
end;

end.
