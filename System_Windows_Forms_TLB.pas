unit System_Windows_Forms_TLB;

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

// PASTLWTR : 1.2
// File generated on 3/6/2015 2:22:48 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Windows\Microsoft.NET\Framework\v2.0.50727\System.Windows.Forms.tlb (1)
// LIBID: {215D64D2-031C-33C7-96E3-61794CD1EE61}
// LCID: 0
// Helpfile: 
// HelpString: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\system32\stdole2.tlb)
//   (2) v2.0 mscorlib, (C:\Windows\Microsoft.NET\Framework\v2.0.50727\mscorlib.tlb)
//   (3) v1.1 Accessibility, (C:\Windows\System32\oleacc.dll)
//   (4) v2.0 System, (C:\Windows\Microsoft.NET\Framework\v2.0.50727\System.tlb)
// Errors:
//   Hint: TypeInfo 'Label' changed to 'Label_'
//   Error creating palette bitmap of (TAccessibleObject) : No Server registered for this CoClass
//   Error creating palette bitmap of (TForm) : No Server registered for this CoClass
//   Error creating palette bitmap of (TControl) : No Server registered for this CoClass
//   Error creating palette bitmap of (TContainerControl) : No Server registered for this CoClass
//   Error creating palette bitmap of (TBindingNavigator) : No Server registered for this CoClass
//   Error creating palette bitmap of (TToolStrip) : No Server registered for this CoClass
//   Error creating palette bitmap of (TButton) : No Server registered for this CoClass
//   Error creating palette bitmap of (TCheckBox) : No Server registered for this CoClass
//   Error creating palette bitmap of (TCheckedListBox) : No Server registered for this CoClass
//   Error creating palette bitmap of (TListBox) : No Server registered for this CoClass
//   Error creating palette bitmap of (TListView) : No Server registered for this CoClass
//   Error creating palette bitmap of (TComboBox) : No Server registered for this CoClass
//   Error creating palette bitmap of (TScrollableControl) : No Server registered for this CoClass
//   Error creating palette bitmap of (TContextMenuStrip) : No Server registered for this CoClass
//   Error creating palette bitmap of (TToolStripDropDownMenu) : No Server registered for this CoClass
//   Error creating palette bitmap of (TDataGrid) : No Server registered for this CoClass
//   Error creating palette bitmap of (TDataGridTextBox) : No Server registered for this CoClass
//   Error creating palette bitmap of (TTextBox) : No Server registered for this CoClass
//   Error creating palette bitmap of (TDataGridView) : No Server registered for this CoClass
//   Error creating palette bitmap of (TPanel) : No Server registered for this CoClass
//   Error creating palette bitmap of (TDataGridViewComboBoxEditingControl) : No Server registered for this CoClass
//   Error creating palette bitmap of (TDataGridViewTextBoxEditingControl) : No Server registered for this CoClass
//   Error creating palette bitmap of (TDateTimePicker) : No Server registered for this CoClass
//   Error creating palette bitmap of (TDomainUpDown) : No Server registered for this CoClass
//   Error creating palette bitmap of (TFlowLayoutPanel) : No Server registered for this CoClass
//   Error creating palette bitmap of (TMenuStrip) : No Server registered for this CoClass
//   Error creating palette bitmap of (TGroupBox) : No Server registered for this CoClass
//   Error creating palette bitmap of (THScrollBar) : No Server registered for this CoClass
//   Error creating palette bitmap of (TLabel) : No Server registered for this CoClass
//   Error creating palette bitmap of (TLinkLabel) : No Server registered for this CoClass
//   Error creating palette bitmap of (TMaskedTextBox) : No Server registered for this CoClass
//   Error creating palette bitmap of (TMdiClient) : No Server registered for this CoClass
//   Error creating palette bitmap of (TMonthCalendar) : No Server registered for this CoClass
//   Error creating palette bitmap of (TNumericUpDown) : No Server registered for this CoClass
//   Error creating palette bitmap of (TPictureBox) : No Server registered for this CoClass
//   Error creating palette bitmap of (TPrintPreviewControl) : No Server registered for this CoClass
//   Error creating palette bitmap of (TPrintPreviewDialog) : No Server registered for this CoClass
//   Error creating palette bitmap of (TProgressBar) : No Server registered for this CoClass
//   Error creating palette bitmap of (TPropertyGrid) : No Server registered for this CoClass
//   Error creating palette bitmap of (TQueryAccessibilityHelpEventArgs) : No Server registered for this CoClass
//   Error creating palette bitmap of (TRadioButton) : No Server registered for this CoClass
//   Error creating palette bitmap of (TRichTextBox) : No Server registered for this CoClass
//   Error creating palette bitmap of (TSplitContainer) : No Server registered for this CoClass
//   Error creating palette bitmap of (TSplitter) : No Server registered for this CoClass
//   Error creating palette bitmap of (TStatusBar) : No Server registered for this CoClass
//   Error creating palette bitmap of (TStatusStrip) : No Server registered for this CoClass
//   Error creating palette bitmap of (TTabControl) : No Server registered for this CoClass
//   Error creating palette bitmap of (TTabPage) : No Server registered for this CoClass
//   Error creating palette bitmap of (TTableLayoutPanel) : No Server registered for this CoClass
//   Error creating palette bitmap of (TToolBar) : No Server registered for this CoClass
//   Error creating palette bitmap of (TToolStripContainer) : No Server registered for this CoClass
//   Error creating palette bitmap of (TToolStripPanel) : No Server registered for this CoClass
//   Error creating palette bitmap of (TToolStripContentPanel) : No Server registered for this CoClass
//   Error creating palette bitmap of (TToolStripDropDown) : No Server registered for this CoClass
//   Error creating palette bitmap of (TTrackBar) : No Server registered for this CoClass
//   Error creating palette bitmap of (TTreeView) : No Server registered for this CoClass
//   Error creating palette bitmap of (TUserControl) : No Server registered for this CoClass
//   Error creating palette bitmap of (TVScrollBar) : No Server registered for this CoClass
//   Error creating palette bitmap of (TWebBrowser) : No Server registered for this CoClass
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, Accessibility_TLB, ActiveX, Classes, Graphics, mscorlib_TLB, OleServer, StdVCL, 
System_TLB, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  System_Windows_FormsMajorVersion = 2;
  System_Windows_FormsMinorVersion = 0;

  LIBID_System_Windows_Forms: TGUID = '{215D64D2-031C-33C7-96E3-61794CD1EE61}';

  IID__AccessibleObject: TGUID = '{399C0499-29D3-3D95-AF77-111DCDB92177}';
  IID__Form: TGUID = '{AD0C79DB-37BE-3B61-9C53-2E4857237227}';
  IID__AxHost: TGUID = '{548054D5-75C5-3A72-A87B-D6F305254065}';
  IID__Control: TGUID = '{83ACBFAE-1A16-33EB-ABA0-BA8DF0B206D7}';
  IID_IWin32Window: TGUID = '{458AB8A2-A1EA-4D7B-8EBE-DEE5D3D9442C}';
  IID__ContainerControl: TGUID = '{A5AF2165-C1BE-39AF-AB35-CD950D01A701}';
  IID__BindingNavigator: TGUID = '{E3FF0D90-9E82-3736-A253-3B2F41EF981A}';
  IID__ToolStrip: TGUID = '{A81676FD-EAA3-39C3-9354-A58951270EB6}';
  IID__Button: TGUID = '{9486855D-B3A4-32E8-AF74-EC881982E3FF}';
  IID__ButtonBase: TGUID = '{D14C1282-8647-317E-A549-D2CBCC264C3A}';
  IID__MouseEventArgs: TGUID = '{276A1A21-AAEF-3378-8902-01F695868FF9}';
  IID__ButtonBaseAccessibleObject: TGUID = '{4343B837-6EC8-3E43-8A59-046C35024677}';
  IID__ControlAccessibleObject: TGUID = '{7496E5C0-90D3-372E-885F-BDD1A0316856}';
  IID__KeyEventArgs: TGUID = '{4AAA99AA-77B1-3CF7-85D8-D9CF69271AC6}';
  IID__CheckBox: TGUID = '{1C7817C6-6A49-301E-B20A-05FF053C3D56}';
  IID__CheckBoxAccessibleObject: TGUID = '{5D9FCE71-04C3-395E-B972-F1205E8DE615}';
  IID__CheckedListBox: TGUID = '{1833C4C9-4E61-3D96-AEB5-65B43DE96A01}';
  IID__ListBox: TGUID = '{E36590E6-CFD5-340E-9650-73500A802C43}';
  IID__KeyPressEventArgs: TGUID = '{B8755BC8-51FE-3D19-A3EC-5A5A5CF120E0}';
  IID__ItemCheckEventArgs: TGUID = '{29BDF32D-E055-38E7-8DCB-920A3038FEF7}';
  IID_IDataObject: TGUID = '{3CEE8CC1-1ADB-327F-9B97-7A9C8089BFB3}';
  IID__ListView: TGUID = '{A87AED55-DDA4-3668-BEFA-1A776496DD3E}';
  IID__ComboBox: TGUID = '{2EFEC16E-EEC9-39A3-9D8A-5E72B5C14F78}';
  IID__ListControl: TGUID = '{D58DFF0C-34C3-3D1E-8251-5F83EE7367C9}';
  IID__ChildAccessibleObject: TGUID = '{518F00C6-2AAB-3B25-A76A-F62883781E18}';
  IID__ScrollableControl: TGUID = '{812A8B20-CB02-3483-8A29-424C6CDAC4B7}';
  IID__ContextMenuStrip: TGUID = '{4B4939AF-61C1-378F-BDF0-68B9B3EE48E3}';
  IID__ToolStripDropDownMenu: TGUID = '{8E07FA2C-B44B-3818-BA44-D88F2A69E8B6}';
  IID__DragEventArgs: TGUID = '{AEDF37AB-9041-3D55-9ACA-BDEDE24566D2}';
  IID__GiveFeedbackEventArgs: TGUID = '{77AD1D22-59C4-3634-9D55-50291CDA49F6}';
  IID__HelpEventArgs: TGUID = '{7FA2B402-744D-34F5-AD8B-BD7C018B31F5}';
  IID__QueryContinueDragEventArgs: TGUID = '{9FD0D341-0808-3A17-A978-ADB5ED517F59}';
  IID__DataGrid: TGUID = '{518A56E2-FBCE-3386-BB15-4A0F67872BDC}';
  IID__ScrollBar: TGUID = '{59C5A9AD-941B-3279-BED8-EDCC2951CADC}';
  IID__NavigateEventArgs: TGUID = '{42959ECE-0606-3758-9679-A48E88F9BAF8}';
  IID__ScrollEventArgs: TGUID = '{CCD8C82C-DFBF-3E14-BE9B-38555F6221F2}';
  IID__DataGridTextBox: TGUID = '{2780E0D4-2B06-3E1F-ADDF-D8DBBB3FB960}';
  IID__TextBox: TGUID = '{EAEF4300-9FB3-306F-8F67-180DEB8DDFB7}';
  IID__DataGridView: TGUID = '{5968374C-8F43-353B-8F0A-780A0A7DDB79}';
  IID__Panel: TGUID = '{549A3DD8-D85F-3D08-87E2-49B08490008B}';
  IID__DataGridViewComboBoxEditingControl: TGUID = '{C6615083-0A23-3997-A54B-F618EB824AF0}';
  IID__DataGridViewTextBoxEditingControl: TGUID = '{A7750701-44A2-353A-923A-7BA68A8E22AF}';
  IID__DateTimePicker: TGUID = '{2BAD7D35-895F-3D4A-B883-0B3CD324B8BD}';
  IID__DateTimePickerAccessibleObject: TGUID = '{5BEF6F14-89F8-3AD5-BE92-0649CFA5ABB1}';
  IID__DomainUpDown: TGUID = '{44792A74-5DD8-3410-A897-F568E4E58161}';
  IID__UpDownBase: TGUID = '{C26446AC-E09B-3545-B01A-5575923636C3}';
  IID__DomainItemAccessibleObject: TGUID = '{0D46DA02-69FB-3A29-9AC6-395925C38479}';
  IID__DomainUpDownAccessibleObject: TGUID = '{131B8005-94C2-37D5-B738-CD2337635E73}';
  IID__FlowLayoutPanel: TGUID = '{B55C4C83-1F69-3D93-9C4E-2AA5619E0C68}';
  IID__MenuStrip: TGUID = '{EB5A3078-05D9-3F32-9045-89F756938A3D}';
  IID__GroupBox: TGUID = '{11B0B536-2F72-3A3F-B2A3-0420A9F5041F}';
  IID__HScrollBar: TGUID = '{7BC4A820-B20F-3ECE-BDD6-EE7E14EB7E0D}';
  IID__ItemDragEventArgs: TGUID = '{7FA2A2C6-276C-3F23-AF2A-800CCD05CFF2}';
  IID__Label: TGUID = '{00AE8203-987D-3B7E-9448-5B3393282D7F}';
  IID__LinkClickedEventArgs: TGUID = '{93194740-9A53-3D3E-902C-240FBE0C90E4}';
  IID__LinkLabel: TGUID = '{4EE61C0D-D2D5-3A50-972B-C0A957D3A541}';
  IID__LinkLabelLinkClickedEventArgs: TGUID = '{CB38AE7B-5208-351D-8B84-3ECA81DE0F34}';
  IID__ListViewItemMouseHoverEventArgs: TGUID = '{A2F121D8-4775-3FB2-93A3-C5862AE8C359}';
  IID__MaskedTextBox: TGUID = '{22B0C1A9-E74E-381A-BABB-66BEF71FF08E}';
  IID__TextBoxBase: TGUID = '{ABC30865-8929-3F02-9D70-6C3D68C83837}';
  IID__MdiClient: TGUID = '{6AB0BB67-4A4B-32F9-A18A-6481916C946F}';
  IID__MonthCalendar: TGUID = '{C3FA9EA8-275E-35E9-89DA-18B1FCA593EE}';
  IID__NumericUpDown: TGUID = '{2AD9F14A-0097-3C69-9F8E-5DDB52F3878B}';
  IID__PictureBox: TGUID = '{BB1C5180-87D0-330C-B698-EE2132DF362E}';
  IID__PrintPreviewControl: TGUID = '{FA3B8143-ECB8-3A38-9DE5-DB0EEA708B5F}';
  IID__PrintPreviewDialog: TGUID = '{57C090D5-80BC-33B8-B782-706A8D833767}';
  IID__ProgressBar: TGUID = '{8E935BCB-21E1-377C-A59F-89F7BA5A4E0F}';
  IID__PropertyGrid: TGUID = '{0C831618-60D7-32B2-9790-1EBDC5ADEFE5}';
  IID__PropertyTabChangedEventArgs: TGUID = '{DB6FE495-8F5B-3C66-9A17-4C40D5593906}';
  IID__PropertyValueChangedEventArgs: TGUID = '{6D43DF59-7EA8-300F-ACB2-760A070CFCF2}';
  IID__QueryAccessibilityHelpEventArgs: TGUID = '{2FE9F084-1511-3052-BE7C-9010B522C10E}';
  IID__RadioButton: TGUID = '{3E431682-BBDE-31B1-AE7F-9D8DD582BD0D}';
  IID__RadioButtonAccessibleObject: TGUID = '{EDC3C736-47FD-3F25-90E4-123234D64FD4}';
  IID__RichTextBox: TGUID = '{1B264763-A1C7-3441-9D61-7EDAEC2D0C44}';
  IID__SplitContainer: TGUID = '{C1DA069E-4C0B-3664-BBA1-F81864825085}';
  IID__SplitterPanel: TGUID = '{3A4C8B1A-4AF9-344A-BC88-DFE863328C86}';
  IID__SplitterEventArgs: TGUID = '{8E61AD1D-76AE-3501-9B36-481BFEBD3E3E}';
  IID__Splitter: TGUID = '{C318A56D-0B03-3A5A-93F6-7DF0B3268237}';
  IID__StatusBar: TGUID = '{93409DA8-FE37-3D4E-9A08-B35B34122C64}';
  IID__StatusStrip: TGUID = '{71CA209D-40D3-3409-B341-DA9B922CCA45}';
  IID__TabControl: TGUID = '{470DE738-5261-302A-B205-4744652D2FD3}';
  IID__TabPage: TGUID = '{59183431-BD56-33D2-A2ED-FA414ADF8DCB}';
  IID__TableLayoutPanel: TGUID = '{05CBE5B2-0292-37DE-BE51-5B7599CA5A11}';
  IID__ThreadExceptionDialog: TGUID = '{B00AA2F6-4D83-3937-B4AC-4C2C2C3F6C70}';
  IID__ToolBar: TGUID = '{F6AB38B6-1C02-3B01-A7F8-510ED1C0B253}';
  IID__ToolStripAccessibleObject: TGUID = '{6F7A7383-2ABE-39D6-85F6-7117ED41979C}';
  IID__ToolStripContainer: TGUID = '{2A42F137-D50D-3D62-AF58-4DF7A4F57C9B}';
  IID__ToolStripPanel: TGUID = '{FB97C26A-FB56-3F71-BBC4-B1377E7B142D}';
  IID__ToolStripContentPanel: TGUID = '{6EE3853E-DDEF-3F29-8F1B-1ED7180D9229}';
  IID__ToolStripDropDown: TGUID = '{C2322B43-25B3-3B30-B3DB-67E4DA2E6533}';
  IID__ToolStripDropDownAccessibleObject: TGUID = '{DF0D9304-0E85-3FFC-8283-6F291F32EE61}';
  IID__ToolStripItemAccessibleObject: TGUID = '{8FD9748A-D04F-3DFB-96A8-5624290F4554}';
  IID__ToolStripOverflow: TGUID = '{75781CE7-317D-3C54-95D4-3E4DC04B4D3F}';
  IID__TrackBar: TGUID = '{7A8CC9AD-4E8D-3AAF-941A-1511C9C1372A}';
  IID__TreeView: TGUID = '{BA97ED62-9EBD-34E8-94AD-F71AEF67DEFF}';
  IID__TreeNodeMouseHoverEventArgs: TGUID = '{F51EDF6C-9E49-334A-8AAE-B0C7C631ABE4}';
  IID__UserControl: TGUID = '{6BEEDF4B-B688-3C0D-8B16-D53290790DFB}';
  IID__VScrollBar: TGUID = '{469D64EC-EB30-3462-A93B-E01BAA5CAF83}';
  IID__WebBrowser: TGUID = '{BB134D18-9643-3862-AA3B-17EBDB1A0DEF}';
  IID__WebBrowserBase: TGUID = '{764905A9-B10E-3C61-96DD-FA6F4BF8648D}';
  IID__ComponentEditorForm: TGUID = '{A7006EFC-6E21-3B74-A9D7-9A2F12E46C8E}';
  IID__ComponentEditorPage: TGUID = '{C858A49A-FDCB-395D-BBB8-9B2B66DC0FB5}';
  CLASS_AccessibleObject: TGUID = '{D0CBA7AF-93F5-378A-BB11-2A5D9AA9C4D7}';
  CLASS_Form: TGUID = '{C60F986A-D86B-3E50-B959-83F196BE2E16}';
  CLASS_AxHost: TGUID = '{5AE0F540-8B2A-3436-BEA4-94B028521F49}';
  CLASS_Control: TGUID = '{D51BE7D3-5EA4-3D65-B9C5-B9087E6F974F}';
  CLASS_ContainerControl: TGUID = '{BD20E131-9782-3651-AE3A-4BBAADDC62D8}';
  CLASS_BindingNavigator: TGUID = '{8D907746-455E-39A7-BD31-BC9F81468347}';
  CLASS_ToolStrip: TGUID = '{DAF7A547-5A5D-3095-9268-1425F428702E}';
  CLASS_Button: TGUID = '{1FCBDA5D-6F09-3A66-ACB8-1B0D748F5C13}';
  CLASS_ButtonBase: TGUID = '{F758A1F6-4102-36BE-81E9-8A674DAD908C}';
  CLASS_MouseEventArgs: TGUID = '{204759F6-3635-32D3-BA35-E5636C6001F7}';
  CLASS_ButtonBaseAccessibleObject: TGUID = '{B1E01A0E-5413-3ED7-9651-C789752D0969}';
  CLASS_ControlAccessibleObject: TGUID = '{2BF3E914-3241-3DB8-8A4C-BACA642F5360}';
  CLASS_KeyEventArgs: TGUID = '{8878906E-C954-32D5-8F66-AD3C93B910EA}';
  CLASS_CheckBox: TGUID = '{C2D6EA6E-E423-3B53-B06B-419F95F34F68}';
  CLASS_CheckBoxAccessibleObject: TGUID = '{5046AA3E-6493-333F-B561-B2BC2453FB5C}';
  CLASS_CheckedListBox: TGUID = '{D8004AA1-697A-30C4-869E-F8F82595E05A}';
  CLASS_ListBox: TGUID = '{D7AC7195-477C-3ABA-BA10-6CF8BE334A86}';
  CLASS_KeyPressEventArgs: TGUID = '{CCC93D67-CC30-3AF2-85AA-FF8B589FDA64}';
  CLASS_ItemCheckEventArgs: TGUID = '{4AA49D46-DDCD-349B-BAF5-612CB25F45A4}';
  CLASS_ListView: TGUID = '{53DCAC10-BF48-3670-BE8A-7E38FF839C71}';
  CLASS_ComboBox: TGUID = '{FE644CA9-E687-308B-AF40-1D0CFABD2AD8}';
  CLASS_ListControl: TGUID = '{63E13B8A-0FD1-33BD-AEA2-4283D081657B}';
  CLASS_ChildAccessibleObject: TGUID = '{33C6507C-E445-37C1-B758-A4EDBD1A281A}';
  CLASS_ScrollableControl: TGUID = '{73156525-C0E7-39EF-8C35-1E7C522CB07F}';
  CLASS_ContextMenuStrip: TGUID = '{D84F5EBD-F1F2-3849-98D7-6FDBA13AC6AB}';
  CLASS_ToolStripDropDownMenu: TGUID = '{5458C631-6A29-344D-B571-DE58784BD9E0}';
  CLASS_DragEventArgs: TGUID = '{52EB994F-D321-39ED-99D1-B69F1B267E9E}';
  CLASS_GiveFeedbackEventArgs: TGUID = '{5BAC1675-5DD4-354F-BED7-1BECA69DE22B}';
  CLASS_HelpEventArgs: TGUID = '{2CB72A4A-04B1-39DC-BC48-0D5A82D0576A}';
  CLASS_QueryContinueDragEventArgs: TGUID = '{1A4924DC-F59C-3800-8C30-E9F072B64884}';
  CLASS_DataGrid: TGUID = '{1733CD63-DB91-3506-B433-4DD3700B596F}';
  CLASS_ScrollBar: TGUID = '{526FCC1C-A977-34DE-848F-D2D18F15AD43}';
  CLASS_NavigateEventArgs: TGUID = '{B3945078-136C-3189-85FF-83B5E2D839F0}';
  CLASS_ScrollEventArgs: TGUID = '{AC32D912-24C7-31C7-A2D6-8E98ED6BE880}';
  CLASS_DataGridTextBox: TGUID = '{0B420F33-D20B-329D-A609-5783B3E79722}';
  CLASS_TextBox: TGUID = '{63C8A502-7863-3F66-998D-79BD0219D2E0}';
  CLASS_DataGridView: TGUID = '{E21338E1-4794-3125-9211-92A7510202E8}';
  CLASS_Panel: TGUID = '{165C9F64-CCB8-3C9B-8AAF-95352F86B99B}';
  CLASS_DataGridViewComboBoxEditingControl: TGUID = '{82596187-3FA3-3CFF-A0CD-151C3598597C}';
  CLASS_DataGridViewTextBoxEditingControl: TGUID = '{7065C038-BA07-337A-BFED-DE2179346428}';
  CLASS_DateTimePicker: TGUID = '{4D09932A-CC59-3DB0-9826-D515941D2D92}';
  CLASS_DateTimePickerAccessibleObject: TGUID = '{64BC3EEC-A5DA-3E22-BE11-E36CF1C70DF5}';
  CLASS_DomainUpDown: TGUID = '{D1C50548-6109-3199-9042-FFAF6834AA01}';
  CLASS_UpDownBase: TGUID = '{70B6F6D3-64FE-373B-85A7-CC5FAB179F55}';
  CLASS_DomainItemAccessibleObject: TGUID = '{4E47315B-1100-3402-B377-FF94ED7A6D00}';
  CLASS_DomainUpDownAccessibleObject: TGUID = '{114B32C2-6669-3737-8DE6-326339FF8D85}';
  CLASS_FlowLayoutPanel: TGUID = '{BA92792E-F10D-3EFC-A100-52757A4C184C}';
  CLASS_MenuStrip: TGUID = '{C930C2F7-CFDA-3940-916C-51BEC9C4D316}';
  CLASS_GroupBox: TGUID = '{C5CD51C2-EE05-358A-9B53-07F9060E435F}';
  CLASS_HScrollBar: TGUID = '{F835D22E-51EB-3A49-93A3-34558BE9C825}';
  CLASS_ItemDragEventArgs: TGUID = '{16372BA7-956F-33EF-8472-903F87562D2A}';
  CLASS_Label_: TGUID = '{93D7475B-94A4-3C10-92E6-FD64BBE5745F}';
  CLASS_LinkClickedEventArgs: TGUID = '{E46C918A-543B-33BD-B2AA-072FE22BDE01}';
  CLASS_LinkLabel: TGUID = '{C116EE15-015E-3760-92F9-59C2D99236F1}';
  CLASS_LinkLabelLinkClickedEventArgs: TGUID = '{E974BB68-E71A-3995-B0DF-7FE510956365}';
  CLASS_ListViewItemMouseHoverEventArgs: TGUID = '{DD1BCAA8-778B-3687-9DD7-E9D2E6F01D75}';
  CLASS_MaskedTextBox: TGUID = '{9C5E8CFB-CAC0-3167-ACEE-BFDD8B5D2238}';
  CLASS_TextBoxBase: TGUID = '{B19C1A95-B668-36DA-8D1D-A2F020F78C3C}';
  CLASS_MdiClient: TGUID = '{CE6E4B0C-1473-3184-B1E3-0027D76E3618}';
  CLASS_MonthCalendar: TGUID = '{B6782E31-494F-32EB-8405-6F24AC68BDBD}';
  CLASS_NumericUpDown: TGUID = '{E2035BFE-7A03-3AF5-B1FC-4A1F34BFD448}';
  CLASS_PictureBox: TGUID = '{492B7BBA-A930-38FF-B51A-32B81068FA89}';
  CLASS_PrintPreviewControl: TGUID = '{C064EAE9-D1DD-32AC-BBFD-8882189841F3}';
  CLASS_PrintPreviewDialog: TGUID = '{17438D08-1CA5-3C2D-B1E0-BF241CA83E5A}';
  CLASS_ProgressBar: TGUID = '{409F95BB-E848-3A04-8B5A-8F13148651A9}';
  CLASS_PropertyGrid: TGUID = '{DC0ED10F-FEA5-3A43-8CA1-19E036DF370F}';
  CLASS_PropertyTabChangedEventArgs: TGUID = '{1C77E4E3-C48C-3206-BD45-2F5EDA26C04A}';
  CLASS_PropertyValueChangedEventArgs: TGUID = '{307A9D73-A1F9-3F46-9015-7920D42FC04E}';
  CLASS_QueryAccessibilityHelpEventArgs: TGUID = '{25AF3ECD-8F91-3CCE-9E6F-03D7348D8CBA}';
  CLASS_RadioButton: TGUID = '{FC511C4D-49A7-32AB-AB23-0AC220A9CDB7}';
  CLASS_RadioButtonAccessibleObject: TGUID = '{8CEDCFDD-4965-3BB4-8EC3-E31A43AC8C0C}';
  CLASS_RichTextBox: TGUID = '{5FBA0DDC-0B9F-3E4F-B99D-B3F297E9820D}';
  CLASS_SplitContainer: TGUID = '{F3F633A7-CA31-3CFC-A958-D8F04B946665}';
  CLASS_SplitterPanel: TGUID = '{89812DAE-F080-30C8-8969-F334C09A9960}';
  CLASS_SplitterEventArgs: TGUID = '{8A4E7E83-B7DC-3E65-BC78-FEB2B0BB430F}';
  CLASS_Splitter: TGUID = '{4BDF38BF-91E6-33D0-AC66-BF7682617615}';
  CLASS_StatusBar: TGUID = '{632D5C3D-6594-33E9-B361-9BCF6946B45A}';
  CLASS_StatusStrip: TGUID = '{E6F7736E-221C-377D-8080-EBA946D3BFE4}';
  CLASS_TabControl: TGUID = '{3863B485-0904-3D25-89D0-190AD0321D29}';
  CLASS_TabPage: TGUID = '{BBD78147-59D7-34A8-9BD3-62E28E957F28}';
  CLASS_TableLayoutPanel: TGUID = '{ABBA8E63-B2D0-346C-80ED-9E0C215069CB}';
  CLASS_ThreadExceptionDialog: TGUID = '{9DC61A7B-E1FC-3397-8EFA-DF03927AD3FC}';
  CLASS_ToolBar: TGUID = '{4E885C2A-C86F-3641-8D7B-9B3501449F45}';
  CLASS_ToolStripAccessibleObject: TGUID = '{BB396E98-E7A8-3D6C-94C6-851F03A2C16D}';
  CLASS_ToolStripContainer: TGUID = '{C0FF87FD-7051-300E-ACC9-8F1A43FC2969}';
  CLASS_ToolStripPanel: TGUID = '{935030C0-F6CE-367E-BA86-CBF721D0E3B6}';
  CLASS_ToolStripContentPanel: TGUID = '{D34F0B81-5AF3-34B1-8CB8-E2166D5733F9}';
  CLASS_ToolStripDropDown: TGUID = '{E7FAC3BE-6AA2-37D6-894F-472D8F064FAB}';
  CLASS_ToolStripDropDownAccessibleObject: TGUID = '{0FF7EC15-9826-3C63-9070-901926640297}';
  CLASS_ToolStripItemAccessibleObject: TGUID = '{99F50AB0-0EB5-3E4D-A41A-E25B749FC408}';
  CLASS_ToolStripOverflow: TGUID = '{8C9707C6-8357-3E1D-9BFF-FA52004A47CF}';
  CLASS_TrackBar: TGUID = '{606C2474-80A5-3E09-B952-724F97B00C01}';
  CLASS_TreeView: TGUID = '{6FAB6F50-DFFE-35B5-9A5F-210DB36909B7}';
  CLASS_TreeNodeMouseHoverEventArgs: TGUID = '{FD266995-AB04-3DBB-A121-079E7BE4C498}';
  CLASS_UserControl: TGUID = '{07427F79-1FC2-3632-B5F4-02B51BA44E18}';
  CLASS_VScrollBar: TGUID = '{CB040AB2-71CB-3546-9881-53CA472CEB3B}';
  CLASS_WebBrowser: TGUID = '{322BC601-B652-3088-A0C8-47A7A02E78F4}';
  CLASS_WebBrowserBase: TGUID = '{1E48F5C9-4F40-3059-8F37-70C77E397522}';
  CLASS_ComponentEditorForm: TGUID = '{C77973E5-77C1-3382-8F5D-694DF4F16F3D}';
  CLASS_ComponentEditorPage: TGUID = '{D621B2A0-D07D-301E-8204-A33F0242EC8F}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum Appearance
type
  Appearance = TOleEnum;
const
  Appearance_Button = $00000001;
  Appearance_Normal = $00000000;

// Constants for enum ArrangeDirection
type
  ArrangeDirection = TOleEnum;
const
  ArrangeDirection_Down = $00000004;
  ArrangeDirection_Left = $00000000;
  ArrangeDirection_Right = $00000000;
  ArrangeDirection_Up = $00000004;

// Constants for enum ImeMode
type
  ImeMode = TOleEnum;
const
  ImeMode_Alpha = $00000008;
  ImeMode_AlphaFull = $00000007;
  ImeMode_Close = $0000000B;
  ImeMode_Disable = $00000003;
  ImeMode_Hangul = $0000000A;
  ImeMode_HangulFull = $00000009;
  ImeMode_Hiragana = $00000004;
  ImeMode_Inherit = $FFFFFFFF;
  ImeMode_Katakana = $00000005;
  ImeMode_KatakanaHalf = $00000006;
  ImeMode_NoControl = $00000000;
  ImeMode_Off = $00000002;
  ImeMode_On = $00000001;
  ImeMode_OnHalf = $0000000C;

// Constants for enum Keys
type
  Keys = TOleEnum;
const
  Keys_A = $00000041;
  Keys_Add = $0000006B;
  Keys_Alt = $00040000;
  Keys_Apps = $0000005D;
  Keys_Attn = $000000F6;
  Keys_B = $00000042;
  Keys_Back = $00000008;
  Keys_BrowserBack = $000000A6;
  Keys_BrowserFavorites = $000000AB;
  Keys_BrowserForward = $000000A7;
  Keys_BrowserHome = $000000AC;
  Keys_BrowserRefresh = $000000A8;
  Keys_BrowserSearch = $000000AA;
  Keys_BrowserStop = $000000A9;
  Keys_C = $00000043;
  Keys_Cancel = $00000003;
  Keys_Capital = $00000014;
  Keys_CapsLock = $00000014;
  Keys_Clear = $0000000C;
  Keys_Control = $00020000;
  Keys_ControlKey = $00000011;
  Keys_Crsel = $000000F7;
  Keys_D = $00000044;
  Keys_D0 = $00000030;
  Keys_D1 = $00000031;
  Keys_D2 = $00000032;
  Keys_D3 = $00000033;
  Keys_D4 = $00000034;
  Keys_D5 = $00000035;
  Keys_D6 = $00000036;
  Keys_D7 = $00000037;
  Keys_D8 = $00000038;
  Keys_D9 = $00000039;
  Keys_Decimal = $0000006E;
  Keys_Delete = $0000002E;
  Keys_Divide = $0000006F;
  Keys_Down = $00000028;
  Keys_E = $00000045;
  Keys_End = $00000023;
  Keys_Enter = $0000000D;
  Keys_EraseEof = $000000F9;
  Keys_Escape = $0000001B;
  Keys_Execute = $0000002B;
  Keys_Exsel = $000000F8;
  Keys_F = $00000046;
  Keys_F1 = $00000070;
  Keys_F10 = $00000079;
  Keys_F11 = $0000007A;
  Keys_F12 = $0000007B;
  Keys_F13 = $0000007C;
  Keys_F14 = $0000007D;
  Keys_F15 = $0000007E;
  Keys_F16 = $0000007F;
  Keys_F17 = $00000080;
  Keys_F18 = $00000081;
  Keys_F19 = $00000082;
  Keys_F2 = $00000071;
  Keys_F20 = $00000083;
  Keys_F21 = $00000084;
  Keys_F22 = $00000085;
  Keys_F23 = $00000086;
  Keys_F24 = $00000087;
  Keys_F3 = $00000072;
  Keys_F4 = $00000073;
  Keys_F5 = $00000074;
  Keys_F6 = $00000075;
  Keys_F7 = $00000076;
  Keys_F8 = $00000077;
  Keys_F9 = $00000078;
  Keys_FinalMode = $00000018;
  Keys_G = $00000047;
  Keys_H = $00000048;
  Keys_HanguelMode = $00000015;
  Keys_HangulMode = $00000015;
  Keys_HanjaMode = $00000019;
  Keys_Help = $0000002F;
  Keys_Home = $00000024;
  Keys_I = $00000049;
  Keys_IMEAccept = $0000001E;
  Keys_IMEAceept = $0000001E;
  Keys_IMEConvert = $0000001C;
  Keys_IMEModeChange = $0000001F;
  Keys_IMENonconvert = $0000001D;
  Keys_Insert = $0000002D;
  Keys_J = $0000004A;
  Keys_JunjaMode = $00000017;
  Keys_K = $0000004B;
  Keys_KanaMode = $00000015;
  Keys_KanjiMode = $00000019;
  Keys_KeyCode = $0000FFFF;
  Keys_L = $0000004C;
  Keys_LButton = $00000001;
  Keys_LControlKey = $000000A2;
  Keys_LMenu = $000000A4;
  Keys_LShiftKey = $000000A0;
  Keys_LWin = $0000005B;
  Keys_LaunchApplication1 = $000000B6;
  Keys_LaunchApplication2 = $000000B7;
  Keys_LaunchMail = $000000B4;
  Keys_Left = $00000025;
  Keys_LineFeed = $0000000A;
  Keys_M = $0000004D;
  Keys_MButton = $00000004;
  Keys_MediaNextTrack = $000000B0;
  Keys_MediaPlayPause = $000000B3;
  Keys_MediaPreviousTrack = $000000B1;
  Keys_MediaStop = $000000B2;
  Keys_Menu = $00000012;
  Keys_Modifiers = $FFFF0000;
  Keys_Multiply = $0000006A;
  Keys_N = $0000004E;
  Keys_Next = $00000022;
  Keys_NoName = $000000FC;
  Keys_None = $00000000;
  Keys_NumLock = $00000090;
  Keys_NumPad0 = $00000060;
  Keys_NumPad1 = $00000061;
  Keys_NumPad2 = $00000062;
  Keys_NumPad3 = $00000063;
  Keys_NumPad4 = $00000064;
  Keys_NumPad5 = $00000065;
  Keys_NumPad6 = $00000066;
  Keys_NumPad7 = $00000067;
  Keys_NumPad8 = $00000068;
  Keys_NumPad9 = $00000069;
  Keys_O = $0000004F;
  Keys_Oem1 = $000000BA;
  Keys_Oem102 = $000000E2;
  Keys_Oem2 = $000000BF;
  Keys_Oem3 = $000000C0;
  Keys_Oem4 = $000000DB;
  Keys_Oem5 = $000000DC;
  Keys_Oem6 = $000000DD;
  Keys_Oem7 = $000000DE;
  Keys_Oem8 = $000000DF;
  Keys_OemBackslash = $000000E2;
  Keys_OemClear = $000000FE;
  Keys_OemCloseBrackets = $000000DD;
  Keys_OemMinus = $000000BD;
  Keys_OemOpenBrackets = $000000DB;
  Keys_OemPeriod = $000000BE;
  Keys_OemPipe = $000000DC;
  Keys_OemQuestion = $000000BF;
  Keys_OemQuotes = $000000DE;
  Keys_OemSemicolon = $000000BA;
  Keys_Oemcomma = $000000BC;
  Keys_Oemplus = $000000BB;
  Keys_Oemtilde = $000000C0;
  Keys_P = $00000050;
  Keys_Pa1 = $000000FD;
  Keys_Packet = $000000E7;
  Keys_PageDown = $00000022;
  Keys_PageUp = $00000021;
  Keys_Pause = $00000013;
  Keys_Play = $000000FA;
  Keys_Print = $0000002A;
  Keys_PrintScreen = $0000002C;
  Keys_Prior = $00000021;
  Keys_ProcessKey = $000000E5;
  Keys_Q = $00000051;
  Keys_R = $00000052;
  Keys_RButton = $00000002;
  Keys_RControlKey = $000000A3;
  Keys_RMenu = $000000A5;
  Keys_RShiftKey = $000000A1;
  Keys_RWin = $0000005C;
  Keys_Return = $0000000D;
  Keys_Right = $00000027;
  Keys_S = $00000053;
  Keys_Scroll = $00000091;
  Keys_Select = $00000029;
  Keys_SelectMedia = $000000B5;
  Keys_Separator = $0000006C;
  Keys_Shift = $00010000;
  Keys_ShiftKey = $00000010;
  Keys_Sleep = $0000005F;
  Keys_Snapshot = $0000002C;
  Keys_Space = $00000020;
  Keys_Subtract = $0000006D;
  Keys_T = $00000054;
  Keys_Tab = $00000009;
  Keys_U = $00000055;
  Keys_Up = $00000026;
  Keys_V = $00000056;
  Keys_VolumeDown = $000000AE;
  Keys_VolumeMute = $000000AD;
  Keys_VolumeUp = $000000AF;
  Keys_W = $00000057;
  Keys_X = $00000058;
  Keys_XButton1 = $00000005;
  Keys_XButton2 = $00000006;
  Keys_Y = $00000059;
  Keys_Z = $0000005A;
  Keys_Zoom = $000000FB;

// Constants for enum Border3DSide
type
  Border3DSide = TOleEnum;
const
  Border3DSide_All = $0000080F;
  Border3DSide_Bottom = $00000008;
  Border3DSide_Left = $00000001;
  Border3DSide_Middle = $00000800;
  Border3DSide_Right = $00000004;
  Border3DSide_Top = $00000002;

// Constants for enum Border3DStyle
type
  Border3DStyle = TOleEnum;
const
  Border3DStyle_Adjust = $00002000;
  Border3DStyle_Bump = $00000009;
  Border3DStyle_Etched = $00000006;
  Border3DStyle_Flat = $0000400A;
  Border3DStyle_Raised = $00000005;
  Border3DStyle_RaisedInner = $00000004;
  Border3DStyle_RaisedOuter = $00000001;
  Border3DStyle_Sunken = $0000000A;
  Border3DStyle_SunkenInner = $00000008;
  Border3DStyle_SunkenOuter = $00000002;

// Constants for enum BorderStyle
type
  BorderStyle = TOleEnum;
const
  BorderStyle_Fixed3D = $00000002;
  BorderStyle_FixedSingle = $00000001;
  BorderStyle_None = $00000000;

// Constants for enum DialogResult
type
  DialogResult = TOleEnum;
const
  DialogResult_Abort = $00000003;
  DialogResult_Cancel = $00000002;
  DialogResult_Ignore = $00000005;
  DialogResult_No = $00000007;
  DialogResult_None = $00000000;
  DialogResult_OK = $00000001;
  DialogResult_Retry = $00000004;
  DialogResult_Yes = $00000006;

// Constants for enum SelectionMode
type
  SelectionMode = TOleEnum;
const
  SelectionMode_MultiExtended = $00000003;
  SelectionMode_MultiSimple = $00000002;
  SelectionMode_None = $00000000;
  SelectionMode_One = $00000001;

// Constants for enum HorizontalAlignment
type
  HorizontalAlignment = TOleEnum;
const
  HorizontalAlignment_Center = $00000002;
  HorizontalAlignment_Left = $00000000;
  HorizontalAlignment_Right = $00000001;

// Constants for enum LeftRightAlignment
type
  LeftRightAlignment = TOleEnum;
const
  LeftRightAlignment_Left = $00000000;
  LeftRightAlignment_Right = $00000001;

// Constants for enum MouseButtons
type
  MouseButtons = TOleEnum;
const
  MouseButtons_Left = $00100000;
  MouseButtons_Middle = $00400000;
  MouseButtons_None = $00000000;
  MouseButtons_Right = $00200000;
  MouseButtons_XButton1 = $00800000;
  MouseButtons_XButton2 = $01000000;

// Constants for enum DataGridViewElementStates
type
  DataGridViewElementStates = TOleEnum;
const
  DataGridViewElementStates_Displayed = $00000001;
  DataGridViewElementStates_Frozen = $00000002;
  DataGridViewElementStates_None = $00000000;
  DataGridViewElementStates_ReadOnly = $00000004;
  DataGridViewElementStates_Resizable = $00000008;
  DataGridViewElementStates_ResizableSet = $00000010;
  DataGridViewElementStates_Selected = $00000020;
  DataGridViewElementStates_Visible = $00000040;

// Constants for enum DragAction
type
  DragAction = TOleEnum;
const
  DragAction_Cancel = $00000002;
  DragAction_Continue = $00000000;
  DragAction_Drop = $00000001;

// Constants for enum FormBorderStyle
type
  FormBorderStyle = TOleEnum;
const
  FormBorderStyle_Fixed3D = $00000002;
  FormBorderStyle_FixedDialog = $00000003;
  FormBorderStyle_FixedSingle = $00000001;
  FormBorderStyle_FixedToolWindow = $00000005;
  FormBorderStyle_None = $00000000;
  FormBorderStyle_Sizable = $00000004;
  FormBorderStyle_SizableToolWindow = $00000006;

// Constants for enum FormStartPosition
type
  FormStartPosition = TOleEnum;
const
  FormStartPosition_CenterParent = $00000004;
  FormStartPosition_CenterScreen = $00000001;
  FormStartPosition_Manual = $00000000;
  FormStartPosition_WindowsDefaultBounds = $00000003;
  FormStartPosition_WindowsDefaultLocation = $00000002;

// Constants for enum FormWindowState
type
  FormWindowState = TOleEnum;
const
  FormWindowState_Maximized = $00000002;
  FormWindowState_Minimized = $00000001;
  FormWindowState_Normal = $00000000;

// Constants for enum Shortcut
type
  Shortcut = TOleEnum;
const
  Shortcut_Alt0 = $00040030;
  Shortcut_Alt1 = $00040031;
  Shortcut_Alt2 = $00040032;
  Shortcut_Alt3 = $00040033;
  Shortcut_Alt4 = $00040034;
  Shortcut_Alt5 = $00040035;
  Shortcut_Alt6 = $00040036;
  Shortcut_Alt7 = $00040037;
  Shortcut_Alt8 = $00040038;
  Shortcut_Alt9 = $00040039;
  Shortcut_AltBksp = $00040008;
  Shortcut_AltDownArrow = $00040028;
  Shortcut_AltF1 = $00040070;
  Shortcut_AltF10 = $00040079;
  Shortcut_AltF11 = $0004007A;
  Shortcut_AltF12 = $0004007B;
  Shortcut_AltF2 = $00040071;
  Shortcut_AltF3 = $00040072;
  Shortcut_AltF4 = $00040073;
  Shortcut_AltF5 = $00040074;
  Shortcut_AltF6 = $00040075;
  Shortcut_AltF7 = $00040076;
  Shortcut_AltF8 = $00040077;
  Shortcut_AltF9 = $00040078;
  Shortcut_AltLeftArrow = $00040025;
  Shortcut_AltRightArrow = $00040027;
  Shortcut_AltUpArrow = $00040026;
  Shortcut_Ctrl0 = $00020030;
  Shortcut_Ctrl1 = $00020031;
  Shortcut_Ctrl2 = $00020032;
  Shortcut_Ctrl3 = $00020033;
  Shortcut_Ctrl4 = $00020034;
  Shortcut_Ctrl5 = $00020035;
  Shortcut_Ctrl6 = $00020036;
  Shortcut_Ctrl7 = $00020037;
  Shortcut_Ctrl8 = $00020038;
  Shortcut_Ctrl9 = $00020039;
  Shortcut_CtrlA = $00020041;
  Shortcut_CtrlB = $00020042;
  Shortcut_CtrlC = $00020043;
  Shortcut_CtrlD = $00020044;
  Shortcut_CtrlDel = $0002002E;
  Shortcut_CtrlE = $00020045;
  Shortcut_CtrlF = $00020046;
  Shortcut_CtrlF1 = $00020070;
  Shortcut_CtrlF10 = $00020079;
  Shortcut_CtrlF11 = $0002007A;
  Shortcut_CtrlF12 = $0002007B;
  Shortcut_CtrlF2 = $00020071;
  Shortcut_CtrlF3 = $00020072;
  Shortcut_CtrlF4 = $00020073;
  Shortcut_CtrlF5 = $00020074;
  Shortcut_CtrlF6 = $00020075;
  Shortcut_CtrlF7 = $00020076;
  Shortcut_CtrlF8 = $00020077;
  Shortcut_CtrlF9 = $00020078;
  Shortcut_CtrlG = $00020047;
  Shortcut_CtrlH = $00020048;
  Shortcut_CtrlI = $00020049;
  Shortcut_CtrlIns = $0002002D;
  Shortcut_CtrlJ = $0002004A;
  Shortcut_CtrlK = $0002004B;
  Shortcut_CtrlL = $0002004C;
  Shortcut_CtrlM = $0002004D;
  Shortcut_CtrlN = $0002004E;
  Shortcut_CtrlO = $0002004F;
  Shortcut_CtrlP = $00020050;
  Shortcut_CtrlQ = $00020051;
  Shortcut_CtrlR = $00020052;
  Shortcut_CtrlS = $00020053;
  Shortcut_CtrlShift0 = $00030030;
  Shortcut_CtrlShift1 = $00030031;
  Shortcut_CtrlShift2 = $00030032;
  Shortcut_CtrlShift3 = $00030033;
  Shortcut_CtrlShift4 = $00030034;
  Shortcut_CtrlShift5 = $00030035;
  Shortcut_CtrlShift6 = $00030036;
  Shortcut_CtrlShift7 = $00030037;
  Shortcut_CtrlShift8 = $00030038;
  Shortcut_CtrlShift9 = $00030039;
  Shortcut_CtrlShiftA = $00030041;
  Shortcut_CtrlShiftB = $00030042;
  Shortcut_CtrlShiftC = $00030043;
  Shortcut_CtrlShiftD = $00030044;
  Shortcut_CtrlShiftE = $00030045;
  Shortcut_CtrlShiftF = $00030046;
  Shortcut_CtrlShiftF1 = $00030070;
  Shortcut_CtrlShiftF10 = $00030079;
  Shortcut_CtrlShiftF11 = $0003007A;
  Shortcut_CtrlShiftF12 = $0003007B;
  Shortcut_CtrlShiftF2 = $00030071;
  Shortcut_CtrlShiftF3 = $00030072;
  Shortcut_CtrlShiftF4 = $00030073;
  Shortcut_CtrlShiftF5 = $00030074;
  Shortcut_CtrlShiftF6 = $00030075;
  Shortcut_CtrlShiftF7 = $00030076;
  Shortcut_CtrlShiftF8 = $00030077;
  Shortcut_CtrlShiftF9 = $00030078;
  Shortcut_CtrlShiftG = $00030047;
  Shortcut_CtrlShiftH = $00030048;
  Shortcut_CtrlShiftI = $00030049;
  Shortcut_CtrlShiftJ = $0003004A;
  Shortcut_CtrlShiftK = $0003004B;
  Shortcut_CtrlShiftL = $0003004C;
  Shortcut_CtrlShiftM = $0003004D;
  Shortcut_CtrlShiftN = $0003004E;
  Shortcut_CtrlShiftO = $0003004F;
  Shortcut_CtrlShiftP = $00030050;
  Shortcut_CtrlShiftQ = $00030051;
  Shortcut_CtrlShiftR = $00030052;
  Shortcut_CtrlShiftS = $00030053;
  Shortcut_CtrlShiftT = $00030054;
  Shortcut_CtrlShiftU = $00030055;
  Shortcut_CtrlShiftV = $00030056;
  Shortcut_CtrlShiftW = $00030057;
  Shortcut_CtrlShiftX = $00030058;
  Shortcut_CtrlShiftY = $00030059;
  Shortcut_CtrlShiftZ = $0003005A;
  Shortcut_CtrlT = $00020054;
  Shortcut_CtrlU = $00020055;
  Shortcut_CtrlV = $00020056;
  Shortcut_CtrlW = $00020057;
  Shortcut_CtrlX = $00020058;
  Shortcut_CtrlY = $00020059;
  Shortcut_CtrlZ = $0002005A;
  Shortcut_Del = $0000002E;
  Shortcut_F1 = $00000070;
  Shortcut_F10 = $00000079;
  Shortcut_F11 = $0000007A;
  Shortcut_F12 = $0000007B;
  Shortcut_F2 = $00000071;
  Shortcut_F3 = $00000072;
  Shortcut_F4 = $00000073;
  Shortcut_F5 = $00000074;
  Shortcut_F6 = $00000075;
  Shortcut_F7 = $00000076;
  Shortcut_F8 = $00000077;
  Shortcut_F9 = $00000078;
  Shortcut_Ins = $0000002D;
  Shortcut_None = $00000000;
  Shortcut_ShiftDel = $0001002E;
  Shortcut_ShiftF1 = $00010070;
  Shortcut_ShiftF10 = $00010079;
  Shortcut_ShiftF11 = $0001007A;
  Shortcut_ShiftF12 = $0001007B;
  Shortcut_ShiftF2 = $00010071;
  Shortcut_ShiftF3 = $00010072;
  Shortcut_ShiftF4 = $00010073;
  Shortcut_ShiftF5 = $00010074;
  Shortcut_ShiftF6 = $00010075;
  Shortcut_ShiftF7 = $00010076;
  Shortcut_ShiftF8 = $00010077;
  Shortcut_ShiftF9 = $00010078;
  Shortcut_ShiftIns = $0001002D;

// Constants for enum SystemParameter
type
  SystemParameter = TOleEnum;
const
  SystemParameter_CaretWidthMetric = $00000008;
  SystemParameter_DropShadow = $00000000;
  SystemParameter_FlatMenu = $00000001;
  SystemParameter_FontSmoothingContrastMetric = $00000002;
  SystemParameter_FontSmoothingTypeMetric = $00000003;
  SystemParameter_HorizontalFocusThicknessMetric = $0000000A;
  SystemParameter_MenuFadeEnabled = $00000004;
  SystemParameter_SelectionFade = $00000005;
  SystemParameter_ToolTipAnimationMetric = $00000006;
  SystemParameter_UIEffects = $00000007;
  SystemParameter_VerticalFocusThicknessMetric = $00000009;

// Constants for enum PropertySort
type
  PropertySort = TOleEnum;
const
  PropertySort_Alphabetical = $00000001;
  PropertySort_Categorized = $00000002;
  PropertySort_CategorizedAlphabetical = $00000003;
  PropertySort_NoSort = $00000000;

// Constants for enum ScrollEventType
type
  ScrollEventType = TOleEnum;
const
  ScrollEventType_EndScroll = $00000008;
  ScrollEventType_First = $00000006;
  ScrollEventType_LargeDecrement = $00000002;
  ScrollEventType_LargeIncrement = $00000003;
  ScrollEventType_Last = $00000007;
  ScrollEventType_SmallDecrement = $00000000;
  ScrollEventType_SmallIncrement = $00000001;
  ScrollEventType_ThumbPosition = $00000004;
  ScrollEventType_ThumbTrack = $00000005;

// Constants for enum ToolStripStatusLabelBorderSides
type
  ToolStripStatusLabelBorderSides = TOleEnum;
const
  ToolStripStatusLabelBorderSides_All = $0000000F;
  ToolStripStatusLabelBorderSides_Bottom = $00000008;
  ToolStripStatusLabelBorderSides_Left = $00000001;
  ToolStripStatusLabelBorderSides_None = $00000000;
  ToolStripStatusLabelBorderSides_Right = $00000004;
  ToolStripStatusLabelBorderSides_Top = $00000002;

// Constants for enum TreeViewHitTestLocations
type
  TreeViewHitTestLocations = TOleEnum;
const
  TreeViewHitTestLocations_AboveClientArea = $00000100;
  TreeViewHitTestLocations_BelowClientArea = $00000200;
  TreeViewHitTestLocations_Image = $00000002;
  TreeViewHitTestLocations_Indent = $00000008;
  TreeViewHitTestLocations_Label = $00000004;
  TreeViewHitTestLocations_LeftOfClientArea = $00000800;
  TreeViewHitTestLocations_None = $00000001;
  TreeViewHitTestLocations_PlusMinus = $00000010;
  TreeViewHitTestLocations_RightOfClientArea = $00000400;
  TreeViewHitTestLocations_RightOfLabel = $00000020;
  TreeViewHitTestLocations_StateImage = $00000040;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _AccessibleObject = interface;
  _AccessibleObjectDisp = dispinterface;
  _Form = interface;
  _FormDisp = dispinterface;
  _AxHost = interface;
  _AxHostDisp = dispinterface;
  _Control = interface;
  _ControlDisp = dispinterface;
  IWin32Window = interface;
  _ContainerControl = interface;
  _ContainerControlDisp = dispinterface;
  _BindingNavigator = interface;
  _BindingNavigatorDisp = dispinterface;
  _ToolStrip = interface;
  _ToolStripDisp = dispinterface;
  _Button = interface;
  _ButtonDisp = dispinterface;
  _ButtonBase = interface;
  _ButtonBaseDisp = dispinterface;
  _MouseEventArgs = interface;
  _MouseEventArgsDisp = dispinterface;
  _ButtonBaseAccessibleObject = interface;
  _ButtonBaseAccessibleObjectDisp = dispinterface;
  _ControlAccessibleObject = interface;
  _ControlAccessibleObjectDisp = dispinterface;
  _KeyEventArgs = interface;
  _KeyEventArgsDisp = dispinterface;
  _CheckBox = interface;
  _CheckBoxDisp = dispinterface;
  _CheckBoxAccessibleObject = interface;
  _CheckBoxAccessibleObjectDisp = dispinterface;
  _CheckedListBox = interface;
  _CheckedListBoxDisp = dispinterface;
  _ListBox = interface;
  _ListBoxDisp = dispinterface;
  _KeyPressEventArgs = interface;
  _KeyPressEventArgsDisp = dispinterface;
  _ItemCheckEventArgs = interface;
  _ItemCheckEventArgsDisp = dispinterface;
  IDataObject = interface;
  IDataObjectDisp = dispinterface;
  _ListView = interface;
  _ListViewDisp = dispinterface;
  _ComboBox = interface;
  _ComboBoxDisp = dispinterface;
  _ListControl = interface;
  _ListControlDisp = dispinterface;
  _ChildAccessibleObject = interface;
  _ChildAccessibleObjectDisp = dispinterface;
  _ScrollableControl = interface;
  _ScrollableControlDisp = dispinterface;
  _ContextMenuStrip = interface;
  _ContextMenuStripDisp = dispinterface;
  _ToolStripDropDownMenu = interface;
  _ToolStripDropDownMenuDisp = dispinterface;
  _DragEventArgs = interface;
  _DragEventArgsDisp = dispinterface;
  _GiveFeedbackEventArgs = interface;
  _GiveFeedbackEventArgsDisp = dispinterface;
  _HelpEventArgs = interface;
  _HelpEventArgsDisp = dispinterface;
  _QueryContinueDragEventArgs = interface;
  _QueryContinueDragEventArgsDisp = dispinterface;
  _DataGrid = interface;
  _DataGridDisp = dispinterface;
  _ScrollBar = interface;
  _ScrollBarDisp = dispinterface;
  _NavigateEventArgs = interface;
  _NavigateEventArgsDisp = dispinterface;
  _ScrollEventArgs = interface;
  _ScrollEventArgsDisp = dispinterface;
  _DataGridTextBox = interface;
  _DataGridTextBoxDisp = dispinterface;
  _TextBox = interface;
  _TextBoxDisp = dispinterface;
  _DataGridView = interface;
  _DataGridViewDisp = dispinterface;
  _Panel = interface;
  _PanelDisp = dispinterface;
  _DataGridViewComboBoxEditingControl = interface;
  _DataGridViewComboBoxEditingControlDisp = dispinterface;
  _DataGridViewTextBoxEditingControl = interface;
  _DataGridViewTextBoxEditingControlDisp = dispinterface;
  _DateTimePicker = interface;
  _DateTimePickerDisp = dispinterface;
  _DateTimePickerAccessibleObject = interface;
  _DateTimePickerAccessibleObjectDisp = dispinterface;
  _DomainUpDown = interface;
  _DomainUpDownDisp = dispinterface;
  _UpDownBase = interface;
  _UpDownBaseDisp = dispinterface;
  _DomainItemAccessibleObject = interface;
  _DomainItemAccessibleObjectDisp = dispinterface;
  _DomainUpDownAccessibleObject = interface;
  _DomainUpDownAccessibleObjectDisp = dispinterface;
  _FlowLayoutPanel = interface;
  _FlowLayoutPanelDisp = dispinterface;
  _MenuStrip = interface;
  _MenuStripDisp = dispinterface;
  _GroupBox = interface;
  _GroupBoxDisp = dispinterface;
  _HScrollBar = interface;
  _HScrollBarDisp = dispinterface;
  _ItemDragEventArgs = interface;
  _ItemDragEventArgsDisp = dispinterface;
  _Label = interface;
  _LabelDisp = dispinterface;
  _LinkClickedEventArgs = interface;
  _LinkClickedEventArgsDisp = dispinterface;
  _LinkLabel = interface;
  _LinkLabelDisp = dispinterface;
  _LinkLabelLinkClickedEventArgs = interface;
  _LinkLabelLinkClickedEventArgsDisp = dispinterface;
  _ListViewItemMouseHoverEventArgs = interface;
  _ListViewItemMouseHoverEventArgsDisp = dispinterface;
  _MaskedTextBox = interface;
  _MaskedTextBoxDisp = dispinterface;
  _TextBoxBase = interface;
  _TextBoxBaseDisp = dispinterface;
  _MdiClient = interface;
  _MdiClientDisp = dispinterface;
  _MonthCalendar = interface;
  _MonthCalendarDisp = dispinterface;
  _NumericUpDown = interface;
  _NumericUpDownDisp = dispinterface;
  _PictureBox = interface;
  _PictureBoxDisp = dispinterface;
  _PrintPreviewControl = interface;
  _PrintPreviewControlDisp = dispinterface;
  _PrintPreviewDialog = interface;
  _PrintPreviewDialogDisp = dispinterface;
  _ProgressBar = interface;
  _ProgressBarDisp = dispinterface;
  _PropertyGrid = interface;
  _PropertyGridDisp = dispinterface;
  _PropertyTabChangedEventArgs = interface;
  _PropertyTabChangedEventArgsDisp = dispinterface;
  _PropertyValueChangedEventArgs = interface;
  _PropertyValueChangedEventArgsDisp = dispinterface;
  _QueryAccessibilityHelpEventArgs = interface;
  _QueryAccessibilityHelpEventArgsDisp = dispinterface;
  _RadioButton = interface;
  _RadioButtonDisp = dispinterface;
  _RadioButtonAccessibleObject = interface;
  _RadioButtonAccessibleObjectDisp = dispinterface;
  _RichTextBox = interface;
  _RichTextBoxDisp = dispinterface;
  _SplitContainer = interface;
  _SplitContainerDisp = dispinterface;
  _SplitterPanel = interface;
  _SplitterPanelDisp = dispinterface;
  _SplitterEventArgs = interface;
  _SplitterEventArgsDisp = dispinterface;
  _Splitter = interface;
  _SplitterDisp = dispinterface;
  _StatusBar = interface;
  _StatusBarDisp = dispinterface;
  _StatusStrip = interface;
  _StatusStripDisp = dispinterface;
  _TabControl = interface;
  _TabControlDisp = dispinterface;
  _TabPage = interface;
  _TabPageDisp = dispinterface;
  _TableLayoutPanel = interface;
  _TableLayoutPanelDisp = dispinterface;
  _ThreadExceptionDialog = interface;
  _ThreadExceptionDialogDisp = dispinterface;
  _ToolBar = interface;
  _ToolBarDisp = dispinterface;
  _ToolStripAccessibleObject = interface;
  _ToolStripAccessibleObjectDisp = dispinterface;
  _ToolStripContainer = interface;
  _ToolStripContainerDisp = dispinterface;
  _ToolStripPanel = interface;
  _ToolStripPanelDisp = dispinterface;
  _ToolStripContentPanel = interface;
  _ToolStripContentPanelDisp = dispinterface;
  _ToolStripDropDown = interface;
  _ToolStripDropDownDisp = dispinterface;
  _ToolStripDropDownAccessibleObject = interface;
  _ToolStripDropDownAccessibleObjectDisp = dispinterface;
  _ToolStripItemAccessibleObject = interface;
  _ToolStripItemAccessibleObjectDisp = dispinterface;
  _ToolStripOverflow = interface;
  _ToolStripOverflowDisp = dispinterface;
  _TrackBar = interface;
  _TrackBarDisp = dispinterface;
  _TreeView = interface;
  _TreeViewDisp = dispinterface;
  _TreeNodeMouseHoverEventArgs = interface;
  _TreeNodeMouseHoverEventArgsDisp = dispinterface;
  _UserControl = interface;
  _UserControlDisp = dispinterface;
  _VScrollBar = interface;
  _VScrollBarDisp = dispinterface;
  _WebBrowser = interface;
  _WebBrowserDisp = dispinterface;
  _WebBrowserBase = interface;
  _WebBrowserBaseDisp = dispinterface;
  _ComponentEditorForm = interface;
  _ComponentEditorFormDisp = dispinterface;
  _ComponentEditorPage = interface;
  _ComponentEditorPageDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  AccessibleObject = _AccessibleObject;
  Form = _Form;
  AxHost = _AxHost;
  Control = _Control;
  ContainerControl = _ContainerControl;
  BindingNavigator = _BindingNavigator;
  ToolStrip = _ToolStrip;
  Button = _Button;
  ButtonBase = _ButtonBase;
  MouseEventArgs = _MouseEventArgs;
  ButtonBaseAccessibleObject = _ButtonBaseAccessibleObject;
  ControlAccessibleObject = _ControlAccessibleObject;
  KeyEventArgs = _KeyEventArgs;
  CheckBox = _CheckBox;
  CheckBoxAccessibleObject = _CheckBoxAccessibleObject;
  CheckedListBox = _CheckedListBox;
  ListBox = _ListBox;
  KeyPressEventArgs = _KeyPressEventArgs;
  ItemCheckEventArgs = _ItemCheckEventArgs;
  ListView = _ListView;
  ComboBox = _ComboBox;
  ListControl = _ListControl;
  ChildAccessibleObject = _ChildAccessibleObject;
  ScrollableControl = _ScrollableControl;
  ContextMenuStrip = _ContextMenuStrip;
  ToolStripDropDownMenu = _ToolStripDropDownMenu;
  DragEventArgs = _DragEventArgs;
  GiveFeedbackEventArgs = _GiveFeedbackEventArgs;
  HelpEventArgs = _HelpEventArgs;
  QueryContinueDragEventArgs = _QueryContinueDragEventArgs;
  DataGrid = _DataGrid;
  ScrollBar = _ScrollBar;
  NavigateEventArgs = _NavigateEventArgs;
  ScrollEventArgs = _ScrollEventArgs;
  DataGridTextBox = _DataGridTextBox;
  TextBox = _TextBox;
  DataGridView = _DataGridView;
  Panel = _Panel;
  DataGridViewComboBoxEditingControl = _DataGridViewComboBoxEditingControl;
  DataGridViewTextBoxEditingControl = _DataGridViewTextBoxEditingControl;
  DateTimePicker = _DateTimePicker;
  DateTimePickerAccessibleObject = _DateTimePickerAccessibleObject;
  DomainUpDown = _DomainUpDown;
  UpDownBase = _UpDownBase;
  DomainItemAccessibleObject = _DomainItemAccessibleObject;
  DomainUpDownAccessibleObject = _DomainUpDownAccessibleObject;
  FlowLayoutPanel = _FlowLayoutPanel;
  MenuStrip = _MenuStrip;
  GroupBox = _GroupBox;
  HScrollBar = _HScrollBar;
  ItemDragEventArgs = _ItemDragEventArgs;
  Label_ = _Label;
  LinkClickedEventArgs = _LinkClickedEventArgs;
  LinkLabel = _LinkLabel;
  LinkLabelLinkClickedEventArgs = _LinkLabelLinkClickedEventArgs;
  ListViewItemMouseHoverEventArgs = _ListViewItemMouseHoverEventArgs;
  MaskedTextBox = _MaskedTextBox;
  TextBoxBase = _TextBoxBase;
  MdiClient = _MdiClient;
  MonthCalendar = _MonthCalendar;
  NumericUpDown = _NumericUpDown;
  PictureBox = _PictureBox;
  PrintPreviewControl = _PrintPreviewControl;
  PrintPreviewDialog = _PrintPreviewDialog;
  ProgressBar = _ProgressBar;
  PropertyGrid = _PropertyGrid;
  PropertyTabChangedEventArgs = _PropertyTabChangedEventArgs;
  PropertyValueChangedEventArgs = _PropertyValueChangedEventArgs;
  QueryAccessibilityHelpEventArgs = _QueryAccessibilityHelpEventArgs;
  RadioButton = _RadioButton;
  RadioButtonAccessibleObject = _RadioButtonAccessibleObject;
  RichTextBox = _RichTextBox;
  SplitContainer = _SplitContainer;
  SplitterPanel = _SplitterPanel;
  SplitterEventArgs = _SplitterEventArgs;
  Splitter = _Splitter;
  StatusBar = _StatusBar;
  StatusStrip = _StatusStrip;
  TabControl = _TabControl;
  TabPage = _TabPage;
  TableLayoutPanel = _TableLayoutPanel;
  ThreadExceptionDialog = _ThreadExceptionDialog;
  ToolBar = _ToolBar;
  ToolStripAccessibleObject = _ToolStripAccessibleObject;
  ToolStripContainer = _ToolStripContainer;
  ToolStripPanel = _ToolStripPanel;
  ToolStripContentPanel = _ToolStripContentPanel;
  ToolStripDropDown = _ToolStripDropDown;
  ToolStripDropDownAccessibleObject = _ToolStripDropDownAccessibleObject;
  ToolStripItemAccessibleObject = _ToolStripItemAccessibleObject;
  ToolStripOverflow = _ToolStripOverflow;
  TrackBar = _TrackBar;
  TreeView = _TreeView;
  TreeNodeMouseHoverEventArgs = _TreeNodeMouseHoverEventArgs;
  UserControl = _UserControl;
  VScrollBar = _VScrollBar;
  WebBrowser = _WebBrowser;
  WebBrowserBase = _WebBrowserBase;
  ComponentEditorForm = _ComponentEditorForm;
  ComponentEditorPage = _ComponentEditorPage;


// *********************************************************************//
// Interface: _AccessibleObject
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {399C0499-29D3-3D95-AF77-111DCDB92177}
// *********************************************************************//
  _AccessibleObject = interface(IDispatch)
    ['{399C0499-29D3-3D95-AF77-111DCDB92177}']
  end;

// *********************************************************************//
// DispIntf:  _AccessibleObjectDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {399C0499-29D3-3D95-AF77-111DCDB92177}
// *********************************************************************//
  _AccessibleObjectDisp = dispinterface
    ['{399C0499-29D3-3D95-AF77-111DCDB92177}']
  end;

// *********************************************************************//
// Interface: _Form
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {AD0C79DB-37BE-3B61-9C53-2E4857237227}
// *********************************************************************//
  _Form = interface(IDispatch)
    ['{AD0C79DB-37BE-3B61-9C53-2E4857237227}']
  end;

// *********************************************************************//
// DispIntf:  _FormDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {AD0C79DB-37BE-3B61-9C53-2E4857237227}
// *********************************************************************//
  _FormDisp = dispinterface
    ['{AD0C79DB-37BE-3B61-9C53-2E4857237227}']
  end;

// *********************************************************************//
// Interface: _AxHost
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {548054D5-75C5-3A72-A87B-D6F305254065}
// *********************************************************************//
  _AxHost = interface(IDispatch)
    ['{548054D5-75C5-3A72-A87B-D6F305254065}']
  end;

// *********************************************************************//
// DispIntf:  _AxHostDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {548054D5-75C5-3A72-A87B-D6F305254065}
// *********************************************************************//
  _AxHostDisp = dispinterface
    ['{548054D5-75C5-3A72-A87B-D6F305254065}']
  end;

// *********************************************************************//
// Interface: _Control
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {83ACBFAE-1A16-33EB-ABA0-BA8DF0B206D7}
// *********************************************************************//
  _Control = interface(IDispatch)
    ['{83ACBFAE-1A16-33EB-ABA0-BA8DF0B206D7}']
  end;

// *********************************************************************//
// DispIntf:  _ControlDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {83ACBFAE-1A16-33EB-ABA0-BA8DF0B206D7}
// *********************************************************************//
  _ControlDisp = dispinterface
    ['{83ACBFAE-1A16-33EB-ABA0-BA8DF0B206D7}']
  end;

// *********************************************************************//
// Interface: IWin32Window
// Flags:     (256) OleAutomation
// GUID:      {458AB8A2-A1EA-4D7B-8EBE-DEE5D3D9442C}
// *********************************************************************//
  IWin32Window = interface(IUnknown)
    ['{458AB8A2-A1EA-4D7B-8EBE-DEE5D3D9442C}']
    function Get_Handle(out pRetVal: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: _ContainerControl
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {A5AF2165-C1BE-39AF-AB35-CD950D01A701}
// *********************************************************************//
  _ContainerControl = interface(IDispatch)
    ['{A5AF2165-C1BE-39AF-AB35-CD950D01A701}']
  end;

// *********************************************************************//
// DispIntf:  _ContainerControlDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {A5AF2165-C1BE-39AF-AB35-CD950D01A701}
// *********************************************************************//
  _ContainerControlDisp = dispinterface
    ['{A5AF2165-C1BE-39AF-AB35-CD950D01A701}']
  end;

// *********************************************************************//
// Interface: _BindingNavigator
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {E3FF0D90-9E82-3736-A253-3B2F41EF981A}
// *********************************************************************//
  _BindingNavigator = interface(IDispatch)
    ['{E3FF0D90-9E82-3736-A253-3B2F41EF981A}']
  end;

// *********************************************************************//
// DispIntf:  _BindingNavigatorDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {E3FF0D90-9E82-3736-A253-3B2F41EF981A}
// *********************************************************************//
  _BindingNavigatorDisp = dispinterface
    ['{E3FF0D90-9E82-3736-A253-3B2F41EF981A}']
  end;

// *********************************************************************//
// Interface: _ToolStrip
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {A81676FD-EAA3-39C3-9354-A58951270EB6}
// *********************************************************************//
  _ToolStrip = interface(IDispatch)
    ['{A81676FD-EAA3-39C3-9354-A58951270EB6}']
  end;

// *********************************************************************//
// DispIntf:  _ToolStripDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {A81676FD-EAA3-39C3-9354-A58951270EB6}
// *********************************************************************//
  _ToolStripDisp = dispinterface
    ['{A81676FD-EAA3-39C3-9354-A58951270EB6}']
  end;

// *********************************************************************//
// Interface: _Button
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {9486855D-B3A4-32E8-AF74-EC881982E3FF}
// *********************************************************************//
  _Button = interface(IDispatch)
    ['{9486855D-B3A4-32E8-AF74-EC881982E3FF}']
  end;

// *********************************************************************//
// DispIntf:  _ButtonDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {9486855D-B3A4-32E8-AF74-EC881982E3FF}
// *********************************************************************//
  _ButtonDisp = dispinterface
    ['{9486855D-B3A4-32E8-AF74-EC881982E3FF}']
  end;

// *********************************************************************//
// Interface: _ButtonBase
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D14C1282-8647-317E-A549-D2CBCC264C3A}
// *********************************************************************//
  _ButtonBase = interface(IDispatch)
    ['{D14C1282-8647-317E-A549-D2CBCC264C3A}']
  end;

// *********************************************************************//
// DispIntf:  _ButtonBaseDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D14C1282-8647-317E-A549-D2CBCC264C3A}
// *********************************************************************//
  _ButtonBaseDisp = dispinterface
    ['{D14C1282-8647-317E-A549-D2CBCC264C3A}']
  end;

// *********************************************************************//
// Interface: _MouseEventArgs
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {276A1A21-AAEF-3378-8902-01F695868FF9}
// *********************************************************************//
  _MouseEventArgs = interface(IDispatch)
    ['{276A1A21-AAEF-3378-8902-01F695868FF9}']
  end;

// *********************************************************************//
// DispIntf:  _MouseEventArgsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {276A1A21-AAEF-3378-8902-01F695868FF9}
// *********************************************************************//
  _MouseEventArgsDisp = dispinterface
    ['{276A1A21-AAEF-3378-8902-01F695868FF9}']
  end;

// *********************************************************************//
// Interface: _ButtonBaseAccessibleObject
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {4343B837-6EC8-3E43-8A59-046C35024677}
// *********************************************************************//
  _ButtonBaseAccessibleObject = interface(IDispatch)
    ['{4343B837-6EC8-3E43-8A59-046C35024677}']
  end;

// *********************************************************************//
// DispIntf:  _ButtonBaseAccessibleObjectDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {4343B837-6EC8-3E43-8A59-046C35024677}
// *********************************************************************//
  _ButtonBaseAccessibleObjectDisp = dispinterface
    ['{4343B837-6EC8-3E43-8A59-046C35024677}']
  end;

// *********************************************************************//
// Interface: _ControlAccessibleObject
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {7496E5C0-90D3-372E-885F-BDD1A0316856}
// *********************************************************************//
  _ControlAccessibleObject = interface(IDispatch)
    ['{7496E5C0-90D3-372E-885F-BDD1A0316856}']
  end;

// *********************************************************************//
// DispIntf:  _ControlAccessibleObjectDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {7496E5C0-90D3-372E-885F-BDD1A0316856}
// *********************************************************************//
  _ControlAccessibleObjectDisp = dispinterface
    ['{7496E5C0-90D3-372E-885F-BDD1A0316856}']
  end;

// *********************************************************************//
// Interface: _KeyEventArgs
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {4AAA99AA-77B1-3CF7-85D8-D9CF69271AC6}
// *********************************************************************//
  _KeyEventArgs = interface(IDispatch)
    ['{4AAA99AA-77B1-3CF7-85D8-D9CF69271AC6}']
  end;

// *********************************************************************//
// DispIntf:  _KeyEventArgsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {4AAA99AA-77B1-3CF7-85D8-D9CF69271AC6}
// *********************************************************************//
  _KeyEventArgsDisp = dispinterface
    ['{4AAA99AA-77B1-3CF7-85D8-D9CF69271AC6}']
  end;

// *********************************************************************//
// Interface: _CheckBox
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {1C7817C6-6A49-301E-B20A-05FF053C3D56}
// *********************************************************************//
  _CheckBox = interface(IDispatch)
    ['{1C7817C6-6A49-301E-B20A-05FF053C3D56}']
  end;

// *********************************************************************//
// DispIntf:  _CheckBoxDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {1C7817C6-6A49-301E-B20A-05FF053C3D56}
// *********************************************************************//
  _CheckBoxDisp = dispinterface
    ['{1C7817C6-6A49-301E-B20A-05FF053C3D56}']
  end;

// *********************************************************************//
// Interface: _CheckBoxAccessibleObject
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {5D9FCE71-04C3-395E-B972-F1205E8DE615}
// *********************************************************************//
  _CheckBoxAccessibleObject = interface(IDispatch)
    ['{5D9FCE71-04C3-395E-B972-F1205E8DE615}']
  end;

// *********************************************************************//
// DispIntf:  _CheckBoxAccessibleObjectDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {5D9FCE71-04C3-395E-B972-F1205E8DE615}
// *********************************************************************//
  _CheckBoxAccessibleObjectDisp = dispinterface
    ['{5D9FCE71-04C3-395E-B972-F1205E8DE615}']
  end;

// *********************************************************************//
// Interface: _CheckedListBox
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {1833C4C9-4E61-3D96-AEB5-65B43DE96A01}
// *********************************************************************//
  _CheckedListBox = interface(IDispatch)
    ['{1833C4C9-4E61-3D96-AEB5-65B43DE96A01}']
  end;

// *********************************************************************//
// DispIntf:  _CheckedListBoxDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {1833C4C9-4E61-3D96-AEB5-65B43DE96A01}
// *********************************************************************//
  _CheckedListBoxDisp = dispinterface
    ['{1833C4C9-4E61-3D96-AEB5-65B43DE96A01}']
  end;

// *********************************************************************//
// Interface: _ListBox
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {E36590E6-CFD5-340E-9650-73500A802C43}
// *********************************************************************//
  _ListBox = interface(IDispatch)
    ['{E36590E6-CFD5-340E-9650-73500A802C43}']
  end;

// *********************************************************************//
// DispIntf:  _ListBoxDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {E36590E6-CFD5-340E-9650-73500A802C43}
// *********************************************************************//
  _ListBoxDisp = dispinterface
    ['{E36590E6-CFD5-340E-9650-73500A802C43}']
  end;

// *********************************************************************//
// Interface: _KeyPressEventArgs
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {B8755BC8-51FE-3D19-A3EC-5A5A5CF120E0}
// *********************************************************************//
  _KeyPressEventArgs = interface(IDispatch)
    ['{B8755BC8-51FE-3D19-A3EC-5A5A5CF120E0}']
  end;

// *********************************************************************//
// DispIntf:  _KeyPressEventArgsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {B8755BC8-51FE-3D19-A3EC-5A5A5CF120E0}
// *********************************************************************//
  _KeyPressEventArgsDisp = dispinterface
    ['{B8755BC8-51FE-3D19-A3EC-5A5A5CF120E0}']
  end;

// *********************************************************************//
// Interface: _ItemCheckEventArgs
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {29BDF32D-E055-38E7-8DCB-920A3038FEF7}
// *********************************************************************//
  _ItemCheckEventArgs = interface(IDispatch)
    ['{29BDF32D-E055-38E7-8DCB-920A3038FEF7}']
  end;

// *********************************************************************//
// DispIntf:  _ItemCheckEventArgsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {29BDF32D-E055-38E7-8DCB-920A3038FEF7}
// *********************************************************************//
  _ItemCheckEventArgsDisp = dispinterface
    ['{29BDF32D-E055-38E7-8DCB-920A3038FEF7}']
  end;

// *********************************************************************//
// Interface: IDataObject
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3CEE8CC1-1ADB-327F-9B97-7A9C8089BFB3}
// *********************************************************************//
  IDataObject = interface(IDispatch)
    ['{3CEE8CC1-1ADB-327F-9B97-7A9C8089BFB3}']
    function GetData(const format: WideString; autoConvert: WordBool): OleVariant; safecall;
    function GetData_2(const format: WideString): OleVariant; safecall;
    function GetData_3(const format: _Type): OleVariant; safecall;
    procedure SetData(const format: WideString; autoConvert: WordBool; data: OleVariant); safecall;
    procedure SetData_2(const format: WideString; data: OleVariant); safecall;
    procedure SetData_3(const format: _Type; data: OleVariant); safecall;
    procedure SetData_4(data: OleVariant); safecall;
    function GetDataPresent(const format: WideString; autoConvert: WordBool): WordBool; safecall;
    function GetDataPresent_2(const format: WideString): WordBool; safecall;
    function GetDataPresent_3(const format: _Type): WordBool; safecall;
    function GetFormats(autoConvert: WordBool): PSafeArray; safecall;
    function GetFormats_2: PSafeArray; safecall;
  end;

// *********************************************************************//
// DispIntf:  IDataObjectDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3CEE8CC1-1ADB-327F-9B97-7A9C8089BFB3}
// *********************************************************************//
  IDataObjectDisp = dispinterface
    ['{3CEE8CC1-1ADB-327F-9B97-7A9C8089BFB3}']
    function GetData(const format: WideString; autoConvert: WordBool): OleVariant; dispid 1610743808;
    function GetData_2(const format: WideString): OleVariant; dispid 1610743809;
    function GetData_3(const format: _Type): OleVariant; dispid 1610743810;
    procedure SetData(const format: WideString; autoConvert: WordBool; data: OleVariant); dispid 1610743811;
    procedure SetData_2(const format: WideString; data: OleVariant); dispid 1610743812;
    procedure SetData_3(const format: _Type; data: OleVariant); dispid 1610743813;
    procedure SetData_4(data: OleVariant); dispid 1610743814;
    function GetDataPresent(const format: WideString; autoConvert: WordBool): WordBool; dispid 1610743815;
    function GetDataPresent_2(const format: WideString): WordBool; dispid 1610743816;
    function GetDataPresent_3(const format: _Type): WordBool; dispid 1610743817;
    function GetFormats(autoConvert: WordBool): {??PSafeArray}OleVariant; dispid 1610743818;
    function GetFormats_2: {??PSafeArray}OleVariant; dispid 1610743819;
  end;

// *********************************************************************//
// Interface: _ListView
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {A87AED55-DDA4-3668-BEFA-1A776496DD3E}
// *********************************************************************//
  _ListView = interface(IDispatch)
    ['{A87AED55-DDA4-3668-BEFA-1A776496DD3E}']
  end;

// *********************************************************************//
// DispIntf:  _ListViewDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {A87AED55-DDA4-3668-BEFA-1A776496DD3E}
// *********************************************************************//
  _ListViewDisp = dispinterface
    ['{A87AED55-DDA4-3668-BEFA-1A776496DD3E}']
  end;

// *********************************************************************//
// Interface: _ComboBox
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {2EFEC16E-EEC9-39A3-9D8A-5E72B5C14F78}
// *********************************************************************//
  _ComboBox = interface(IDispatch)
    ['{2EFEC16E-EEC9-39A3-9D8A-5E72B5C14F78}']
  end;

// *********************************************************************//
// DispIntf:  _ComboBoxDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {2EFEC16E-EEC9-39A3-9D8A-5E72B5C14F78}
// *********************************************************************//
  _ComboBoxDisp = dispinterface
    ['{2EFEC16E-EEC9-39A3-9D8A-5E72B5C14F78}']
  end;

// *********************************************************************//
// Interface: _ListControl
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D58DFF0C-34C3-3D1E-8251-5F83EE7367C9}
// *********************************************************************//
  _ListControl = interface(IDispatch)
    ['{D58DFF0C-34C3-3D1E-8251-5F83EE7367C9}']
  end;

// *********************************************************************//
// DispIntf:  _ListControlDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D58DFF0C-34C3-3D1E-8251-5F83EE7367C9}
// *********************************************************************//
  _ListControlDisp = dispinterface
    ['{D58DFF0C-34C3-3D1E-8251-5F83EE7367C9}']
  end;

// *********************************************************************//
// Interface: _ChildAccessibleObject
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {518F00C6-2AAB-3B25-A76A-F62883781E18}
// *********************************************************************//
  _ChildAccessibleObject = interface(IDispatch)
    ['{518F00C6-2AAB-3B25-A76A-F62883781E18}']
  end;

// *********************************************************************//
// DispIntf:  _ChildAccessibleObjectDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {518F00C6-2AAB-3B25-A76A-F62883781E18}
// *********************************************************************//
  _ChildAccessibleObjectDisp = dispinterface
    ['{518F00C6-2AAB-3B25-A76A-F62883781E18}']
  end;

// *********************************************************************//
// Interface: _ScrollableControl
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {812A8B20-CB02-3483-8A29-424C6CDAC4B7}
// *********************************************************************//
  _ScrollableControl = interface(IDispatch)
    ['{812A8B20-CB02-3483-8A29-424C6CDAC4B7}']
  end;

// *********************************************************************//
// DispIntf:  _ScrollableControlDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {812A8B20-CB02-3483-8A29-424C6CDAC4B7}
// *********************************************************************//
  _ScrollableControlDisp = dispinterface
    ['{812A8B20-CB02-3483-8A29-424C6CDAC4B7}']
  end;

// *********************************************************************//
// Interface: _ContextMenuStrip
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {4B4939AF-61C1-378F-BDF0-68B9B3EE48E3}
// *********************************************************************//
  _ContextMenuStrip = interface(IDispatch)
    ['{4B4939AF-61C1-378F-BDF0-68B9B3EE48E3}']
  end;

// *********************************************************************//
// DispIntf:  _ContextMenuStripDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {4B4939AF-61C1-378F-BDF0-68B9B3EE48E3}
// *********************************************************************//
  _ContextMenuStripDisp = dispinterface
    ['{4B4939AF-61C1-378F-BDF0-68B9B3EE48E3}']
  end;

// *********************************************************************//
// Interface: _ToolStripDropDownMenu
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {8E07FA2C-B44B-3818-BA44-D88F2A69E8B6}
// *********************************************************************//
  _ToolStripDropDownMenu = interface(IDispatch)
    ['{8E07FA2C-B44B-3818-BA44-D88F2A69E8B6}']
  end;

// *********************************************************************//
// DispIntf:  _ToolStripDropDownMenuDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {8E07FA2C-B44B-3818-BA44-D88F2A69E8B6}
// *********************************************************************//
  _ToolStripDropDownMenuDisp = dispinterface
    ['{8E07FA2C-B44B-3818-BA44-D88F2A69E8B6}']
  end;

// *********************************************************************//
// Interface: _DragEventArgs
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {AEDF37AB-9041-3D55-9ACA-BDEDE24566D2}
// *********************************************************************//
  _DragEventArgs = interface(IDispatch)
    ['{AEDF37AB-9041-3D55-9ACA-BDEDE24566D2}']
  end;

// *********************************************************************//
// DispIntf:  _DragEventArgsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {AEDF37AB-9041-3D55-9ACA-BDEDE24566D2}
// *********************************************************************//
  _DragEventArgsDisp = dispinterface
    ['{AEDF37AB-9041-3D55-9ACA-BDEDE24566D2}']
  end;

// *********************************************************************//
// Interface: _GiveFeedbackEventArgs
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {77AD1D22-59C4-3634-9D55-50291CDA49F6}
// *********************************************************************//
  _GiveFeedbackEventArgs = interface(IDispatch)
    ['{77AD1D22-59C4-3634-9D55-50291CDA49F6}']
  end;

// *********************************************************************//
// DispIntf:  _GiveFeedbackEventArgsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {77AD1D22-59C4-3634-9D55-50291CDA49F6}
// *********************************************************************//
  _GiveFeedbackEventArgsDisp = dispinterface
    ['{77AD1D22-59C4-3634-9D55-50291CDA49F6}']
  end;

// *********************************************************************//
// Interface: _HelpEventArgs
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {7FA2B402-744D-34F5-AD8B-BD7C018B31F5}
// *********************************************************************//
  _HelpEventArgs = interface(IDispatch)
    ['{7FA2B402-744D-34F5-AD8B-BD7C018B31F5}']
  end;

// *********************************************************************//
// DispIntf:  _HelpEventArgsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {7FA2B402-744D-34F5-AD8B-BD7C018B31F5}
// *********************************************************************//
  _HelpEventArgsDisp = dispinterface
    ['{7FA2B402-744D-34F5-AD8B-BD7C018B31F5}']
  end;

// *********************************************************************//
// Interface: _QueryContinueDragEventArgs
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {9FD0D341-0808-3A17-A978-ADB5ED517F59}
// *********************************************************************//
  _QueryContinueDragEventArgs = interface(IDispatch)
    ['{9FD0D341-0808-3A17-A978-ADB5ED517F59}']
  end;

// *********************************************************************//
// DispIntf:  _QueryContinueDragEventArgsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {9FD0D341-0808-3A17-A978-ADB5ED517F59}
// *********************************************************************//
  _QueryContinueDragEventArgsDisp = dispinterface
    ['{9FD0D341-0808-3A17-A978-ADB5ED517F59}']
  end;

// *********************************************************************//
// Interface: _DataGrid
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {518A56E2-FBCE-3386-BB15-4A0F67872BDC}
// *********************************************************************//
  _DataGrid = interface(IDispatch)
    ['{518A56E2-FBCE-3386-BB15-4A0F67872BDC}']
  end;

// *********************************************************************//
// DispIntf:  _DataGridDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {518A56E2-FBCE-3386-BB15-4A0F67872BDC}
// *********************************************************************//
  _DataGridDisp = dispinterface
    ['{518A56E2-FBCE-3386-BB15-4A0F67872BDC}']
  end;

// *********************************************************************//
// Interface: _ScrollBar
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {59C5A9AD-941B-3279-BED8-EDCC2951CADC}
// *********************************************************************//
  _ScrollBar = interface(IDispatch)
    ['{59C5A9AD-941B-3279-BED8-EDCC2951CADC}']
  end;

// *********************************************************************//
// DispIntf:  _ScrollBarDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {59C5A9AD-941B-3279-BED8-EDCC2951CADC}
// *********************************************************************//
  _ScrollBarDisp = dispinterface
    ['{59C5A9AD-941B-3279-BED8-EDCC2951CADC}']
  end;

// *********************************************************************//
// Interface: _NavigateEventArgs
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {42959ECE-0606-3758-9679-A48E88F9BAF8}
// *********************************************************************//
  _NavigateEventArgs = interface(IDispatch)
    ['{42959ECE-0606-3758-9679-A48E88F9BAF8}']
  end;

// *********************************************************************//
// DispIntf:  _NavigateEventArgsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {42959ECE-0606-3758-9679-A48E88F9BAF8}
// *********************************************************************//
  _NavigateEventArgsDisp = dispinterface
    ['{42959ECE-0606-3758-9679-A48E88F9BAF8}']
  end;

// *********************************************************************//
// Interface: _ScrollEventArgs
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {CCD8C82C-DFBF-3E14-BE9B-38555F6221F2}
// *********************************************************************//
  _ScrollEventArgs = interface(IDispatch)
    ['{CCD8C82C-DFBF-3E14-BE9B-38555F6221F2}']
  end;

// *********************************************************************//
// DispIntf:  _ScrollEventArgsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {CCD8C82C-DFBF-3E14-BE9B-38555F6221F2}
// *********************************************************************//
  _ScrollEventArgsDisp = dispinterface
    ['{CCD8C82C-DFBF-3E14-BE9B-38555F6221F2}']
  end;

// *********************************************************************//
// Interface: _DataGridTextBox
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {2780E0D4-2B06-3E1F-ADDF-D8DBBB3FB960}
// *********************************************************************//
  _DataGridTextBox = interface(IDispatch)
    ['{2780E0D4-2B06-3E1F-ADDF-D8DBBB3FB960}']
  end;

// *********************************************************************//
// DispIntf:  _DataGridTextBoxDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {2780E0D4-2B06-3E1F-ADDF-D8DBBB3FB960}
// *********************************************************************//
  _DataGridTextBoxDisp = dispinterface
    ['{2780E0D4-2B06-3E1F-ADDF-D8DBBB3FB960}']
  end;

// *********************************************************************//
// Interface: _TextBox
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {EAEF4300-9FB3-306F-8F67-180DEB8DDFB7}
// *********************************************************************//
  _TextBox = interface(IDispatch)
    ['{EAEF4300-9FB3-306F-8F67-180DEB8DDFB7}']
  end;

// *********************************************************************//
// DispIntf:  _TextBoxDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {EAEF4300-9FB3-306F-8F67-180DEB8DDFB7}
// *********************************************************************//
  _TextBoxDisp = dispinterface
    ['{EAEF4300-9FB3-306F-8F67-180DEB8DDFB7}']
  end;

// *********************************************************************//
// Interface: _DataGridView
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {5968374C-8F43-353B-8F0A-780A0A7DDB79}
// *********************************************************************//
  _DataGridView = interface(IDispatch)
    ['{5968374C-8F43-353B-8F0A-780A0A7DDB79}']
  end;

// *********************************************************************//
// DispIntf:  _DataGridViewDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {5968374C-8F43-353B-8F0A-780A0A7DDB79}
// *********************************************************************//
  _DataGridViewDisp = dispinterface
    ['{5968374C-8F43-353B-8F0A-780A0A7DDB79}']
  end;

// *********************************************************************//
// Interface: _Panel
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {549A3DD8-D85F-3D08-87E2-49B08490008B}
// *********************************************************************//
  _Panel = interface(IDispatch)
    ['{549A3DD8-D85F-3D08-87E2-49B08490008B}']
  end;

// *********************************************************************//
// DispIntf:  _PanelDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {549A3DD8-D85F-3D08-87E2-49B08490008B}
// *********************************************************************//
  _PanelDisp = dispinterface
    ['{549A3DD8-D85F-3D08-87E2-49B08490008B}']
  end;

// *********************************************************************//
// Interface: _DataGridViewComboBoxEditingControl
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {C6615083-0A23-3997-A54B-F618EB824AF0}
// *********************************************************************//
  _DataGridViewComboBoxEditingControl = interface(IDispatch)
    ['{C6615083-0A23-3997-A54B-F618EB824AF0}']
  end;

// *********************************************************************//
// DispIntf:  _DataGridViewComboBoxEditingControlDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {C6615083-0A23-3997-A54B-F618EB824AF0}
// *********************************************************************//
  _DataGridViewComboBoxEditingControlDisp = dispinterface
    ['{C6615083-0A23-3997-A54B-F618EB824AF0}']
  end;

// *********************************************************************//
// Interface: _DataGridViewTextBoxEditingControl
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {A7750701-44A2-353A-923A-7BA68A8E22AF}
// *********************************************************************//
  _DataGridViewTextBoxEditingControl = interface(IDispatch)
    ['{A7750701-44A2-353A-923A-7BA68A8E22AF}']
  end;

// *********************************************************************//
// DispIntf:  _DataGridViewTextBoxEditingControlDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {A7750701-44A2-353A-923A-7BA68A8E22AF}
// *********************************************************************//
  _DataGridViewTextBoxEditingControlDisp = dispinterface
    ['{A7750701-44A2-353A-923A-7BA68A8E22AF}']
  end;

// *********************************************************************//
// Interface: _DateTimePicker
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {2BAD7D35-895F-3D4A-B883-0B3CD324B8BD}
// *********************************************************************//
  _DateTimePicker = interface(IDispatch)
    ['{2BAD7D35-895F-3D4A-B883-0B3CD324B8BD}']
  end;

// *********************************************************************//
// DispIntf:  _DateTimePickerDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {2BAD7D35-895F-3D4A-B883-0B3CD324B8BD}
// *********************************************************************//
  _DateTimePickerDisp = dispinterface
    ['{2BAD7D35-895F-3D4A-B883-0B3CD324B8BD}']
  end;

// *********************************************************************//
// Interface: _DateTimePickerAccessibleObject
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {5BEF6F14-89F8-3AD5-BE92-0649CFA5ABB1}
// *********************************************************************//
  _DateTimePickerAccessibleObject = interface(IDispatch)
    ['{5BEF6F14-89F8-3AD5-BE92-0649CFA5ABB1}']
  end;

// *********************************************************************//
// DispIntf:  _DateTimePickerAccessibleObjectDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {5BEF6F14-89F8-3AD5-BE92-0649CFA5ABB1}
// *********************************************************************//
  _DateTimePickerAccessibleObjectDisp = dispinterface
    ['{5BEF6F14-89F8-3AD5-BE92-0649CFA5ABB1}']
  end;

// *********************************************************************//
// Interface: _DomainUpDown
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {44792A74-5DD8-3410-A897-F568E4E58161}
// *********************************************************************//
  _DomainUpDown = interface(IDispatch)
    ['{44792A74-5DD8-3410-A897-F568E4E58161}']
  end;

// *********************************************************************//
// DispIntf:  _DomainUpDownDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {44792A74-5DD8-3410-A897-F568E4E58161}
// *********************************************************************//
  _DomainUpDownDisp = dispinterface
    ['{44792A74-5DD8-3410-A897-F568E4E58161}']
  end;

// *********************************************************************//
// Interface: _UpDownBase
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {C26446AC-E09B-3545-B01A-5575923636C3}
// *********************************************************************//
  _UpDownBase = interface(IDispatch)
    ['{C26446AC-E09B-3545-B01A-5575923636C3}']
  end;

// *********************************************************************//
// DispIntf:  _UpDownBaseDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {C26446AC-E09B-3545-B01A-5575923636C3}
// *********************************************************************//
  _UpDownBaseDisp = dispinterface
    ['{C26446AC-E09B-3545-B01A-5575923636C3}']
  end;

// *********************************************************************//
// Interface: _DomainItemAccessibleObject
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0D46DA02-69FB-3A29-9AC6-395925C38479}
// *********************************************************************//
  _DomainItemAccessibleObject = interface(IDispatch)
    ['{0D46DA02-69FB-3A29-9AC6-395925C38479}']
  end;

// *********************************************************************//
// DispIntf:  _DomainItemAccessibleObjectDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0D46DA02-69FB-3A29-9AC6-395925C38479}
// *********************************************************************//
  _DomainItemAccessibleObjectDisp = dispinterface
    ['{0D46DA02-69FB-3A29-9AC6-395925C38479}']
  end;

// *********************************************************************//
// Interface: _DomainUpDownAccessibleObject
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {131B8005-94C2-37D5-B738-CD2337635E73}
// *********************************************************************//
  _DomainUpDownAccessibleObject = interface(IDispatch)
    ['{131B8005-94C2-37D5-B738-CD2337635E73}']
  end;

// *********************************************************************//
// DispIntf:  _DomainUpDownAccessibleObjectDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {131B8005-94C2-37D5-B738-CD2337635E73}
// *********************************************************************//
  _DomainUpDownAccessibleObjectDisp = dispinterface
    ['{131B8005-94C2-37D5-B738-CD2337635E73}']
  end;

// *********************************************************************//
// Interface: _FlowLayoutPanel
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {B55C4C83-1F69-3D93-9C4E-2AA5619E0C68}
// *********************************************************************//
  _FlowLayoutPanel = interface(IDispatch)
    ['{B55C4C83-1F69-3D93-9C4E-2AA5619E0C68}']
  end;

// *********************************************************************//
// DispIntf:  _FlowLayoutPanelDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {B55C4C83-1F69-3D93-9C4E-2AA5619E0C68}
// *********************************************************************//
  _FlowLayoutPanelDisp = dispinterface
    ['{B55C4C83-1F69-3D93-9C4E-2AA5619E0C68}']
  end;

// *********************************************************************//
// Interface: _MenuStrip
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {EB5A3078-05D9-3F32-9045-89F756938A3D}
// *********************************************************************//
  _MenuStrip = interface(IDispatch)
    ['{EB5A3078-05D9-3F32-9045-89F756938A3D}']
  end;

// *********************************************************************//
// DispIntf:  _MenuStripDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {EB5A3078-05D9-3F32-9045-89F756938A3D}
// *********************************************************************//
  _MenuStripDisp = dispinterface
    ['{EB5A3078-05D9-3F32-9045-89F756938A3D}']
  end;

// *********************************************************************//
// Interface: _GroupBox
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {11B0B536-2F72-3A3F-B2A3-0420A9F5041F}
// *********************************************************************//
  _GroupBox = interface(IDispatch)
    ['{11B0B536-2F72-3A3F-B2A3-0420A9F5041F}']
  end;

// *********************************************************************//
// DispIntf:  _GroupBoxDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {11B0B536-2F72-3A3F-B2A3-0420A9F5041F}
// *********************************************************************//
  _GroupBoxDisp = dispinterface
    ['{11B0B536-2F72-3A3F-B2A3-0420A9F5041F}']
  end;

// *********************************************************************//
// Interface: _HScrollBar
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {7BC4A820-B20F-3ECE-BDD6-EE7E14EB7E0D}
// *********************************************************************//
  _HScrollBar = interface(IDispatch)
    ['{7BC4A820-B20F-3ECE-BDD6-EE7E14EB7E0D}']
  end;

// *********************************************************************//
// DispIntf:  _HScrollBarDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {7BC4A820-B20F-3ECE-BDD6-EE7E14EB7E0D}
// *********************************************************************//
  _HScrollBarDisp = dispinterface
    ['{7BC4A820-B20F-3ECE-BDD6-EE7E14EB7E0D}']
  end;

// *********************************************************************//
// Interface: _ItemDragEventArgs
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {7FA2A2C6-276C-3F23-AF2A-800CCD05CFF2}
// *********************************************************************//
  _ItemDragEventArgs = interface(IDispatch)
    ['{7FA2A2C6-276C-3F23-AF2A-800CCD05CFF2}']
  end;

// *********************************************************************//
// DispIntf:  _ItemDragEventArgsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {7FA2A2C6-276C-3F23-AF2A-800CCD05CFF2}
// *********************************************************************//
  _ItemDragEventArgsDisp = dispinterface
    ['{7FA2A2C6-276C-3F23-AF2A-800CCD05CFF2}']
  end;

// *********************************************************************//
// Interface: _Label
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {00AE8203-987D-3B7E-9448-5B3393282D7F}
// *********************************************************************//
  _Label = interface(IDispatch)
    ['{00AE8203-987D-3B7E-9448-5B3393282D7F}']
  end;

// *********************************************************************//
// DispIntf:  _LabelDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {00AE8203-987D-3B7E-9448-5B3393282D7F}
// *********************************************************************//
  _LabelDisp = dispinterface
    ['{00AE8203-987D-3B7E-9448-5B3393282D7F}']
  end;

// *********************************************************************//
// Interface: _LinkClickedEventArgs
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {93194740-9A53-3D3E-902C-240FBE0C90E4}
// *********************************************************************//
  _LinkClickedEventArgs = interface(IDispatch)
    ['{93194740-9A53-3D3E-902C-240FBE0C90E4}']
  end;

// *********************************************************************//
// DispIntf:  _LinkClickedEventArgsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {93194740-9A53-3D3E-902C-240FBE0C90E4}
// *********************************************************************//
  _LinkClickedEventArgsDisp = dispinterface
    ['{93194740-9A53-3D3E-902C-240FBE0C90E4}']
  end;

// *********************************************************************//
// Interface: _LinkLabel
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {4EE61C0D-D2D5-3A50-972B-C0A957D3A541}
// *********************************************************************//
  _LinkLabel = interface(IDispatch)
    ['{4EE61C0D-D2D5-3A50-972B-C0A957D3A541}']
  end;

// *********************************************************************//
// DispIntf:  _LinkLabelDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {4EE61C0D-D2D5-3A50-972B-C0A957D3A541}
// *********************************************************************//
  _LinkLabelDisp = dispinterface
    ['{4EE61C0D-D2D5-3A50-972B-C0A957D3A541}']
  end;

// *********************************************************************//
// Interface: _LinkLabelLinkClickedEventArgs
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {CB38AE7B-5208-351D-8B84-3ECA81DE0F34}
// *********************************************************************//
  _LinkLabelLinkClickedEventArgs = interface(IDispatch)
    ['{CB38AE7B-5208-351D-8B84-3ECA81DE0F34}']
  end;

// *********************************************************************//
// DispIntf:  _LinkLabelLinkClickedEventArgsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {CB38AE7B-5208-351D-8B84-3ECA81DE0F34}
// *********************************************************************//
  _LinkLabelLinkClickedEventArgsDisp = dispinterface
    ['{CB38AE7B-5208-351D-8B84-3ECA81DE0F34}']
  end;

// *********************************************************************//
// Interface: _ListViewItemMouseHoverEventArgs
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {A2F121D8-4775-3FB2-93A3-C5862AE8C359}
// *********************************************************************//
  _ListViewItemMouseHoverEventArgs = interface(IDispatch)
    ['{A2F121D8-4775-3FB2-93A3-C5862AE8C359}']
  end;

// *********************************************************************//
// DispIntf:  _ListViewItemMouseHoverEventArgsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {A2F121D8-4775-3FB2-93A3-C5862AE8C359}
// *********************************************************************//
  _ListViewItemMouseHoverEventArgsDisp = dispinterface
    ['{A2F121D8-4775-3FB2-93A3-C5862AE8C359}']
  end;

// *********************************************************************//
// Interface: _MaskedTextBox
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {22B0C1A9-E74E-381A-BABB-66BEF71FF08E}
// *********************************************************************//
  _MaskedTextBox = interface(IDispatch)
    ['{22B0C1A9-E74E-381A-BABB-66BEF71FF08E}']
  end;

// *********************************************************************//
// DispIntf:  _MaskedTextBoxDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {22B0C1A9-E74E-381A-BABB-66BEF71FF08E}
// *********************************************************************//
  _MaskedTextBoxDisp = dispinterface
    ['{22B0C1A9-E74E-381A-BABB-66BEF71FF08E}']
  end;

// *********************************************************************//
// Interface: _TextBoxBase
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {ABC30865-8929-3F02-9D70-6C3D68C83837}
// *********************************************************************//
  _TextBoxBase = interface(IDispatch)
    ['{ABC30865-8929-3F02-9D70-6C3D68C83837}']
  end;

// *********************************************************************//
// DispIntf:  _TextBoxBaseDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {ABC30865-8929-3F02-9D70-6C3D68C83837}
// *********************************************************************//
  _TextBoxBaseDisp = dispinterface
    ['{ABC30865-8929-3F02-9D70-6C3D68C83837}']
  end;

// *********************************************************************//
// Interface: _MdiClient
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {6AB0BB67-4A4B-32F9-A18A-6481916C946F}
// *********************************************************************//
  _MdiClient = interface(IDispatch)
    ['{6AB0BB67-4A4B-32F9-A18A-6481916C946F}']
  end;

// *********************************************************************//
// DispIntf:  _MdiClientDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {6AB0BB67-4A4B-32F9-A18A-6481916C946F}
// *********************************************************************//
  _MdiClientDisp = dispinterface
    ['{6AB0BB67-4A4B-32F9-A18A-6481916C946F}']
  end;

// *********************************************************************//
// Interface: _MonthCalendar
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {C3FA9EA8-275E-35E9-89DA-18B1FCA593EE}
// *********************************************************************//
  _MonthCalendar = interface(IDispatch)
    ['{C3FA9EA8-275E-35E9-89DA-18B1FCA593EE}']
  end;

// *********************************************************************//
// DispIntf:  _MonthCalendarDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {C3FA9EA8-275E-35E9-89DA-18B1FCA593EE}
// *********************************************************************//
  _MonthCalendarDisp = dispinterface
    ['{C3FA9EA8-275E-35E9-89DA-18B1FCA593EE}']
  end;

// *********************************************************************//
// Interface: _NumericUpDown
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {2AD9F14A-0097-3C69-9F8E-5DDB52F3878B}
// *********************************************************************//
  _NumericUpDown = interface(IDispatch)
    ['{2AD9F14A-0097-3C69-9F8E-5DDB52F3878B}']
  end;

// *********************************************************************//
// DispIntf:  _NumericUpDownDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {2AD9F14A-0097-3C69-9F8E-5DDB52F3878B}
// *********************************************************************//
  _NumericUpDownDisp = dispinterface
    ['{2AD9F14A-0097-3C69-9F8E-5DDB52F3878B}']
  end;

// *********************************************************************//
// Interface: _PictureBox
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {BB1C5180-87D0-330C-B698-EE2132DF362E}
// *********************************************************************//
  _PictureBox = interface(IDispatch)
    ['{BB1C5180-87D0-330C-B698-EE2132DF362E}']
  end;

// *********************************************************************//
// DispIntf:  _PictureBoxDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {BB1C5180-87D0-330C-B698-EE2132DF362E}
// *********************************************************************//
  _PictureBoxDisp = dispinterface
    ['{BB1C5180-87D0-330C-B698-EE2132DF362E}']
  end;

// *********************************************************************//
// Interface: _PrintPreviewControl
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {FA3B8143-ECB8-3A38-9DE5-DB0EEA708B5F}
// *********************************************************************//
  _PrintPreviewControl = interface(IDispatch)
    ['{FA3B8143-ECB8-3A38-9DE5-DB0EEA708B5F}']
  end;

// *********************************************************************//
// DispIntf:  _PrintPreviewControlDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {FA3B8143-ECB8-3A38-9DE5-DB0EEA708B5F}
// *********************************************************************//
  _PrintPreviewControlDisp = dispinterface
    ['{FA3B8143-ECB8-3A38-9DE5-DB0EEA708B5F}']
  end;

// *********************************************************************//
// Interface: _PrintPreviewDialog
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {57C090D5-80BC-33B8-B782-706A8D833767}
// *********************************************************************//
  _PrintPreviewDialog = interface(IDispatch)
    ['{57C090D5-80BC-33B8-B782-706A8D833767}']
  end;

// *********************************************************************//
// DispIntf:  _PrintPreviewDialogDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {57C090D5-80BC-33B8-B782-706A8D833767}
// *********************************************************************//
  _PrintPreviewDialogDisp = dispinterface
    ['{57C090D5-80BC-33B8-B782-706A8D833767}']
  end;

// *********************************************************************//
// Interface: _ProgressBar
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {8E935BCB-21E1-377C-A59F-89F7BA5A4E0F}
// *********************************************************************//
  _ProgressBar = interface(IDispatch)
    ['{8E935BCB-21E1-377C-A59F-89F7BA5A4E0F}']
  end;

// *********************************************************************//
// DispIntf:  _ProgressBarDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {8E935BCB-21E1-377C-A59F-89F7BA5A4E0F}
// *********************************************************************//
  _ProgressBarDisp = dispinterface
    ['{8E935BCB-21E1-377C-A59F-89F7BA5A4E0F}']
  end;

// *********************************************************************//
// Interface: _PropertyGrid
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0C831618-60D7-32B2-9790-1EBDC5ADEFE5}
// *********************************************************************//
  _PropertyGrid = interface(IDispatch)
    ['{0C831618-60D7-32B2-9790-1EBDC5ADEFE5}']
  end;

// *********************************************************************//
// DispIntf:  _PropertyGridDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0C831618-60D7-32B2-9790-1EBDC5ADEFE5}
// *********************************************************************//
  _PropertyGridDisp = dispinterface
    ['{0C831618-60D7-32B2-9790-1EBDC5ADEFE5}']
  end;

// *********************************************************************//
// Interface: _PropertyTabChangedEventArgs
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {DB6FE495-8F5B-3C66-9A17-4C40D5593906}
// *********************************************************************//
  _PropertyTabChangedEventArgs = interface(IDispatch)
    ['{DB6FE495-8F5B-3C66-9A17-4C40D5593906}']
  end;

// *********************************************************************//
// DispIntf:  _PropertyTabChangedEventArgsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {DB6FE495-8F5B-3C66-9A17-4C40D5593906}
// *********************************************************************//
  _PropertyTabChangedEventArgsDisp = dispinterface
    ['{DB6FE495-8F5B-3C66-9A17-4C40D5593906}']
  end;

// *********************************************************************//
// Interface: _PropertyValueChangedEventArgs
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {6D43DF59-7EA8-300F-ACB2-760A070CFCF2}
// *********************************************************************//
  _PropertyValueChangedEventArgs = interface(IDispatch)
    ['{6D43DF59-7EA8-300F-ACB2-760A070CFCF2}']
  end;

// *********************************************************************//
// DispIntf:  _PropertyValueChangedEventArgsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {6D43DF59-7EA8-300F-ACB2-760A070CFCF2}
// *********************************************************************//
  _PropertyValueChangedEventArgsDisp = dispinterface
    ['{6D43DF59-7EA8-300F-ACB2-760A070CFCF2}']
  end;

// *********************************************************************//
// Interface: _QueryAccessibilityHelpEventArgs
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {2FE9F084-1511-3052-BE7C-9010B522C10E}
// *********************************************************************//
  _QueryAccessibilityHelpEventArgs = interface(IDispatch)
    ['{2FE9F084-1511-3052-BE7C-9010B522C10E}']
  end;

// *********************************************************************//
// DispIntf:  _QueryAccessibilityHelpEventArgsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {2FE9F084-1511-3052-BE7C-9010B522C10E}
// *********************************************************************//
  _QueryAccessibilityHelpEventArgsDisp = dispinterface
    ['{2FE9F084-1511-3052-BE7C-9010B522C10E}']
  end;

// *********************************************************************//
// Interface: _RadioButton
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {3E431682-BBDE-31B1-AE7F-9D8DD582BD0D}
// *********************************************************************//
  _RadioButton = interface(IDispatch)
    ['{3E431682-BBDE-31B1-AE7F-9D8DD582BD0D}']
  end;

// *********************************************************************//
// DispIntf:  _RadioButtonDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {3E431682-BBDE-31B1-AE7F-9D8DD582BD0D}
// *********************************************************************//
  _RadioButtonDisp = dispinterface
    ['{3E431682-BBDE-31B1-AE7F-9D8DD582BD0D}']
  end;

// *********************************************************************//
// Interface: _RadioButtonAccessibleObject
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {EDC3C736-47FD-3F25-90E4-123234D64FD4}
// *********************************************************************//
  _RadioButtonAccessibleObject = interface(IDispatch)
    ['{EDC3C736-47FD-3F25-90E4-123234D64FD4}']
  end;

// *********************************************************************//
// DispIntf:  _RadioButtonAccessibleObjectDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {EDC3C736-47FD-3F25-90E4-123234D64FD4}
// *********************************************************************//
  _RadioButtonAccessibleObjectDisp = dispinterface
    ['{EDC3C736-47FD-3F25-90E4-123234D64FD4}']
  end;

// *********************************************************************//
// Interface: _RichTextBox
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {1B264763-A1C7-3441-9D61-7EDAEC2D0C44}
// *********************************************************************//
  _RichTextBox = interface(IDispatch)
    ['{1B264763-A1C7-3441-9D61-7EDAEC2D0C44}']
  end;

// *********************************************************************//
// DispIntf:  _RichTextBoxDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {1B264763-A1C7-3441-9D61-7EDAEC2D0C44}
// *********************************************************************//
  _RichTextBoxDisp = dispinterface
    ['{1B264763-A1C7-3441-9D61-7EDAEC2D0C44}']
  end;

// *********************************************************************//
// Interface: _SplitContainer
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {C1DA069E-4C0B-3664-BBA1-F81864825085}
// *********************************************************************//
  _SplitContainer = interface(IDispatch)
    ['{C1DA069E-4C0B-3664-BBA1-F81864825085}']
  end;

// *********************************************************************//
// DispIntf:  _SplitContainerDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {C1DA069E-4C0B-3664-BBA1-F81864825085}
// *********************************************************************//
  _SplitContainerDisp = dispinterface
    ['{C1DA069E-4C0B-3664-BBA1-F81864825085}']
  end;

// *********************************************************************//
// Interface: _SplitterPanel
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {3A4C8B1A-4AF9-344A-BC88-DFE863328C86}
// *********************************************************************//
  _SplitterPanel = interface(IDispatch)
    ['{3A4C8B1A-4AF9-344A-BC88-DFE863328C86}']
  end;

// *********************************************************************//
// DispIntf:  _SplitterPanelDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {3A4C8B1A-4AF9-344A-BC88-DFE863328C86}
// *********************************************************************//
  _SplitterPanelDisp = dispinterface
    ['{3A4C8B1A-4AF9-344A-BC88-DFE863328C86}']
  end;

// *********************************************************************//
// Interface: _SplitterEventArgs
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {8E61AD1D-76AE-3501-9B36-481BFEBD3E3E}
// *********************************************************************//
  _SplitterEventArgs = interface(IDispatch)
    ['{8E61AD1D-76AE-3501-9B36-481BFEBD3E3E}']
  end;

// *********************************************************************//
// DispIntf:  _SplitterEventArgsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {8E61AD1D-76AE-3501-9B36-481BFEBD3E3E}
// *********************************************************************//
  _SplitterEventArgsDisp = dispinterface
    ['{8E61AD1D-76AE-3501-9B36-481BFEBD3E3E}']
  end;

// *********************************************************************//
// Interface: _Splitter
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {C318A56D-0B03-3A5A-93F6-7DF0B3268237}
// *********************************************************************//
  _Splitter = interface(IDispatch)
    ['{C318A56D-0B03-3A5A-93F6-7DF0B3268237}']
  end;

// *********************************************************************//
// DispIntf:  _SplitterDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {C318A56D-0B03-3A5A-93F6-7DF0B3268237}
// *********************************************************************//
  _SplitterDisp = dispinterface
    ['{C318A56D-0B03-3A5A-93F6-7DF0B3268237}']
  end;

// *********************************************************************//
// Interface: _StatusBar
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {93409DA8-FE37-3D4E-9A08-B35B34122C64}
// *********************************************************************//
  _StatusBar = interface(IDispatch)
    ['{93409DA8-FE37-3D4E-9A08-B35B34122C64}']
  end;

// *********************************************************************//
// DispIntf:  _StatusBarDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {93409DA8-FE37-3D4E-9A08-B35B34122C64}
// *********************************************************************//
  _StatusBarDisp = dispinterface
    ['{93409DA8-FE37-3D4E-9A08-B35B34122C64}']
  end;

// *********************************************************************//
// Interface: _StatusStrip
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {71CA209D-40D3-3409-B341-DA9B922CCA45}
// *********************************************************************//
  _StatusStrip = interface(IDispatch)
    ['{71CA209D-40D3-3409-B341-DA9B922CCA45}']
  end;

// *********************************************************************//
// DispIntf:  _StatusStripDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {71CA209D-40D3-3409-B341-DA9B922CCA45}
// *********************************************************************//
  _StatusStripDisp = dispinterface
    ['{71CA209D-40D3-3409-B341-DA9B922CCA45}']
  end;

// *********************************************************************//
// Interface: _TabControl
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {470DE738-5261-302A-B205-4744652D2FD3}
// *********************************************************************//
  _TabControl = interface(IDispatch)
    ['{470DE738-5261-302A-B205-4744652D2FD3}']
  end;

// *********************************************************************//
// DispIntf:  _TabControlDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {470DE738-5261-302A-B205-4744652D2FD3}
// *********************************************************************//
  _TabControlDisp = dispinterface
    ['{470DE738-5261-302A-B205-4744652D2FD3}']
  end;

// *********************************************************************//
// Interface: _TabPage
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {59183431-BD56-33D2-A2ED-FA414ADF8DCB}
// *********************************************************************//
  _TabPage = interface(IDispatch)
    ['{59183431-BD56-33D2-A2ED-FA414ADF8DCB}']
  end;

// *********************************************************************//
// DispIntf:  _TabPageDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {59183431-BD56-33D2-A2ED-FA414ADF8DCB}
// *********************************************************************//
  _TabPageDisp = dispinterface
    ['{59183431-BD56-33D2-A2ED-FA414ADF8DCB}']
  end;

// *********************************************************************//
// Interface: _TableLayoutPanel
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {05CBE5B2-0292-37DE-BE51-5B7599CA5A11}
// *********************************************************************//
  _TableLayoutPanel = interface(IDispatch)
    ['{05CBE5B2-0292-37DE-BE51-5B7599CA5A11}']
  end;

// *********************************************************************//
// DispIntf:  _TableLayoutPanelDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {05CBE5B2-0292-37DE-BE51-5B7599CA5A11}
// *********************************************************************//
  _TableLayoutPanelDisp = dispinterface
    ['{05CBE5B2-0292-37DE-BE51-5B7599CA5A11}']
  end;

// *********************************************************************//
// Interface: _ThreadExceptionDialog
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {B00AA2F6-4D83-3937-B4AC-4C2C2C3F6C70}
// *********************************************************************//
  _ThreadExceptionDialog = interface(IDispatch)
    ['{B00AA2F6-4D83-3937-B4AC-4C2C2C3F6C70}']
  end;

// *********************************************************************//
// DispIntf:  _ThreadExceptionDialogDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {B00AA2F6-4D83-3937-B4AC-4C2C2C3F6C70}
// *********************************************************************//
  _ThreadExceptionDialogDisp = dispinterface
    ['{B00AA2F6-4D83-3937-B4AC-4C2C2C3F6C70}']
  end;

// *********************************************************************//
// Interface: _ToolBar
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {F6AB38B6-1C02-3B01-A7F8-510ED1C0B253}
// *********************************************************************//
  _ToolBar = interface(IDispatch)
    ['{F6AB38B6-1C02-3B01-A7F8-510ED1C0B253}']
  end;

// *********************************************************************//
// DispIntf:  _ToolBarDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {F6AB38B6-1C02-3B01-A7F8-510ED1C0B253}
// *********************************************************************//
  _ToolBarDisp = dispinterface
    ['{F6AB38B6-1C02-3B01-A7F8-510ED1C0B253}']
  end;

// *********************************************************************//
// Interface: _ToolStripAccessibleObject
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {6F7A7383-2ABE-39D6-85F6-7117ED41979C}
// *********************************************************************//
  _ToolStripAccessibleObject = interface(IDispatch)
    ['{6F7A7383-2ABE-39D6-85F6-7117ED41979C}']
  end;

// *********************************************************************//
// DispIntf:  _ToolStripAccessibleObjectDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {6F7A7383-2ABE-39D6-85F6-7117ED41979C}
// *********************************************************************//
  _ToolStripAccessibleObjectDisp = dispinterface
    ['{6F7A7383-2ABE-39D6-85F6-7117ED41979C}']
  end;

// *********************************************************************//
// Interface: _ToolStripContainer
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {2A42F137-D50D-3D62-AF58-4DF7A4F57C9B}
// *********************************************************************//
  _ToolStripContainer = interface(IDispatch)
    ['{2A42F137-D50D-3D62-AF58-4DF7A4F57C9B}']
  end;

// *********************************************************************//
// DispIntf:  _ToolStripContainerDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {2A42F137-D50D-3D62-AF58-4DF7A4F57C9B}
// *********************************************************************//
  _ToolStripContainerDisp = dispinterface
    ['{2A42F137-D50D-3D62-AF58-4DF7A4F57C9B}']
  end;

// *********************************************************************//
// Interface: _ToolStripPanel
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {FB97C26A-FB56-3F71-BBC4-B1377E7B142D}
// *********************************************************************//
  _ToolStripPanel = interface(IDispatch)
    ['{FB97C26A-FB56-3F71-BBC4-B1377E7B142D}']
  end;

// *********************************************************************//
// DispIntf:  _ToolStripPanelDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {FB97C26A-FB56-3F71-BBC4-B1377E7B142D}
// *********************************************************************//
  _ToolStripPanelDisp = dispinterface
    ['{FB97C26A-FB56-3F71-BBC4-B1377E7B142D}']
  end;

// *********************************************************************//
// Interface: _ToolStripContentPanel
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {6EE3853E-DDEF-3F29-8F1B-1ED7180D9229}
// *********************************************************************//
  _ToolStripContentPanel = interface(IDispatch)
    ['{6EE3853E-DDEF-3F29-8F1B-1ED7180D9229}']
  end;

// *********************************************************************//
// DispIntf:  _ToolStripContentPanelDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {6EE3853E-DDEF-3F29-8F1B-1ED7180D9229}
// *********************************************************************//
  _ToolStripContentPanelDisp = dispinterface
    ['{6EE3853E-DDEF-3F29-8F1B-1ED7180D9229}']
  end;

// *********************************************************************//
// Interface: _ToolStripDropDown
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {C2322B43-25B3-3B30-B3DB-67E4DA2E6533}
// *********************************************************************//
  _ToolStripDropDown = interface(IDispatch)
    ['{C2322B43-25B3-3B30-B3DB-67E4DA2E6533}']
  end;

// *********************************************************************//
// DispIntf:  _ToolStripDropDownDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {C2322B43-25B3-3B30-B3DB-67E4DA2E6533}
// *********************************************************************//
  _ToolStripDropDownDisp = dispinterface
    ['{C2322B43-25B3-3B30-B3DB-67E4DA2E6533}']
  end;

// *********************************************************************//
// Interface: _ToolStripDropDownAccessibleObject
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {DF0D9304-0E85-3FFC-8283-6F291F32EE61}
// *********************************************************************//
  _ToolStripDropDownAccessibleObject = interface(IDispatch)
    ['{DF0D9304-0E85-3FFC-8283-6F291F32EE61}']
  end;

// *********************************************************************//
// DispIntf:  _ToolStripDropDownAccessibleObjectDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {DF0D9304-0E85-3FFC-8283-6F291F32EE61}
// *********************************************************************//
  _ToolStripDropDownAccessibleObjectDisp = dispinterface
    ['{DF0D9304-0E85-3FFC-8283-6F291F32EE61}']
  end;

// *********************************************************************//
// Interface: _ToolStripItemAccessibleObject
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {8FD9748A-D04F-3DFB-96A8-5624290F4554}
// *********************************************************************//
  _ToolStripItemAccessibleObject = interface(IDispatch)
    ['{8FD9748A-D04F-3DFB-96A8-5624290F4554}']
  end;

// *********************************************************************//
// DispIntf:  _ToolStripItemAccessibleObjectDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {8FD9748A-D04F-3DFB-96A8-5624290F4554}
// *********************************************************************//
  _ToolStripItemAccessibleObjectDisp = dispinterface
    ['{8FD9748A-D04F-3DFB-96A8-5624290F4554}']
  end;

// *********************************************************************//
// Interface: _ToolStripOverflow
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {75781CE7-317D-3C54-95D4-3E4DC04B4D3F}
// *********************************************************************//
  _ToolStripOverflow = interface(IDispatch)
    ['{75781CE7-317D-3C54-95D4-3E4DC04B4D3F}']
  end;

// *********************************************************************//
// DispIntf:  _ToolStripOverflowDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {75781CE7-317D-3C54-95D4-3E4DC04B4D3F}
// *********************************************************************//
  _ToolStripOverflowDisp = dispinterface
    ['{75781CE7-317D-3C54-95D4-3E4DC04B4D3F}']
  end;

// *********************************************************************//
// Interface: _TrackBar
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {7A8CC9AD-4E8D-3AAF-941A-1511C9C1372A}
// *********************************************************************//
  _TrackBar = interface(IDispatch)
    ['{7A8CC9AD-4E8D-3AAF-941A-1511C9C1372A}']
  end;

// *********************************************************************//
// DispIntf:  _TrackBarDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {7A8CC9AD-4E8D-3AAF-941A-1511C9C1372A}
// *********************************************************************//
  _TrackBarDisp = dispinterface
    ['{7A8CC9AD-4E8D-3AAF-941A-1511C9C1372A}']
  end;

// *********************************************************************//
// Interface: _TreeView
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {BA97ED62-9EBD-34E8-94AD-F71AEF67DEFF}
// *********************************************************************//
  _TreeView = interface(IDispatch)
    ['{BA97ED62-9EBD-34E8-94AD-F71AEF67DEFF}']
  end;

// *********************************************************************//
// DispIntf:  _TreeViewDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {BA97ED62-9EBD-34E8-94AD-F71AEF67DEFF}
// *********************************************************************//
  _TreeViewDisp = dispinterface
    ['{BA97ED62-9EBD-34E8-94AD-F71AEF67DEFF}']
  end;

// *********************************************************************//
// Interface: _TreeNodeMouseHoverEventArgs
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {F51EDF6C-9E49-334A-8AAE-B0C7C631ABE4}
// *********************************************************************//
  _TreeNodeMouseHoverEventArgs = interface(IDispatch)
    ['{F51EDF6C-9E49-334A-8AAE-B0C7C631ABE4}']
  end;

// *********************************************************************//
// DispIntf:  _TreeNodeMouseHoverEventArgsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {F51EDF6C-9E49-334A-8AAE-B0C7C631ABE4}
// *********************************************************************//
  _TreeNodeMouseHoverEventArgsDisp = dispinterface
    ['{F51EDF6C-9E49-334A-8AAE-B0C7C631ABE4}']
  end;

// *********************************************************************//
// Interface: _UserControl
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {6BEEDF4B-B688-3C0D-8B16-D53290790DFB}
// *********************************************************************//
  _UserControl = interface(IDispatch)
    ['{6BEEDF4B-B688-3C0D-8B16-D53290790DFB}']
  end;

// *********************************************************************//
// DispIntf:  _UserControlDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {6BEEDF4B-B688-3C0D-8B16-D53290790DFB}
// *********************************************************************//
  _UserControlDisp = dispinterface
    ['{6BEEDF4B-B688-3C0D-8B16-D53290790DFB}']
  end;

// *********************************************************************//
// Interface: _VScrollBar
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {469D64EC-EB30-3462-A93B-E01BAA5CAF83}
// *********************************************************************//
  _VScrollBar = interface(IDispatch)
    ['{469D64EC-EB30-3462-A93B-E01BAA5CAF83}']
  end;

// *********************************************************************//
// DispIntf:  _VScrollBarDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {469D64EC-EB30-3462-A93B-E01BAA5CAF83}
// *********************************************************************//
  _VScrollBarDisp = dispinterface
    ['{469D64EC-EB30-3462-A93B-E01BAA5CAF83}']
  end;

// *********************************************************************//
// Interface: _WebBrowser
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {BB134D18-9643-3862-AA3B-17EBDB1A0DEF}
// *********************************************************************//
  _WebBrowser = interface(IDispatch)
    ['{BB134D18-9643-3862-AA3B-17EBDB1A0DEF}']
  end;

// *********************************************************************//
// DispIntf:  _WebBrowserDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {BB134D18-9643-3862-AA3B-17EBDB1A0DEF}
// *********************************************************************//
  _WebBrowserDisp = dispinterface
    ['{BB134D18-9643-3862-AA3B-17EBDB1A0DEF}']
  end;

// *********************************************************************//
// Interface: _WebBrowserBase
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {764905A9-B10E-3C61-96DD-FA6F4BF8648D}
// *********************************************************************//
  _WebBrowserBase = interface(IDispatch)
    ['{764905A9-B10E-3C61-96DD-FA6F4BF8648D}']
  end;

// *********************************************************************//
// DispIntf:  _WebBrowserBaseDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {764905A9-B10E-3C61-96DD-FA6F4BF8648D}
// *********************************************************************//
  _WebBrowserBaseDisp = dispinterface
    ['{764905A9-B10E-3C61-96DD-FA6F4BF8648D}']
  end;

// *********************************************************************//
// Interface: _ComponentEditorForm
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {A7006EFC-6E21-3B74-A9D7-9A2F12E46C8E}
// *********************************************************************//
  _ComponentEditorForm = interface(IDispatch)
    ['{A7006EFC-6E21-3B74-A9D7-9A2F12E46C8E}']
  end;

// *********************************************************************//
// DispIntf:  _ComponentEditorFormDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {A7006EFC-6E21-3B74-A9D7-9A2F12E46C8E}
// *********************************************************************//
  _ComponentEditorFormDisp = dispinterface
    ['{A7006EFC-6E21-3B74-A9D7-9A2F12E46C8E}']
  end;

// *********************************************************************//
// Interface: _ComponentEditorPage
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {C858A49A-FDCB-395D-BBB8-9B2B66DC0FB5}
// *********************************************************************//
  _ComponentEditorPage = interface(IDispatch)
    ['{C858A49A-FDCB-395D-BBB8-9B2B66DC0FB5}']
  end;

// *********************************************************************//
// DispIntf:  _ComponentEditorPageDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {C858A49A-FDCB-395D-BBB8-9B2B66DC0FB5}
// *********************************************************************//
  _ComponentEditorPageDisp = dispinterface
    ['{C858A49A-FDCB-395D-BBB8-9B2B66DC0FB5}']
  end;

// *********************************************************************//
// The Class CoAccessibleObject provides a Create and CreateRemote method to          
// create instances of the default interface _AccessibleObject exposed by              
// the CoClass AccessibleObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAccessibleObject = class
    class function Create: _AccessibleObject;
    class function CreateRemote(const MachineName: string): _AccessibleObject;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TAccessibleObject
// Help String      : 
// Default Interface: _AccessibleObject
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TAccessibleObjectProperties= class;
{$ENDIF}
  TAccessibleObject = class(TOleServer)
  private
    FIntf:        _AccessibleObject;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TAccessibleObjectProperties;
    function      GetServerProperties: TAccessibleObjectProperties;
{$ENDIF}
    function      GetDefaultInterface: _AccessibleObject;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _AccessibleObject);
    procedure Disconnect; override;
    property DefaultInterface: _AccessibleObject read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TAccessibleObjectProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TAccessibleObject
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TAccessibleObjectProperties = class(TPersistent)
  private
    FServer:    TAccessibleObject;
    function    GetDefaultInterface: _AccessibleObject;
    constructor Create(AServer: TAccessibleObject);
  protected
  public
    property DefaultInterface: _AccessibleObject read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoForm provides a Create and CreateRemote method to          
// create instances of the default interface _Form exposed by              
// the CoClass Form. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoForm = class
    class function Create: _Form;
    class function CreateRemote(const MachineName: string): _Form;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TForm
// Help String      : 
// Default Interface: _Form
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TFormProperties= class;
{$ENDIF}
  TForm = class(TOleServer)
  private
    FIntf:        _Form;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TFormProperties;
    function      GetServerProperties: TFormProperties;
{$ENDIF}
    function      GetDefaultInterface: _Form;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _Form);
    procedure Disconnect; override;
    property DefaultInterface: _Form read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TFormProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TForm
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TFormProperties = class(TPersistent)
  private
    FServer:    TForm;
    function    GetDefaultInterface: _Form;
    constructor Create(AServer: TForm);
  protected
  public
    property DefaultInterface: _Form read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoAxHost provides a Create and CreateRemote method to          
// create instances of the default interface _AxHost exposed by              
// the CoClass AxHost. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAxHost = class
    class function Create: _AxHost;
    class function CreateRemote(const MachineName: string): _AxHost;
  end;

// *********************************************************************//
// The Class CoControl provides a Create and CreateRemote method to          
// create instances of the default interface _Control exposed by              
// the CoClass Control. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoControl = class
    class function Create: _Control;
    class function CreateRemote(const MachineName: string): _Control;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TControl
// Help String      : 
// Default Interface: _Control
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TControlProperties= class;
{$ENDIF}
  TControl = class(TOleServer)
  private
    FIntf:        _Control;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TControlProperties;
    function      GetServerProperties: TControlProperties;
{$ENDIF}
    function      GetDefaultInterface: _Control;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _Control);
    procedure Disconnect; override;
    property DefaultInterface: _Control read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TControlProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TControl
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TControlProperties = class(TPersistent)
  private
    FServer:    TControl;
    function    GetDefaultInterface: _Control;
    constructor Create(AServer: TControl);
  protected
  public
    property DefaultInterface: _Control read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoContainerControl provides a Create and CreateRemote method to          
// create instances of the default interface _ContainerControl exposed by              
// the CoClass ContainerControl. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoContainerControl = class
    class function Create: _ContainerControl;
    class function CreateRemote(const MachineName: string): _ContainerControl;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TContainerControl
// Help String      : 
// Default Interface: _ContainerControl
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TContainerControlProperties= class;
{$ENDIF}
  TContainerControl = class(TOleServer)
  private
    FIntf:        _ContainerControl;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TContainerControlProperties;
    function      GetServerProperties: TContainerControlProperties;
{$ENDIF}
    function      GetDefaultInterface: _ContainerControl;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _ContainerControl);
    procedure Disconnect; override;
    property DefaultInterface: _ContainerControl read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TContainerControlProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TContainerControl
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TContainerControlProperties = class(TPersistent)
  private
    FServer:    TContainerControl;
    function    GetDefaultInterface: _ContainerControl;
    constructor Create(AServer: TContainerControl);
  protected
  public
    property DefaultInterface: _ContainerControl read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoBindingNavigator provides a Create and CreateRemote method to          
// create instances of the default interface _BindingNavigator exposed by              
// the CoClass BindingNavigator. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoBindingNavigator = class
    class function Create: _BindingNavigator;
    class function CreateRemote(const MachineName: string): _BindingNavigator;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TBindingNavigator
// Help String      : 
// Default Interface: _BindingNavigator
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TBindingNavigatorProperties= class;
{$ENDIF}
  TBindingNavigator = class(TOleServer)
  private
    FIntf:        _BindingNavigator;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TBindingNavigatorProperties;
    function      GetServerProperties: TBindingNavigatorProperties;
{$ENDIF}
    function      GetDefaultInterface: _BindingNavigator;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _BindingNavigator);
    procedure Disconnect; override;
    property DefaultInterface: _BindingNavigator read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TBindingNavigatorProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TBindingNavigator
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TBindingNavigatorProperties = class(TPersistent)
  private
    FServer:    TBindingNavigator;
    function    GetDefaultInterface: _BindingNavigator;
    constructor Create(AServer: TBindingNavigator);
  protected
  public
    property DefaultInterface: _BindingNavigator read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoToolStrip provides a Create and CreateRemote method to          
// create instances of the default interface _ToolStrip exposed by              
// the CoClass ToolStrip. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoToolStrip = class
    class function Create: _ToolStrip;
    class function CreateRemote(const MachineName: string): _ToolStrip;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TToolStrip
// Help String      : 
// Default Interface: _ToolStrip
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TToolStripProperties= class;
{$ENDIF}
  TToolStrip = class(TOleServer)
  private
    FIntf:        _ToolStrip;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TToolStripProperties;
    function      GetServerProperties: TToolStripProperties;
{$ENDIF}
    function      GetDefaultInterface: _ToolStrip;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _ToolStrip);
    procedure Disconnect; override;
    property DefaultInterface: _ToolStrip read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TToolStripProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TToolStrip
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TToolStripProperties = class(TPersistent)
  private
    FServer:    TToolStrip;
    function    GetDefaultInterface: _ToolStrip;
    constructor Create(AServer: TToolStrip);
  protected
  public
    property DefaultInterface: _ToolStrip read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoButton provides a Create and CreateRemote method to          
// create instances of the default interface _Button exposed by              
// the CoClass Button. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoButton = class
    class function Create: _Button;
    class function CreateRemote(const MachineName: string): _Button;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TButton
// Help String      : 
// Default Interface: _Button
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TButtonProperties= class;
{$ENDIF}
  TButton = class(TOleServer)
  private
    FIntf:        _Button;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TButtonProperties;
    function      GetServerProperties: TButtonProperties;
{$ENDIF}
    function      GetDefaultInterface: _Button;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _Button);
    procedure Disconnect; override;
    property DefaultInterface: _Button read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TButtonProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TButton
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TButtonProperties = class(TPersistent)
  private
    FServer:    TButton;
    function    GetDefaultInterface: _Button;
    constructor Create(AServer: TButton);
  protected
  public
    property DefaultInterface: _Button read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoButtonBase provides a Create and CreateRemote method to          
// create instances of the default interface _ButtonBase exposed by              
// the CoClass ButtonBase. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoButtonBase = class
    class function Create: _ButtonBase;
    class function CreateRemote(const MachineName: string): _ButtonBase;
  end;

// *********************************************************************//
// The Class CoMouseEventArgs provides a Create and CreateRemote method to          
// create instances of the default interface _MouseEventArgs exposed by              
// the CoClass MouseEventArgs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoMouseEventArgs = class
    class function Create: _MouseEventArgs;
    class function CreateRemote(const MachineName: string): _MouseEventArgs;
  end;

// *********************************************************************//
// The Class CoButtonBaseAccessibleObject provides a Create and CreateRemote method to          
// create instances of the default interface _ButtonBaseAccessibleObject exposed by              
// the CoClass ButtonBaseAccessibleObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoButtonBaseAccessibleObject = class
    class function Create: _ButtonBaseAccessibleObject;
    class function CreateRemote(const MachineName: string): _ButtonBaseAccessibleObject;
  end;

// *********************************************************************//
// The Class CoControlAccessibleObject provides a Create and CreateRemote method to          
// create instances of the default interface _ControlAccessibleObject exposed by              
// the CoClass ControlAccessibleObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoControlAccessibleObject = class
    class function Create: _ControlAccessibleObject;
    class function CreateRemote(const MachineName: string): _ControlAccessibleObject;
  end;

// *********************************************************************//
// The Class CoKeyEventArgs provides a Create and CreateRemote method to          
// create instances of the default interface _KeyEventArgs exposed by              
// the CoClass KeyEventArgs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoKeyEventArgs = class
    class function Create: _KeyEventArgs;
    class function CreateRemote(const MachineName: string): _KeyEventArgs;
  end;

// *********************************************************************//
// The Class CoCheckBox provides a Create and CreateRemote method to          
// create instances of the default interface _CheckBox exposed by              
// the CoClass CheckBox. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCheckBox = class
    class function Create: _CheckBox;
    class function CreateRemote(const MachineName: string): _CheckBox;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TCheckBox
// Help String      : 
// Default Interface: _CheckBox
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TCheckBoxProperties= class;
{$ENDIF}
  TCheckBox = class(TOleServer)
  private
    FIntf:        _CheckBox;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TCheckBoxProperties;
    function      GetServerProperties: TCheckBoxProperties;
{$ENDIF}
    function      GetDefaultInterface: _CheckBox;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _CheckBox);
    procedure Disconnect; override;
    property DefaultInterface: _CheckBox read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TCheckBoxProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TCheckBox
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TCheckBoxProperties = class(TPersistent)
  private
    FServer:    TCheckBox;
    function    GetDefaultInterface: _CheckBox;
    constructor Create(AServer: TCheckBox);
  protected
  public
    property DefaultInterface: _CheckBox read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoCheckBoxAccessibleObject provides a Create and CreateRemote method to          
// create instances of the default interface _CheckBoxAccessibleObject exposed by              
// the CoClass CheckBoxAccessibleObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCheckBoxAccessibleObject = class
    class function Create: _CheckBoxAccessibleObject;
    class function CreateRemote(const MachineName: string): _CheckBoxAccessibleObject;
  end;

// *********************************************************************//
// The Class CoCheckedListBox provides a Create and CreateRemote method to          
// create instances of the default interface _CheckedListBox exposed by              
// the CoClass CheckedListBox. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCheckedListBox = class
    class function Create: _CheckedListBox;
    class function CreateRemote(const MachineName: string): _CheckedListBox;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TCheckedListBox
// Help String      : 
// Default Interface: _CheckedListBox
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TCheckedListBoxProperties= class;
{$ENDIF}
  TCheckedListBox = class(TOleServer)
  private
    FIntf:        _CheckedListBox;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TCheckedListBoxProperties;
    function      GetServerProperties: TCheckedListBoxProperties;
{$ENDIF}
    function      GetDefaultInterface: _CheckedListBox;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _CheckedListBox);
    procedure Disconnect; override;
    property DefaultInterface: _CheckedListBox read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TCheckedListBoxProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TCheckedListBox
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TCheckedListBoxProperties = class(TPersistent)
  private
    FServer:    TCheckedListBox;
    function    GetDefaultInterface: _CheckedListBox;
    constructor Create(AServer: TCheckedListBox);
  protected
  public
    property DefaultInterface: _CheckedListBox read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoListBox provides a Create and CreateRemote method to          
// create instances of the default interface _ListBox exposed by              
// the CoClass ListBox. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoListBox = class
    class function Create: _ListBox;
    class function CreateRemote(const MachineName: string): _ListBox;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TListBox
// Help String      : 
// Default Interface: _ListBox
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TListBoxProperties= class;
{$ENDIF}
  TListBox = class(TOleServer)
  private
    FIntf:        _ListBox;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TListBoxProperties;
    function      GetServerProperties: TListBoxProperties;
{$ENDIF}
    function      GetDefaultInterface: _ListBox;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _ListBox);
    procedure Disconnect; override;
    property DefaultInterface: _ListBox read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TListBoxProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TListBox
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TListBoxProperties = class(TPersistent)
  private
    FServer:    TListBox;
    function    GetDefaultInterface: _ListBox;
    constructor Create(AServer: TListBox);
  protected
  public
    property DefaultInterface: _ListBox read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoKeyPressEventArgs provides a Create and CreateRemote method to          
// create instances of the default interface _KeyPressEventArgs exposed by              
// the CoClass KeyPressEventArgs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoKeyPressEventArgs = class
    class function Create: _KeyPressEventArgs;
    class function CreateRemote(const MachineName: string): _KeyPressEventArgs;
  end;

// *********************************************************************//
// The Class CoItemCheckEventArgs provides a Create and CreateRemote method to          
// create instances of the default interface _ItemCheckEventArgs exposed by              
// the CoClass ItemCheckEventArgs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoItemCheckEventArgs = class
    class function Create: _ItemCheckEventArgs;
    class function CreateRemote(const MachineName: string): _ItemCheckEventArgs;
  end;

// *********************************************************************//
// The Class CoListView provides a Create and CreateRemote method to          
// create instances of the default interface _ListView exposed by              
// the CoClass ListView. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoListView = class
    class function Create: _ListView;
    class function CreateRemote(const MachineName: string): _ListView;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TListView
// Help String      : 
// Default Interface: _ListView
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TListViewProperties= class;
{$ENDIF}
  TListView = class(TOleServer)
  private
    FIntf:        _ListView;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TListViewProperties;
    function      GetServerProperties: TListViewProperties;
{$ENDIF}
    function      GetDefaultInterface: _ListView;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _ListView);
    procedure Disconnect; override;
    property DefaultInterface: _ListView read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TListViewProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TListView
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TListViewProperties = class(TPersistent)
  private
    FServer:    TListView;
    function    GetDefaultInterface: _ListView;
    constructor Create(AServer: TListView);
  protected
  public
    property DefaultInterface: _ListView read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoComboBox provides a Create and CreateRemote method to          
// create instances of the default interface _ComboBox exposed by              
// the CoClass ComboBox. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoComboBox = class
    class function Create: _ComboBox;
    class function CreateRemote(const MachineName: string): _ComboBox;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TComboBox
// Help String      : 
// Default Interface: _ComboBox
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TComboBoxProperties= class;
{$ENDIF}
  TComboBox = class(TOleServer)
  private
    FIntf:        _ComboBox;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TComboBoxProperties;
    function      GetServerProperties: TComboBoxProperties;
{$ENDIF}
    function      GetDefaultInterface: _ComboBox;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _ComboBox);
    procedure Disconnect; override;
    property DefaultInterface: _ComboBox read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TComboBoxProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TComboBox
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TComboBoxProperties = class(TPersistent)
  private
    FServer:    TComboBox;
    function    GetDefaultInterface: _ComboBox;
    constructor Create(AServer: TComboBox);
  protected
  public
    property DefaultInterface: _ComboBox read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoListControl provides a Create and CreateRemote method to          
// create instances of the default interface _ListControl exposed by              
// the CoClass ListControl. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoListControl = class
    class function Create: _ListControl;
    class function CreateRemote(const MachineName: string): _ListControl;
  end;

// *********************************************************************//
// The Class CoChildAccessibleObject provides a Create and CreateRemote method to          
// create instances of the default interface _ChildAccessibleObject exposed by              
// the CoClass ChildAccessibleObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoChildAccessibleObject = class
    class function Create: _ChildAccessibleObject;
    class function CreateRemote(const MachineName: string): _ChildAccessibleObject;
  end;

// *********************************************************************//
// The Class CoScrollableControl provides a Create and CreateRemote method to          
// create instances of the default interface _ScrollableControl exposed by              
// the CoClass ScrollableControl. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoScrollableControl = class
    class function Create: _ScrollableControl;
    class function CreateRemote(const MachineName: string): _ScrollableControl;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TScrollableControl
// Help String      : 
// Default Interface: _ScrollableControl
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TScrollableControlProperties= class;
{$ENDIF}
  TScrollableControl = class(TOleServer)
  private
    FIntf:        _ScrollableControl;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TScrollableControlProperties;
    function      GetServerProperties: TScrollableControlProperties;
{$ENDIF}
    function      GetDefaultInterface: _ScrollableControl;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _ScrollableControl);
    procedure Disconnect; override;
    property DefaultInterface: _ScrollableControl read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TScrollableControlProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TScrollableControl
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TScrollableControlProperties = class(TPersistent)
  private
    FServer:    TScrollableControl;
    function    GetDefaultInterface: _ScrollableControl;
    constructor Create(AServer: TScrollableControl);
  protected
  public
    property DefaultInterface: _ScrollableControl read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoContextMenuStrip provides a Create and CreateRemote method to          
// create instances of the default interface _ContextMenuStrip exposed by              
// the CoClass ContextMenuStrip. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoContextMenuStrip = class
    class function Create: _ContextMenuStrip;
    class function CreateRemote(const MachineName: string): _ContextMenuStrip;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TContextMenuStrip
// Help String      : 
// Default Interface: _ContextMenuStrip
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TContextMenuStripProperties= class;
{$ENDIF}
  TContextMenuStrip = class(TOleServer)
  private
    FIntf:        _ContextMenuStrip;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TContextMenuStripProperties;
    function      GetServerProperties: TContextMenuStripProperties;
{$ENDIF}
    function      GetDefaultInterface: _ContextMenuStrip;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _ContextMenuStrip);
    procedure Disconnect; override;
    property DefaultInterface: _ContextMenuStrip read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TContextMenuStripProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TContextMenuStrip
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TContextMenuStripProperties = class(TPersistent)
  private
    FServer:    TContextMenuStrip;
    function    GetDefaultInterface: _ContextMenuStrip;
    constructor Create(AServer: TContextMenuStrip);
  protected
  public
    property DefaultInterface: _ContextMenuStrip read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoToolStripDropDownMenu provides a Create and CreateRemote method to          
// create instances of the default interface _ToolStripDropDownMenu exposed by              
// the CoClass ToolStripDropDownMenu. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoToolStripDropDownMenu = class
    class function Create: _ToolStripDropDownMenu;
    class function CreateRemote(const MachineName: string): _ToolStripDropDownMenu;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TToolStripDropDownMenu
// Help String      : 
// Default Interface: _ToolStripDropDownMenu
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TToolStripDropDownMenuProperties= class;
{$ENDIF}
  TToolStripDropDownMenu = class(TOleServer)
  private
    FIntf:        _ToolStripDropDownMenu;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TToolStripDropDownMenuProperties;
    function      GetServerProperties: TToolStripDropDownMenuProperties;
{$ENDIF}
    function      GetDefaultInterface: _ToolStripDropDownMenu;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _ToolStripDropDownMenu);
    procedure Disconnect; override;
    property DefaultInterface: _ToolStripDropDownMenu read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TToolStripDropDownMenuProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TToolStripDropDownMenu
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TToolStripDropDownMenuProperties = class(TPersistent)
  private
    FServer:    TToolStripDropDownMenu;
    function    GetDefaultInterface: _ToolStripDropDownMenu;
    constructor Create(AServer: TToolStripDropDownMenu);
  protected
  public
    property DefaultInterface: _ToolStripDropDownMenu read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoDragEventArgs provides a Create and CreateRemote method to          
// create instances of the default interface _DragEventArgs exposed by              
// the CoClass DragEventArgs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDragEventArgs = class
    class function Create: _DragEventArgs;
    class function CreateRemote(const MachineName: string): _DragEventArgs;
  end;

// *********************************************************************//
// The Class CoGiveFeedbackEventArgs provides a Create and CreateRemote method to          
// create instances of the default interface _GiveFeedbackEventArgs exposed by              
// the CoClass GiveFeedbackEventArgs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoGiveFeedbackEventArgs = class
    class function Create: _GiveFeedbackEventArgs;
    class function CreateRemote(const MachineName: string): _GiveFeedbackEventArgs;
  end;

// *********************************************************************//
// The Class CoHelpEventArgs provides a Create and CreateRemote method to          
// create instances of the default interface _HelpEventArgs exposed by              
// the CoClass HelpEventArgs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoHelpEventArgs = class
    class function Create: _HelpEventArgs;
    class function CreateRemote(const MachineName: string): _HelpEventArgs;
  end;

// *********************************************************************//
// The Class CoQueryContinueDragEventArgs provides a Create and CreateRemote method to          
// create instances of the default interface _QueryContinueDragEventArgs exposed by              
// the CoClass QueryContinueDragEventArgs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoQueryContinueDragEventArgs = class
    class function Create: _QueryContinueDragEventArgs;
    class function CreateRemote(const MachineName: string): _QueryContinueDragEventArgs;
  end;

// *********************************************************************//
// The Class CoDataGrid provides a Create and CreateRemote method to          
// create instances of the default interface _DataGrid exposed by              
// the CoClass DataGrid. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDataGrid = class
    class function Create: _DataGrid;
    class function CreateRemote(const MachineName: string): _DataGrid;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TDataGrid
// Help String      : 
// Default Interface: _DataGrid
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TDataGridProperties= class;
{$ENDIF}
  TDataGrid = class(TOleServer)
  private
    FIntf:        _DataGrid;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TDataGridProperties;
    function      GetServerProperties: TDataGridProperties;
{$ENDIF}
    function      GetDefaultInterface: _DataGrid;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _DataGrid);
    procedure Disconnect; override;
    property DefaultInterface: _DataGrid read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TDataGridProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TDataGrid
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TDataGridProperties = class(TPersistent)
  private
    FServer:    TDataGrid;
    function    GetDefaultInterface: _DataGrid;
    constructor Create(AServer: TDataGrid);
  protected
  public
    property DefaultInterface: _DataGrid read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoScrollBar provides a Create and CreateRemote method to          
// create instances of the default interface _ScrollBar exposed by              
// the CoClass ScrollBar. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoScrollBar = class
    class function Create: _ScrollBar;
    class function CreateRemote(const MachineName: string): _ScrollBar;
  end;

// *********************************************************************//
// The Class CoNavigateEventArgs provides a Create and CreateRemote method to          
// create instances of the default interface _NavigateEventArgs exposed by              
// the CoClass NavigateEventArgs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoNavigateEventArgs = class
    class function Create: _NavigateEventArgs;
    class function CreateRemote(const MachineName: string): _NavigateEventArgs;
  end;

// *********************************************************************//
// The Class CoScrollEventArgs provides a Create and CreateRemote method to          
// create instances of the default interface _ScrollEventArgs exposed by              
// the CoClass ScrollEventArgs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoScrollEventArgs = class
    class function Create: _ScrollEventArgs;
    class function CreateRemote(const MachineName: string): _ScrollEventArgs;
  end;

// *********************************************************************//
// The Class CoDataGridTextBox provides a Create and CreateRemote method to          
// create instances of the default interface _DataGridTextBox exposed by              
// the CoClass DataGridTextBox. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDataGridTextBox = class
    class function Create: _DataGridTextBox;
    class function CreateRemote(const MachineName: string): _DataGridTextBox;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TDataGridTextBox
// Help String      : 
// Default Interface: _DataGridTextBox
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TDataGridTextBoxProperties= class;
{$ENDIF}
  TDataGridTextBox = class(TOleServer)
  private
    FIntf:        _DataGridTextBox;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TDataGridTextBoxProperties;
    function      GetServerProperties: TDataGridTextBoxProperties;
{$ENDIF}
    function      GetDefaultInterface: _DataGridTextBox;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _DataGridTextBox);
    procedure Disconnect; override;
    property DefaultInterface: _DataGridTextBox read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TDataGridTextBoxProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TDataGridTextBox
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TDataGridTextBoxProperties = class(TPersistent)
  private
    FServer:    TDataGridTextBox;
    function    GetDefaultInterface: _DataGridTextBox;
    constructor Create(AServer: TDataGridTextBox);
  protected
  public
    property DefaultInterface: _DataGridTextBox read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoTextBox provides a Create and CreateRemote method to          
// create instances of the default interface _TextBox exposed by              
// the CoClass TextBox. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTextBox = class
    class function Create: _TextBox;
    class function CreateRemote(const MachineName: string): _TextBox;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TTextBox
// Help String      : 
// Default Interface: _TextBox
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TTextBoxProperties= class;
{$ENDIF}
  TTextBox = class(TOleServer)
  private
    FIntf:        _TextBox;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TTextBoxProperties;
    function      GetServerProperties: TTextBoxProperties;
{$ENDIF}
    function      GetDefaultInterface: _TextBox;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _TextBox);
    procedure Disconnect; override;
    property DefaultInterface: _TextBox read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TTextBoxProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TTextBox
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TTextBoxProperties = class(TPersistent)
  private
    FServer:    TTextBox;
    function    GetDefaultInterface: _TextBox;
    constructor Create(AServer: TTextBox);
  protected
  public
    property DefaultInterface: _TextBox read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoDataGridView provides a Create and CreateRemote method to          
// create instances of the default interface _DataGridView exposed by              
// the CoClass DataGridView. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDataGridView = class
    class function Create: _DataGridView;
    class function CreateRemote(const MachineName: string): _DataGridView;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TDataGridView
// Help String      : 
// Default Interface: _DataGridView
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TDataGridViewProperties= class;
{$ENDIF}
  TDataGridView = class(TOleServer)
  private
    FIntf:        _DataGridView;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TDataGridViewProperties;
    function      GetServerProperties: TDataGridViewProperties;
{$ENDIF}
    function      GetDefaultInterface: _DataGridView;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _DataGridView);
    procedure Disconnect; override;
    property DefaultInterface: _DataGridView read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TDataGridViewProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TDataGridView
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TDataGridViewProperties = class(TPersistent)
  private
    FServer:    TDataGridView;
    function    GetDefaultInterface: _DataGridView;
    constructor Create(AServer: TDataGridView);
  protected
  public
    property DefaultInterface: _DataGridView read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoPanel provides a Create and CreateRemote method to          
// create instances of the default interface _Panel exposed by              
// the CoClass Panel. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPanel = class
    class function Create: _Panel;
    class function CreateRemote(const MachineName: string): _Panel;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TPanel
// Help String      : 
// Default Interface: _Panel
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TPanelProperties= class;
{$ENDIF}
  TPanel = class(TOleServer)
  private
    FIntf:        _Panel;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TPanelProperties;
    function      GetServerProperties: TPanelProperties;
{$ENDIF}
    function      GetDefaultInterface: _Panel;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _Panel);
    procedure Disconnect; override;
    property DefaultInterface: _Panel read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TPanelProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TPanel
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TPanelProperties = class(TPersistent)
  private
    FServer:    TPanel;
    function    GetDefaultInterface: _Panel;
    constructor Create(AServer: TPanel);
  protected
  public
    property DefaultInterface: _Panel read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoDataGridViewComboBoxEditingControl provides a Create and CreateRemote method to          
// create instances of the default interface _DataGridViewComboBoxEditingControl exposed by              
// the CoClass DataGridViewComboBoxEditingControl. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDataGridViewComboBoxEditingControl = class
    class function Create: _DataGridViewComboBoxEditingControl;
    class function CreateRemote(const MachineName: string): _DataGridViewComboBoxEditingControl;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TDataGridViewComboBoxEditingControl
// Help String      : 
// Default Interface: _DataGridViewComboBoxEditingControl
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TDataGridViewComboBoxEditingControlProperties= class;
{$ENDIF}
  TDataGridViewComboBoxEditingControl = class(TOleServer)
  private
    FIntf:        _DataGridViewComboBoxEditingControl;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TDataGridViewComboBoxEditingControlProperties;
    function      GetServerProperties: TDataGridViewComboBoxEditingControlProperties;
{$ENDIF}
    function      GetDefaultInterface: _DataGridViewComboBoxEditingControl;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _DataGridViewComboBoxEditingControl);
    procedure Disconnect; override;
    property DefaultInterface: _DataGridViewComboBoxEditingControl read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TDataGridViewComboBoxEditingControlProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TDataGridViewComboBoxEditingControl
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TDataGridViewComboBoxEditingControlProperties = class(TPersistent)
  private
    FServer:    TDataGridViewComboBoxEditingControl;
    function    GetDefaultInterface: _DataGridViewComboBoxEditingControl;
    constructor Create(AServer: TDataGridViewComboBoxEditingControl);
  protected
  public
    property DefaultInterface: _DataGridViewComboBoxEditingControl read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoDataGridViewTextBoxEditingControl provides a Create and CreateRemote method to          
// create instances of the default interface _DataGridViewTextBoxEditingControl exposed by              
// the CoClass DataGridViewTextBoxEditingControl. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDataGridViewTextBoxEditingControl = class
    class function Create: _DataGridViewTextBoxEditingControl;
    class function CreateRemote(const MachineName: string): _DataGridViewTextBoxEditingControl;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TDataGridViewTextBoxEditingControl
// Help String      : 
// Default Interface: _DataGridViewTextBoxEditingControl
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TDataGridViewTextBoxEditingControlProperties= class;
{$ENDIF}
  TDataGridViewTextBoxEditingControl = class(TOleServer)
  private
    FIntf:        _DataGridViewTextBoxEditingControl;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TDataGridViewTextBoxEditingControlProperties;
    function      GetServerProperties: TDataGridViewTextBoxEditingControlProperties;
{$ENDIF}
    function      GetDefaultInterface: _DataGridViewTextBoxEditingControl;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _DataGridViewTextBoxEditingControl);
    procedure Disconnect; override;
    property DefaultInterface: _DataGridViewTextBoxEditingControl read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TDataGridViewTextBoxEditingControlProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TDataGridViewTextBoxEditingControl
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TDataGridViewTextBoxEditingControlProperties = class(TPersistent)
  private
    FServer:    TDataGridViewTextBoxEditingControl;
    function    GetDefaultInterface: _DataGridViewTextBoxEditingControl;
    constructor Create(AServer: TDataGridViewTextBoxEditingControl);
  protected
  public
    property DefaultInterface: _DataGridViewTextBoxEditingControl read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoDateTimePicker provides a Create and CreateRemote method to          
// create instances of the default interface _DateTimePicker exposed by              
// the CoClass DateTimePicker. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDateTimePicker = class
    class function Create: _DateTimePicker;
    class function CreateRemote(const MachineName: string): _DateTimePicker;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TDateTimePicker
// Help String      : 
// Default Interface: _DateTimePicker
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TDateTimePickerProperties= class;
{$ENDIF}
  TDateTimePicker = class(TOleServer)
  private
    FIntf:        _DateTimePicker;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TDateTimePickerProperties;
    function      GetServerProperties: TDateTimePickerProperties;
{$ENDIF}
    function      GetDefaultInterface: _DateTimePicker;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _DateTimePicker);
    procedure Disconnect; override;
    property DefaultInterface: _DateTimePicker read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TDateTimePickerProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TDateTimePicker
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TDateTimePickerProperties = class(TPersistent)
  private
    FServer:    TDateTimePicker;
    function    GetDefaultInterface: _DateTimePicker;
    constructor Create(AServer: TDateTimePicker);
  protected
  public
    property DefaultInterface: _DateTimePicker read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoDateTimePickerAccessibleObject provides a Create and CreateRemote method to          
// create instances of the default interface _DateTimePickerAccessibleObject exposed by              
// the CoClass DateTimePickerAccessibleObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDateTimePickerAccessibleObject = class
    class function Create: _DateTimePickerAccessibleObject;
    class function CreateRemote(const MachineName: string): _DateTimePickerAccessibleObject;
  end;

// *********************************************************************//
// The Class CoDomainUpDown provides a Create and CreateRemote method to          
// create instances of the default interface _DomainUpDown exposed by              
// the CoClass DomainUpDown. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDomainUpDown = class
    class function Create: _DomainUpDown;
    class function CreateRemote(const MachineName: string): _DomainUpDown;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TDomainUpDown
// Help String      : 
// Default Interface: _DomainUpDown
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TDomainUpDownProperties= class;
{$ENDIF}
  TDomainUpDown = class(TOleServer)
  private
    FIntf:        _DomainUpDown;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TDomainUpDownProperties;
    function      GetServerProperties: TDomainUpDownProperties;
{$ENDIF}
    function      GetDefaultInterface: _DomainUpDown;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _DomainUpDown);
    procedure Disconnect; override;
    property DefaultInterface: _DomainUpDown read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TDomainUpDownProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TDomainUpDown
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TDomainUpDownProperties = class(TPersistent)
  private
    FServer:    TDomainUpDown;
    function    GetDefaultInterface: _DomainUpDown;
    constructor Create(AServer: TDomainUpDown);
  protected
  public
    property DefaultInterface: _DomainUpDown read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoUpDownBase provides a Create and CreateRemote method to          
// create instances of the default interface _UpDownBase exposed by              
// the CoClass UpDownBase. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoUpDownBase = class
    class function Create: _UpDownBase;
    class function CreateRemote(const MachineName: string): _UpDownBase;
  end;

// *********************************************************************//
// The Class CoDomainItemAccessibleObject provides a Create and CreateRemote method to          
// create instances of the default interface _DomainItemAccessibleObject exposed by              
// the CoClass DomainItemAccessibleObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDomainItemAccessibleObject = class
    class function Create: _DomainItemAccessibleObject;
    class function CreateRemote(const MachineName: string): _DomainItemAccessibleObject;
  end;

// *********************************************************************//
// The Class CoDomainUpDownAccessibleObject provides a Create and CreateRemote method to          
// create instances of the default interface _DomainUpDownAccessibleObject exposed by              
// the CoClass DomainUpDownAccessibleObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDomainUpDownAccessibleObject = class
    class function Create: _DomainUpDownAccessibleObject;
    class function CreateRemote(const MachineName: string): _DomainUpDownAccessibleObject;
  end;

// *********************************************************************//
// The Class CoFlowLayoutPanel provides a Create and CreateRemote method to          
// create instances of the default interface _FlowLayoutPanel exposed by              
// the CoClass FlowLayoutPanel. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoFlowLayoutPanel = class
    class function Create: _FlowLayoutPanel;
    class function CreateRemote(const MachineName: string): _FlowLayoutPanel;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TFlowLayoutPanel
// Help String      : 
// Default Interface: _FlowLayoutPanel
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TFlowLayoutPanelProperties= class;
{$ENDIF}
  TFlowLayoutPanel = class(TOleServer)
  private
    FIntf:        _FlowLayoutPanel;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TFlowLayoutPanelProperties;
    function      GetServerProperties: TFlowLayoutPanelProperties;
{$ENDIF}
    function      GetDefaultInterface: _FlowLayoutPanel;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _FlowLayoutPanel);
    procedure Disconnect; override;
    property DefaultInterface: _FlowLayoutPanel read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TFlowLayoutPanelProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TFlowLayoutPanel
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TFlowLayoutPanelProperties = class(TPersistent)
  private
    FServer:    TFlowLayoutPanel;
    function    GetDefaultInterface: _FlowLayoutPanel;
    constructor Create(AServer: TFlowLayoutPanel);
  protected
  public
    property DefaultInterface: _FlowLayoutPanel read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoMenuStrip provides a Create and CreateRemote method to          
// create instances of the default interface _MenuStrip exposed by              
// the CoClass MenuStrip. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoMenuStrip = class
    class function Create: _MenuStrip;
    class function CreateRemote(const MachineName: string): _MenuStrip;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TMenuStrip
// Help String      : 
// Default Interface: _MenuStrip
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TMenuStripProperties= class;
{$ENDIF}
  TMenuStrip = class(TOleServer)
  private
    FIntf:        _MenuStrip;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TMenuStripProperties;
    function      GetServerProperties: TMenuStripProperties;
{$ENDIF}
    function      GetDefaultInterface: _MenuStrip;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _MenuStrip);
    procedure Disconnect; override;
    property DefaultInterface: _MenuStrip read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TMenuStripProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TMenuStrip
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TMenuStripProperties = class(TPersistent)
  private
    FServer:    TMenuStrip;
    function    GetDefaultInterface: _MenuStrip;
    constructor Create(AServer: TMenuStrip);
  protected
  public
    property DefaultInterface: _MenuStrip read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoGroupBox provides a Create and CreateRemote method to          
// create instances of the default interface _GroupBox exposed by              
// the CoClass GroupBox. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoGroupBox = class
    class function Create: _GroupBox;
    class function CreateRemote(const MachineName: string): _GroupBox;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TGroupBox
// Help String      : 
// Default Interface: _GroupBox
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TGroupBoxProperties= class;
{$ENDIF}
  TGroupBox = class(TOleServer)
  private
    FIntf:        _GroupBox;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TGroupBoxProperties;
    function      GetServerProperties: TGroupBoxProperties;
{$ENDIF}
    function      GetDefaultInterface: _GroupBox;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _GroupBox);
    procedure Disconnect; override;
    property DefaultInterface: _GroupBox read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TGroupBoxProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TGroupBox
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TGroupBoxProperties = class(TPersistent)
  private
    FServer:    TGroupBox;
    function    GetDefaultInterface: _GroupBox;
    constructor Create(AServer: TGroupBox);
  protected
  public
    property DefaultInterface: _GroupBox read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoHScrollBar provides a Create and CreateRemote method to          
// create instances of the default interface _HScrollBar exposed by              
// the CoClass HScrollBar. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoHScrollBar = class
    class function Create: _HScrollBar;
    class function CreateRemote(const MachineName: string): _HScrollBar;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : THScrollBar
// Help String      : 
// Default Interface: _HScrollBar
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  THScrollBarProperties= class;
{$ENDIF}
  THScrollBar = class(TOleServer)
  private
    FIntf:        _HScrollBar;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       THScrollBarProperties;
    function      GetServerProperties: THScrollBarProperties;
{$ENDIF}
    function      GetDefaultInterface: _HScrollBar;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _HScrollBar);
    procedure Disconnect; override;
    property DefaultInterface: _HScrollBar read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: THScrollBarProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : THScrollBar
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 THScrollBarProperties = class(TPersistent)
  private
    FServer:    THScrollBar;
    function    GetDefaultInterface: _HScrollBar;
    constructor Create(AServer: THScrollBar);
  protected
  public
    property DefaultInterface: _HScrollBar read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoItemDragEventArgs provides a Create and CreateRemote method to          
// create instances of the default interface _ItemDragEventArgs exposed by              
// the CoClass ItemDragEventArgs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoItemDragEventArgs = class
    class function Create: _ItemDragEventArgs;
    class function CreateRemote(const MachineName: string): _ItemDragEventArgs;
  end;

// *********************************************************************//
// The Class CoLabel_ provides a Create and CreateRemote method to          
// create instances of the default interface _Label exposed by              
// the CoClass Label_. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLabel_ = class
    class function Create: _Label;
    class function CreateRemote(const MachineName: string): _Label;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TLabel
// Help String      : 
// Default Interface: _Label
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TLabelProperties= class;
{$ENDIF}
  TLabel = class(TOleServer)
  private
    FIntf:        _Label;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TLabelProperties;
    function      GetServerProperties: TLabelProperties;
{$ENDIF}
    function      GetDefaultInterface: _Label;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _Label);
    procedure Disconnect; override;
    property DefaultInterface: _Label read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TLabelProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TLabel
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TLabelProperties = class(TPersistent)
  private
    FServer:    TLabel;
    function    GetDefaultInterface: _Label;
    constructor Create(AServer: TLabel);
  protected
  public
    property DefaultInterface: _Label read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoLinkClickedEventArgs provides a Create and CreateRemote method to          
// create instances of the default interface _LinkClickedEventArgs exposed by              
// the CoClass LinkClickedEventArgs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLinkClickedEventArgs = class
    class function Create: _LinkClickedEventArgs;
    class function CreateRemote(const MachineName: string): _LinkClickedEventArgs;
  end;

// *********************************************************************//
// The Class CoLinkLabel provides a Create and CreateRemote method to          
// create instances of the default interface _LinkLabel exposed by              
// the CoClass LinkLabel. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLinkLabel = class
    class function Create: _LinkLabel;
    class function CreateRemote(const MachineName: string): _LinkLabel;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TLinkLabel
// Help String      : 
// Default Interface: _LinkLabel
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TLinkLabelProperties= class;
{$ENDIF}
  TLinkLabel = class(TOleServer)
  private
    FIntf:        _LinkLabel;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TLinkLabelProperties;
    function      GetServerProperties: TLinkLabelProperties;
{$ENDIF}
    function      GetDefaultInterface: _LinkLabel;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _LinkLabel);
    procedure Disconnect; override;
    property DefaultInterface: _LinkLabel read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TLinkLabelProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TLinkLabel
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TLinkLabelProperties = class(TPersistent)
  private
    FServer:    TLinkLabel;
    function    GetDefaultInterface: _LinkLabel;
    constructor Create(AServer: TLinkLabel);
  protected
  public
    property DefaultInterface: _LinkLabel read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoLinkLabelLinkClickedEventArgs provides a Create and CreateRemote method to          
// create instances of the default interface _LinkLabelLinkClickedEventArgs exposed by              
// the CoClass LinkLabelLinkClickedEventArgs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLinkLabelLinkClickedEventArgs = class
    class function Create: _LinkLabelLinkClickedEventArgs;
    class function CreateRemote(const MachineName: string): _LinkLabelLinkClickedEventArgs;
  end;

// *********************************************************************//
// The Class CoListViewItemMouseHoverEventArgs provides a Create and CreateRemote method to          
// create instances of the default interface _ListViewItemMouseHoverEventArgs exposed by              
// the CoClass ListViewItemMouseHoverEventArgs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoListViewItemMouseHoverEventArgs = class
    class function Create: _ListViewItemMouseHoverEventArgs;
    class function CreateRemote(const MachineName: string): _ListViewItemMouseHoverEventArgs;
  end;

// *********************************************************************//
// The Class CoMaskedTextBox provides a Create and CreateRemote method to          
// create instances of the default interface _MaskedTextBox exposed by              
// the CoClass MaskedTextBox. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoMaskedTextBox = class
    class function Create: _MaskedTextBox;
    class function CreateRemote(const MachineName: string): _MaskedTextBox;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TMaskedTextBox
// Help String      : 
// Default Interface: _MaskedTextBox
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TMaskedTextBoxProperties= class;
{$ENDIF}
  TMaskedTextBox = class(TOleServer)
  private
    FIntf:        _MaskedTextBox;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TMaskedTextBoxProperties;
    function      GetServerProperties: TMaskedTextBoxProperties;
{$ENDIF}
    function      GetDefaultInterface: _MaskedTextBox;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _MaskedTextBox);
    procedure Disconnect; override;
    property DefaultInterface: _MaskedTextBox read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TMaskedTextBoxProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TMaskedTextBox
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TMaskedTextBoxProperties = class(TPersistent)
  private
    FServer:    TMaskedTextBox;
    function    GetDefaultInterface: _MaskedTextBox;
    constructor Create(AServer: TMaskedTextBox);
  protected
  public
    property DefaultInterface: _MaskedTextBox read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoTextBoxBase provides a Create and CreateRemote method to          
// create instances of the default interface _TextBoxBase exposed by              
// the CoClass TextBoxBase. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTextBoxBase = class
    class function Create: _TextBoxBase;
    class function CreateRemote(const MachineName: string): _TextBoxBase;
  end;

// *********************************************************************//
// The Class CoMdiClient provides a Create and CreateRemote method to          
// create instances of the default interface _MdiClient exposed by              
// the CoClass MdiClient. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoMdiClient = class
    class function Create: _MdiClient;
    class function CreateRemote(const MachineName: string): _MdiClient;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TMdiClient
// Help String      : 
// Default Interface: _MdiClient
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TMdiClientProperties= class;
{$ENDIF}
  TMdiClient = class(TOleServer)
  private
    FIntf:        _MdiClient;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TMdiClientProperties;
    function      GetServerProperties: TMdiClientProperties;
{$ENDIF}
    function      GetDefaultInterface: _MdiClient;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _MdiClient);
    procedure Disconnect; override;
    property DefaultInterface: _MdiClient read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TMdiClientProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TMdiClient
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TMdiClientProperties = class(TPersistent)
  private
    FServer:    TMdiClient;
    function    GetDefaultInterface: _MdiClient;
    constructor Create(AServer: TMdiClient);
  protected
  public
    property DefaultInterface: _MdiClient read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoMonthCalendar provides a Create and CreateRemote method to          
// create instances of the default interface _MonthCalendar exposed by              
// the CoClass MonthCalendar. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoMonthCalendar = class
    class function Create: _MonthCalendar;
    class function CreateRemote(const MachineName: string): _MonthCalendar;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TMonthCalendar
// Help String      : 
// Default Interface: _MonthCalendar
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TMonthCalendarProperties= class;
{$ENDIF}
  TMonthCalendar = class(TOleServer)
  private
    FIntf:        _MonthCalendar;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TMonthCalendarProperties;
    function      GetServerProperties: TMonthCalendarProperties;
{$ENDIF}
    function      GetDefaultInterface: _MonthCalendar;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _MonthCalendar);
    procedure Disconnect; override;
    property DefaultInterface: _MonthCalendar read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TMonthCalendarProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TMonthCalendar
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TMonthCalendarProperties = class(TPersistent)
  private
    FServer:    TMonthCalendar;
    function    GetDefaultInterface: _MonthCalendar;
    constructor Create(AServer: TMonthCalendar);
  protected
  public
    property DefaultInterface: _MonthCalendar read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoNumericUpDown provides a Create and CreateRemote method to          
// create instances of the default interface _NumericUpDown exposed by              
// the CoClass NumericUpDown. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoNumericUpDown = class
    class function Create: _NumericUpDown;
    class function CreateRemote(const MachineName: string): _NumericUpDown;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TNumericUpDown
// Help String      : 
// Default Interface: _NumericUpDown
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TNumericUpDownProperties= class;
{$ENDIF}
  TNumericUpDown = class(TOleServer)
  private
    FIntf:        _NumericUpDown;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TNumericUpDownProperties;
    function      GetServerProperties: TNumericUpDownProperties;
{$ENDIF}
    function      GetDefaultInterface: _NumericUpDown;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _NumericUpDown);
    procedure Disconnect; override;
    property DefaultInterface: _NumericUpDown read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TNumericUpDownProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TNumericUpDown
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TNumericUpDownProperties = class(TPersistent)
  private
    FServer:    TNumericUpDown;
    function    GetDefaultInterface: _NumericUpDown;
    constructor Create(AServer: TNumericUpDown);
  protected
  public
    property DefaultInterface: _NumericUpDown read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoPictureBox provides a Create and CreateRemote method to          
// create instances of the default interface _PictureBox exposed by              
// the CoClass PictureBox. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPictureBox = class
    class function Create: _PictureBox;
    class function CreateRemote(const MachineName: string): _PictureBox;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TPictureBox
// Help String      : 
// Default Interface: _PictureBox
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TPictureBoxProperties= class;
{$ENDIF}
  TPictureBox = class(TOleServer)
  private
    FIntf:        _PictureBox;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TPictureBoxProperties;
    function      GetServerProperties: TPictureBoxProperties;
{$ENDIF}
    function      GetDefaultInterface: _PictureBox;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _PictureBox);
    procedure Disconnect; override;
    property DefaultInterface: _PictureBox read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TPictureBoxProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TPictureBox
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TPictureBoxProperties = class(TPersistent)
  private
    FServer:    TPictureBox;
    function    GetDefaultInterface: _PictureBox;
    constructor Create(AServer: TPictureBox);
  protected
  public
    property DefaultInterface: _PictureBox read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoPrintPreviewControl provides a Create and CreateRemote method to          
// create instances of the default interface _PrintPreviewControl exposed by              
// the CoClass PrintPreviewControl. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPrintPreviewControl = class
    class function Create: _PrintPreviewControl;
    class function CreateRemote(const MachineName: string): _PrintPreviewControl;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TPrintPreviewControl
// Help String      : 
// Default Interface: _PrintPreviewControl
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TPrintPreviewControlProperties= class;
{$ENDIF}
  TPrintPreviewControl = class(TOleServer)
  private
    FIntf:        _PrintPreviewControl;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TPrintPreviewControlProperties;
    function      GetServerProperties: TPrintPreviewControlProperties;
{$ENDIF}
    function      GetDefaultInterface: _PrintPreviewControl;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _PrintPreviewControl);
    procedure Disconnect; override;
    property DefaultInterface: _PrintPreviewControl read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TPrintPreviewControlProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TPrintPreviewControl
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TPrintPreviewControlProperties = class(TPersistent)
  private
    FServer:    TPrintPreviewControl;
    function    GetDefaultInterface: _PrintPreviewControl;
    constructor Create(AServer: TPrintPreviewControl);
  protected
  public
    property DefaultInterface: _PrintPreviewControl read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoPrintPreviewDialog provides a Create and CreateRemote method to          
// create instances of the default interface _PrintPreviewDialog exposed by              
// the CoClass PrintPreviewDialog. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPrintPreviewDialog = class
    class function Create: _PrintPreviewDialog;
    class function CreateRemote(const MachineName: string): _PrintPreviewDialog;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TPrintPreviewDialog
// Help String      : 
// Default Interface: _PrintPreviewDialog
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TPrintPreviewDialogProperties= class;
{$ENDIF}
  TPrintPreviewDialog = class(TOleServer)
  private
    FIntf:        _PrintPreviewDialog;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TPrintPreviewDialogProperties;
    function      GetServerProperties: TPrintPreviewDialogProperties;
{$ENDIF}
    function      GetDefaultInterface: _PrintPreviewDialog;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _PrintPreviewDialog);
    procedure Disconnect; override;
    property DefaultInterface: _PrintPreviewDialog read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TPrintPreviewDialogProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TPrintPreviewDialog
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TPrintPreviewDialogProperties = class(TPersistent)
  private
    FServer:    TPrintPreviewDialog;
    function    GetDefaultInterface: _PrintPreviewDialog;
    constructor Create(AServer: TPrintPreviewDialog);
  protected
  public
    property DefaultInterface: _PrintPreviewDialog read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoProgressBar provides a Create and CreateRemote method to          
// create instances of the default interface _ProgressBar exposed by              
// the CoClass ProgressBar. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoProgressBar = class
    class function Create: _ProgressBar;
    class function CreateRemote(const MachineName: string): _ProgressBar;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TProgressBar
// Help String      : 
// Default Interface: _ProgressBar
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TProgressBarProperties= class;
{$ENDIF}
  TProgressBar = class(TOleServer)
  private
    FIntf:        _ProgressBar;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TProgressBarProperties;
    function      GetServerProperties: TProgressBarProperties;
{$ENDIF}
    function      GetDefaultInterface: _ProgressBar;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _ProgressBar);
    procedure Disconnect; override;
    property DefaultInterface: _ProgressBar read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TProgressBarProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TProgressBar
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TProgressBarProperties = class(TPersistent)
  private
    FServer:    TProgressBar;
    function    GetDefaultInterface: _ProgressBar;
    constructor Create(AServer: TProgressBar);
  protected
  public
    property DefaultInterface: _ProgressBar read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoPropertyGrid provides a Create and CreateRemote method to          
// create instances of the default interface _PropertyGrid exposed by              
// the CoClass PropertyGrid. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPropertyGrid = class
    class function Create: _PropertyGrid;
    class function CreateRemote(const MachineName: string): _PropertyGrid;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TPropertyGrid
// Help String      : 
// Default Interface: _PropertyGrid
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TPropertyGridProperties= class;
{$ENDIF}
  TPropertyGrid = class(TOleServer)
  private
    FIntf:        _PropertyGrid;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TPropertyGridProperties;
    function      GetServerProperties: TPropertyGridProperties;
{$ENDIF}
    function      GetDefaultInterface: _PropertyGrid;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _PropertyGrid);
    procedure Disconnect; override;
    property DefaultInterface: _PropertyGrid read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TPropertyGridProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TPropertyGrid
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TPropertyGridProperties = class(TPersistent)
  private
    FServer:    TPropertyGrid;
    function    GetDefaultInterface: _PropertyGrid;
    constructor Create(AServer: TPropertyGrid);
  protected
  public
    property DefaultInterface: _PropertyGrid read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoPropertyTabChangedEventArgs provides a Create and CreateRemote method to          
// create instances of the default interface _PropertyTabChangedEventArgs exposed by              
// the CoClass PropertyTabChangedEventArgs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPropertyTabChangedEventArgs = class
    class function Create: _PropertyTabChangedEventArgs;
    class function CreateRemote(const MachineName: string): _PropertyTabChangedEventArgs;
  end;

// *********************************************************************//
// The Class CoPropertyValueChangedEventArgs provides a Create and CreateRemote method to          
// create instances of the default interface _PropertyValueChangedEventArgs exposed by              
// the CoClass PropertyValueChangedEventArgs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPropertyValueChangedEventArgs = class
    class function Create: _PropertyValueChangedEventArgs;
    class function CreateRemote(const MachineName: string): _PropertyValueChangedEventArgs;
  end;

// *********************************************************************//
// The Class CoQueryAccessibilityHelpEventArgs provides a Create and CreateRemote method to          
// create instances of the default interface _QueryAccessibilityHelpEventArgs exposed by              
// the CoClass QueryAccessibilityHelpEventArgs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoQueryAccessibilityHelpEventArgs = class
    class function Create: _QueryAccessibilityHelpEventArgs;
    class function CreateRemote(const MachineName: string): _QueryAccessibilityHelpEventArgs;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TQueryAccessibilityHelpEventArgs
// Help String      : 
// Default Interface: _QueryAccessibilityHelpEventArgs
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TQueryAccessibilityHelpEventArgsProperties= class;
{$ENDIF}
  TQueryAccessibilityHelpEventArgs = class(TOleServer)
  private
    FIntf:        _QueryAccessibilityHelpEventArgs;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TQueryAccessibilityHelpEventArgsProperties;
    function      GetServerProperties: TQueryAccessibilityHelpEventArgsProperties;
{$ENDIF}
    function      GetDefaultInterface: _QueryAccessibilityHelpEventArgs;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _QueryAccessibilityHelpEventArgs);
    procedure Disconnect; override;
    property DefaultInterface: _QueryAccessibilityHelpEventArgs read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TQueryAccessibilityHelpEventArgsProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TQueryAccessibilityHelpEventArgs
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TQueryAccessibilityHelpEventArgsProperties = class(TPersistent)
  private
    FServer:    TQueryAccessibilityHelpEventArgs;
    function    GetDefaultInterface: _QueryAccessibilityHelpEventArgs;
    constructor Create(AServer: TQueryAccessibilityHelpEventArgs);
  protected
  public
    property DefaultInterface: _QueryAccessibilityHelpEventArgs read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoRadioButton provides a Create and CreateRemote method to          
// create instances of the default interface _RadioButton exposed by              
// the CoClass RadioButton. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRadioButton = class
    class function Create: _RadioButton;
    class function CreateRemote(const MachineName: string): _RadioButton;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TRadioButton
// Help String      : 
// Default Interface: _RadioButton
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TRadioButtonProperties= class;
{$ENDIF}
  TRadioButton = class(TOleServer)
  private
    FIntf:        _RadioButton;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TRadioButtonProperties;
    function      GetServerProperties: TRadioButtonProperties;
{$ENDIF}
    function      GetDefaultInterface: _RadioButton;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _RadioButton);
    procedure Disconnect; override;
    property DefaultInterface: _RadioButton read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TRadioButtonProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TRadioButton
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TRadioButtonProperties = class(TPersistent)
  private
    FServer:    TRadioButton;
    function    GetDefaultInterface: _RadioButton;
    constructor Create(AServer: TRadioButton);
  protected
  public
    property DefaultInterface: _RadioButton read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoRadioButtonAccessibleObject provides a Create and CreateRemote method to          
// create instances of the default interface _RadioButtonAccessibleObject exposed by              
// the CoClass RadioButtonAccessibleObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRadioButtonAccessibleObject = class
    class function Create: _RadioButtonAccessibleObject;
    class function CreateRemote(const MachineName: string): _RadioButtonAccessibleObject;
  end;

// *********************************************************************//
// The Class CoRichTextBox provides a Create and CreateRemote method to          
// create instances of the default interface _RichTextBox exposed by              
// the CoClass RichTextBox. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRichTextBox = class
    class function Create: _RichTextBox;
    class function CreateRemote(const MachineName: string): _RichTextBox;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TRichTextBox
// Help String      : 
// Default Interface: _RichTextBox
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TRichTextBoxProperties= class;
{$ENDIF}
  TRichTextBox = class(TOleServer)
  private
    FIntf:        _RichTextBox;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TRichTextBoxProperties;
    function      GetServerProperties: TRichTextBoxProperties;
{$ENDIF}
    function      GetDefaultInterface: _RichTextBox;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _RichTextBox);
    procedure Disconnect; override;
    property DefaultInterface: _RichTextBox read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TRichTextBoxProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TRichTextBox
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TRichTextBoxProperties = class(TPersistent)
  private
    FServer:    TRichTextBox;
    function    GetDefaultInterface: _RichTextBox;
    constructor Create(AServer: TRichTextBox);
  protected
  public
    property DefaultInterface: _RichTextBox read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoSplitContainer provides a Create and CreateRemote method to          
// create instances of the default interface _SplitContainer exposed by              
// the CoClass SplitContainer. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSplitContainer = class
    class function Create: _SplitContainer;
    class function CreateRemote(const MachineName: string): _SplitContainer;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TSplitContainer
// Help String      : 
// Default Interface: _SplitContainer
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TSplitContainerProperties= class;
{$ENDIF}
  TSplitContainer = class(TOleServer)
  private
    FIntf:        _SplitContainer;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TSplitContainerProperties;
    function      GetServerProperties: TSplitContainerProperties;
{$ENDIF}
    function      GetDefaultInterface: _SplitContainer;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _SplitContainer);
    procedure Disconnect; override;
    property DefaultInterface: _SplitContainer read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TSplitContainerProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TSplitContainer
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TSplitContainerProperties = class(TPersistent)
  private
    FServer:    TSplitContainer;
    function    GetDefaultInterface: _SplitContainer;
    constructor Create(AServer: TSplitContainer);
  protected
  public
    property DefaultInterface: _SplitContainer read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoSplitterPanel provides a Create and CreateRemote method to          
// create instances of the default interface _SplitterPanel exposed by              
// the CoClass SplitterPanel. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSplitterPanel = class
    class function Create: _SplitterPanel;
    class function CreateRemote(const MachineName: string): _SplitterPanel;
  end;

// *********************************************************************//
// The Class CoSplitterEventArgs provides a Create and CreateRemote method to          
// create instances of the default interface _SplitterEventArgs exposed by              
// the CoClass SplitterEventArgs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSplitterEventArgs = class
    class function Create: _SplitterEventArgs;
    class function CreateRemote(const MachineName: string): _SplitterEventArgs;
  end;

// *********************************************************************//
// The Class CoSplitter provides a Create and CreateRemote method to          
// create instances of the default interface _Splitter exposed by              
// the CoClass Splitter. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSplitter = class
    class function Create: _Splitter;
    class function CreateRemote(const MachineName: string): _Splitter;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TSplitter
// Help String      : 
// Default Interface: _Splitter
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TSplitterProperties= class;
{$ENDIF}
  TSplitter = class(TOleServer)
  private
    FIntf:        _Splitter;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TSplitterProperties;
    function      GetServerProperties: TSplitterProperties;
{$ENDIF}
    function      GetDefaultInterface: _Splitter;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _Splitter);
    procedure Disconnect; override;
    property DefaultInterface: _Splitter read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TSplitterProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TSplitter
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TSplitterProperties = class(TPersistent)
  private
    FServer:    TSplitter;
    function    GetDefaultInterface: _Splitter;
    constructor Create(AServer: TSplitter);
  protected
  public
    property DefaultInterface: _Splitter read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoStatusBar provides a Create and CreateRemote method to          
// create instances of the default interface _StatusBar exposed by              
// the CoClass StatusBar. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoStatusBar = class
    class function Create: _StatusBar;
    class function CreateRemote(const MachineName: string): _StatusBar;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TStatusBar
// Help String      : 
// Default Interface: _StatusBar
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TStatusBarProperties= class;
{$ENDIF}
  TStatusBar = class(TOleServer)
  private
    FIntf:        _StatusBar;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TStatusBarProperties;
    function      GetServerProperties: TStatusBarProperties;
{$ENDIF}
    function      GetDefaultInterface: _StatusBar;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _StatusBar);
    procedure Disconnect; override;
    property DefaultInterface: _StatusBar read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TStatusBarProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TStatusBar
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TStatusBarProperties = class(TPersistent)
  private
    FServer:    TStatusBar;
    function    GetDefaultInterface: _StatusBar;
    constructor Create(AServer: TStatusBar);
  protected
  public
    property DefaultInterface: _StatusBar read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoStatusStrip provides a Create and CreateRemote method to          
// create instances of the default interface _StatusStrip exposed by              
// the CoClass StatusStrip. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoStatusStrip = class
    class function Create: _StatusStrip;
    class function CreateRemote(const MachineName: string): _StatusStrip;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TStatusStrip
// Help String      : 
// Default Interface: _StatusStrip
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TStatusStripProperties= class;
{$ENDIF}
  TStatusStrip = class(TOleServer)
  private
    FIntf:        _StatusStrip;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TStatusStripProperties;
    function      GetServerProperties: TStatusStripProperties;
{$ENDIF}
    function      GetDefaultInterface: _StatusStrip;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _StatusStrip);
    procedure Disconnect; override;
    property DefaultInterface: _StatusStrip read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TStatusStripProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TStatusStrip
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TStatusStripProperties = class(TPersistent)
  private
    FServer:    TStatusStrip;
    function    GetDefaultInterface: _StatusStrip;
    constructor Create(AServer: TStatusStrip);
  protected
  public
    property DefaultInterface: _StatusStrip read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoTabControl provides a Create and CreateRemote method to          
// create instances of the default interface _TabControl exposed by              
// the CoClass TabControl. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTabControl = class
    class function Create: _TabControl;
    class function CreateRemote(const MachineName: string): _TabControl;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TTabControl
// Help String      : 
// Default Interface: _TabControl
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TTabControlProperties= class;
{$ENDIF}
  TTabControl = class(TOleServer)
  private
    FIntf:        _TabControl;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TTabControlProperties;
    function      GetServerProperties: TTabControlProperties;
{$ENDIF}
    function      GetDefaultInterface: _TabControl;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _TabControl);
    procedure Disconnect; override;
    property DefaultInterface: _TabControl read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TTabControlProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TTabControl
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TTabControlProperties = class(TPersistent)
  private
    FServer:    TTabControl;
    function    GetDefaultInterface: _TabControl;
    constructor Create(AServer: TTabControl);
  protected
  public
    property DefaultInterface: _TabControl read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoTabPage provides a Create and CreateRemote method to          
// create instances of the default interface _TabPage exposed by              
// the CoClass TabPage. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTabPage = class
    class function Create: _TabPage;
    class function CreateRemote(const MachineName: string): _TabPage;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TTabPage
// Help String      : 
// Default Interface: _TabPage
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TTabPageProperties= class;
{$ENDIF}
  TTabPage = class(TOleServer)
  private
    FIntf:        _TabPage;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TTabPageProperties;
    function      GetServerProperties: TTabPageProperties;
{$ENDIF}
    function      GetDefaultInterface: _TabPage;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _TabPage);
    procedure Disconnect; override;
    property DefaultInterface: _TabPage read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TTabPageProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TTabPage
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TTabPageProperties = class(TPersistent)
  private
    FServer:    TTabPage;
    function    GetDefaultInterface: _TabPage;
    constructor Create(AServer: TTabPage);
  protected
  public
    property DefaultInterface: _TabPage read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoTableLayoutPanel provides a Create and CreateRemote method to          
// create instances of the default interface _TableLayoutPanel exposed by              
// the CoClass TableLayoutPanel. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTableLayoutPanel = class
    class function Create: _TableLayoutPanel;
    class function CreateRemote(const MachineName: string): _TableLayoutPanel;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TTableLayoutPanel
// Help String      : 
// Default Interface: _TableLayoutPanel
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TTableLayoutPanelProperties= class;
{$ENDIF}
  TTableLayoutPanel = class(TOleServer)
  private
    FIntf:        _TableLayoutPanel;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TTableLayoutPanelProperties;
    function      GetServerProperties: TTableLayoutPanelProperties;
{$ENDIF}
    function      GetDefaultInterface: _TableLayoutPanel;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _TableLayoutPanel);
    procedure Disconnect; override;
    property DefaultInterface: _TableLayoutPanel read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TTableLayoutPanelProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TTableLayoutPanel
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TTableLayoutPanelProperties = class(TPersistent)
  private
    FServer:    TTableLayoutPanel;
    function    GetDefaultInterface: _TableLayoutPanel;
    constructor Create(AServer: TTableLayoutPanel);
  protected
  public
    property DefaultInterface: _TableLayoutPanel read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoThreadExceptionDialog provides a Create and CreateRemote method to          
// create instances of the default interface _ThreadExceptionDialog exposed by              
// the CoClass ThreadExceptionDialog. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoThreadExceptionDialog = class
    class function Create: _ThreadExceptionDialog;
    class function CreateRemote(const MachineName: string): _ThreadExceptionDialog;
  end;

// *********************************************************************//
// The Class CoToolBar provides a Create and CreateRemote method to          
// create instances of the default interface _ToolBar exposed by              
// the CoClass ToolBar. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoToolBar = class
    class function Create: _ToolBar;
    class function CreateRemote(const MachineName: string): _ToolBar;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TToolBar
// Help String      : 
// Default Interface: _ToolBar
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TToolBarProperties= class;
{$ENDIF}
  TToolBar = class(TOleServer)
  private
    FIntf:        _ToolBar;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TToolBarProperties;
    function      GetServerProperties: TToolBarProperties;
{$ENDIF}
    function      GetDefaultInterface: _ToolBar;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _ToolBar);
    procedure Disconnect; override;
    property DefaultInterface: _ToolBar read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TToolBarProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TToolBar
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TToolBarProperties = class(TPersistent)
  private
    FServer:    TToolBar;
    function    GetDefaultInterface: _ToolBar;
    constructor Create(AServer: TToolBar);
  protected
  public
    property DefaultInterface: _ToolBar read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoToolStripAccessibleObject provides a Create and CreateRemote method to          
// create instances of the default interface _ToolStripAccessibleObject exposed by              
// the CoClass ToolStripAccessibleObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoToolStripAccessibleObject = class
    class function Create: _ToolStripAccessibleObject;
    class function CreateRemote(const MachineName: string): _ToolStripAccessibleObject;
  end;

// *********************************************************************//
// The Class CoToolStripContainer provides a Create and CreateRemote method to          
// create instances of the default interface _ToolStripContainer exposed by              
// the CoClass ToolStripContainer. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoToolStripContainer = class
    class function Create: _ToolStripContainer;
    class function CreateRemote(const MachineName: string): _ToolStripContainer;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TToolStripContainer
// Help String      : 
// Default Interface: _ToolStripContainer
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TToolStripContainerProperties= class;
{$ENDIF}
  TToolStripContainer = class(TOleServer)
  private
    FIntf:        _ToolStripContainer;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TToolStripContainerProperties;
    function      GetServerProperties: TToolStripContainerProperties;
{$ENDIF}
    function      GetDefaultInterface: _ToolStripContainer;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _ToolStripContainer);
    procedure Disconnect; override;
    property DefaultInterface: _ToolStripContainer read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TToolStripContainerProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TToolStripContainer
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TToolStripContainerProperties = class(TPersistent)
  private
    FServer:    TToolStripContainer;
    function    GetDefaultInterface: _ToolStripContainer;
    constructor Create(AServer: TToolStripContainer);
  protected
  public
    property DefaultInterface: _ToolStripContainer read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoToolStripPanel provides a Create and CreateRemote method to          
// create instances of the default interface _ToolStripPanel exposed by              
// the CoClass ToolStripPanel. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoToolStripPanel = class
    class function Create: _ToolStripPanel;
    class function CreateRemote(const MachineName: string): _ToolStripPanel;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TToolStripPanel
// Help String      : 
// Default Interface: _ToolStripPanel
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TToolStripPanelProperties= class;
{$ENDIF}
  TToolStripPanel = class(TOleServer)
  private
    FIntf:        _ToolStripPanel;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TToolStripPanelProperties;
    function      GetServerProperties: TToolStripPanelProperties;
{$ENDIF}
    function      GetDefaultInterface: _ToolStripPanel;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _ToolStripPanel);
    procedure Disconnect; override;
    property DefaultInterface: _ToolStripPanel read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TToolStripPanelProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TToolStripPanel
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TToolStripPanelProperties = class(TPersistent)
  private
    FServer:    TToolStripPanel;
    function    GetDefaultInterface: _ToolStripPanel;
    constructor Create(AServer: TToolStripPanel);
  protected
  public
    property DefaultInterface: _ToolStripPanel read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoToolStripContentPanel provides a Create and CreateRemote method to          
// create instances of the default interface _ToolStripContentPanel exposed by              
// the CoClass ToolStripContentPanel. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoToolStripContentPanel = class
    class function Create: _ToolStripContentPanel;
    class function CreateRemote(const MachineName: string): _ToolStripContentPanel;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TToolStripContentPanel
// Help String      : 
// Default Interface: _ToolStripContentPanel
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TToolStripContentPanelProperties= class;
{$ENDIF}
  TToolStripContentPanel = class(TOleServer)
  private
    FIntf:        _ToolStripContentPanel;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TToolStripContentPanelProperties;
    function      GetServerProperties: TToolStripContentPanelProperties;
{$ENDIF}
    function      GetDefaultInterface: _ToolStripContentPanel;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _ToolStripContentPanel);
    procedure Disconnect; override;
    property DefaultInterface: _ToolStripContentPanel read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TToolStripContentPanelProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TToolStripContentPanel
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TToolStripContentPanelProperties = class(TPersistent)
  private
    FServer:    TToolStripContentPanel;
    function    GetDefaultInterface: _ToolStripContentPanel;
    constructor Create(AServer: TToolStripContentPanel);
  protected
  public
    property DefaultInterface: _ToolStripContentPanel read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoToolStripDropDown provides a Create and CreateRemote method to          
// create instances of the default interface _ToolStripDropDown exposed by              
// the CoClass ToolStripDropDown. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoToolStripDropDown = class
    class function Create: _ToolStripDropDown;
    class function CreateRemote(const MachineName: string): _ToolStripDropDown;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TToolStripDropDown
// Help String      : 
// Default Interface: _ToolStripDropDown
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TToolStripDropDownProperties= class;
{$ENDIF}
  TToolStripDropDown = class(TOleServer)
  private
    FIntf:        _ToolStripDropDown;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TToolStripDropDownProperties;
    function      GetServerProperties: TToolStripDropDownProperties;
{$ENDIF}
    function      GetDefaultInterface: _ToolStripDropDown;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _ToolStripDropDown);
    procedure Disconnect; override;
    property DefaultInterface: _ToolStripDropDown read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TToolStripDropDownProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TToolStripDropDown
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TToolStripDropDownProperties = class(TPersistent)
  private
    FServer:    TToolStripDropDown;
    function    GetDefaultInterface: _ToolStripDropDown;
    constructor Create(AServer: TToolStripDropDown);
  protected
  public
    property DefaultInterface: _ToolStripDropDown read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoToolStripDropDownAccessibleObject provides a Create and CreateRemote method to          
// create instances of the default interface _ToolStripDropDownAccessibleObject exposed by              
// the CoClass ToolStripDropDownAccessibleObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoToolStripDropDownAccessibleObject = class
    class function Create: _ToolStripDropDownAccessibleObject;
    class function CreateRemote(const MachineName: string): _ToolStripDropDownAccessibleObject;
  end;

// *********************************************************************//
// The Class CoToolStripItemAccessibleObject provides a Create and CreateRemote method to          
// create instances of the default interface _ToolStripItemAccessibleObject exposed by              
// the CoClass ToolStripItemAccessibleObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoToolStripItemAccessibleObject = class
    class function Create: _ToolStripItemAccessibleObject;
    class function CreateRemote(const MachineName: string): _ToolStripItemAccessibleObject;
  end;

// *********************************************************************//
// The Class CoToolStripOverflow provides a Create and CreateRemote method to          
// create instances of the default interface _ToolStripOverflow exposed by              
// the CoClass ToolStripOverflow. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoToolStripOverflow = class
    class function Create: _ToolStripOverflow;
    class function CreateRemote(const MachineName: string): _ToolStripOverflow;
  end;

// *********************************************************************//
// The Class CoTrackBar provides a Create and CreateRemote method to          
// create instances of the default interface _TrackBar exposed by              
// the CoClass TrackBar. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTrackBar = class
    class function Create: _TrackBar;
    class function CreateRemote(const MachineName: string): _TrackBar;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TTrackBar
// Help String      : 
// Default Interface: _TrackBar
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TTrackBarProperties= class;
{$ENDIF}
  TTrackBar = class(TOleServer)
  private
    FIntf:        _TrackBar;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TTrackBarProperties;
    function      GetServerProperties: TTrackBarProperties;
{$ENDIF}
    function      GetDefaultInterface: _TrackBar;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _TrackBar);
    procedure Disconnect; override;
    property DefaultInterface: _TrackBar read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TTrackBarProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TTrackBar
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TTrackBarProperties = class(TPersistent)
  private
    FServer:    TTrackBar;
    function    GetDefaultInterface: _TrackBar;
    constructor Create(AServer: TTrackBar);
  protected
  public
    property DefaultInterface: _TrackBar read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoTreeView provides a Create and CreateRemote method to          
// create instances of the default interface _TreeView exposed by              
// the CoClass TreeView. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTreeView = class
    class function Create: _TreeView;
    class function CreateRemote(const MachineName: string): _TreeView;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TTreeView
// Help String      : 
// Default Interface: _TreeView
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TTreeViewProperties= class;
{$ENDIF}
  TTreeView = class(TOleServer)
  private
    FIntf:        _TreeView;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TTreeViewProperties;
    function      GetServerProperties: TTreeViewProperties;
{$ENDIF}
    function      GetDefaultInterface: _TreeView;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _TreeView);
    procedure Disconnect; override;
    property DefaultInterface: _TreeView read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TTreeViewProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TTreeView
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TTreeViewProperties = class(TPersistent)
  private
    FServer:    TTreeView;
    function    GetDefaultInterface: _TreeView;
    constructor Create(AServer: TTreeView);
  protected
  public
    property DefaultInterface: _TreeView read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoTreeNodeMouseHoverEventArgs provides a Create and CreateRemote method to          
// create instances of the default interface _TreeNodeMouseHoverEventArgs exposed by              
// the CoClass TreeNodeMouseHoverEventArgs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTreeNodeMouseHoverEventArgs = class
    class function Create: _TreeNodeMouseHoverEventArgs;
    class function CreateRemote(const MachineName: string): _TreeNodeMouseHoverEventArgs;
  end;

// *********************************************************************//
// The Class CoUserControl provides a Create and CreateRemote method to          
// create instances of the default interface _UserControl exposed by              
// the CoClass UserControl. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoUserControl = class
    class function Create: _UserControl;
    class function CreateRemote(const MachineName: string): _UserControl;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TUserControl
// Help String      : 
// Default Interface: _UserControl
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TUserControlProperties= class;
{$ENDIF}
  TUserControl = class(TOleServer)
  private
    FIntf:        _UserControl;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TUserControlProperties;
    function      GetServerProperties: TUserControlProperties;
{$ENDIF}
    function      GetDefaultInterface: _UserControl;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _UserControl);
    procedure Disconnect; override;
    property DefaultInterface: _UserControl read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TUserControlProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TUserControl
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TUserControlProperties = class(TPersistent)
  private
    FServer:    TUserControl;
    function    GetDefaultInterface: _UserControl;
    constructor Create(AServer: TUserControl);
  protected
  public
    property DefaultInterface: _UserControl read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoVScrollBar provides a Create and CreateRemote method to          
// create instances of the default interface _VScrollBar exposed by              
// the CoClass VScrollBar. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoVScrollBar = class
    class function Create: _VScrollBar;
    class function CreateRemote(const MachineName: string): _VScrollBar;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TVScrollBar
// Help String      : 
// Default Interface: _VScrollBar
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TVScrollBarProperties= class;
{$ENDIF}
  TVScrollBar = class(TOleServer)
  private
    FIntf:        _VScrollBar;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TVScrollBarProperties;
    function      GetServerProperties: TVScrollBarProperties;
{$ENDIF}
    function      GetDefaultInterface: _VScrollBar;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _VScrollBar);
    procedure Disconnect; override;
    property DefaultInterface: _VScrollBar read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TVScrollBarProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TVScrollBar
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TVScrollBarProperties = class(TPersistent)
  private
    FServer:    TVScrollBar;
    function    GetDefaultInterface: _VScrollBar;
    constructor Create(AServer: TVScrollBar);
  protected
  public
    property DefaultInterface: _VScrollBar read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoWebBrowser provides a Create and CreateRemote method to          
// create instances of the default interface _WebBrowser exposed by              
// the CoClass WebBrowser. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoWebBrowser = class
    class function Create: _WebBrowser;
    class function CreateRemote(const MachineName: string): _WebBrowser;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TWebBrowser
// Help String      : 
// Default Interface: _WebBrowser
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TWebBrowserProperties= class;
{$ENDIF}
  TWebBrowser = class(TOleServer)
  private
    FIntf:        _WebBrowser;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TWebBrowserProperties;
    function      GetServerProperties: TWebBrowserProperties;
{$ENDIF}
    function      GetDefaultInterface: _WebBrowser;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _WebBrowser);
    procedure Disconnect; override;
    property DefaultInterface: _WebBrowser read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TWebBrowserProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TWebBrowser
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TWebBrowserProperties = class(TPersistent)
  private
    FServer:    TWebBrowser;
    function    GetDefaultInterface: _WebBrowser;
    constructor Create(AServer: TWebBrowser);
  protected
  public
    property DefaultInterface: _WebBrowser read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoWebBrowserBase provides a Create and CreateRemote method to          
// create instances of the default interface _WebBrowserBase exposed by              
// the CoClass WebBrowserBase. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoWebBrowserBase = class
    class function Create: _WebBrowserBase;
    class function CreateRemote(const MachineName: string): _WebBrowserBase;
  end;

// *********************************************************************//
// The Class CoComponentEditorForm provides a Create and CreateRemote method to          
// create instances of the default interface _ComponentEditorForm exposed by              
// the CoClass ComponentEditorForm. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoComponentEditorForm = class
    class function Create: _ComponentEditorForm;
    class function CreateRemote(const MachineName: string): _ComponentEditorForm;
  end;

// *********************************************************************//
// The Class CoComponentEditorPage provides a Create and CreateRemote method to          
// create instances of the default interface _ComponentEditorPage exposed by              
// the CoClass ComponentEditorPage. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoComponentEditorPage = class
    class function Create: _ComponentEditorPage;
    class function CreateRemote(const MachineName: string): _ComponentEditorPage;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'Servers';

  dtlOcxPage = 'Servers';

implementation

uses ComObj;

class function CoAccessibleObject.Create: _AccessibleObject;
begin
  Result := CreateComObject(CLASS_AccessibleObject) as _AccessibleObject;
end;

class function CoAccessibleObject.CreateRemote(const MachineName: string): _AccessibleObject;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AccessibleObject) as _AccessibleObject;
end;

procedure TAccessibleObject.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{D0CBA7AF-93F5-378A-BB11-2A5D9AA9C4D7}';
    IntfIID:   '{399C0499-29D3-3D95-AF77-111DCDB92177}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TAccessibleObject.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _AccessibleObject;
  end;
end;

procedure TAccessibleObject.ConnectTo(svrIntf: _AccessibleObject);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TAccessibleObject.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TAccessibleObject.GetDefaultInterface: _AccessibleObject;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TAccessibleObject.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TAccessibleObjectProperties.Create(Self);
{$ENDIF}
end;

destructor TAccessibleObject.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TAccessibleObject.GetServerProperties: TAccessibleObjectProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TAccessibleObjectProperties.Create(AServer: TAccessibleObject);
begin
  inherited Create;
  FServer := AServer;
end;

function TAccessibleObjectProperties.GetDefaultInterface: _AccessibleObject;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoForm.Create: _Form;
begin
  Result := CreateComObject(CLASS_Form) as _Form;
end;

class function CoForm.CreateRemote(const MachineName: string): _Form;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Form) as _Form;
end;

procedure TForm.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{C60F986A-D86B-3E50-B959-83F196BE2E16}';
    IntfIID:   '{AD0C79DB-37BE-3B61-9C53-2E4857237227}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TForm.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _Form;
  end;
end;

procedure TForm.ConnectTo(svrIntf: _Form);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TForm.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TForm.GetDefaultInterface: _Form;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TFormProperties.Create(Self);
{$ENDIF}
end;

destructor TForm.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TForm.GetServerProperties: TFormProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TFormProperties.Create(AServer: TForm);
begin
  inherited Create;
  FServer := AServer;
end;

function TFormProperties.GetDefaultInterface: _Form;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoAxHost.Create: _AxHost;
begin
  Result := CreateComObject(CLASS_AxHost) as _AxHost;
end;

class function CoAxHost.CreateRemote(const MachineName: string): _AxHost;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AxHost) as _AxHost;
end;

class function CoControl.Create: _Control;
begin
  Result := CreateComObject(CLASS_Control) as _Control;
end;

class function CoControl.CreateRemote(const MachineName: string): _Control;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Control) as _Control;
end;

procedure TControl.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{D51BE7D3-5EA4-3D65-B9C5-B9087E6F974F}';
    IntfIID:   '{83ACBFAE-1A16-33EB-ABA0-BA8DF0B206D7}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TControl.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _Control;
  end;
end;

procedure TControl.ConnectTo(svrIntf: _Control);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TControl.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TControl.GetDefaultInterface: _Control;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TControlProperties.Create(Self);
{$ENDIF}
end;

destructor TControl.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TControl.GetServerProperties: TControlProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TControlProperties.Create(AServer: TControl);
begin
  inherited Create;
  FServer := AServer;
end;

function TControlProperties.GetDefaultInterface: _Control;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoContainerControl.Create: _ContainerControl;
begin
  Result := CreateComObject(CLASS_ContainerControl) as _ContainerControl;
end;

class function CoContainerControl.CreateRemote(const MachineName: string): _ContainerControl;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ContainerControl) as _ContainerControl;
end;

procedure TContainerControl.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{BD20E131-9782-3651-AE3A-4BBAADDC62D8}';
    IntfIID:   '{A5AF2165-C1BE-39AF-AB35-CD950D01A701}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TContainerControl.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _ContainerControl;
  end;
end;

procedure TContainerControl.ConnectTo(svrIntf: _ContainerControl);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TContainerControl.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TContainerControl.GetDefaultInterface: _ContainerControl;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TContainerControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TContainerControlProperties.Create(Self);
{$ENDIF}
end;

destructor TContainerControl.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TContainerControl.GetServerProperties: TContainerControlProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TContainerControlProperties.Create(AServer: TContainerControl);
begin
  inherited Create;
  FServer := AServer;
end;

function TContainerControlProperties.GetDefaultInterface: _ContainerControl;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoBindingNavigator.Create: _BindingNavigator;
begin
  Result := CreateComObject(CLASS_BindingNavigator) as _BindingNavigator;
end;

class function CoBindingNavigator.CreateRemote(const MachineName: string): _BindingNavigator;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_BindingNavigator) as _BindingNavigator;
end;

procedure TBindingNavigator.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{8D907746-455E-39A7-BD31-BC9F81468347}';
    IntfIID:   '{E3FF0D90-9E82-3736-A253-3B2F41EF981A}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TBindingNavigator.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _BindingNavigator;
  end;
end;

procedure TBindingNavigator.ConnectTo(svrIntf: _BindingNavigator);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TBindingNavigator.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TBindingNavigator.GetDefaultInterface: _BindingNavigator;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TBindingNavigator.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TBindingNavigatorProperties.Create(Self);
{$ENDIF}
end;

destructor TBindingNavigator.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TBindingNavigator.GetServerProperties: TBindingNavigatorProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TBindingNavigatorProperties.Create(AServer: TBindingNavigator);
begin
  inherited Create;
  FServer := AServer;
end;

function TBindingNavigatorProperties.GetDefaultInterface: _BindingNavigator;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoToolStrip.Create: _ToolStrip;
begin
  Result := CreateComObject(CLASS_ToolStrip) as _ToolStrip;
end;

class function CoToolStrip.CreateRemote(const MachineName: string): _ToolStrip;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ToolStrip) as _ToolStrip;
end;

procedure TToolStrip.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{DAF7A547-5A5D-3095-9268-1425F428702E}';
    IntfIID:   '{A81676FD-EAA3-39C3-9354-A58951270EB6}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TToolStrip.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _ToolStrip;
  end;
end;

procedure TToolStrip.ConnectTo(svrIntf: _ToolStrip);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TToolStrip.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TToolStrip.GetDefaultInterface: _ToolStrip;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TToolStrip.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TToolStripProperties.Create(Self);
{$ENDIF}
end;

destructor TToolStrip.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TToolStrip.GetServerProperties: TToolStripProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TToolStripProperties.Create(AServer: TToolStrip);
begin
  inherited Create;
  FServer := AServer;
end;

function TToolStripProperties.GetDefaultInterface: _ToolStrip;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoButton.Create: _Button;
begin
  Result := CreateComObject(CLASS_Button) as _Button;
end;

class function CoButton.CreateRemote(const MachineName: string): _Button;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Button) as _Button;
end;

procedure TButton.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{1FCBDA5D-6F09-3A66-ACB8-1B0D748F5C13}';
    IntfIID:   '{9486855D-B3A4-32E8-AF74-EC881982E3FF}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TButton.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _Button;
  end;
end;

procedure TButton.ConnectTo(svrIntf: _Button);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TButton.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TButton.GetDefaultInterface: _Button;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TButtonProperties.Create(Self);
{$ENDIF}
end;

destructor TButton.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TButton.GetServerProperties: TButtonProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TButtonProperties.Create(AServer: TButton);
begin
  inherited Create;
  FServer := AServer;
end;

function TButtonProperties.GetDefaultInterface: _Button;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoButtonBase.Create: _ButtonBase;
begin
  Result := CreateComObject(CLASS_ButtonBase) as _ButtonBase;
end;

class function CoButtonBase.CreateRemote(const MachineName: string): _ButtonBase;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ButtonBase) as _ButtonBase;
end;

class function CoMouseEventArgs.Create: _MouseEventArgs;
begin
  Result := CreateComObject(CLASS_MouseEventArgs) as _MouseEventArgs;
end;

class function CoMouseEventArgs.CreateRemote(const MachineName: string): _MouseEventArgs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_MouseEventArgs) as _MouseEventArgs;
end;

class function CoButtonBaseAccessibleObject.Create: _ButtonBaseAccessibleObject;
begin
  Result := CreateComObject(CLASS_ButtonBaseAccessibleObject) as _ButtonBaseAccessibleObject;
end;

class function CoButtonBaseAccessibleObject.CreateRemote(const MachineName: string): _ButtonBaseAccessibleObject;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ButtonBaseAccessibleObject) as _ButtonBaseAccessibleObject;
end;

class function CoControlAccessibleObject.Create: _ControlAccessibleObject;
begin
  Result := CreateComObject(CLASS_ControlAccessibleObject) as _ControlAccessibleObject;
end;

class function CoControlAccessibleObject.CreateRemote(const MachineName: string): _ControlAccessibleObject;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ControlAccessibleObject) as _ControlAccessibleObject;
end;

class function CoKeyEventArgs.Create: _KeyEventArgs;
begin
  Result := CreateComObject(CLASS_KeyEventArgs) as _KeyEventArgs;
end;

class function CoKeyEventArgs.CreateRemote(const MachineName: string): _KeyEventArgs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_KeyEventArgs) as _KeyEventArgs;
end;

class function CoCheckBox.Create: _CheckBox;
begin
  Result := CreateComObject(CLASS_CheckBox) as _CheckBox;
end;

class function CoCheckBox.CreateRemote(const MachineName: string): _CheckBox;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CheckBox) as _CheckBox;
end;

procedure TCheckBox.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{C2D6EA6E-E423-3B53-B06B-419F95F34F68}';
    IntfIID:   '{1C7817C6-6A49-301E-B20A-05FF053C3D56}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TCheckBox.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _CheckBox;
  end;
end;

procedure TCheckBox.ConnectTo(svrIntf: _CheckBox);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TCheckBox.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TCheckBox.GetDefaultInterface: _CheckBox;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TCheckBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TCheckBoxProperties.Create(Self);
{$ENDIF}
end;

destructor TCheckBox.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TCheckBox.GetServerProperties: TCheckBoxProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TCheckBoxProperties.Create(AServer: TCheckBox);
begin
  inherited Create;
  FServer := AServer;
end;

function TCheckBoxProperties.GetDefaultInterface: _CheckBox;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoCheckBoxAccessibleObject.Create: _CheckBoxAccessibleObject;
begin
  Result := CreateComObject(CLASS_CheckBoxAccessibleObject) as _CheckBoxAccessibleObject;
end;

class function CoCheckBoxAccessibleObject.CreateRemote(const MachineName: string): _CheckBoxAccessibleObject;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CheckBoxAccessibleObject) as _CheckBoxAccessibleObject;
end;

class function CoCheckedListBox.Create: _CheckedListBox;
begin
  Result := CreateComObject(CLASS_CheckedListBox) as _CheckedListBox;
end;

class function CoCheckedListBox.CreateRemote(const MachineName: string): _CheckedListBox;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CheckedListBox) as _CheckedListBox;
end;

procedure TCheckedListBox.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{D8004AA1-697A-30C4-869E-F8F82595E05A}';
    IntfIID:   '{1833C4C9-4E61-3D96-AEB5-65B43DE96A01}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TCheckedListBox.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _CheckedListBox;
  end;
end;

procedure TCheckedListBox.ConnectTo(svrIntf: _CheckedListBox);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TCheckedListBox.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TCheckedListBox.GetDefaultInterface: _CheckedListBox;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TCheckedListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TCheckedListBoxProperties.Create(Self);
{$ENDIF}
end;

destructor TCheckedListBox.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TCheckedListBox.GetServerProperties: TCheckedListBoxProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TCheckedListBoxProperties.Create(AServer: TCheckedListBox);
begin
  inherited Create;
  FServer := AServer;
end;

function TCheckedListBoxProperties.GetDefaultInterface: _CheckedListBox;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoListBox.Create: _ListBox;
begin
  Result := CreateComObject(CLASS_ListBox) as _ListBox;
end;

class function CoListBox.CreateRemote(const MachineName: string): _ListBox;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ListBox) as _ListBox;
end;

procedure TListBox.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{D7AC7195-477C-3ABA-BA10-6CF8BE334A86}';
    IntfIID:   '{E36590E6-CFD5-340E-9650-73500A802C43}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TListBox.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _ListBox;
  end;
end;

procedure TListBox.ConnectTo(svrIntf: _ListBox);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TListBox.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TListBox.GetDefaultInterface: _ListBox;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TListBoxProperties.Create(Self);
{$ENDIF}
end;

destructor TListBox.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TListBox.GetServerProperties: TListBoxProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TListBoxProperties.Create(AServer: TListBox);
begin
  inherited Create;
  FServer := AServer;
end;

function TListBoxProperties.GetDefaultInterface: _ListBox;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoKeyPressEventArgs.Create: _KeyPressEventArgs;
begin
  Result := CreateComObject(CLASS_KeyPressEventArgs) as _KeyPressEventArgs;
end;

class function CoKeyPressEventArgs.CreateRemote(const MachineName: string): _KeyPressEventArgs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_KeyPressEventArgs) as _KeyPressEventArgs;
end;

class function CoItemCheckEventArgs.Create: _ItemCheckEventArgs;
begin
  Result := CreateComObject(CLASS_ItemCheckEventArgs) as _ItemCheckEventArgs;
end;

class function CoItemCheckEventArgs.CreateRemote(const MachineName: string): _ItemCheckEventArgs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ItemCheckEventArgs) as _ItemCheckEventArgs;
end;

class function CoListView.Create: _ListView;
begin
  Result := CreateComObject(CLASS_ListView) as _ListView;
end;

class function CoListView.CreateRemote(const MachineName: string): _ListView;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ListView) as _ListView;
end;

procedure TListView.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{53DCAC10-BF48-3670-BE8A-7E38FF839C71}';
    IntfIID:   '{A87AED55-DDA4-3668-BEFA-1A776496DD3E}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TListView.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _ListView;
  end;
end;

procedure TListView.ConnectTo(svrIntf: _ListView);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TListView.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TListView.GetDefaultInterface: _ListView;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TListView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TListViewProperties.Create(Self);
{$ENDIF}
end;

destructor TListView.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TListView.GetServerProperties: TListViewProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TListViewProperties.Create(AServer: TListView);
begin
  inherited Create;
  FServer := AServer;
end;

function TListViewProperties.GetDefaultInterface: _ListView;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoComboBox.Create: _ComboBox;
begin
  Result := CreateComObject(CLASS_ComboBox) as _ComboBox;
end;

class function CoComboBox.CreateRemote(const MachineName: string): _ComboBox;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ComboBox) as _ComboBox;
end;

procedure TComboBox.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{FE644CA9-E687-308B-AF40-1D0CFABD2AD8}';
    IntfIID:   '{2EFEC16E-EEC9-39A3-9D8A-5E72B5C14F78}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TComboBox.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _ComboBox;
  end;
end;

procedure TComboBox.ConnectTo(svrIntf: _ComboBox);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TComboBox.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TComboBox.GetDefaultInterface: _ComboBox;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TComboBoxProperties.Create(Self);
{$ENDIF}
end;

destructor TComboBox.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TComboBox.GetServerProperties: TComboBoxProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TComboBoxProperties.Create(AServer: TComboBox);
begin
  inherited Create;
  FServer := AServer;
end;

function TComboBoxProperties.GetDefaultInterface: _ComboBox;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoListControl.Create: _ListControl;
begin
  Result := CreateComObject(CLASS_ListControl) as _ListControl;
end;

class function CoListControl.CreateRemote(const MachineName: string): _ListControl;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ListControl) as _ListControl;
end;

class function CoChildAccessibleObject.Create: _ChildAccessibleObject;
begin
  Result := CreateComObject(CLASS_ChildAccessibleObject) as _ChildAccessibleObject;
end;

class function CoChildAccessibleObject.CreateRemote(const MachineName: string): _ChildAccessibleObject;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ChildAccessibleObject) as _ChildAccessibleObject;
end;

class function CoScrollableControl.Create: _ScrollableControl;
begin
  Result := CreateComObject(CLASS_ScrollableControl) as _ScrollableControl;
end;

class function CoScrollableControl.CreateRemote(const MachineName: string): _ScrollableControl;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ScrollableControl) as _ScrollableControl;
end;

procedure TScrollableControl.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{73156525-C0E7-39EF-8C35-1E7C522CB07F}';
    IntfIID:   '{812A8B20-CB02-3483-8A29-424C6CDAC4B7}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TScrollableControl.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _ScrollableControl;
  end;
end;

procedure TScrollableControl.ConnectTo(svrIntf: _ScrollableControl);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TScrollableControl.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TScrollableControl.GetDefaultInterface: _ScrollableControl;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TScrollableControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TScrollableControlProperties.Create(Self);
{$ENDIF}
end;

destructor TScrollableControl.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TScrollableControl.GetServerProperties: TScrollableControlProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TScrollableControlProperties.Create(AServer: TScrollableControl);
begin
  inherited Create;
  FServer := AServer;
end;

function TScrollableControlProperties.GetDefaultInterface: _ScrollableControl;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoContextMenuStrip.Create: _ContextMenuStrip;
begin
  Result := CreateComObject(CLASS_ContextMenuStrip) as _ContextMenuStrip;
end;

class function CoContextMenuStrip.CreateRemote(const MachineName: string): _ContextMenuStrip;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ContextMenuStrip) as _ContextMenuStrip;
end;

procedure TContextMenuStrip.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{D84F5EBD-F1F2-3849-98D7-6FDBA13AC6AB}';
    IntfIID:   '{4B4939AF-61C1-378F-BDF0-68B9B3EE48E3}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TContextMenuStrip.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _ContextMenuStrip;
  end;
end;

procedure TContextMenuStrip.ConnectTo(svrIntf: _ContextMenuStrip);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TContextMenuStrip.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TContextMenuStrip.GetDefaultInterface: _ContextMenuStrip;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TContextMenuStrip.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TContextMenuStripProperties.Create(Self);
{$ENDIF}
end;

destructor TContextMenuStrip.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TContextMenuStrip.GetServerProperties: TContextMenuStripProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TContextMenuStripProperties.Create(AServer: TContextMenuStrip);
begin
  inherited Create;
  FServer := AServer;
end;

function TContextMenuStripProperties.GetDefaultInterface: _ContextMenuStrip;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoToolStripDropDownMenu.Create: _ToolStripDropDownMenu;
begin
  Result := CreateComObject(CLASS_ToolStripDropDownMenu) as _ToolStripDropDownMenu;
end;

class function CoToolStripDropDownMenu.CreateRemote(const MachineName: string): _ToolStripDropDownMenu;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ToolStripDropDownMenu) as _ToolStripDropDownMenu;
end;

procedure TToolStripDropDownMenu.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{5458C631-6A29-344D-B571-DE58784BD9E0}';
    IntfIID:   '{8E07FA2C-B44B-3818-BA44-D88F2A69E8B6}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TToolStripDropDownMenu.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _ToolStripDropDownMenu;
  end;
end;

procedure TToolStripDropDownMenu.ConnectTo(svrIntf: _ToolStripDropDownMenu);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TToolStripDropDownMenu.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TToolStripDropDownMenu.GetDefaultInterface: _ToolStripDropDownMenu;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TToolStripDropDownMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TToolStripDropDownMenuProperties.Create(Self);
{$ENDIF}
end;

destructor TToolStripDropDownMenu.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TToolStripDropDownMenu.GetServerProperties: TToolStripDropDownMenuProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TToolStripDropDownMenuProperties.Create(AServer: TToolStripDropDownMenu);
begin
  inherited Create;
  FServer := AServer;
end;

function TToolStripDropDownMenuProperties.GetDefaultInterface: _ToolStripDropDownMenu;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoDragEventArgs.Create: _DragEventArgs;
begin
  Result := CreateComObject(CLASS_DragEventArgs) as _DragEventArgs;
end;

class function CoDragEventArgs.CreateRemote(const MachineName: string): _DragEventArgs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DragEventArgs) as _DragEventArgs;
end;

class function CoGiveFeedbackEventArgs.Create: _GiveFeedbackEventArgs;
begin
  Result := CreateComObject(CLASS_GiveFeedbackEventArgs) as _GiveFeedbackEventArgs;
end;

class function CoGiveFeedbackEventArgs.CreateRemote(const MachineName: string): _GiveFeedbackEventArgs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_GiveFeedbackEventArgs) as _GiveFeedbackEventArgs;
end;

class function CoHelpEventArgs.Create: _HelpEventArgs;
begin
  Result := CreateComObject(CLASS_HelpEventArgs) as _HelpEventArgs;
end;

class function CoHelpEventArgs.CreateRemote(const MachineName: string): _HelpEventArgs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_HelpEventArgs) as _HelpEventArgs;
end;

class function CoQueryContinueDragEventArgs.Create: _QueryContinueDragEventArgs;
begin
  Result := CreateComObject(CLASS_QueryContinueDragEventArgs) as _QueryContinueDragEventArgs;
end;

class function CoQueryContinueDragEventArgs.CreateRemote(const MachineName: string): _QueryContinueDragEventArgs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_QueryContinueDragEventArgs) as _QueryContinueDragEventArgs;
end;

class function CoDataGrid.Create: _DataGrid;
begin
  Result := CreateComObject(CLASS_DataGrid) as _DataGrid;
end;

class function CoDataGrid.CreateRemote(const MachineName: string): _DataGrid;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DataGrid) as _DataGrid;
end;

procedure TDataGrid.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{1733CD63-DB91-3506-B433-4DD3700B596F}';
    IntfIID:   '{518A56E2-FBCE-3386-BB15-4A0F67872BDC}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TDataGrid.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _DataGrid;
  end;
end;

procedure TDataGrid.ConnectTo(svrIntf: _DataGrid);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TDataGrid.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TDataGrid.GetDefaultInterface: _DataGrid;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TDataGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TDataGridProperties.Create(Self);
{$ENDIF}
end;

destructor TDataGrid.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TDataGrid.GetServerProperties: TDataGridProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TDataGridProperties.Create(AServer: TDataGrid);
begin
  inherited Create;
  FServer := AServer;
end;

function TDataGridProperties.GetDefaultInterface: _DataGrid;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoScrollBar.Create: _ScrollBar;
begin
  Result := CreateComObject(CLASS_ScrollBar) as _ScrollBar;
end;

class function CoScrollBar.CreateRemote(const MachineName: string): _ScrollBar;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ScrollBar) as _ScrollBar;
end;

class function CoNavigateEventArgs.Create: _NavigateEventArgs;
begin
  Result := CreateComObject(CLASS_NavigateEventArgs) as _NavigateEventArgs;
end;

class function CoNavigateEventArgs.CreateRemote(const MachineName: string): _NavigateEventArgs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_NavigateEventArgs) as _NavigateEventArgs;
end;

class function CoScrollEventArgs.Create: _ScrollEventArgs;
begin
  Result := CreateComObject(CLASS_ScrollEventArgs) as _ScrollEventArgs;
end;

class function CoScrollEventArgs.CreateRemote(const MachineName: string): _ScrollEventArgs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ScrollEventArgs) as _ScrollEventArgs;
end;

class function CoDataGridTextBox.Create: _DataGridTextBox;
begin
  Result := CreateComObject(CLASS_DataGridTextBox) as _DataGridTextBox;
end;

class function CoDataGridTextBox.CreateRemote(const MachineName: string): _DataGridTextBox;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DataGridTextBox) as _DataGridTextBox;
end;

procedure TDataGridTextBox.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{0B420F33-D20B-329D-A609-5783B3E79722}';
    IntfIID:   '{2780E0D4-2B06-3E1F-ADDF-D8DBBB3FB960}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TDataGridTextBox.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _DataGridTextBox;
  end;
end;

procedure TDataGridTextBox.ConnectTo(svrIntf: _DataGridTextBox);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TDataGridTextBox.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TDataGridTextBox.GetDefaultInterface: _DataGridTextBox;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TDataGridTextBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TDataGridTextBoxProperties.Create(Self);
{$ENDIF}
end;

destructor TDataGridTextBox.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TDataGridTextBox.GetServerProperties: TDataGridTextBoxProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TDataGridTextBoxProperties.Create(AServer: TDataGridTextBox);
begin
  inherited Create;
  FServer := AServer;
end;

function TDataGridTextBoxProperties.GetDefaultInterface: _DataGridTextBox;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoTextBox.Create: _TextBox;
begin
  Result := CreateComObject(CLASS_TextBox) as _TextBox;
end;

class function CoTextBox.CreateRemote(const MachineName: string): _TextBox;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TextBox) as _TextBox;
end;

procedure TTextBox.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{63C8A502-7863-3F66-998D-79BD0219D2E0}';
    IntfIID:   '{EAEF4300-9FB3-306F-8F67-180DEB8DDFB7}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TTextBox.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _TextBox;
  end;
end;

procedure TTextBox.ConnectTo(svrIntf: _TextBox);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TTextBox.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TTextBox.GetDefaultInterface: _TextBox;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TTextBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TTextBoxProperties.Create(Self);
{$ENDIF}
end;

destructor TTextBox.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TTextBox.GetServerProperties: TTextBoxProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TTextBoxProperties.Create(AServer: TTextBox);
begin
  inherited Create;
  FServer := AServer;
end;

function TTextBoxProperties.GetDefaultInterface: _TextBox;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoDataGridView.Create: _DataGridView;
begin
  Result := CreateComObject(CLASS_DataGridView) as _DataGridView;
end;

class function CoDataGridView.CreateRemote(const MachineName: string): _DataGridView;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DataGridView) as _DataGridView;
end;

procedure TDataGridView.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{E21338E1-4794-3125-9211-92A7510202E8}';
    IntfIID:   '{5968374C-8F43-353B-8F0A-780A0A7DDB79}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TDataGridView.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _DataGridView;
  end;
end;

procedure TDataGridView.ConnectTo(svrIntf: _DataGridView);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TDataGridView.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TDataGridView.GetDefaultInterface: _DataGridView;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TDataGridView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TDataGridViewProperties.Create(Self);
{$ENDIF}
end;

destructor TDataGridView.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TDataGridView.GetServerProperties: TDataGridViewProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TDataGridViewProperties.Create(AServer: TDataGridView);
begin
  inherited Create;
  FServer := AServer;
end;

function TDataGridViewProperties.GetDefaultInterface: _DataGridView;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoPanel.Create: _Panel;
begin
  Result := CreateComObject(CLASS_Panel) as _Panel;
end;

class function CoPanel.CreateRemote(const MachineName: string): _Panel;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Panel) as _Panel;
end;

procedure TPanel.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{165C9F64-CCB8-3C9B-8AAF-95352F86B99B}';
    IntfIID:   '{549A3DD8-D85F-3D08-87E2-49B08490008B}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TPanel.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _Panel;
  end;
end;

procedure TPanel.ConnectTo(svrIntf: _Panel);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TPanel.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TPanel.GetDefaultInterface: _Panel;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TPanelProperties.Create(Self);
{$ENDIF}
end;

destructor TPanel.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TPanel.GetServerProperties: TPanelProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TPanelProperties.Create(AServer: TPanel);
begin
  inherited Create;
  FServer := AServer;
end;

function TPanelProperties.GetDefaultInterface: _Panel;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoDataGridViewComboBoxEditingControl.Create: _DataGridViewComboBoxEditingControl;
begin
  Result := CreateComObject(CLASS_DataGridViewComboBoxEditingControl) as _DataGridViewComboBoxEditingControl;
end;

class function CoDataGridViewComboBoxEditingControl.CreateRemote(const MachineName: string): _DataGridViewComboBoxEditingControl;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DataGridViewComboBoxEditingControl) as _DataGridViewComboBoxEditingControl;
end;

procedure TDataGridViewComboBoxEditingControl.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{82596187-3FA3-3CFF-A0CD-151C3598597C}';
    IntfIID:   '{C6615083-0A23-3997-A54B-F618EB824AF0}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TDataGridViewComboBoxEditingControl.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _DataGridViewComboBoxEditingControl;
  end;
end;

procedure TDataGridViewComboBoxEditingControl.ConnectTo(svrIntf: _DataGridViewComboBoxEditingControl);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TDataGridViewComboBoxEditingControl.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TDataGridViewComboBoxEditingControl.GetDefaultInterface: _DataGridViewComboBoxEditingControl;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TDataGridViewComboBoxEditingControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TDataGridViewComboBoxEditingControlProperties.Create(Self);
{$ENDIF}
end;

destructor TDataGridViewComboBoxEditingControl.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TDataGridViewComboBoxEditingControl.GetServerProperties: TDataGridViewComboBoxEditingControlProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TDataGridViewComboBoxEditingControlProperties.Create(AServer: TDataGridViewComboBoxEditingControl);
begin
  inherited Create;
  FServer := AServer;
end;

function TDataGridViewComboBoxEditingControlProperties.GetDefaultInterface: _DataGridViewComboBoxEditingControl;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoDataGridViewTextBoxEditingControl.Create: _DataGridViewTextBoxEditingControl;
begin
  Result := CreateComObject(CLASS_DataGridViewTextBoxEditingControl) as _DataGridViewTextBoxEditingControl;
end;

class function CoDataGridViewTextBoxEditingControl.CreateRemote(const MachineName: string): _DataGridViewTextBoxEditingControl;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DataGridViewTextBoxEditingControl) as _DataGridViewTextBoxEditingControl;
end;

procedure TDataGridViewTextBoxEditingControl.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{7065C038-BA07-337A-BFED-DE2179346428}';
    IntfIID:   '{A7750701-44A2-353A-923A-7BA68A8E22AF}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TDataGridViewTextBoxEditingControl.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _DataGridViewTextBoxEditingControl;
  end;
end;

procedure TDataGridViewTextBoxEditingControl.ConnectTo(svrIntf: _DataGridViewTextBoxEditingControl);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TDataGridViewTextBoxEditingControl.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TDataGridViewTextBoxEditingControl.GetDefaultInterface: _DataGridViewTextBoxEditingControl;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TDataGridViewTextBoxEditingControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TDataGridViewTextBoxEditingControlProperties.Create(Self);
{$ENDIF}
end;

destructor TDataGridViewTextBoxEditingControl.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TDataGridViewTextBoxEditingControl.GetServerProperties: TDataGridViewTextBoxEditingControlProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TDataGridViewTextBoxEditingControlProperties.Create(AServer: TDataGridViewTextBoxEditingControl);
begin
  inherited Create;
  FServer := AServer;
end;

function TDataGridViewTextBoxEditingControlProperties.GetDefaultInterface: _DataGridViewTextBoxEditingControl;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoDateTimePicker.Create: _DateTimePicker;
begin
  Result := CreateComObject(CLASS_DateTimePicker) as _DateTimePicker;
end;

class function CoDateTimePicker.CreateRemote(const MachineName: string): _DateTimePicker;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DateTimePicker) as _DateTimePicker;
end;

procedure TDateTimePicker.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{4D09932A-CC59-3DB0-9826-D515941D2D92}';
    IntfIID:   '{2BAD7D35-895F-3D4A-B883-0B3CD324B8BD}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TDateTimePicker.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _DateTimePicker;
  end;
end;

procedure TDateTimePicker.ConnectTo(svrIntf: _DateTimePicker);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TDateTimePicker.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TDateTimePicker.GetDefaultInterface: _DateTimePicker;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TDateTimePicker.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TDateTimePickerProperties.Create(Self);
{$ENDIF}
end;

destructor TDateTimePicker.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TDateTimePicker.GetServerProperties: TDateTimePickerProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TDateTimePickerProperties.Create(AServer: TDateTimePicker);
begin
  inherited Create;
  FServer := AServer;
end;

function TDateTimePickerProperties.GetDefaultInterface: _DateTimePicker;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoDateTimePickerAccessibleObject.Create: _DateTimePickerAccessibleObject;
begin
  Result := CreateComObject(CLASS_DateTimePickerAccessibleObject) as _DateTimePickerAccessibleObject;
end;

class function CoDateTimePickerAccessibleObject.CreateRemote(const MachineName: string): _DateTimePickerAccessibleObject;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DateTimePickerAccessibleObject) as _DateTimePickerAccessibleObject;
end;

class function CoDomainUpDown.Create: _DomainUpDown;
begin
  Result := CreateComObject(CLASS_DomainUpDown) as _DomainUpDown;
end;

class function CoDomainUpDown.CreateRemote(const MachineName: string): _DomainUpDown;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DomainUpDown) as _DomainUpDown;
end;

procedure TDomainUpDown.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{D1C50548-6109-3199-9042-FFAF6834AA01}';
    IntfIID:   '{44792A74-5DD8-3410-A897-F568E4E58161}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TDomainUpDown.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _DomainUpDown;
  end;
end;

procedure TDomainUpDown.ConnectTo(svrIntf: _DomainUpDown);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TDomainUpDown.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TDomainUpDown.GetDefaultInterface: _DomainUpDown;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TDomainUpDown.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TDomainUpDownProperties.Create(Self);
{$ENDIF}
end;

destructor TDomainUpDown.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TDomainUpDown.GetServerProperties: TDomainUpDownProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TDomainUpDownProperties.Create(AServer: TDomainUpDown);
begin
  inherited Create;
  FServer := AServer;
end;

function TDomainUpDownProperties.GetDefaultInterface: _DomainUpDown;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoUpDownBase.Create: _UpDownBase;
begin
  Result := CreateComObject(CLASS_UpDownBase) as _UpDownBase;
end;

class function CoUpDownBase.CreateRemote(const MachineName: string): _UpDownBase;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_UpDownBase) as _UpDownBase;
end;

class function CoDomainItemAccessibleObject.Create: _DomainItemAccessibleObject;
begin
  Result := CreateComObject(CLASS_DomainItemAccessibleObject) as _DomainItemAccessibleObject;
end;

class function CoDomainItemAccessibleObject.CreateRemote(const MachineName: string): _DomainItemAccessibleObject;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DomainItemAccessibleObject) as _DomainItemAccessibleObject;
end;

class function CoDomainUpDownAccessibleObject.Create: _DomainUpDownAccessibleObject;
begin
  Result := CreateComObject(CLASS_DomainUpDownAccessibleObject) as _DomainUpDownAccessibleObject;
end;

class function CoDomainUpDownAccessibleObject.CreateRemote(const MachineName: string): _DomainUpDownAccessibleObject;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DomainUpDownAccessibleObject) as _DomainUpDownAccessibleObject;
end;

class function CoFlowLayoutPanel.Create: _FlowLayoutPanel;
begin
  Result := CreateComObject(CLASS_FlowLayoutPanel) as _FlowLayoutPanel;
end;

class function CoFlowLayoutPanel.CreateRemote(const MachineName: string): _FlowLayoutPanel;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FlowLayoutPanel) as _FlowLayoutPanel;
end;

procedure TFlowLayoutPanel.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{BA92792E-F10D-3EFC-A100-52757A4C184C}';
    IntfIID:   '{B55C4C83-1F69-3D93-9C4E-2AA5619E0C68}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TFlowLayoutPanel.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _FlowLayoutPanel;
  end;
end;

procedure TFlowLayoutPanel.ConnectTo(svrIntf: _FlowLayoutPanel);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TFlowLayoutPanel.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TFlowLayoutPanel.GetDefaultInterface: _FlowLayoutPanel;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TFlowLayoutPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TFlowLayoutPanelProperties.Create(Self);
{$ENDIF}
end;

destructor TFlowLayoutPanel.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TFlowLayoutPanel.GetServerProperties: TFlowLayoutPanelProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TFlowLayoutPanelProperties.Create(AServer: TFlowLayoutPanel);
begin
  inherited Create;
  FServer := AServer;
end;

function TFlowLayoutPanelProperties.GetDefaultInterface: _FlowLayoutPanel;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoMenuStrip.Create: _MenuStrip;
begin
  Result := CreateComObject(CLASS_MenuStrip) as _MenuStrip;
end;

class function CoMenuStrip.CreateRemote(const MachineName: string): _MenuStrip;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_MenuStrip) as _MenuStrip;
end;

procedure TMenuStrip.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{C930C2F7-CFDA-3940-916C-51BEC9C4D316}';
    IntfIID:   '{EB5A3078-05D9-3F32-9045-89F756938A3D}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMenuStrip.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _MenuStrip;
  end;
end;

procedure TMenuStrip.ConnectTo(svrIntf: _MenuStrip);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TMenuStrip.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TMenuStrip.GetDefaultInterface: _MenuStrip;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TMenuStrip.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TMenuStripProperties.Create(Self);
{$ENDIF}
end;

destructor TMenuStrip.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMenuStrip.GetServerProperties: TMenuStripProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TMenuStripProperties.Create(AServer: TMenuStrip);
begin
  inherited Create;
  FServer := AServer;
end;

function TMenuStripProperties.GetDefaultInterface: _MenuStrip;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoGroupBox.Create: _GroupBox;
begin
  Result := CreateComObject(CLASS_GroupBox) as _GroupBox;
end;

class function CoGroupBox.CreateRemote(const MachineName: string): _GroupBox;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_GroupBox) as _GroupBox;
end;

procedure TGroupBox.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{C5CD51C2-EE05-358A-9B53-07F9060E435F}';
    IntfIID:   '{11B0B536-2F72-3A3F-B2A3-0420A9F5041F}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TGroupBox.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _GroupBox;
  end;
end;

procedure TGroupBox.ConnectTo(svrIntf: _GroupBox);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TGroupBox.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TGroupBox.GetDefaultInterface: _GroupBox;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TGroupBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TGroupBoxProperties.Create(Self);
{$ENDIF}
end;

destructor TGroupBox.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TGroupBox.GetServerProperties: TGroupBoxProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TGroupBoxProperties.Create(AServer: TGroupBox);
begin
  inherited Create;
  FServer := AServer;
end;

function TGroupBoxProperties.GetDefaultInterface: _GroupBox;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoHScrollBar.Create: _HScrollBar;
begin
  Result := CreateComObject(CLASS_HScrollBar) as _HScrollBar;
end;

class function CoHScrollBar.CreateRemote(const MachineName: string): _HScrollBar;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_HScrollBar) as _HScrollBar;
end;

procedure THScrollBar.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{F835D22E-51EB-3A49-93A3-34558BE9C825}';
    IntfIID:   '{7BC4A820-B20F-3ECE-BDD6-EE7E14EB7E0D}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure THScrollBar.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _HScrollBar;
  end;
end;

procedure THScrollBar.ConnectTo(svrIntf: _HScrollBar);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure THScrollBar.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function THScrollBar.GetDefaultInterface: _HScrollBar;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor THScrollBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := THScrollBarProperties.Create(Self);
{$ENDIF}
end;

destructor THScrollBar.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function THScrollBar.GetServerProperties: THScrollBarProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor THScrollBarProperties.Create(AServer: THScrollBar);
begin
  inherited Create;
  FServer := AServer;
end;

function THScrollBarProperties.GetDefaultInterface: _HScrollBar;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoItemDragEventArgs.Create: _ItemDragEventArgs;
begin
  Result := CreateComObject(CLASS_ItemDragEventArgs) as _ItemDragEventArgs;
end;

class function CoItemDragEventArgs.CreateRemote(const MachineName: string): _ItemDragEventArgs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ItemDragEventArgs) as _ItemDragEventArgs;
end;

class function CoLabel_.Create: _Label;
begin
  Result := CreateComObject(CLASS_Label_) as _Label;
end;

class function CoLabel_.CreateRemote(const MachineName: string): _Label;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Label_) as _Label;
end;

procedure TLabel.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{93D7475B-94A4-3C10-92E6-FD64BBE5745F}';
    IntfIID:   '{00AE8203-987D-3B7E-9448-5B3393282D7F}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TLabel.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _Label;
  end;
end;

procedure TLabel.ConnectTo(svrIntf: _Label);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TLabel.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TLabel.GetDefaultInterface: _Label;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TLabelProperties.Create(Self);
{$ENDIF}
end;

destructor TLabel.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TLabel.GetServerProperties: TLabelProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TLabelProperties.Create(AServer: TLabel);
begin
  inherited Create;
  FServer := AServer;
end;

function TLabelProperties.GetDefaultInterface: _Label;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoLinkClickedEventArgs.Create: _LinkClickedEventArgs;
begin
  Result := CreateComObject(CLASS_LinkClickedEventArgs) as _LinkClickedEventArgs;
end;

class function CoLinkClickedEventArgs.CreateRemote(const MachineName: string): _LinkClickedEventArgs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LinkClickedEventArgs) as _LinkClickedEventArgs;
end;

class function CoLinkLabel.Create: _LinkLabel;
begin
  Result := CreateComObject(CLASS_LinkLabel) as _LinkLabel;
end;

class function CoLinkLabel.CreateRemote(const MachineName: string): _LinkLabel;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LinkLabel) as _LinkLabel;
end;

procedure TLinkLabel.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{C116EE15-015E-3760-92F9-59C2D99236F1}';
    IntfIID:   '{4EE61C0D-D2D5-3A50-972B-C0A957D3A541}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TLinkLabel.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _LinkLabel;
  end;
end;

procedure TLinkLabel.ConnectTo(svrIntf: _LinkLabel);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TLinkLabel.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TLinkLabel.GetDefaultInterface: _LinkLabel;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TLinkLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TLinkLabelProperties.Create(Self);
{$ENDIF}
end;

destructor TLinkLabel.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TLinkLabel.GetServerProperties: TLinkLabelProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TLinkLabelProperties.Create(AServer: TLinkLabel);
begin
  inherited Create;
  FServer := AServer;
end;

function TLinkLabelProperties.GetDefaultInterface: _LinkLabel;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoLinkLabelLinkClickedEventArgs.Create: _LinkLabelLinkClickedEventArgs;
begin
  Result := CreateComObject(CLASS_LinkLabelLinkClickedEventArgs) as _LinkLabelLinkClickedEventArgs;
end;

class function CoLinkLabelLinkClickedEventArgs.CreateRemote(const MachineName: string): _LinkLabelLinkClickedEventArgs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LinkLabelLinkClickedEventArgs) as _LinkLabelLinkClickedEventArgs;
end;

class function CoListViewItemMouseHoverEventArgs.Create: _ListViewItemMouseHoverEventArgs;
begin
  Result := CreateComObject(CLASS_ListViewItemMouseHoverEventArgs) as _ListViewItemMouseHoverEventArgs;
end;

class function CoListViewItemMouseHoverEventArgs.CreateRemote(const MachineName: string): _ListViewItemMouseHoverEventArgs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ListViewItemMouseHoverEventArgs) as _ListViewItemMouseHoverEventArgs;
end;

class function CoMaskedTextBox.Create: _MaskedTextBox;
begin
  Result := CreateComObject(CLASS_MaskedTextBox) as _MaskedTextBox;
end;

class function CoMaskedTextBox.CreateRemote(const MachineName: string): _MaskedTextBox;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_MaskedTextBox) as _MaskedTextBox;
end;

procedure TMaskedTextBox.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{9C5E8CFB-CAC0-3167-ACEE-BFDD8B5D2238}';
    IntfIID:   '{22B0C1A9-E74E-381A-BABB-66BEF71FF08E}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMaskedTextBox.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _MaskedTextBox;
  end;
end;

procedure TMaskedTextBox.ConnectTo(svrIntf: _MaskedTextBox);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TMaskedTextBox.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TMaskedTextBox.GetDefaultInterface: _MaskedTextBox;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TMaskedTextBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TMaskedTextBoxProperties.Create(Self);
{$ENDIF}
end;

destructor TMaskedTextBox.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMaskedTextBox.GetServerProperties: TMaskedTextBoxProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TMaskedTextBoxProperties.Create(AServer: TMaskedTextBox);
begin
  inherited Create;
  FServer := AServer;
end;

function TMaskedTextBoxProperties.GetDefaultInterface: _MaskedTextBox;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoTextBoxBase.Create: _TextBoxBase;
begin
  Result := CreateComObject(CLASS_TextBoxBase) as _TextBoxBase;
end;

class function CoTextBoxBase.CreateRemote(const MachineName: string): _TextBoxBase;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TextBoxBase) as _TextBoxBase;
end;

class function CoMdiClient.Create: _MdiClient;
begin
  Result := CreateComObject(CLASS_MdiClient) as _MdiClient;
end;

class function CoMdiClient.CreateRemote(const MachineName: string): _MdiClient;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_MdiClient) as _MdiClient;
end;

procedure TMdiClient.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{CE6E4B0C-1473-3184-B1E3-0027D76E3618}';
    IntfIID:   '{6AB0BB67-4A4B-32F9-A18A-6481916C946F}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMdiClient.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _MdiClient;
  end;
end;

procedure TMdiClient.ConnectTo(svrIntf: _MdiClient);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TMdiClient.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TMdiClient.GetDefaultInterface: _MdiClient;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TMdiClient.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TMdiClientProperties.Create(Self);
{$ENDIF}
end;

destructor TMdiClient.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMdiClient.GetServerProperties: TMdiClientProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TMdiClientProperties.Create(AServer: TMdiClient);
begin
  inherited Create;
  FServer := AServer;
end;

function TMdiClientProperties.GetDefaultInterface: _MdiClient;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoMonthCalendar.Create: _MonthCalendar;
begin
  Result := CreateComObject(CLASS_MonthCalendar) as _MonthCalendar;
end;

class function CoMonthCalendar.CreateRemote(const MachineName: string): _MonthCalendar;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_MonthCalendar) as _MonthCalendar;
end;

procedure TMonthCalendar.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{B6782E31-494F-32EB-8405-6F24AC68BDBD}';
    IntfIID:   '{C3FA9EA8-275E-35E9-89DA-18B1FCA593EE}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMonthCalendar.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _MonthCalendar;
  end;
end;

procedure TMonthCalendar.ConnectTo(svrIntf: _MonthCalendar);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TMonthCalendar.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TMonthCalendar.GetDefaultInterface: _MonthCalendar;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TMonthCalendar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TMonthCalendarProperties.Create(Self);
{$ENDIF}
end;

destructor TMonthCalendar.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMonthCalendar.GetServerProperties: TMonthCalendarProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TMonthCalendarProperties.Create(AServer: TMonthCalendar);
begin
  inherited Create;
  FServer := AServer;
end;

function TMonthCalendarProperties.GetDefaultInterface: _MonthCalendar;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoNumericUpDown.Create: _NumericUpDown;
begin
  Result := CreateComObject(CLASS_NumericUpDown) as _NumericUpDown;
end;

class function CoNumericUpDown.CreateRemote(const MachineName: string): _NumericUpDown;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_NumericUpDown) as _NumericUpDown;
end;

procedure TNumericUpDown.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{E2035BFE-7A03-3AF5-B1FC-4A1F34BFD448}';
    IntfIID:   '{2AD9F14A-0097-3C69-9F8E-5DDB52F3878B}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TNumericUpDown.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _NumericUpDown;
  end;
end;

procedure TNumericUpDown.ConnectTo(svrIntf: _NumericUpDown);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TNumericUpDown.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TNumericUpDown.GetDefaultInterface: _NumericUpDown;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TNumericUpDown.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TNumericUpDownProperties.Create(Self);
{$ENDIF}
end;

destructor TNumericUpDown.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TNumericUpDown.GetServerProperties: TNumericUpDownProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TNumericUpDownProperties.Create(AServer: TNumericUpDown);
begin
  inherited Create;
  FServer := AServer;
end;

function TNumericUpDownProperties.GetDefaultInterface: _NumericUpDown;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoPictureBox.Create: _PictureBox;
begin
  Result := CreateComObject(CLASS_PictureBox) as _PictureBox;
end;

class function CoPictureBox.CreateRemote(const MachineName: string): _PictureBox;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PictureBox) as _PictureBox;
end;

procedure TPictureBox.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{492B7BBA-A930-38FF-B51A-32B81068FA89}';
    IntfIID:   '{BB1C5180-87D0-330C-B698-EE2132DF362E}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TPictureBox.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _PictureBox;
  end;
end;

procedure TPictureBox.ConnectTo(svrIntf: _PictureBox);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TPictureBox.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TPictureBox.GetDefaultInterface: _PictureBox;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TPictureBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TPictureBoxProperties.Create(Self);
{$ENDIF}
end;

destructor TPictureBox.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TPictureBox.GetServerProperties: TPictureBoxProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TPictureBoxProperties.Create(AServer: TPictureBox);
begin
  inherited Create;
  FServer := AServer;
end;

function TPictureBoxProperties.GetDefaultInterface: _PictureBox;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoPrintPreviewControl.Create: _PrintPreviewControl;
begin
  Result := CreateComObject(CLASS_PrintPreviewControl) as _PrintPreviewControl;
end;

class function CoPrintPreviewControl.CreateRemote(const MachineName: string): _PrintPreviewControl;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PrintPreviewControl) as _PrintPreviewControl;
end;

procedure TPrintPreviewControl.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{C064EAE9-D1DD-32AC-BBFD-8882189841F3}';
    IntfIID:   '{FA3B8143-ECB8-3A38-9DE5-DB0EEA708B5F}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TPrintPreviewControl.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _PrintPreviewControl;
  end;
end;

procedure TPrintPreviewControl.ConnectTo(svrIntf: _PrintPreviewControl);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TPrintPreviewControl.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TPrintPreviewControl.GetDefaultInterface: _PrintPreviewControl;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TPrintPreviewControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TPrintPreviewControlProperties.Create(Self);
{$ENDIF}
end;

destructor TPrintPreviewControl.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TPrintPreviewControl.GetServerProperties: TPrintPreviewControlProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TPrintPreviewControlProperties.Create(AServer: TPrintPreviewControl);
begin
  inherited Create;
  FServer := AServer;
end;

function TPrintPreviewControlProperties.GetDefaultInterface: _PrintPreviewControl;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoPrintPreviewDialog.Create: _PrintPreviewDialog;
begin
  Result := CreateComObject(CLASS_PrintPreviewDialog) as _PrintPreviewDialog;
end;

class function CoPrintPreviewDialog.CreateRemote(const MachineName: string): _PrintPreviewDialog;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PrintPreviewDialog) as _PrintPreviewDialog;
end;

procedure TPrintPreviewDialog.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{17438D08-1CA5-3C2D-B1E0-BF241CA83E5A}';
    IntfIID:   '{57C090D5-80BC-33B8-B782-706A8D833767}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TPrintPreviewDialog.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _PrintPreviewDialog;
  end;
end;

procedure TPrintPreviewDialog.ConnectTo(svrIntf: _PrintPreviewDialog);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TPrintPreviewDialog.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TPrintPreviewDialog.GetDefaultInterface: _PrintPreviewDialog;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TPrintPreviewDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TPrintPreviewDialogProperties.Create(Self);
{$ENDIF}
end;

destructor TPrintPreviewDialog.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TPrintPreviewDialog.GetServerProperties: TPrintPreviewDialogProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TPrintPreviewDialogProperties.Create(AServer: TPrintPreviewDialog);
begin
  inherited Create;
  FServer := AServer;
end;

function TPrintPreviewDialogProperties.GetDefaultInterface: _PrintPreviewDialog;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoProgressBar.Create: _ProgressBar;
begin
  Result := CreateComObject(CLASS_ProgressBar) as _ProgressBar;
end;

class function CoProgressBar.CreateRemote(const MachineName: string): _ProgressBar;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ProgressBar) as _ProgressBar;
end;

procedure TProgressBar.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{409F95BB-E848-3A04-8B5A-8F13148651A9}';
    IntfIID:   '{8E935BCB-21E1-377C-A59F-89F7BA5A4E0F}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TProgressBar.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _ProgressBar;
  end;
end;

procedure TProgressBar.ConnectTo(svrIntf: _ProgressBar);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TProgressBar.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TProgressBar.GetDefaultInterface: _ProgressBar;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TProgressBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TProgressBarProperties.Create(Self);
{$ENDIF}
end;

destructor TProgressBar.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TProgressBar.GetServerProperties: TProgressBarProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TProgressBarProperties.Create(AServer: TProgressBar);
begin
  inherited Create;
  FServer := AServer;
end;

function TProgressBarProperties.GetDefaultInterface: _ProgressBar;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoPropertyGrid.Create: _PropertyGrid;
begin
  Result := CreateComObject(CLASS_PropertyGrid) as _PropertyGrid;
end;

class function CoPropertyGrid.CreateRemote(const MachineName: string): _PropertyGrid;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PropertyGrid) as _PropertyGrid;
end;

procedure TPropertyGrid.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{DC0ED10F-FEA5-3A43-8CA1-19E036DF370F}';
    IntfIID:   '{0C831618-60D7-32B2-9790-1EBDC5ADEFE5}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TPropertyGrid.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _PropertyGrid;
  end;
end;

procedure TPropertyGrid.ConnectTo(svrIntf: _PropertyGrid);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TPropertyGrid.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TPropertyGrid.GetDefaultInterface: _PropertyGrid;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TPropertyGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TPropertyGridProperties.Create(Self);
{$ENDIF}
end;

destructor TPropertyGrid.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TPropertyGrid.GetServerProperties: TPropertyGridProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TPropertyGridProperties.Create(AServer: TPropertyGrid);
begin
  inherited Create;
  FServer := AServer;
end;

function TPropertyGridProperties.GetDefaultInterface: _PropertyGrid;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoPropertyTabChangedEventArgs.Create: _PropertyTabChangedEventArgs;
begin
  Result := CreateComObject(CLASS_PropertyTabChangedEventArgs) as _PropertyTabChangedEventArgs;
end;

class function CoPropertyTabChangedEventArgs.CreateRemote(const MachineName: string): _PropertyTabChangedEventArgs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PropertyTabChangedEventArgs) as _PropertyTabChangedEventArgs;
end;

class function CoPropertyValueChangedEventArgs.Create: _PropertyValueChangedEventArgs;
begin
  Result := CreateComObject(CLASS_PropertyValueChangedEventArgs) as _PropertyValueChangedEventArgs;
end;

class function CoPropertyValueChangedEventArgs.CreateRemote(const MachineName: string): _PropertyValueChangedEventArgs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PropertyValueChangedEventArgs) as _PropertyValueChangedEventArgs;
end;

class function CoQueryAccessibilityHelpEventArgs.Create: _QueryAccessibilityHelpEventArgs;
begin
  Result := CreateComObject(CLASS_QueryAccessibilityHelpEventArgs) as _QueryAccessibilityHelpEventArgs;
end;

class function CoQueryAccessibilityHelpEventArgs.CreateRemote(const MachineName: string): _QueryAccessibilityHelpEventArgs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_QueryAccessibilityHelpEventArgs) as _QueryAccessibilityHelpEventArgs;
end;

procedure TQueryAccessibilityHelpEventArgs.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{25AF3ECD-8F91-3CCE-9E6F-03D7348D8CBA}';
    IntfIID:   '{2FE9F084-1511-3052-BE7C-9010B522C10E}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TQueryAccessibilityHelpEventArgs.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _QueryAccessibilityHelpEventArgs;
  end;
end;

procedure TQueryAccessibilityHelpEventArgs.ConnectTo(svrIntf: _QueryAccessibilityHelpEventArgs);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TQueryAccessibilityHelpEventArgs.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TQueryAccessibilityHelpEventArgs.GetDefaultInterface: _QueryAccessibilityHelpEventArgs;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TQueryAccessibilityHelpEventArgs.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TQueryAccessibilityHelpEventArgsProperties.Create(Self);
{$ENDIF}
end;

destructor TQueryAccessibilityHelpEventArgs.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TQueryAccessibilityHelpEventArgs.GetServerProperties: TQueryAccessibilityHelpEventArgsProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TQueryAccessibilityHelpEventArgsProperties.Create(AServer: TQueryAccessibilityHelpEventArgs);
begin
  inherited Create;
  FServer := AServer;
end;

function TQueryAccessibilityHelpEventArgsProperties.GetDefaultInterface: _QueryAccessibilityHelpEventArgs;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoRadioButton.Create: _RadioButton;
begin
  Result := CreateComObject(CLASS_RadioButton) as _RadioButton;
end;

class function CoRadioButton.CreateRemote(const MachineName: string): _RadioButton;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RadioButton) as _RadioButton;
end;

procedure TRadioButton.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{FC511C4D-49A7-32AB-AB23-0AC220A9CDB7}';
    IntfIID:   '{3E431682-BBDE-31B1-AE7F-9D8DD582BD0D}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TRadioButton.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _RadioButton;
  end;
end;

procedure TRadioButton.ConnectTo(svrIntf: _RadioButton);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TRadioButton.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TRadioButton.GetDefaultInterface: _RadioButton;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TRadioButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TRadioButtonProperties.Create(Self);
{$ENDIF}
end;

destructor TRadioButton.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TRadioButton.GetServerProperties: TRadioButtonProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TRadioButtonProperties.Create(AServer: TRadioButton);
begin
  inherited Create;
  FServer := AServer;
end;

function TRadioButtonProperties.GetDefaultInterface: _RadioButton;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoRadioButtonAccessibleObject.Create: _RadioButtonAccessibleObject;
begin
  Result := CreateComObject(CLASS_RadioButtonAccessibleObject) as _RadioButtonAccessibleObject;
end;

class function CoRadioButtonAccessibleObject.CreateRemote(const MachineName: string): _RadioButtonAccessibleObject;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RadioButtonAccessibleObject) as _RadioButtonAccessibleObject;
end;

class function CoRichTextBox.Create: _RichTextBox;
begin
  Result := CreateComObject(CLASS_RichTextBox) as _RichTextBox;
end;

class function CoRichTextBox.CreateRemote(const MachineName: string): _RichTextBox;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RichTextBox) as _RichTextBox;
end;

procedure TRichTextBox.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{5FBA0DDC-0B9F-3E4F-B99D-B3F297E9820D}';
    IntfIID:   '{1B264763-A1C7-3441-9D61-7EDAEC2D0C44}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TRichTextBox.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _RichTextBox;
  end;
end;

procedure TRichTextBox.ConnectTo(svrIntf: _RichTextBox);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TRichTextBox.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TRichTextBox.GetDefaultInterface: _RichTextBox;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TRichTextBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TRichTextBoxProperties.Create(Self);
{$ENDIF}
end;

destructor TRichTextBox.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TRichTextBox.GetServerProperties: TRichTextBoxProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TRichTextBoxProperties.Create(AServer: TRichTextBox);
begin
  inherited Create;
  FServer := AServer;
end;

function TRichTextBoxProperties.GetDefaultInterface: _RichTextBox;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoSplitContainer.Create: _SplitContainer;
begin
  Result := CreateComObject(CLASS_SplitContainer) as _SplitContainer;
end;

class function CoSplitContainer.CreateRemote(const MachineName: string): _SplitContainer;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SplitContainer) as _SplitContainer;
end;

procedure TSplitContainer.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{F3F633A7-CA31-3CFC-A958-D8F04B946665}';
    IntfIID:   '{C1DA069E-4C0B-3664-BBA1-F81864825085}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TSplitContainer.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _SplitContainer;
  end;
end;

procedure TSplitContainer.ConnectTo(svrIntf: _SplitContainer);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TSplitContainer.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TSplitContainer.GetDefaultInterface: _SplitContainer;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TSplitContainer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TSplitContainerProperties.Create(Self);
{$ENDIF}
end;

destructor TSplitContainer.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TSplitContainer.GetServerProperties: TSplitContainerProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TSplitContainerProperties.Create(AServer: TSplitContainer);
begin
  inherited Create;
  FServer := AServer;
end;

function TSplitContainerProperties.GetDefaultInterface: _SplitContainer;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoSplitterPanel.Create: _SplitterPanel;
begin
  Result := CreateComObject(CLASS_SplitterPanel) as _SplitterPanel;
end;

class function CoSplitterPanel.CreateRemote(const MachineName: string): _SplitterPanel;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SplitterPanel) as _SplitterPanel;
end;

class function CoSplitterEventArgs.Create: _SplitterEventArgs;
begin
  Result := CreateComObject(CLASS_SplitterEventArgs) as _SplitterEventArgs;
end;

class function CoSplitterEventArgs.CreateRemote(const MachineName: string): _SplitterEventArgs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SplitterEventArgs) as _SplitterEventArgs;
end;

class function CoSplitter.Create: _Splitter;
begin
  Result := CreateComObject(CLASS_Splitter) as _Splitter;
end;

class function CoSplitter.CreateRemote(const MachineName: string): _Splitter;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Splitter) as _Splitter;
end;

procedure TSplitter.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{4BDF38BF-91E6-33D0-AC66-BF7682617615}';
    IntfIID:   '{C318A56D-0B03-3A5A-93F6-7DF0B3268237}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TSplitter.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _Splitter;
  end;
end;

procedure TSplitter.ConnectTo(svrIntf: _Splitter);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TSplitter.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TSplitter.GetDefaultInterface: _Splitter;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TSplitter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TSplitterProperties.Create(Self);
{$ENDIF}
end;

destructor TSplitter.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TSplitter.GetServerProperties: TSplitterProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TSplitterProperties.Create(AServer: TSplitter);
begin
  inherited Create;
  FServer := AServer;
end;

function TSplitterProperties.GetDefaultInterface: _Splitter;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoStatusBar.Create: _StatusBar;
begin
  Result := CreateComObject(CLASS_StatusBar) as _StatusBar;
end;

class function CoStatusBar.CreateRemote(const MachineName: string): _StatusBar;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_StatusBar) as _StatusBar;
end;

procedure TStatusBar.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{632D5C3D-6594-33E9-B361-9BCF6946B45A}';
    IntfIID:   '{93409DA8-FE37-3D4E-9A08-B35B34122C64}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TStatusBar.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _StatusBar;
  end;
end;

procedure TStatusBar.ConnectTo(svrIntf: _StatusBar);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TStatusBar.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TStatusBar.GetDefaultInterface: _StatusBar;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TStatusBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TStatusBarProperties.Create(Self);
{$ENDIF}
end;

destructor TStatusBar.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TStatusBar.GetServerProperties: TStatusBarProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TStatusBarProperties.Create(AServer: TStatusBar);
begin
  inherited Create;
  FServer := AServer;
end;

function TStatusBarProperties.GetDefaultInterface: _StatusBar;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoStatusStrip.Create: _StatusStrip;
begin
  Result := CreateComObject(CLASS_StatusStrip) as _StatusStrip;
end;

class function CoStatusStrip.CreateRemote(const MachineName: string): _StatusStrip;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_StatusStrip) as _StatusStrip;
end;

procedure TStatusStrip.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{E6F7736E-221C-377D-8080-EBA946D3BFE4}';
    IntfIID:   '{71CA209D-40D3-3409-B341-DA9B922CCA45}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TStatusStrip.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _StatusStrip;
  end;
end;

procedure TStatusStrip.ConnectTo(svrIntf: _StatusStrip);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TStatusStrip.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TStatusStrip.GetDefaultInterface: _StatusStrip;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TStatusStrip.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TStatusStripProperties.Create(Self);
{$ENDIF}
end;

destructor TStatusStrip.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TStatusStrip.GetServerProperties: TStatusStripProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TStatusStripProperties.Create(AServer: TStatusStrip);
begin
  inherited Create;
  FServer := AServer;
end;

function TStatusStripProperties.GetDefaultInterface: _StatusStrip;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoTabControl.Create: _TabControl;
begin
  Result := CreateComObject(CLASS_TabControl) as _TabControl;
end;

class function CoTabControl.CreateRemote(const MachineName: string): _TabControl;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TabControl) as _TabControl;
end;

procedure TTabControl.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{3863B485-0904-3D25-89D0-190AD0321D29}';
    IntfIID:   '{470DE738-5261-302A-B205-4744652D2FD3}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TTabControl.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _TabControl;
  end;
end;

procedure TTabControl.ConnectTo(svrIntf: _TabControl);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TTabControl.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TTabControl.GetDefaultInterface: _TabControl;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TTabControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TTabControlProperties.Create(Self);
{$ENDIF}
end;

destructor TTabControl.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TTabControl.GetServerProperties: TTabControlProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TTabControlProperties.Create(AServer: TTabControl);
begin
  inherited Create;
  FServer := AServer;
end;

function TTabControlProperties.GetDefaultInterface: _TabControl;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoTabPage.Create: _TabPage;
begin
  Result := CreateComObject(CLASS_TabPage) as _TabPage;
end;

class function CoTabPage.CreateRemote(const MachineName: string): _TabPage;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TabPage) as _TabPage;
end;

procedure TTabPage.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{BBD78147-59D7-34A8-9BD3-62E28E957F28}';
    IntfIID:   '{59183431-BD56-33D2-A2ED-FA414ADF8DCB}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TTabPage.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _TabPage;
  end;
end;

procedure TTabPage.ConnectTo(svrIntf: _TabPage);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TTabPage.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TTabPage.GetDefaultInterface: _TabPage;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TTabPage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TTabPageProperties.Create(Self);
{$ENDIF}
end;

destructor TTabPage.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TTabPage.GetServerProperties: TTabPageProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TTabPageProperties.Create(AServer: TTabPage);
begin
  inherited Create;
  FServer := AServer;
end;

function TTabPageProperties.GetDefaultInterface: _TabPage;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoTableLayoutPanel.Create: _TableLayoutPanel;
begin
  Result := CreateComObject(CLASS_TableLayoutPanel) as _TableLayoutPanel;
end;

class function CoTableLayoutPanel.CreateRemote(const MachineName: string): _TableLayoutPanel;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TableLayoutPanel) as _TableLayoutPanel;
end;

procedure TTableLayoutPanel.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{ABBA8E63-B2D0-346C-80ED-9E0C215069CB}';
    IntfIID:   '{05CBE5B2-0292-37DE-BE51-5B7599CA5A11}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TTableLayoutPanel.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _TableLayoutPanel;
  end;
end;

procedure TTableLayoutPanel.ConnectTo(svrIntf: _TableLayoutPanel);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TTableLayoutPanel.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TTableLayoutPanel.GetDefaultInterface: _TableLayoutPanel;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TTableLayoutPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TTableLayoutPanelProperties.Create(Self);
{$ENDIF}
end;

destructor TTableLayoutPanel.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TTableLayoutPanel.GetServerProperties: TTableLayoutPanelProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TTableLayoutPanelProperties.Create(AServer: TTableLayoutPanel);
begin
  inherited Create;
  FServer := AServer;
end;

function TTableLayoutPanelProperties.GetDefaultInterface: _TableLayoutPanel;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoThreadExceptionDialog.Create: _ThreadExceptionDialog;
begin
  Result := CreateComObject(CLASS_ThreadExceptionDialog) as _ThreadExceptionDialog;
end;

class function CoThreadExceptionDialog.CreateRemote(const MachineName: string): _ThreadExceptionDialog;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ThreadExceptionDialog) as _ThreadExceptionDialog;
end;

class function CoToolBar.Create: _ToolBar;
begin
  Result := CreateComObject(CLASS_ToolBar) as _ToolBar;
end;

class function CoToolBar.CreateRemote(const MachineName: string): _ToolBar;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ToolBar) as _ToolBar;
end;

procedure TToolBar.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{4E885C2A-C86F-3641-8D7B-9B3501449F45}';
    IntfIID:   '{F6AB38B6-1C02-3B01-A7F8-510ED1C0B253}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TToolBar.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _ToolBar;
  end;
end;

procedure TToolBar.ConnectTo(svrIntf: _ToolBar);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TToolBar.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TToolBar.GetDefaultInterface: _ToolBar;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TToolBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TToolBarProperties.Create(Self);
{$ENDIF}
end;

destructor TToolBar.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TToolBar.GetServerProperties: TToolBarProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TToolBarProperties.Create(AServer: TToolBar);
begin
  inherited Create;
  FServer := AServer;
end;

function TToolBarProperties.GetDefaultInterface: _ToolBar;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoToolStripAccessibleObject.Create: _ToolStripAccessibleObject;
begin
  Result := CreateComObject(CLASS_ToolStripAccessibleObject) as _ToolStripAccessibleObject;
end;

class function CoToolStripAccessibleObject.CreateRemote(const MachineName: string): _ToolStripAccessibleObject;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ToolStripAccessibleObject) as _ToolStripAccessibleObject;
end;

class function CoToolStripContainer.Create: _ToolStripContainer;
begin
  Result := CreateComObject(CLASS_ToolStripContainer) as _ToolStripContainer;
end;

class function CoToolStripContainer.CreateRemote(const MachineName: string): _ToolStripContainer;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ToolStripContainer) as _ToolStripContainer;
end;

procedure TToolStripContainer.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{C0FF87FD-7051-300E-ACC9-8F1A43FC2969}';
    IntfIID:   '{2A42F137-D50D-3D62-AF58-4DF7A4F57C9B}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TToolStripContainer.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _ToolStripContainer;
  end;
end;

procedure TToolStripContainer.ConnectTo(svrIntf: _ToolStripContainer);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TToolStripContainer.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TToolStripContainer.GetDefaultInterface: _ToolStripContainer;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TToolStripContainer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TToolStripContainerProperties.Create(Self);
{$ENDIF}
end;

destructor TToolStripContainer.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TToolStripContainer.GetServerProperties: TToolStripContainerProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TToolStripContainerProperties.Create(AServer: TToolStripContainer);
begin
  inherited Create;
  FServer := AServer;
end;

function TToolStripContainerProperties.GetDefaultInterface: _ToolStripContainer;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoToolStripPanel.Create: _ToolStripPanel;
begin
  Result := CreateComObject(CLASS_ToolStripPanel) as _ToolStripPanel;
end;

class function CoToolStripPanel.CreateRemote(const MachineName: string): _ToolStripPanel;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ToolStripPanel) as _ToolStripPanel;
end;

procedure TToolStripPanel.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{935030C0-F6CE-367E-BA86-CBF721D0E3B6}';
    IntfIID:   '{FB97C26A-FB56-3F71-BBC4-B1377E7B142D}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TToolStripPanel.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _ToolStripPanel;
  end;
end;

procedure TToolStripPanel.ConnectTo(svrIntf: _ToolStripPanel);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TToolStripPanel.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TToolStripPanel.GetDefaultInterface: _ToolStripPanel;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TToolStripPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TToolStripPanelProperties.Create(Self);
{$ENDIF}
end;

destructor TToolStripPanel.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TToolStripPanel.GetServerProperties: TToolStripPanelProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TToolStripPanelProperties.Create(AServer: TToolStripPanel);
begin
  inherited Create;
  FServer := AServer;
end;

function TToolStripPanelProperties.GetDefaultInterface: _ToolStripPanel;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoToolStripContentPanel.Create: _ToolStripContentPanel;
begin
  Result := CreateComObject(CLASS_ToolStripContentPanel) as _ToolStripContentPanel;
end;

class function CoToolStripContentPanel.CreateRemote(const MachineName: string): _ToolStripContentPanel;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ToolStripContentPanel) as _ToolStripContentPanel;
end;

procedure TToolStripContentPanel.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{D34F0B81-5AF3-34B1-8CB8-E2166D5733F9}';
    IntfIID:   '{6EE3853E-DDEF-3F29-8F1B-1ED7180D9229}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TToolStripContentPanel.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _ToolStripContentPanel;
  end;
end;

procedure TToolStripContentPanel.ConnectTo(svrIntf: _ToolStripContentPanel);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TToolStripContentPanel.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TToolStripContentPanel.GetDefaultInterface: _ToolStripContentPanel;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TToolStripContentPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TToolStripContentPanelProperties.Create(Self);
{$ENDIF}
end;

destructor TToolStripContentPanel.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TToolStripContentPanel.GetServerProperties: TToolStripContentPanelProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TToolStripContentPanelProperties.Create(AServer: TToolStripContentPanel);
begin
  inherited Create;
  FServer := AServer;
end;

function TToolStripContentPanelProperties.GetDefaultInterface: _ToolStripContentPanel;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoToolStripDropDown.Create: _ToolStripDropDown;
begin
  Result := CreateComObject(CLASS_ToolStripDropDown) as _ToolStripDropDown;
end;

class function CoToolStripDropDown.CreateRemote(const MachineName: string): _ToolStripDropDown;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ToolStripDropDown) as _ToolStripDropDown;
end;

procedure TToolStripDropDown.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{E7FAC3BE-6AA2-37D6-894F-472D8F064FAB}';
    IntfIID:   '{C2322B43-25B3-3B30-B3DB-67E4DA2E6533}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TToolStripDropDown.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _ToolStripDropDown;
  end;
end;

procedure TToolStripDropDown.ConnectTo(svrIntf: _ToolStripDropDown);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TToolStripDropDown.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TToolStripDropDown.GetDefaultInterface: _ToolStripDropDown;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TToolStripDropDown.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TToolStripDropDownProperties.Create(Self);
{$ENDIF}
end;

destructor TToolStripDropDown.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TToolStripDropDown.GetServerProperties: TToolStripDropDownProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TToolStripDropDownProperties.Create(AServer: TToolStripDropDown);
begin
  inherited Create;
  FServer := AServer;
end;

function TToolStripDropDownProperties.GetDefaultInterface: _ToolStripDropDown;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoToolStripDropDownAccessibleObject.Create: _ToolStripDropDownAccessibleObject;
begin
  Result := CreateComObject(CLASS_ToolStripDropDownAccessibleObject) as _ToolStripDropDownAccessibleObject;
end;

class function CoToolStripDropDownAccessibleObject.CreateRemote(const MachineName: string): _ToolStripDropDownAccessibleObject;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ToolStripDropDownAccessibleObject) as _ToolStripDropDownAccessibleObject;
end;

class function CoToolStripItemAccessibleObject.Create: _ToolStripItemAccessibleObject;
begin
  Result := CreateComObject(CLASS_ToolStripItemAccessibleObject) as _ToolStripItemAccessibleObject;
end;

class function CoToolStripItemAccessibleObject.CreateRemote(const MachineName: string): _ToolStripItemAccessibleObject;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ToolStripItemAccessibleObject) as _ToolStripItemAccessibleObject;
end;

class function CoToolStripOverflow.Create: _ToolStripOverflow;
begin
  Result := CreateComObject(CLASS_ToolStripOverflow) as _ToolStripOverflow;
end;

class function CoToolStripOverflow.CreateRemote(const MachineName: string): _ToolStripOverflow;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ToolStripOverflow) as _ToolStripOverflow;
end;

class function CoTrackBar.Create: _TrackBar;
begin
  Result := CreateComObject(CLASS_TrackBar) as _TrackBar;
end;

class function CoTrackBar.CreateRemote(const MachineName: string): _TrackBar;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TrackBar) as _TrackBar;
end;

procedure TTrackBar.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{606C2474-80A5-3E09-B952-724F97B00C01}';
    IntfIID:   '{7A8CC9AD-4E8D-3AAF-941A-1511C9C1372A}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TTrackBar.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _TrackBar;
  end;
end;

procedure TTrackBar.ConnectTo(svrIntf: _TrackBar);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TTrackBar.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TTrackBar.GetDefaultInterface: _TrackBar;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TTrackBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TTrackBarProperties.Create(Self);
{$ENDIF}
end;

destructor TTrackBar.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TTrackBar.GetServerProperties: TTrackBarProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TTrackBarProperties.Create(AServer: TTrackBar);
begin
  inherited Create;
  FServer := AServer;
end;

function TTrackBarProperties.GetDefaultInterface: _TrackBar;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoTreeView.Create: _TreeView;
begin
  Result := CreateComObject(CLASS_TreeView) as _TreeView;
end;

class function CoTreeView.CreateRemote(const MachineName: string): _TreeView;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TreeView) as _TreeView;
end;

procedure TTreeView.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{6FAB6F50-DFFE-35B5-9A5F-210DB36909B7}';
    IntfIID:   '{BA97ED62-9EBD-34E8-94AD-F71AEF67DEFF}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TTreeView.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _TreeView;
  end;
end;

procedure TTreeView.ConnectTo(svrIntf: _TreeView);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TTreeView.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TTreeView.GetDefaultInterface: _TreeView;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TTreeView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TTreeViewProperties.Create(Self);
{$ENDIF}
end;

destructor TTreeView.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TTreeView.GetServerProperties: TTreeViewProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TTreeViewProperties.Create(AServer: TTreeView);
begin
  inherited Create;
  FServer := AServer;
end;

function TTreeViewProperties.GetDefaultInterface: _TreeView;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoTreeNodeMouseHoverEventArgs.Create: _TreeNodeMouseHoverEventArgs;
begin
  Result := CreateComObject(CLASS_TreeNodeMouseHoverEventArgs) as _TreeNodeMouseHoverEventArgs;
end;

class function CoTreeNodeMouseHoverEventArgs.CreateRemote(const MachineName: string): _TreeNodeMouseHoverEventArgs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TreeNodeMouseHoverEventArgs) as _TreeNodeMouseHoverEventArgs;
end;

class function CoUserControl.Create: _UserControl;
begin
  Result := CreateComObject(CLASS_UserControl) as _UserControl;
end;

class function CoUserControl.CreateRemote(const MachineName: string): _UserControl;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_UserControl) as _UserControl;
end;

procedure TUserControl.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{07427F79-1FC2-3632-B5F4-02B51BA44E18}';
    IntfIID:   '{6BEEDF4B-B688-3C0D-8B16-D53290790DFB}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TUserControl.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _UserControl;
  end;
end;

procedure TUserControl.ConnectTo(svrIntf: _UserControl);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TUserControl.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TUserControl.GetDefaultInterface: _UserControl;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TUserControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TUserControlProperties.Create(Self);
{$ENDIF}
end;

destructor TUserControl.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TUserControl.GetServerProperties: TUserControlProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TUserControlProperties.Create(AServer: TUserControl);
begin
  inherited Create;
  FServer := AServer;
end;

function TUserControlProperties.GetDefaultInterface: _UserControl;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoVScrollBar.Create: _VScrollBar;
begin
  Result := CreateComObject(CLASS_VScrollBar) as _VScrollBar;
end;

class function CoVScrollBar.CreateRemote(const MachineName: string): _VScrollBar;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_VScrollBar) as _VScrollBar;
end;

procedure TVScrollBar.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{CB040AB2-71CB-3546-9881-53CA472CEB3B}';
    IntfIID:   '{469D64EC-EB30-3462-A93B-E01BAA5CAF83}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TVScrollBar.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _VScrollBar;
  end;
end;

procedure TVScrollBar.ConnectTo(svrIntf: _VScrollBar);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TVScrollBar.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TVScrollBar.GetDefaultInterface: _VScrollBar;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TVScrollBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TVScrollBarProperties.Create(Self);
{$ENDIF}
end;

destructor TVScrollBar.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TVScrollBar.GetServerProperties: TVScrollBarProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TVScrollBarProperties.Create(AServer: TVScrollBar);
begin
  inherited Create;
  FServer := AServer;
end;

function TVScrollBarProperties.GetDefaultInterface: _VScrollBar;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoWebBrowser.Create: _WebBrowser;
begin
  Result := CreateComObject(CLASS_WebBrowser) as _WebBrowser;
end;

class function CoWebBrowser.CreateRemote(const MachineName: string): _WebBrowser;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_WebBrowser) as _WebBrowser;
end;

procedure TWebBrowser.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{322BC601-B652-3088-A0C8-47A7A02E78F4}';
    IntfIID:   '{BB134D18-9643-3862-AA3B-17EBDB1A0DEF}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TWebBrowser.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _WebBrowser;
  end;
end;

procedure TWebBrowser.ConnectTo(svrIntf: _WebBrowser);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TWebBrowser.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TWebBrowser.GetDefaultInterface: _WebBrowser;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TWebBrowser.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TWebBrowserProperties.Create(Self);
{$ENDIF}
end;

destructor TWebBrowser.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TWebBrowser.GetServerProperties: TWebBrowserProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TWebBrowserProperties.Create(AServer: TWebBrowser);
begin
  inherited Create;
  FServer := AServer;
end;

function TWebBrowserProperties.GetDefaultInterface: _WebBrowser;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoWebBrowserBase.Create: _WebBrowserBase;
begin
  Result := CreateComObject(CLASS_WebBrowserBase) as _WebBrowserBase;
end;

class function CoWebBrowserBase.CreateRemote(const MachineName: string): _WebBrowserBase;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_WebBrowserBase) as _WebBrowserBase;
end;

class function CoComponentEditorForm.Create: _ComponentEditorForm;
begin
  Result := CreateComObject(CLASS_ComponentEditorForm) as _ComponentEditorForm;
end;

class function CoComponentEditorForm.CreateRemote(const MachineName: string): _ComponentEditorForm;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ComponentEditorForm) as _ComponentEditorForm;
end;

class function CoComponentEditorPage.Create: _ComponentEditorPage;
begin
  Result := CreateComObject(CLASS_ComponentEditorPage) as _ComponentEditorPage;
end;

class function CoComponentEditorPage.CreateRemote(const MachineName: string): _ComponentEditorPage;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ComponentEditorPage) as _ComponentEditorPage;
end;

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TAccessibleObject, TForm, TControl, TContainerControl, 
    TBindingNavigator, TToolStrip, TButton, TCheckBox, TCheckedListBox, 
    TListBox, TListView, TComboBox, TScrollableControl, TContextMenuStrip, 
    TToolStripDropDownMenu, TDataGrid, TDataGridTextBox, TTextBox, TDataGridView, 
    TPanel, TDataGridViewComboBoxEditingControl, TDataGridViewTextBoxEditingControl, TDateTimePicker, TDomainUpDown, 
    TFlowLayoutPanel, TMenuStrip, TGroupBox, THScrollBar, TLabel, 
    TLinkLabel, TMaskedTextBox, TMdiClient, TMonthCalendar, TNumericUpDown, 
    TPictureBox, TPrintPreviewControl, TPrintPreviewDialog, TProgressBar, TPropertyGrid, 
    TQueryAccessibilityHelpEventArgs, TRadioButton, TRichTextBox, TSplitContainer, TSplitter, 
    TStatusBar, TStatusStrip, TTabControl, TTabPage, TTableLayoutPanel, 
    TToolBar, TToolStripContainer, TToolStripPanel, TToolStripContentPanel, TToolStripDropDown, 
    TTrackBar, TTreeView, TUserControl, TVScrollBar, TWebBrowser]);
end;

end.
