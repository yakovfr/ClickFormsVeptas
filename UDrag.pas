unit UDrag;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2008 by Bradford Technologies, Inc. }


interface

Uses
	Controls, Extctrls, Graphics, Types,
  UCell,StdCtrls,UForm;

Type

	//This is the drag object we use for dragging a form.
  //TDragObjectEx will free itself.
	TDragFormObject = class(TDragObjectEx)
		FForm:    TObject;              //this is TFormUID
		hasData:  Boolean;							//does this form have a data with it.
		theForm:  TObject;							//docForm where the data is located
		theDoc:   TObject;							//so we make sure we dont' drag onto ourselves
	end;

 //This is the drag object for draging a UAAR Datalog record
  TDragUAARRecord = class(TDragFormObject)
    srcRecNo:     Integer;              //record to drop
    hasMultRecs:  Boolean;
    srcRecNos:    Array of Integer;
  end;

	//This is the drag object for dropping a bookmark onto form
	TDragBookMark = class(TDragObjectEx);    //just name this something we can identify

  //This is used for dragging an image into a cell (ie photosheet to cell)
  TDragImage = class(TDragObjectEx)
    ImageCell:      TGraphicCell;
    IsThumbImage:   Boolean;
    ImageFilePath:  String;
  end;

  //This is used to drop a map label onto an image cell
  //The image cell will then create the indicated Map Label type
  TDragLabel = class(TDragObjectEx)
    FLabelType:   Integer;         //type of label
    FLabelID:     Integer;         //0=subject, 1=comp1, 2=comp2, etc
    FLabelCatID:  Integer;         //subj, comp, rental, listing
    FLabelText:   String;          //'SUBJECT'
    FLabelColor:  TColor;          //color
    FLabelAngle:  Integer;         //orientation
    FLabelShape:  Integer;         //unique shape
  end;

  //This is the drag object for moving forms within
  //the PageMgr list. Allows to rearrange forms with
  //simple drag and drop
  TDragPageIndex = class(TDragObjectEx)
    SrcPageIndex:     Integer;
    SrcFormIndex:     Integer;
    SrcForm: TDocForm;
    SrcList: TListBox;
    SrcFormId: TObject;
  end;


  //This is used to set drag Cell Response IDs into a cell
  //RspID are used to assoc a response list in a particlar file with a cell
  //Primarily for Form Designer Person
  TDragID = class(TDragObjectEx)
    KindID: Integer;      //residential
    ID: Integer;          //the global ID within Kind
    IDName: String;       //Name of the ID
  end;

  TDragRspID  = class(TDragID);      //class for Rsp IDs
  TDragCellID = Class(TDragID);      //Class for Cell IDs
  TDragCntxID = Class(TDragID);      //Class for Cell Context IDs
  
Implementation

end.
