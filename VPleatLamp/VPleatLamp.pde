//v pleat lamp

import processing.pdf.*;
import processing.opengl.*;

int numPleats = 10;//number of pleats (must be even)
float pleatWidth = 0.5;//pleat width (inches)
float pleatHeight = 10;//pleat height (inches)

//file export parameters
int cutterWidth = 36;//width of laser cutter (inches)
int cutterHeight = 24;//height of laser cutter (inches)
float cornerOffset = 0.5;//offset of geometry from top left corner of laser bed (inches)
String filename = "PleatedLamp";

ArrayList<float[]> usableProfileVertices;//storage for vertices
ProfileViewController profileVC = new ProfileViewController();

void setup(){
  size(900,600,OPENGL);
  frame.setResizable(true);
  usableProfileVertices = createProfileGeometry();
}

void draw() {
  noStroke();
  background(50);
  lights();
  
  pushMatrix();
  translate(height/2, height/2 , 0);
  rotateX(mouseY*0.01);
  rotateY(mouseX*0.01);
  render3D();
  popMatrix();
  
  pushMatrix();
  translate(height, height/2 , 0);
  render2D();
  popMatrix();
}

void render3D(){
  fill(255,0,0);
  float pleatAngle = TWO_PI/numPleats;
  for (int i=0;i<numPleats;i++){
    rotateY(pleatAngle);
    rect(0, 0, 100, 100);
  }
}

void render2D(){
  fill(0,255,0,100);
  profileVC.drawVertices();
  profileVC.draw2DProfile();
}

void keyPressed(){
  if (key == 'p') {
    PleatExporter exporter = new PleatExporter();
    exporter.drawPleat2DGeometry(usableProfileVertices);
  }
}


///get rid of this
ArrayList<float[]> createProfileGeometry(){
  //only angles between PI/2 and -PI/2
  ArrayList<float[]> profileGeo = new ArrayList<float[]>();
  float[] vertex1 = {3,PI/4};
  profileGeo.add(vertex1);
  float[] vertex2 = {9,PI/4};
  profileGeo.add(vertex2);
  for (float[] _vertex : profileGeo){
    _vertex[0] *= 72;
  }
  return profileGeo;
}
