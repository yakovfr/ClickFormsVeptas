unit UWinTab;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }

interface
uses
  Windows;

const
  WT_DEFBASE = $7FF0;
  WT_MAXOFFSET = $F;

//message IDs
  WT_PACKET     = WT_DEFBASE + 0;
  WT_CTXOPEN    = WT_DEFBASE + 1;
  WT_CTXCLOSE   = WT_DEFBASE + 2;
  WT_CTXUPDATE  = WT_DEFBASE + 3;
  WT_CTXOVERLAP = WT_DEFBASE + 4;
  WT_PROXIMITY  = WT_DEFBASE + 5;
  WT_INFOCHANGE = WT_DEFBASE + 6;
  WT_CSRCHANGE  = WT_DEFBASE + 7;
  WT_MAX        = WT_DEFBASE + WT_MAXOFFSET;

// WTPKT mask bits
  PK_CONTEXT    = $0001; {/* reporting context*/}
  PK_STATUS     = $0002; {/* status bits*/}
  PK_TIME       = $0004; {/* time stamp*/}
  PK_CHANGED    = $0008; {/* change bit vector*/}
  PK_SERIAL_NUMBER = $0010; {/* packet serial number*/}
  PK_CURSOR     = $0020; {/* reporting cursor*/}
  PK_BUTTONS    = $0040; {/* button information*/}
  PK_X = $0080; {/* x axis*/}
  PK_Y = $0100; {/* y axis*/}
  PK_Z = $0200; {/* z axis*/}
  PK_NORMAL_PRESSURE  = $0400; {/* normal or tip pressure*/}
  PK_TANGENT_PRESSURE = $0800; {/* tangential or barrel pressure*/}
  PK_ORIENTATION      = $1000; {/* orientation info: tilts*/}
  PK_ROTATION         = $2000; {/* rotation info; 1.1*/}

  PK_GETALL = PK_CONTEXT or PK_STATUS or PK_TIME or PK_SERIAL_NUMBER or PK_BUTTONS or PK_X or PK_Y or PK_Z;

// unit specifiers
  TU_NONE       = 0;
  TU_INCHES     = 1;
  TU_CENTIMETERS = 2;
  TU_CIRCLE     = 3;

// system button assignment values
  SBN_NONE      = $00;
  SBN_LCLICK    = $01;
  SBN_LDBLCLICK = $02;
  SBN_LDRAG     = $03;
  SBN_RCLICK    = $04;
  SBN_RDBLCLICK = $05;
  SBN_RDRAG     = $06;
  SBN_MCLICK    = $07;
  SBN_MDBLCLICK = $08;
  SBN_MDRAG     = $09;

// for Pen Windows
  SBN_PTCLICK     = $10;
  SBN_PTDBLCLICK  = $20;
  SBN_PTDRAG      = $30;
  SBN_PNCLICK     = $40;
  SBN_PNDBLCLICK  = $50;
  SBN_PNDRAG      = $60;
  SBN_P1CLICK     = $70;
  SBN_P1DBLCLICK  = $80;
  SBN_P1DRAG      = $90;
  SBN_P2CLICK     = $A0;
  SBN_P2DBLCLICK  = $B0;
  SBN_P2DRAG      = $C0;
  SBN_P3CLICK     = $D0;
  SBN_P3DBLCLICK  = $E0;
  SBN_P3DRAG      = $F0;

// hardware capabilities
  HWC_INTEGRATED  = $0001;
  HWC_TOUCH       = $0002;
  HWC_HARDPROX    = $0004;
  HWC_PHYSID_CURSORS = $0008;   

// cursor capabilities
  CRC_MULTIMODE = $0001;
  CRC_AGGREGATE = $0002;
  CRC_INVERT = $0004;

// info categories
  WTI_INTERFACE   = 1;
  IFC_WINTABID    = 1;
  IFC_SPECVERSION = 2;
  IFC_IMPLVERSION = 3;
  IFC_NDEVICES    = 4;
  IFC_NCURSORS    = 5;
  IFC_NCONTEXTS   = 6;
  IFC_CTXOPTIONS  = 7;
  IFC_CTXSAVESIZE = 8;
  IFC_NEXTENSIONS = 9;
  IFC_NMANAGERS   = 10;
  IFC_MAX         = 10;

//Status
  STA_CONTEXTS  = 1;
  WTI_STATUS    = 2;
  STA_SYSCTXS   = 2;
  STA_PKTRATE   = 3;
  STA_PKTDATA   = 4;
  STA_MANAGERS  = 5;
  STA_SYSTEM    = 6;
  STA_BUTTONUSE = 7;
  STA_SYSBTNUSE = 8;
  STA_MAX       = 8;

//NOWTDEFCONTEXT
  WTI_DEFCONTEXT  = 3;
  WTI_DEFSYSCTX   = 4;
  WTI_DDCTXS      = 400; {/* 1.1*/}
  WTI_DSCTXS      = 500; {/* 1.1*/}
  CTX_NAME        = 1;
  CTX_OPTIONS     = 2;
  CTX_STATUS      = 3;
  CTX_LOCKS       = 4;
  CTX_MSGBASE     = 5;
  CTX_DEVICE      = 6;
  CTX_PKTRATE     = 7;
  CTX_PKTDATA     = 8;
  CTX_PKTMODE     = 9;
  CTX_MOVEMASK    = 10;
  CTX_BTNDNMASK   = 11;
  CTX_BTNUPMASK   = 12;
  CTX_INORGX      = 13;
  CTX_INORGY      = 14;
  CTX_INORGZ      = 15;
  CTX_INEXTX      = 16;
  CTX_INEXTY      = 17;
  CTX_INEXTZ      = 18;
  CTX_OUTORGX     = 19;
  CTX_OUTORGY     = 20;
  CTX_OUTORGZ     = 21;
  CTX_OUTEXTX     = 22;
  CTX_OUTEXTY     = 23;
  CTX_OUTEXTZ     = 24;
  CTX_SENSX       = 25;
  CTX_SENSY       = 26;
  CTX_SENSZ       = 27;
  CTX_SYSMODE     = 28;
  CTX_SYSORGX     = 29;
  CTX_SYSORGY     = 30;
  CTX_SYSEXTX     = 31;
  CTX_SYSEXTY     = 32;
  CTX_SYSSENSX    = 33;
  CTX_SYSSENSY    = 34;
  CTX_MAX         = 34;

// NOWTDEVICES
  WTI_DEVICES   = 100;
  DVC_NAME      = 1;
  DVC_HARDWARE  = 2;
  DVC_NCSRTYPES = 3;
  DVC_FIRSTCSR  = 4;
  DVC_PKTRATE   = 5;
  DVC_PKTDATA   = 6;
  DVC_PKTMODE   = 7;
  DVC_CSRDATA   = 8;
  DVC_XMARGIN   = 9;
  DVC_YMARGIN   = 10;
  DVC_ZMARGIN   = 11;
  DVC_X = 12;
  DVC_Y = 13;
  DVC_Z = 14;
  DVC_NPRESSURE = 15;
  DVC_TPRESSURE = 16;
  DVC_ORIENTATION = 17;
  DVC_ROTATION  = 18; {/* 1.1*/}
  DVC_PNPID     = 19; {/* 1.1*/}
  DVC_MAX       = 19;

// NOWTCURSORS
  WTI_CURSORS = 200;
  CSR_NAME = 1;
  CSR_ACTIVE = 2;
  CSR_PKTDATA = 3;
  CSR_BUTTONS = 4;
  CSR_BUTTONBITS = 5;
  CSR_BTNNAMES = 6;
  CSR_BUTTONMAP = 7;
  CSR_SYSBTNMAP = 8;
  CSR_NPBUTTON = 9;
  CSR_NPBTNMARKS = 10;
  CSR_NPRESPONSE = 11;
  CSR_TPBUTTON = 12;
  CSR_TPBTNMARKS = 13;
  CSR_TPRESPONSE = 14;
  CSR_PHYSID = 15; {/* 1.1*/}
  CSR_MODE = 16; {/* 1.1*/}
  CSR_MINPKTDATA = 17; {/* 1.1*/}
  CSR_MINBUTTONS = 18; {/* 1.1*/}
  CSR_CAPABILITIES = 19; {/* 1.1*/}
  CSR_MAX = 19;

//NOWTEXTENSIONS
  WTI_EXTENSIONS = 300;
  EXT_NAME    = 1;
  EXT_TAG     = 2;
  EXT_MASK    = 3;
  EXT_SIZE    = 4;
  EXT_AXES    = 5;
  EXT_DEFAULT = 6;
  EXT_DEFCONTEXT = 7;
  EXT_DEFSYSCTX = 8;
  EXT_CURSORS = 9;
  EXT_MAX     = 109; {/* Allow 100 cursors*/}

// CONTEXT DATA DEFS
  LCNAMELEN = 40;
  LC_NAMELEN = 40;

// context option values
  CXO_SYSTEM    = $0001;
  CXO_PEN       = $0002;
  CXO_MESSAGES  = $0004;
  CXO_MARGIN    = $8000;
  CXO_MGNINSIDE = $4000;
  CXO_CSRMESSAGES = $0008; {/* 1.1*/}

// context status values
  CXS_DISABLED  = $0001;
  CXS_OBSCURED  = $0002;
  CXS_ONTOP     = $0004;

// context lock values
  CXL_INSIZE    = $0001;
  CXL_INASPECT  = $0002;
  CXL_SENSITIVITY = $0004;
  CXL_MARGIN    = $0008;
  CXL_SYSOUT    = $0010;

// packet status values
  TPS_PROXIMITY = $0001;
  TPS_QUEUE_ERR = $0002;
  TPS_MARGIN    = $0004;
  TPS_GRAB      = $0008;
  TPS_INVERT    = $0010;

(*
// grandfather in obsolete member names
  rotPitch = roPitch;
  rotRoll = roRoll;
  rotYaw = roYaw;
*)
// relative buttons
  TBN_NONE  = 0;
  TBN_UP    = 1;
  TBN_DOWN  = 2;

// NOWTDEVCFG
  WTDC_NONE   = 0;
  WTDC_CANCEL = 1;
  WTDC_OK     = 2;
  WTDC_RESTART = 3;

// HOOK CONSTANTS
  WTH_PLAYBACK    = 1;
  WTH_RECORD      = 2;
  WTHC_GETLPLPFN  = -3;
  WTHC_LPLPFNNEXT = -2;
  WTHC_LPFNNEXT   = -1;
  WTHC_ACTION     = 0;
  WTHC_GETNEXT    = 1;
  WTHC_SKIP       = 2;

// constants for use with pktdef.h
  PKEXT_ABSOLUTE = 1;
  PKEXT_RELATIVE = 2;

// Extension tags.
  WTX_OBT     = 0; // Out of bounds tracking
  WTX_FKEYS   = 1; // Function keys
  WTX_TILT    = 2; // Raw Cartesian tilt
  WTX_CSRMASK = 3; // select input by cursor type
  WTX_XBTNMASK = 4; // Extended button mask

type
  WTPKT = LongInt;        {= packet mask }
  FIX32 = LongInt;        {= fixed-point arithmetic type }

  HCTX = THandle;       //handle to the context
  HMGR = THandle;       //handle to the manager info
  
  tagAXIS = record
    axMin: LongInt;
    axMax: LongInt;
    axUnits: Word;
    axResolution: FIX32;
  end; {tagAXIS}

  ORIENTATION = record
    orAzimuth: Integer;
    orAltitude: Integer;
    orTwist: Integer;
  end; {tagORIENTATION}

  ROTATION = record
    roPitch: Integer;
    roRoll: Integer;
    roYaw: Integer;
  end; {tagROTATION}

  tagPACKET =  record
    pkX: LongInt;             //this is all we asked for
    pkY: LongInt;             //so this is all we get
(*
    pkContext: HCTX;
    pkStatus: WORD;
    pkTime: LongInt;
    pkChanged: WTPKT;
    pkSerialNumber: WORD;
    pkCursor: WORD;
    pkButtons: LongInt;
    pkX: LongInt;
    pkY: LongInt;
    pkZ: LongInt;
    pkNormalPressure: LongInt;
    pkTangentPressure: LongInt;
    pkOrientation: ORIENTATION;
    pkRotation: ROTATION;
//    pkFKeys: Word;
//    pkTilt: TILT;
*)
  end;
  PACKETREC = tagPACKET;
  PPacketRec = ^PACKETREC;

  tagLOGCONTEXTA = record
    lcName: Array[0..LC_NAMELEN-1] of Char;
    lcOptions: LongInt;
    lcStatus: LongInt;
    lcLocks: LongInt;
    lcMsgBase: LongInt;
    lcDevice: LongInt;
    lcPktRate: LongInt;
    lcPktData: WTPKT;
    lcPktMode: WTPKT;
    lcMoveMask: WTPKT;
    lcBtnDnMask: LongInt;
    lcBtnUpMask: LongInt;
    lcInOrgX: LongInt;
    lcInOrgY: LongInt;
    lcInOrgZ: LongInt;
    lcInExtX: LongInt;
    lcInExtY: LongInt;
    lcInExtZ: LongInt;
    lcOutOrgX: LongInt;
    lcOutOrgY: LongInt;
    lcOutOrgZ: LongInt;
    lcOutExtX: LongInt;
    lcOutExtY: LongInt;
    lcOutExtZ: LongInt;
    lcSensX: FIX32;
    lcSensY: FIX32;
    lcSensZ: FIX32;
    lcSysMode: Bool;
    lcSysOrgX: Integer;
    lcSysOrgY: Integer;
    lcSysExtX: Integer;
    lcSysExtY: Integer;
    lcSysSensX: FIX32;
    lcSysSensY: FIX32;
  end; {tagLOGCONTEXTA}

  LOGCONTEXT = tagLOGCONTEXTA;
  PLOGCONTEXT = ^LOGCONTEXT;
  NPLOGCONTEXT = PLOGCONTEXT;
  LPLOGCONTEXT = ^PLOGCONTEXT;

  tagXBTNMASK = record
    xBtnDnMask: Array[0..32-1] of BYTE;
    xBtnUpMask: Array[0..32-1] of BYTE;
  end; {tagXBTNMASK}

type
  tagTILT = record
    tiltX: Integer;
    tiltY: Integer;
  end; {tagTILT}

// WinTab DLL Function Index ID
const
  ORD_WTInfoA       = 20;
  ORD_WTOpenA       = 21;
  ORD_WTClose       = 22;
  ORD_WTPacketsGet  = 23;
  ORD_WTPacket      = 24;
  ORD_WTEnable      = 40;
  ORD_WTOverlap     = 41;
  ORD_WTConfig      = 60;
  ORD_WTGetA        = 61;
  ORD_WTSetA        = 62;
  ORD_WTExtGet      = 63;
  ORD_WTExtSet      = 64;
  ORD_WTSave        = 65;
  ORD_WTRestore     = 66;
  ORD_WTPacketsPeek = 80;
  ORD_WTDataGet     = 81;
  ORD_WTDataPeek    = 82;
  ORD_WTMgrOpen     = 100;
  ORD_WTMgrClose    = 101;
  ORD_WTMgrContextEnum  = 120;
  ORD_WTMgrContextOwner = 121;
  ORD_WTMgrDefContext   = 122;
  ORD_WTMgrDefContextEx = 206;
  ORD_WTMgrDeviceConfig = 140;
  ORD_WTMgrExt          = 180;
  ORD_WTMgrCsrEnable    = 181;
  ORD_WTMgrCsrButtonMap = 182;
  ORD_WTMgrCsrPressureBtnMarks = 183;
  ORD_WTMgrCsrPressureResponse = 184;
  ORD_WTMgrCsrExt       = 185;



var
  WTInfo:       function(wCategory: Word; nIndex: Word; pOutput: Pointer): Integer cdecl stdcall;
  WTOpen:       function(hWnd: HWND; var LogCtx: LOGCONTEXT; fEnable: Bool): HCTX cdecl stdcall;
  WTClose:      function(hCntx: HCTX): Bool cdecl  stdcall;
  WTPacketsGet: function(hCntx: HCTX; cMaxPkts: Integer; var pPkts: Pointer): Integer cdecl  stdcall;
//  WTPacket:     function(hCntx: HCTX; wSerial: Integer; pPkt: PPacketRec): Bool cdecl  stdcall;
  WTPacket:     function(hCntx: HCTX; wSerial: Integer; var pPkt: PacketRec): Bool cdecl  stdcall;


// VISIBILITY FUNCTIONS
  WTEnable:   function(_1: HCTX; _2: Bool): Bool cdecl  stdcall;
  WTOverlap:  function(_1: HCTX; _2: Bool): Bool cdecl  stdcall;

// CONTEXT EDITING FUNCTIONS
  WTConfig:   function(_1: HCTX; _2: HWND): Bool cdecl  stdcall;
  WTGetA:     function(_1: HCTX; var _2: LOGCONTEXT): Bool cdecl  stdcall;
  WTSetA:     function(_1: HCTX; var _2: LOGCONTEXT): Bool cdecl  stdcall;
  WTExtGet:   function(_1: HCTX; _2: Word; var _3: Pointer): Bool cdecl  stdcall;
  WTExtSet:   function(_1: HCTX; _2: Word; var _3: Pointer): Bool cdecl  stdcall;
  WTSave:     function(_1: HCTX; var _2: Pointer): Bool cdecl  stdcall;
  WTRestore:  function(_1: HWND; var _2: Pointer; _3: Bool): HCTX cdecl  stdcall;

// ADVANCED PACKET AND QUEUE FUNCTIONS
  WTPacketsPeek: function(_1: HCTX; _2: Integer; var _3: Pointer): Integer cdecl  stdcall;
  WTDataGet:  function(_1: HCTX; _2: Word; _3: Word; _4: Integer; var _5: Pointer; var _6: Integer): Integer cdecl  stdcall;
  WTDataPeek: function(_1: HCTX; _2: Word; _3: Word; _4: Integer; var _5: Pointer; var _6: Integer): Integer cdecl  stdcall;
  WTMgrOpen:  function(_1: HWND; _2: Word): HMGR cdecl  stdcall;
  WTMgrClose: function(_1: HMGR): Bool cdecl  stdcall;


// MANAGER CONTEXT FUNCTIONS*/ }
//  WTMgrContextEnum: function(_1: HMGR;_2: WTENUMPROC;var _3: Longint): Bool cdecl  stdcall;
  WTMgrContextOwner:  function(_1: HMGR; _2: HCTX): HWND cdecl  stdcall;
  WTMgrDefContext:    function(_1: HMGR; _2: Bool): HCTX cdecl  stdcall;
  WTMgrDefContextEx:  function(_1: HMGR; _2: Word; _3: Bool): HCTX cdecl  stdcall;

// MANAGER CONFIG BOX FUNCTIONS
  WTMgrDeviceConfig:  function(_1: HMGR; _2: Word; _3: HWND): Word cdecl  stdcall;

// MANAGER PREFERENCE DATA FUNCTIONS
  WTMgrExt: function(_1: HMGR; _2: Word; var _3: Pointer): Bool cdecl  stdcall;
  WTMgrCsrEnable: function(_1: HMGR; _2: Word; _3: Bool): Bool cdecl  stdcall;
  WTMgrCsrButtonMap: function(_1: HMGR; _2: Word; var _3: BYTE; var _4: BYTE): Bool cdecl  stdcall;
  WTMgrCsrPressureBtnMarks: function(_1: HMGR; _2: Word; _3: LongInt; _4: LongInt): Bool cdecl  stdcall;
  WTMgrCsrPressureResponse: function(_1: HMGR; _2: Word; var _3: Pointer; var _4: Pointer): Bool cdecl  stdcall;
  WTMgrCsrExt: function(_1: HMGR; _2: Word; _3: Word; var _4: Pointer): Bool cdecl stdcall;



  Function LoadWinTabFunctions(WinTabDLL: Thandle): Boolean;

implementation

uses
  UStatus, Sysutils;

(*
{ RaiseLastWin32Error }

procedure RaiseLastWin32Error;
var
  LastError: DWORD;
  Error: EWin32Error;
begin
  LastError := GetLastError;
  if LastError <> ERROR_SUCCESS then
    Error := EWin32Error.CreateResFmt(@SWin32Error, [LastError,
      SysErrorMessage(LastError)])
  else
    Error := EWin32Error.CreateRes(@SUnkWin32Error);
  Error.ErrorCode := LastError;
  raise Error;
end;
*)
Function LoadWinTabFunctions(WinTabDLL: Thandle): Boolean;
(*
  function GetProcAddr(ProcName: PChar): Pointer;
  begin
    Result := GetProcAddress(WinTabDLL, ProcName);
    if not Assigned(Result) then
      RaiseLastWin32Error;
  end;
*)
begin
  result := WinTabDLL >= 32;

  if result then
    begin
      @WTInfo := GetProcAddress(WinTabDLL, 'WTInfoA');
      if @WTInfo = nil then ShowNotice('WTInfo undefined');

      @WTOpen := GetProcAddress(WinTabDLL, 'WTOpenA');
      if @WTOpen = nil then ShowNotice('WTOpen undefined');

      @WTClose := GetProcAddress(WinTabDLL, 'WTClose');
      if @WTClose = nil then ShowNotice('WTClose undefined');

      @WTPacketsGet := GetProcAddress(WinTabDLL, 'WTPacketsGet');
      if @WTPacketsGet = nil then ShowNotice('WTPacketsGet undefined');

      @WTPacket := GetProcAddress(WinTabDLL, 'WTPacket');
      if @WTPacket = nil then ShowNotice('WTPacket undefined');
    end;
end;

end.
