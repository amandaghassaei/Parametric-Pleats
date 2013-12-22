//handles caculations and interactions for 2D profile view

class ProfileViewController {
  
  ArrayList<PVector> profileVertices;//storage for all vertices in view
  ArrayList<float[]> usableVertices;//storage for all allowed vertices and their angles
  
  ProfileViewController(){
    profileVertices = new ArrayList<PVector>();
    PVector point = new PVector(0,0);
    profileVertices.add(point);
    point = new PVector(100,40);
    profileVertices.add(point);
    point = new PVector(60,70);
    profileVertices.add(point);
    point = new PVector(30,70);
    profileVertices.add(point);
    point = new PVector(0,100);
    profileVertices.add(point);
    
    usableVertices = this.calculateUsableVertices();
  }
  
  ArrayList<float[]> calculateUsableVertices(){
    ArrayList<float[]> newList = new ArrayList<float[]>();
    float totalLength = 0;
    for (int i=1;i<profileVertices.size()-1;i++){//forget about endpoints
      totalLength+=profileVertices.get(i).mag();
      PVector vector1 = PVector.sub(profileVertices.get(i),profileVertices.get(i-1));
      PVector vector2 = PVector.sub(profileVertices.get(i),profileVertices.get(i+1));
      float bendAngle = acos((vector1.dot(vector2))/(vector1.mag()*vector2.mag()));
      if (bendAngle>-PI && bendAngle<PI){
        if (bendAngle>PI/30 || bendAngle<-PI/30){
          float[] usableVertex = {totalLength, bendAngle/2};//this needs to depend on rad
          newList.add(usableVertex);
        }
      }
    }
    return newList;
  }
  
  void draw2DProfile(){
    
  }
  
  void drawVertices(){
    for (PVector vertex : profileVertices){
      ellipse(vertex.x, vertex.y, 10, 10);
    }
  }
  
}
