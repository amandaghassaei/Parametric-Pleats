//exports 2D pleat pattern to pdf

class PleatExporter{
  
  int dpi = 72;//processing exports at 72 dpi by default
  float pleatHeightScaled = dpi*pleatHeight;
  float pleatWidthScaled = dpi*pleatWidth;
  float cornerOffsetScaled = dpi*cornerOffset;
  int cutterWidthScaled = dpi*cutterWidth;
  int cutterHeightScaled = dpi*cutterHeight;
    
  void drawPleat2DGeometry(ArrayList<float[]> profileVertices) {
    //size(cutterWidthScaled, cutterHeightScaled);
    beginRecord(PDF, filename+".pdf"); 
    background(255);//white background
    strokeWeight(0.001);//hairline width
    stroke(0);//black lines
    noFill();
    
    pushMatrix();
    translate(cornerOffsetScaled,cornerOffsetScaled);
    
    this.drawParallelPleats();
    boolean flippedOrientation = false;
    for (float[] _vertex : profileVertices){
      this.drawVPleat(_vertex[0], _vertex[1], flippedOrientation);
      flippedOrientation = !flippedOrientation;//you must flip the orientation of the V pleats after each pleat
    }
    endRecord();
    exit();
  }
  
  void drawParallelPleats(){
    for (int i=0;i<numPleats;i++){
      float x = i*pleatWidthScaled;
      line(x,0,x,pleatHeightScaled);
    }
    line(pleatWidthScaled*numPleats,0,pleatWidthScaled*numPleats,pleatHeightScaled);
  }

  void drawVPleat(float vertexPosition, float vertexAngle, boolean flipped){
    float vertexHeight = getVertexHeight(vertexAngle)*dpi;
    float vertexTop = vertexPosition - vertexHeight/2;
    float vertexBottom = vertexPosition + vertexHeight/2;
    beginShape();
    for (int i=0;i<numPleats+1;i++){
      if (flipped){
        vertex(i*pleatWidthScaled,vertexTop);
      } else {
        vertex(i*pleatWidthScaled,vertexBottom);
      }
      flipped = !flipped;
    }
    endShape();
  }
}
