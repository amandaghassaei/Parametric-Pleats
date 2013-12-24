//equalateral triangle tessellation

import processing.pdf.*;

int tessCols = 10;//num of columns in tessellation
int tessRows = 10;//num of rows in tessellation
float cornerOffset = 0.5;//offset oftessellated area from top left corner (inches)
boolean drawBorder = true;//cutlines around square border of tessellated area
float triSize = 1;//the length of each side of the triangle
float kerf = 0.1;//add extra spacing between tiles (inches)
String filename = "TriTessellation";

int cutterWidth = 36;//width of laser cutter (inches)
int cutterHeight = 24;//height of laser cutter (inches)

void setup(){
  
  int dpi = 72;//processing exports at 72 dpi by default
  scaleAllVariables(dpi);
  
  size(cutterWidth,cutterHeight);
  beginRecord(PDF, filename + ".pdf");//save as PDF
  background(255);//white background
  strokeWeight(0.001);//hairline width
  stroke(0);//black lines
  
  pushMatrix();
  translate(cornerOffset,cornerOffset);
  
  boolean flipOrientation = false;
  line(0,kerf/2,tessCols*triSize,kerf/2);
  for (int i=0;i<tessRows;i++){
    float top = i*sqrt(3)*triSize/2;
    float bottom = (i+1)*sqrt(3)*triSize/2;
    if (flipOrientation){
      line(0,bottom-kerf/2,tessCols*triSize,bottom-kerf/2);
      if (kerf>0 && i<tessRows-1) line(0,bottom+kerf/2,tessCols*triSize,bottom+kerf/2);
      for (int j=0;j<tessCols;j++){
        line(j*triSize,bottom-kerf,j*triSize+triSize/2,top-kerf);
        line(j*triSize+triSize/2,top-kerf,(j+1)*triSize,bottom-kerf);
        if (kerf>0){
          line(j*triSize,bottom+kerf,j*triSize+triSize/2,top+kerf);
          line(j*triSize+triSize/2,top+kerf,(j+1)*triSize,bottom+kerf);
        }
      }
    } else {
      if (drawBorder){
        line(0,bottom-kerf/2,tessCols*triSize,bottom-kerf/2);
        if (kerf>0 && i<tessRows-1) line(0,bottom+kerf/2,tessCols*triSize,bottom+kerf/2);
      } else {
        line(triSize/2,bottom-kerf/2,tessCols*triSize-triSize/2,bottom-kerf/2);
        if (kerf>0 && i<tessRows-1) line(triSize/2,bottom+kerf/2,tessCols*triSize-triSize/2,bottom+kerf/2);
      }
      for (int j=0;j<tessCols;j++){
        line(j*triSize,top+kerf,j*triSize+triSize/2,bottom+kerf);
        line(j*triSize+triSize/2,bottom+kerf,(j+1)*triSize,top+kerf);
        if (kerf>0){
          line(j*triSize,top-kerf,j*triSize+triSize/2,bottom-kerf);
          line(j*triSize+triSize/2,bottom-kerf,(j+1)*triSize,top-kerf);
        }
      }
    }
    flipOrientation = !flipOrientation;//toggle orientation
  }
  
  if (drawBorder){
    line(tessCols*triSize-kerf/2,0,tessCols*triSize-kerf/2,tessRows*sqrt(3)*triSize/2);
    line(kerf/2,0,kerf/2,tessRows*sqrt(3)*triSize/2);
  }
  
  endRecord();
  exit();
  println("finished");
}

void scaleAllVariables(int dpi){
  cutterWidth*=dpi;
  cutterHeight*=dpi;
  cornerOffset*=dpi;
  triSize*=dpi;
  kerf*=dpi;
}
