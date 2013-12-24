//compressible grid surface

import processing.pdf.*;

int tessCols = 7;//num of columns in tessellation
int tessRows = 6;//num of rows in tessellation
float cornerOffset = 0.5;//offset oftessellated area from top left corner (inches)
float gridSize = 2;//the size of the tesselated grid (inches)
float kerf = 0.05;//add extra spacing between tiles (inches)
String filename = "GlideReflection";

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
  
  line(0,kerf/2,tessCols*gridSize,kerf/2);
  for (int i=0;i<tessRows;i++){
    if (kerf>0) {
      line(0,gridSize*(i+0.5)+kerf/2,tessCols*gridSize,gridSize*(i+0.5)+kerf/2);
      if (i<tessRows-1) line(0,gridSize*(i+1)+kerf/2,tessCols*gridSize,gridSize*(i+1)+kerf/2);
    }
    line(0,gridSize*(i+0.5)-kerf/2,tessCols*gridSize,gridSize*(i+0.5)-kerf/2);
    line(0,gridSize*(i+1)-kerf/2,tessCols*gridSize,gridSize*(i+1)-kerf/2);
  }
  
  line(kerf/2,0,kerf/2,tessRows*gridSize);
  boolean verticalOffset = false;
  float fortyFiveKerfOffset = kerf*sqrt(2)/2;
  for (int i=0;i<tessCols;i++){
    if (kerf>0 && i<tessCols-1) line(gridSize*(i+1)+kerf/2,0,gridSize*(i+1)+kerf/2,tessRows*gridSize);
    line(gridSize*(i+1)-kerf/2,0,gridSize*(i+1)-kerf/2,tessRows*gridSize);
    for (int j=0;j<tessRows;j++){
      if (verticalOffset){
        line((i+0.5)*gridSize,j*gridSize+fortyFiveKerfOffset,i*gridSize,(j+0.5)*gridSize+fortyFiveKerfOffset);
        line((i+0.5)*gridSize,j*gridSize+fortyFiveKerfOffset,(i+1)*gridSize,(j+0.5)*gridSize+fortyFiveKerfOffset);
        line(i*gridSize,(j+0.5)*gridSize+fortyFiveKerfOffset,(i+0.5)*gridSize,(j+1)*gridSize+fortyFiveKerfOffset);
        line((i+1)*gridSize,(j+0.5)*gridSize+fortyFiveKerfOffset,(i+0.5)*gridSize,(j+1)*gridSize+fortyFiveKerfOffset);
      } else {
        line(i*gridSize,j*gridSize+fortyFiveKerfOffset,(i+1)*gridSize,(j+1)*gridSize+fortyFiveKerfOffset);
        line((i+1)*gridSize,j*gridSize+fortyFiveKerfOffset,i*gridSize,(j+1)*gridSize+fortyFiveKerfOffset);
      }
      if (kerf>0){
        if (verticalOffset){
          line((i+0.5)*gridSize,j*gridSize-fortyFiveKerfOffset,i*gridSize,(j+0.5)*gridSize-fortyFiveKerfOffset);
          line((i+0.5)*gridSize,j*gridSize-fortyFiveKerfOffset,(i+1)*gridSize,(j+0.5)*gridSize-fortyFiveKerfOffset);
          line(i*gridSize,(j+0.5)*gridSize-fortyFiveKerfOffset,(i+0.5)*gridSize,(j+1)*gridSize-fortyFiveKerfOffset);
          line((i+1)*gridSize,(j+0.5)*gridSize-fortyFiveKerfOffset,(i+0.5)*gridSize,(j+1)*gridSize-fortyFiveKerfOffset);
        } else {
          line(i*gridSize,j*gridSize-fortyFiveKerfOffset,(i+1)*gridSize,(j+1)*gridSize-fortyFiveKerfOffset);
          line((i+1)*gridSize,j*gridSize-fortyFiveKerfOffset,i*gridSize,(j+1)*gridSize-fortyFiveKerfOffset);
        }
      }
    }
    verticalOffset = !verticalOffset;
  }

  endRecord();
  exit();
  println("finished");
}

void scaleAllVariables(int dpi){
  cutterWidth*=dpi;
  cutterHeight*=dpi;
  cornerOffset*=dpi;
  gridSize*=dpi;
  kerf*=dpi;
}
