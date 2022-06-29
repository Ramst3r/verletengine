class Stick{
  Point a;
  Point b;
  float currentLength;
  boolean hidden = false;
  boolean clothStick = false;
  
  public Stick(Point a, Point b, boolean hidden){
    this.a = a;
    this.b = b;
    this.hidden = hidden;
    
    currentLength = dist(a.currentX, a.currentY, b.currentX, b.currentY);
  }
  
  public void recalcLength(){
    currentLength = dist(a.currentX, a.currentY, b.currentX, b.currentY);
  }
}
