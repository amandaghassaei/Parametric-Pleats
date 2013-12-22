//exports 2D pleat pattern to pdf

class PleatExporter{
  
  int dpi = 72;//processing exports at 72 dpi by default
  float pleatHeightScaled = dpi*pleatHeight;
  float pleatWidthScaled = dpi*pleatWidth;
  float cornerOffsetScaled = dpi*cornerOffset;
  int cutterWidthScaled = dpi*cutterWidth;
  int cutterHeightScaled = dpi*cutterHeight;
  
  PGraphics pdf = createGraphics(cutterWidthScaled, cutterHeightScaled, PDF, filename+".pdf");
  
  void drawPleat2DGeometry(ArrayList<float[]> profileVertices) {
    pdf.beginDraw();
    pdf.background(255);//white background
    pdf.strokeWeight(0.001);//hairline width
    pdf.stroke(0);//black lines
    pdf.noFill();
    
    pushMatrix();
    translate(cornerOffsetScaled,cornerOffsetScaled);
    
    this.drawParallelPleats();
    boolean flippedOrientation = false;
    for (float[] _vertex : profileVertices){
      this.drawVPleat(_vertex[0], _vertex[1], flippedOrientation);
      flippedOrientation = !flippedOrientation;//you must flip the orientation of the V pleats after each pleat
    }
    pdf.endDraw();
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
    pg.beginShape();
    for (int i=0;i<numPleats+1;i++){
      if (flipped){
        pg.vertex(i*pleatWidthScaled,vertexTop);
      } else {
        pg.vertex(i*pleatWidthScaled,vertexBottom);
      }
      flipped = !flipped;
    }
    pg.endShape();
  }
}
