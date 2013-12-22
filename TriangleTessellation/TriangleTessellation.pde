//equalateral triangle tessellation

import processing.pdf.*;

int tessCols = 10;//num of columns in tessellation
int tessRows = 10;//num of rows in tessellation
float cornerOffset = 0.5;//offset oftessellated area from top left corner (inches)
boolean drawBorder = true;//cutlines around square border of tessellated area
float triSize = 1;//the length of each side of the triangle
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
  line(0,0,tessCols*triSize,0);
  for (int i=0;i<tessRows;i++){
    float top = i*sqrt(3)*triSize/2;
    float bottom = (i+1)*sqrt(3)*triSize/2;
    if (flipOrientation){
      line(0,bottom,tessCols*triSize,bottom);
      for (int j=0;j<tessCols;j++){
        line(j*triSize,bottom,j*triSize+triSize/2,top);
        line(j*triSize+triSize/2,top,(j+1)*triSize,bottom);
      }
    } else {
      if (drawBorder){
        line(0,bottom,tessCols*triSize,bottom);
      } else {
        line(triSize/2,bottom,tessCols*triSize-triSize/2,bottom);
      }
      for (int j=0;j<tessCols;j++){
        line(j*triSize,top,j*triSize+triSize/2,bottom);
        line(j*triSize+triSize/2,bottom,(j+1)*triSize,top);
      }
    }
    flipOrientation = !flipOrientation;//toggle orientation
  }
  
  if (drawBorder){
    line(tessCols*triSize,0,tessCols*triSize,tessRows*sqrt(3)*triSize/2);
    line(0,0,0,tessRows*sqrt(3)*triSize/2);
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
}
