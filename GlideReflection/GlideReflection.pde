//compressible grid surface

import processing.pdf.*;

int tessCols = 7;//num of columns in tessellation
int tessRows = 6;//num of rows in tessellation
float cornerOffset = 0.5;//offset oftessellated area from top left corner (inches)
float gridSize = 2;//the size of the tesselated grid (inches)
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
  
  line(0,0,tessCols*gridSize,0);
  for (int i=0;i<tessRows;i++){
    line(0,gridSize*(i+0.5),tessCols*gridSize,gridSize*(i+0.5));
    line(0,gridSize*(i+1),tessCols*gridSize,gridSize*(i+1));
  }
  line(0,0,0,tessRows*gridSize);
  boolean verticalOffset = false;
  for (int i=0;i<tessCols;i++){
    line(gridSize*(i+1),0,gridSize*(i+1),tessRows*gridSize);
    for (int j=0;j<tessRows;j++){
      if (verticalOffset){
        line((i+0.5)*gridSize,j*gridSize,i*gridSize,(j+0.5)*gridSize);
        line((i+0.5)*gridSize,j*gridSize,(i+1)*gridSize,(j+0.5)*gridSize);
        line(i*gridSize,(j+0.5)*gridSize,(i+0.5)*gridSize,(j+1)*gridSize);
        line((i+1)*gridSize,(j+0.5)*gridSize,(i+0.5)*gridSize,(j+1)*gridSize);
      } else {
        line(i*gridSize,j*gridSize,(i+1)*gridSize,(j+1)*gridSize);
        line((i+1)*gridSize,j*gridSize,i*gridSize,(j+1)*gridSize);
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
}
