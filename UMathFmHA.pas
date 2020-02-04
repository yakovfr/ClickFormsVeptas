unit UMathFmHA;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2006 by Bradford Technologies, Inc. }


interface

uses
  UGlobals, UContainer;

const
  fmFarmTract         = 498;
  fmFSAMineralRights  = 963;



  function ProcessForm0498Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0963Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

implementation

uses
	Dialogs, SysUtils, Math,
	UUtil1, UStatus, UBase, UForm, UPage, UCell, UMath, UStrings;




function F0963_FutureIncome(doc: TContainer; CX: CellUID; U1, P1, R1, C1, CellR: Integer): Integer;
var
  VR, VCost: Double;
begin
  VR := MultiplyCells(doc, CX, [U1,P1,R1]);
  VCost := GetCellVaLue(doc, mcx(cx,C1));
  VR := VR - VCost;
  result := SetCellValue(doc, mcx(cx,CellR), VR);
end;



function ProcessForm0498Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
      //Page 4
        1:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [2, 10]);
        2:
          cmd := MultAB(doc, mcx(cx, 5), mcx(cx, 10), mcx(cx, 11));
        3:
          cmd := SumCellArray(doc, cx, [11, 19, 27, 35, 43, 51, 59], 63);
        4:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [5, 10]);
        5:
          cmd := MultAB(doc, mcx(cx, 13), mcx(cx, 18), mcx(cx, 19));
        6:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [7, 10]);
        7:
          cmd := MultAB(doc, mcx(cx, 21), mcx(cx, 26), mcx(cx, 27));
        8:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [9, 10]);
        9:
          cmd := MultAB(doc, mcx(cx, 29), mcx(cx, 34), mcx(cx, 35));
        10:
          cmd := SumCellArray(doc, cx, [5, 13, 21, 29, 37, 45, 53], 60);
        11:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [12, 10]);
        12:
          cmd := MultAB(doc, mcx(cx, 37), mcx(cx, 42), mcx(cx, 43));
        13:
          cmd := DivideAB(doc, mcx(cx, 63), mcx(cx, 60), mcx(cx, 62));
        14:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [15, 10]);
        15:
          cmd := MultAB(doc, mcx(cx, 45), mcx(cx, 50), mcx(cx, 51));
        16:
          cmd := SumCellArray(doc, cx, [60, 64, 72, 80, 88, 95, 102, 109], 116);
        17:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [18, 10]);
        18:
          cmd := MultAB(doc, mcx(cx, 53), mcx(cx, 58), mcx(cx, 59));
        19:
          cmd := SumCellArray(doc, cx, [63, 70, 78, 86, 94, 101, 108, 115], 118);
        20:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [13, 16]);
        21:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [13, 19]);
        22:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [23, 16]);
        23:
          cmd := MultAB(doc, mcx(cx, 64), mcx(cx, 69), mcx(cx, 70));
        24:
          cmd := SumCellArray(doc, cx, [132, 144, 156, 168, 180, 192, 204, 216, 228, 240, 252, 264, 276, 288, 300], 304);
        25:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [26, 16]);
        26:
          cmd := MultAB(doc, mcx(cx, 72), mcx(cx, 77), mcx(cx, 78));
        27:
          cmd := SumCellArray(doc, cx, [122, 306], 310);
        28:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [29, 16]);
        29:
          cmd := MultAB(doc, mcx(cx, 80), mcx(cx, 85), mcx(cx, 86));
        30:
          cmd := DivideAB(doc, mcx(cx, 306), mcx(cx, 116), mcx(cx, 307));
        31:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [32, 16]);
        32:
          cmd := MultAB(doc, mcx(cx, 88), mcx(cx, 93), mcx(cx, 94));
        34:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [35, 16]);
        35:
          cmd := MultAB(doc, mcx(cx, 95), mcx(cx, 100), mcx(cx, 101));
        37:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [38, 16]);
        38:
          cmd := MultAB(doc, mcx(cx, 102), mcx(cx, 107), mcx(cx, 108));
        40:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [41, 16]);
        41:
          cmd := MultAB(doc, mcx(cx, 109), mcx(cx, 114), mcx(cx, 115));
        42:
          cmd := DivideAB(doc, mcx(cx, 118), mcx(cx, 116), mcx(cx, 117));
        43:  //this cell does a lot of processing...
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [42, 30, 80, 98, 99, 100, 101, 102, 103, 104, 105, 106]);
        44:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [42, 46]);
        45:
          cmd := MultAB(doc, mcx(cx, 119), mcx(cx, 120), mcx(cx, 121));
        46:
          cmd := SumCellArray(doc, cx, [118, 121], 122);
        47:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [24, 48]);
        48:
          cmd := MultPercentAB(doc, mcx(cx, 132), mcx(cx, 133), mcx(cx, 134));
        49:
          cmd := SumCellArray(doc, cx, [134, 146, 158, 170, 182, 194, 206, 218, 230, 242, 254, 266, 278, 290, 302], 305);
        50:
          cmd := SumCellArray(doc, cx, [135, 147, 159, 171, 183, 195, 207, 219, 231, 243, 255, 267, 279, 291, 303], 306);
        51:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [24, 52]);
        52:
          cmd := MultPercentAB(doc, mcx(cx, 144), mcx(cx, 145), mcx(cx, 146));
        53:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [24, 54]);
        54:
          cmd := MultPercentAB(doc, mcx(cx, 156), mcx(cx, 157), mcx(cx, 158));
        55:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [24, 56]);
        56:
          cmd := MultPercentAB(doc, mcx(cx, 168), mcx(cx, 169), mcx(cx, 170));
        57:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [24, 58]);
        58:
          cmd := MultPercentAB(doc, mcx(cx, 180), mcx(cx, 181), mcx(cx, 182));
        59:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [24, 60]);
        60:
          cmd := MultPercentAB(doc, mcx(cx, 192), mcx(cx, 193), mcx(cx, 194));
        61:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [24, 62]);
        62:
          cmd := MultPercentAB(doc, mcx(cx, 204), mcx(cx, 205), mcx(cx, 206));
        63:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [24, 64]);
        64:
          cmd := MultPercentAB(doc, mcx(cx, 216), mcx(cx, 217), mcx(cx, 218));
        65:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [24, 66]);
        66:
          cmd := MultPercentAB(doc, mcx(cx, 228), mcx(cx, 229), mcx(cx, 230));
        67:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [24, 68]);
        68:
          cmd := MultPercentAB(doc, mcx(cx, 240), mcx(cx, 241), mcx(cx, 242));
        69:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [24, 70]);
        70:
          cmd := MultPercentAB(doc, mcx(cx, 252), mcx(cx, 253), mcx(cx, 254));
        71:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [24, 72]);
        72:
          cmd := MultPercentAB(doc, mcx(cx, 264), mcx(cx, 265), mcx(cx, 266));
        73:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [24, 74]);
        74:
          cmd := MultPercentAB(doc, mcx(cx, 276), mcx(cx, 277), mcx(cx, 278));
        75:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [24, 76]);
        76:
          cmd := MultPercentAB(doc, mcx(cx, 288), mcx(cx, 289), mcx(cx, 290));
        77:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [24, 78]);
        78:
          cmd := MultPercentAB(doc, mcx(cx, 300), mcx(cx, 301), mcx(cx, 302));
        79:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [27, 30]);
        80:
          cmd := DivideAB(doc, mcx(cx, 310), mcx(cx, 116), mcx(cx, 309));
      //Page 5
        81:
          cmd := DivideAB(doc, mcx(cx, 8), mcx(cx, 7), mcx(cx, 9));
        82:
          cmd := DivideAB(doc, mcx(cx, 20), mcx(cx, 19), mcx(cx, 21));
        83:
          cmd := DivideAB(doc, mcx(cx, 32), mcx(cx, 31), mcx(cx, 33));
        84:
          cmd := DivideAB(doc, mcx(cx, 44), mcx(cx, 43), mcx(cx, 45));
        85:
          cmd := DivideAB(doc, mcx(cx, 56), mcx(cx, 55), mcx(cx, 57));
        86:
          cmd := DivideAB(doc, mcx(cx, 68), mcx(cx, 67), mcx(cx, 69));
        87:
          cmd := DivideAB(doc, mcx(cx, 80), mcx(cx, 79), mcx(cx, 81));
        88:
          cmd := DivideAB(doc, mcx(cx, 92), mcx(cx, 91), mcx(cx, 93));
        89:
          cmd := SumCellArray(doc, cx, [9, 10, 11, 12, 13, 14], 15);
        90:
          cmd := SumCellArray(doc, cx, [21, 22, 23, 24, 25, 26], 27);
        91:
          cmd := SumCellArray(doc, cx, [33, 34, 35, 36, 37, 38], 39);
        92:
          cmd := SumCellArray(doc, cx, [45, 46, 47, 48, 49, 50], 51);
        93:
          cmd := SumCellArray(doc, cx, [57, 58, 59, 60, 61, 62], 63);
        94:
          cmd := SumCellArray(doc, cx, [69, 70, 71, 72, 73, 74], 75);
        95:
          cmd := SumCellArray(doc, cx, [81, 82, 83, 84, 85, 86], 87);
        96:
          cmd := SumCellArray(doc, cx, [93, 94, 95, 96, 97, 98], 99);
        98:
          cmd := MultAB(doc, mcx(cx, 15), mcpx(cx, 4, 116), mcpx(cx, 5, 16));
        99:
          cmd := MultAB(doc, mcx(cx, 27), mcpx(cx, 4, 116), mcpx(cx, 5, 28));
        100:
          cmd := MultAB(doc, mcx(cx, 39), mcpx(cx, 4, 116), mcpx(cx, 5, 40));
        101:
          cmd := MultAB(doc, mcx(cx, 51), mcpx(cx, 4, 116), mcpx(cx, 5, 52));
        102:
          cmd := MultAB(doc, mcx(cx, 63), mcpx(cx, 4, 116), mcpx(cx, 5, 64));
        103:
          cmd := MultAB(doc, mcx(cx, 75), mcpx(cx, 4, 116), mcpx(cx, 5, 76));
        104:
          cmd := MultAB(doc, mcx(cx, 87), mcpx(cx, 4, 116), mcpx(cx, 5, 88));
        105:
          cmd := MultAB(doc, mcx(cx, 99), mcpx(cx, 4, 116), mcpx(cx, 5, 100));
        106:
          cmd := MultAB(doc, mcx(cx, 101), mcpx(cx, 4, 116), mcpx(cx, 5, 102));
      //Page 6
        39:
          cmd := SumCellArray(doc, cx, [6, 14, 22, 30, 38, 46, 54, 62, 70, 78, 86, 94, 102, 110, 118, 126, 133, 136, 143, 150, 151], 157);
        107:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [39, 108]);
        108:
          cmd := MultAB(doc, mcx(cx, 6), mcx(cx, 7), mcx(cx, 8));
        109:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [39, 110]);
        110:
          cmd := MultAB(doc, mcx(cx, 14), mcx(cx, 15), mcx(cx, 16));
        111:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [39, 112]);
        112:
          cmd := MultAB(doc, mcx(cx, 22), mcx(cx, 23), mcx(cx, 24));
        113:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [39, 114]);
        114:
          cmd := MultAB(doc, mcx(cx, 30), mcx(cx, 31), mcx(cx, 32));
        115:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [39, 116]);
        116:
          cmd := MultAB(doc, mcx(cx, 38), mcx(cx, 39), mcx(cx, 40));
        117:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [39, 118]);
        118:
          cmd := MultAB(doc, mcx(cx, 46), mcx(cx, 47), mcx(cx, 48));
        208:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [39, 119]);
        119:
          cmd := MultAB(doc, mcx(cx, 54), mcx(cx, 55), mcx(cx, 56));
        120:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [39, 121]);
        121:
          cmd := MultAB(doc, mcx(cx, 62), mcx(cx, 63), mcx(cx, 64));
        122:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [39, 123]);
        123:
          cmd := MultAB(doc, mcx(cx, 70), mcx(cx, 71), mcx(cx, 72));
        124:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [39, 125]);
        125:
          cmd := MultAB(doc, mcx(cx, 78), mcx(cx, 79), mcx(cx, 80));
        126:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [39, 127]);
        127:
          cmd := MultAB(doc, mcx(cx, 86), mcx(cx, 87), mcx(cx, 88));
        128:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [39, 129]);
        129:
          cmd := MultAB(doc, mcx(cx, 94), mcx(cx, 95), mcx(cx, 96));
        130:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [39, 131]);
        131:
          cmd := MultAB(doc, mcx(cx, 102), mcx(cx, 103), mcx(cx, 104));
        132:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [39, 133]);
        133:
          cmd := MultAB(doc, mcx(cx, 110), mcx(cx, 111), mcx(cx, 112));
        134:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [39, 135]);
        135:
          cmd := MultAB(doc, mcx(cx, 118), mcx(cx, 119), mcx(cx, 120));
        136:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [39, 137]);
        137:
          cmd := MultAB(doc, mcx(cx, 126), mcx(cx, 127), mcx(cx, 128));
        138:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [39, 139]);
        139:
          cmd := MultAB(doc, mcx(cx, 136), mcx(cx, 137), mcx(cx, 138));
        209:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [39, 140]);
        140:
          cmd := MultAB(doc, mcx(cx, 143), mcx(cx, 144), mcx(cx, 145));
        141:
          cmd := MultAB(doc, mcx(cx, 8), mcx(cx, 9), mcx(cx, 10));
        142:
          cmd := MultAB(doc, mcx(cx, 16), mcx(cx, 17), mcx(cx, 18));
        143:
          cmd := MultAB(doc, mcx(cx, 24), mcx(cx, 25), mcx(cx, 26));
        144:
          cmd := MultAB(doc, mcx(cx, 32), mcx(cx, 33), mcx(cx, 34));
        145:
          cmd := MultAB(doc, mcx(cx, 40), mcx(cx, 41), mcx(cx, 42));
        146:
          cmd := MultAB(doc, mcx(cx, 48), mcx(cx, 49), mcx(cx, 50));
        147:
          cmd := MultAB(doc, mcx(cx, 56), mcx(cx, 57), mcx(cx, 58));
        148:
          cmd := MultAB(doc, mcx(cx, 64), mcx(cx, 65), mcx(cx, 66));
        149:
          cmd := MultAB(doc, mcx(cx, 72), mcx(cx, 73), mcx(cx, 74));
        150:
          cmd := MultAB(doc, mcx(cx, 80), mcx(cx, 81), mcx(cx, 82));
        151:
          cmd := MultAB(doc, mcx(cx, 88), mcx(cx, 89), mcx(cx, 90));
        152:
          cmd := MultAB(doc, mcx(cx, 96), mcx(cx, 97), mcx(cx, 98));
        153:
          cmd := MultAB(doc, mcx(cx, 104), mcx(cx, 105), mcx(cx, 106));
        154:
          cmd := MultAB(doc, mcx(cx, 112), mcx(cx, 113), mcx(cx, 114));
        155:
          cmd := MultAB(doc, mcx(cx, 120), mcx(cx, 121), mcx(cx, 122));
        156:
          cmd := MultAB(doc, mcx(cx, 128), mcx(cx, 129), mcx(cx, 130));
        157:
          cmd := MultAB(doc, mcx(cx, 138), mcx(cx, 139), mcx(cx, 140));
        158:
          cmd := MultAB(doc, mcx(cx, 145), mcx(cx, 146), mcx(cx, 147));
        159:
          cmd := MultAB(doc, mcx(cx, 152), mcx(cx, 153), mcx(cx, 154));
        36:
          cmd := SumCellArray(doc, cx, [10, 18, 26, 34, 42, 50, 58, 66, 74, 82, 90, 98, 106, 114, 122, 130, 140, 147, 154], 158);
        160:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [36, 179]);
        161:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [36, 180]);
        162:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [36, 181]);
        163:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [36, 182]);
        164:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [36, 183]);
        165:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [36, 184]);
        166:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [36, 185]);
        167:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [36, 186]);
        168:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [36, 187]);
        169:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [36, 188]);
        170:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [36, 189]);
        171:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [36, 190]);
        172:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [36, 191]);
        173:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [36, 192]);
        174:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [36, 193]);
        175:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [36, 194]);
        176:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [36, 196]);
        177:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [36, 197]);
        178:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [36, 198]);
        179:
          cmd := MultPercentAB(doc, mcx(cx, 10), mcx(cx, 11), mcx(cx, 12));
        180:
          cmd := MultPercentAB(doc, mcx(cx, 18), mcx(cx, 19), mcx(cx, 20));
        181:
          cmd := MultPercentAB(doc, mcx(cx, 26), mcx(cx, 27), mcx(cx, 28));
        182:
          cmd := MultPercentAB(doc, mcx(cx, 34), mcx(cx, 35), mcx(cx, 36));
        183:
          cmd := MultPercentAB(doc, mcx(cx, 42), mcx(cx, 43), mcx(cx, 44));
        184:
          cmd := MultPercentAB(doc, mcx(cx, 50), mcx(cx, 51), mcx(cx, 52));
        185:
          cmd := MultPercentAB(doc, mcx(cx, 58), mcx(cx, 59), mcx(cx, 60));
        186:
          cmd := MultPercentAB(doc, mcx(cx, 66), mcx(cx, 67), mcx(cx, 68));
        187:
          cmd := MultPercentAB(doc, mcx(cx, 74), mcx(cx, 75), mcx(cx, 76));
        188:
          cmd := MultPercentAB(doc, mcx(cx, 82), mcx(cx, 83), mcx(cx, 84));
        189:
          cmd := MultPercentAB(doc, mcx(cx, 90), mcx(cx, 91), mcx(cx, 92));
        190:
          cmd := MultPercentAB(doc, mcx(cx, 98), mcx(cx, 99), mcx(cx, 100));
        191:
          cmd := MultPercentAB(doc, mcx(cx, 106), mcx(cx, 107), mcx(cx, 108));
        192:
          cmd := MultPercentAB(doc, mcx(cx, 114), mcx(cx, 115), mcx(cx, 116));
        193:
          cmd := MultPercentAB(doc, mcx(cx, 122), mcx(cx, 123), mcx(cx, 124));
        194:
          cmd := MultPercentAB(doc, mcx(cx, 130), mcx(cx, 131), mcx(cx, 132));
        195:
          Cmd := MultAByVal(doc, mcx(cx,134), mcx(cx,135), 12.0);
        196:
          cmd := MultPercentAB(doc, mcx(cx, 140), mcx(cx, 141), mcx(cx, 142));
        197:
          cmd := MultPercentAB(doc, mcx(cx, 147), mcx(cx, 148), mcx(cx, 149));
        198:
          cmd := MultPercentAB(doc, mcx(cx, 154), mcx(cx, 155), mcx(cx, 156));
        199:
          cmd := SumCellArray(doc, cx, [12, 20, 28, 36, 44, 52, 60, 68, 76, 84, 92, 100, 108, 116, 124, 132, 135, 142, 149, 156], 159);
        200:
          cmd := SumCellArray(doc, cx, [160, 162, 164, 165, 166, 168, 169, 171, 173, 175], 177);
        201:
          cmd := MultPercentAB(doc, mcx(cx, 159), mcx(cx, 167), mcx(cx, 168));
        202:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [201, 210, 211]);
        203:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [210, 211, 212]);
        204:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [212, 213]);
        205:
          cmd := DivideABPercent(doc, mcx(cx, 179), mcx(cx, 180), mcx(cx, 182));
        206:
          cmd := SumCellArray(doc, cx, [183, 182], 184);
        207:
          cmd := ProcessMultipleCmds(ProcessForm0498Math, doc, cx, [206, 213]);
        210:
          cmd := PercentAOfB(doc, mcx(cx, 177), mcx(cx, 159), mcx(cx, 178));
        211:
          cmd := SubtAB(doc, mcx(cx,159), mcx(CX,177), mcx(CX,179));
        212:
          cmd := DivideAB(doc, mcx(cx, 177), mcx(cx, 157), mcx(cx, 176));
        213:
          cmd := DivideAB(doc, mcx(cx, 182), mcx(cx, 157), mcx(cx, 181));
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

{math for FSA Mineral Rights form - 963}
function ProcessForm0963Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
      //Page 1
        1:
          cmd := SumABC(doc, MCX(CX,11), MCX(CX,13), MCX(CX,15), MCX(CX,16));    //sum acres
      //page 3  - production
        3:
          cmd := MultABC(doc, MCX(CX,6), MCX(CX,7), MCX(CX,8), MCX(CX,9));       //1 units*price*royalty = return
        4:
          cmd := MultABC(doc, MCX(CX,11), MCX(CX,12), MCX(CX,13), MCX(CX,14));       //2 units*price*royalty = return
        5:
          cmd := MultABC(doc, MCX(CX,16), MCX(CX,17), MCX(CX,18), MCX(CX,19));       //3 units*price*royalty = return
        6:
          cmd := MultABC(doc, MCX(CX,21), MCX(CX,22), MCX(CX,23), MCX(CX,24));       //4 units*price*royalty = return
        7:
          cmd := MultABC(doc, MCX(CX,26), MCX(CX,27), MCX(CX,28), MCX(CX,29));       //5 units*price*royalty = return
        8:
          cmd := MultABC(doc, MCX(CX,31), MCX(CX,32), MCX(CX,33), MCX(CX,34));       //6 units*price*royalty = return
        9:
          cmd := MultABC(doc, MCX(CX,36), MCX(CX,37), MCX(CX,38), MCX(CX,39));       //7 units*price*royalty = return
        10:
          cmd := AvgCellsR(doc, CX, [9,14,19,24,29,34,39], 40);                     //average gross returns
        11:
          cmd := SubtAB(doc, mcx(cx,40), mcx(cx,41), mcx(cx,42));                    // net income
        //futures
        12:
          cmd := MultABC(doc, MCX(CX,44), MCX(CX,45), MCX(CX,46), MCX(CX,47));       //1 units*price*royalty = return
        13:
          cmd := MultABC(doc, MCX(CX,49), MCX(CX,50), MCX(CX,51), MCX(CX,52));       //2 units*price*royalty = return
        14:
          cmd := MultABC(doc, MCX(CX,54), MCX(CX,55), MCX(CX,56), MCX(CX,57));       //3 units*price*royalty = return
        15:
          cmd := MultABC(doc, MCX(CX,59), MCX(CX,60), MCX(CX,61), MCX(CX,62));       //4 units*price*royalty = return
        16:
          cmd := MultABC(doc, MCX(CX,64), MCX(CX,65), MCX(CX,66), MCX(CX,67));       //5 units*price*royalty = return
        17:
          cmd := AvgCellsR(doc, CX, [47,52,57,62,67], 68);                           //average gross returns
        18:
          cmd := SubtAB(doc, mcx(cx,68), mcx(cx,69), mcx(cx,70));                    // net income

        19:
          cmd := DivideAB(doc, mcx(cx,71), mcx(cx,72), mcx(cx,73));                  //cap rate

        20:
          cmd := MultAB(doc, mcx(cx,75), mcx(cx,76), mcx(cx,77));                    //1 unit x price
        21:
          cmd := MultAB(doc, mcx(cx,83), mcx(cx,84), mcx(cx,85));                     //2 unit x price
        22:
          cmd := MultAB(doc, mcx(cx,91), mcx(cx,92), mcx(cx,93));                    //3 unit x price
        23:
          cmd := MultAB(doc, mcx(cx,99), mcx(cx,100), mcx(cx,101));                  //4 unit x price
        24:
          cmd := MultAB(doc, mcx(cx,107), mcx(cx,108), mcx(cx,109));                 //5 unit x price
        25:
          cmd := MultAB(doc, mcx(cx,115), mcx(cx,116), mcx(cx,117));                 //6 unit x price

        26:
          cmd := SubtAB(doc, mcx(cx,79), mcx(cx,80), mcx(cx,81));                     //1 Net - discount
        27:
          cmd := SubtAB(doc, mcx(cx,87), mcx(cx,88), mcx(cx,89));                     //2 Net - discount
        28:
          cmd := SubtAB(doc, mcx(cx,95), mcx(cx,96), mcx(cx,97));                     //3 Net - discount
        29:
          cmd := SubtAB(doc, mcx(cx,103), mcx(cx,104), mcx(cx,105));                  //4 Net - discount
        30:
          cmd := SubtAB(doc, mcx(cx,111), mcx(cx,112), mcx(cx,113));                  //5 Net - discount
        31:
          cmd := SubtAB(doc, mcx(cx,119), mcx(cx,120), mcx(cx,121));                  //6 Net - discount

        32:
          cmd := SumCellArray(doc, CX, [81,89,97,105,113,121], 122);                  //present value of future income
        33:
          cmd := 0;   //there is a sum of values (not sure what values)

        34:
          cmd := SubtAB(doc, mcx(cx,77), mcx(cx,78), mcx(cx,79));                     //1 royalty - costs
        35:
          cmd := SubtAB(doc, mcx(cx,85), mcx(cx,86), mcx(cx,87));                     //2 royalty - costs
        36:
          cmd := SubtAB(doc, mcx(cx,93), mcx(cx,94), mcx(cx,95));                     //3 royalty - costs
        37:
          cmd := SubtAB(doc, mcx(cx,101), mcx(cx,102), mcx(cx,103));                  //4 royalty - costs
        38:
          cmd := SubtAB(doc, mcx(cx,109), mcx(cx,110), mcx(cx,111));                  //5 royalty - costs
        39:
          cmd := SubtAB(doc, mcx(cx,117), mcx(cx,118), mcx(cx,119));                  //6 royalty - costs

      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;


end.
