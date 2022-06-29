void calcBodyCollision(Point p){
  if(p.locked) return;
  for(int i = 0; i < points.size(); i++){
      
     //if(points.get(i) == p || points.get(i) == null) return;
      
     Point otherP = points.get(i);
     //if(p.locked) return;
     float dist = dist(p.currentX, p.currentY, otherP.currentX, otherP.currentY);
     
     
     if(dist <= radius*2){       
        PVector collDir = new PVector(p.currentX - otherP.currentX, p.currentY - otherP.currentY).normalize();
 
        float displacement = 0.5 * (dist - (radius*2));
        PVector displaceVec = collDir.mult(displacement);
        
        if(!p.locked){
          p.currentX -= displaceVec.x;  
          p.currentY -= displaceVec.y;
        }
        
        if(!otherP.locked){
          otherP.currentX += displaceVec.x;
          otherP.currentY += displaceVec.y;
        }
     }
     else continue;
  }
}

Point p;
void calcStickCollision(Stick s){
  
  if(s.clothStick) return;
  
  float lineWidth = linethickSlider.getValue();
  
  for(int i = 0; i < points.size(); i++){
    //Stick s = sticks.get(i);
    p = points.get(i);
    //println(p);
    
    
    
    
    if(p == s.a || p == s.b) continue;
    
    PVector sLine = new PVector(s.a.currentX, s.a.currentY);
    PVector eLine = new PVector(s.b.currentX, s.b.currentY);
    
    PVector lineDirs = new PVector(eLine.x - sLine.x, eLine.y - sLine.y);
    PVector circleDirs = new PVector(p.currentX - sLine.x, p.currentY - sLine.y);
        
    PVector circleCenter = new PVector(p.currentX, p.currentY);
    //vec2 intersections = vec2StickCircleIntersect(sLine, eLine, circleCenter);
    
    float l = lineDirs.x * lineDirs.x + lineDirs.y * lineDirs.y;
    
    float t = max(0, min(l, (lineDirs.x * circleDirs.x + lineDirs.y * circleDirs.y))) / l;
    
    PVector closestPoint = new PVector(sLine.x + t * lineDirs.x, sLine.y + t * lineDirs.y);

    //if(StickCircleIntersect(sLine, eLine, circleCenter, radiusSlider.getValue())){
    PVector collDir = new PVector(p.currentX - closestPoint.x, p.currentY - closestPoint.y).normalize();
      //println(collDir);
      PVector lineNormal = new PVector(-1 * (eLine.y - sLine.y) , eLine.x - sLine.x).normalize();
      //println(lineNormal);

    if(dist(closestPoint.x, closestPoint.y, circleCenter.x, circleCenter.y) < linethickSlider.getValue() + radiusSlider.getValue()){
      
      float dist = dist(closestPoint.x, closestPoint.y, circleCenter.x, circleCenter.y);
      float displacement = 0.5 * (dist - (radiusSlider.getValue()) - lineWidth);
      collDir.mult(displacement);
      
      /*
      float vX = -p.curVx;
      float vY = p.curVy;
      
      p.currentX = closestPoint.x + collDir.x * (radius + (linethickSlider.getValue() * 0.5));
      p.currentY = closestPoint.y + collDir.y * (radius + (linethickSlider.getValue() * 0.5));
      
      p.oldX = p.currentX + vX;
      p.oldY = p.currentY + vY;
      
      //println("collision");
      */
      
      
      
      
      if(!p.locked){
        p.currentX -= collDir.x;
        p.currentY -= collDir.y;
      }
      
      
      float dista = dist(p.currentX, p.currentY, s.a.currentX, s.a.currentY);
      float distb = dist(p.currentX, p.currentY, s.b.currentX, s.b.currentY);
      
      float ratioa = dista / s.currentLength;
      float ratiob = distb / s.currentLength;

      if(!s.a.locked && dista < distb) {
        s.a.currentX += collDir.x;
        s.a.currentY += collDir.y;
      }
      else if(!s.b.locked) {
        s.b.currentX += collDir.x;
        s.b.currentY += collDir.y;
      }
      
      
    //}
    }
  }
}


boolean StickCircleIntersect(PVector startLine, PVector endLine, PVector circleCenter, float radius){
  PVector d = new PVector(endLine.x - startLine.x, endLine.y - startLine.y);
  PVector f = new PVector(startLine.x - circleCenter.x, startLine.y - circleCenter.y);
  
  float a = d.dot(d);
  float b = 2*f.dot(d);
  float c = f.dot(f) - radius*radius - linethickSlider.getValue()*linethickSlider.getValue();
  
  float discr = b*b-4*a*c;
  
  if(discr < 0) return false;
  else {
    discr = sqrt(discr);
    
    float t1 = (-b - discr) / (2*a);
    float t2 = (-b + discr) / (2*a);
    
    if(t1 >= 0 && t1 <= 1) return true;
    if(t2 >= 0 && t2 <= 1) return true;
    
    return false;
  }
}

vec2 vec2StickCircleIntersect(PVector startLine, PVector endLine, PVector circleCenter){
  PVector d = new PVector(endLine.x - startLine.x, endLine.y - startLine.y);
  PVector f = new PVector(startLine.x - circleCenter.x, startLine.y - circleCenter.y);
  
  float a = d.dot(d);
  float b = 2*f.dot(d);
  float c = f.dot(f) - radius*radius - linethickSlider.getValue()*linethickSlider.getValue();
  
  float discr = b*b-4*a*c;
  
  if(discr < 0) return new vec2(-1, -1);
  else {
    discr = sqrt(discr);
    
    float t1 = (-b - discr) / (2*a);
    float t2 = (-b + discr) / (2*a);
    
    return new vec2(t1, t2);
  }
}

float normfloat(float val, float min, float max){
  return (val - min) / (max - min);
}
