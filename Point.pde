class Point
{
  float currentX;
  float currentY;
  
  float oldX;
  float oldY;
  
  float curVx;
  float curVy;
  
  boolean locked = false;
  boolean hidden = false;
  
  public Point(float x, float y, float ox, float oy){
    currentX = x;
    currentY = y;
    oldX = ox;
    oldY = oy;
  }
}
