//v pleat lamp

import processing.pdf.*;

float cornerOffset = 0.5;//offset of geometry from top left corner of laser bed (inches)
String filename = "PleatedLamp";

int numPleats = 10;//number of pleats (must be even)
float pleatWidth = 0.5;//pleat width (inches)
float pleatHeight = 10;//pleat height (inches)

int cutterWidth = 36;//width of laser cutter (inches)
int cutterHeight = 24;//height of laser cutter (inches)
int dpi = 72;//processing exports at 72 dpi by default

void setup(){
  
  ArrayList<float[]> profileVertices = createProfileGeometry();
  drawPleat2DGeometry(profileVertices);
  
}

void drawPleat2DGeometry(ArrayList<float[]> profileVertices) {
  scaleAll2DVariables();
  
  size(cutterWidth,cutterHeight);
  beginRecord(PDF, filename + ".pdf");//save as PDF
  background(255);//white background
  strokeWeight(0.001);//hairline width
  stroke(0);//black lines
  noFill();
  
  pushMatrix();
  translate(cornerOffset,cornerOffset);
  
  drawParallelPleats();
  boolean flippedOrientation = false;
  for (float[] _vertex : profileVertices){
    drawVPleat(_vertex[0], _vertex[1], flippedOrientation);
    flippedOrientation = !flippedOrientation;//you must flip the orientation of the V pleats after each pleat
  }
  endRecord();
  exit();
}

void drawParallelPleats(){
  for (int i=0;i<numPleats;i++){
    float x = i*pleatWidth;
    line(x,0,x,pleatHeight);
  }
  line(pleatWidth*numPleats,0,pleatWidth*numPleats,pleatHeight);
}

void drawVPleat(float vertexPosition, float vertexAngle, boolean flipped){
  float vertexHeight = pleatWidth/tan(vertexAngle);
  float vertexTop = vertexPosition - vertexHeight/2;
  float vertexBottom = vertexPosition + vertexHeight/2;
  beginShape();
  for (int i=0;i<numPleats+1;i++){
    if (flipped){
      vertex(i*pleatWidth,vertexTop);
    } else {
      vertex(i*pleatWidth,vertexBottom);
    }
    flipped = !flipped;
  }
  endShape();
}

ArrayList<float[]> createProfileGeometry(){
  //only angles between PI/2 and -PI/2
  ArrayList<float[]> profileGeo = new ArrayList<float[]>();
  float[] vertex1 = {3,-PI/4};
  profileGeo.add(vertex1);
  float[] vertex2 = {9,-PI/4};
  profileGeo.add(vertex2);
  for (float[] _vertex : profileGeo){
    _vertex[0] *= dpi;
  }
  return profileGeo;
}

void scaleAll2DVariables(){
  pleatHeight*=dpi;
  pleatWidth*=dpi;
  cornerOffset*=dpi;
  cutterWidth*=dpi;
  cutterHeight*=dpi;
}
