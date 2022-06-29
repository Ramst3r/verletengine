boolean isSimulating = true;
float inc = 0;

void updatePoints(){
  inc += random(0.01, 0.05);
  for(int i = 0; i < points.size(); i++){
    Point p = points.get(i);
    
    if(checkboxCollision.getState(0)) calcBodyCollision(p);
    
    if(!p.locked) {
    float velocityX = (p.currentX - p.oldX) + windSlider.getValue() * 0.05 * abs(noise(inc));
    float velocityY = (p.currentY - p.oldY);
    p.curVx = velocityX;
    p.curVy = velocityY;
    //if(velocityX < 0.2f && velocityX != 0 && velocityY < 0.2f && velocityY != 0) continue; //perf save

    
    velocityX *= (1 - (dragSlider.getValue() * 0.1)); //0.1 just a scalar
    velocityY *= (1 - (dragSlider.getValue() * 0.1));
    
    
    
    p.oldX = p.currentX;
    p.oldY = p.currentY;
    
    p.currentY += gravSlider.getValue();
    
    //calcFriction(p, velocityX, velocityY);
    velocityX = calcFrictionX(p, velocityX);
    velocityY = calcFrictionY(p, velocityY);
    
    p.currentX += velocityX;
    p.currentY += velocityY;
    
    //calcStickCollision(p, velocityX, velocityY);
    
    }
    
    
    
    
  }
  
  
}

float calcFrictionX(Point p, float vX){
  if(calcBorderFriction(p)) {
      float fcX = vX * frictionCEslider.getValue();
      fcX *= -1;
      
      vX += fcX;
      
      return vX;
    }
    else return vX;
}

float calcFrictionY(Point p, float vY){
  if(calcBorderFriction(p)) {
      
     float fcY = vY * frictionCEslider.getValue();
      fcY *= -1;
      
      
      vY += fcY;
      
      return vY;
    }
    else return vY;
}

Stick s;
void updateSticks(){
  for(int i = 0; i < sticks.size(); i++){
    
    //if(sticks.get(i) == null) return;
     
     s = sticks.get(i);
    
     if(checkboxCollisionL.getState(0)) calcStickCollision(s);
    
    float distX = s.b.currentX - s.a.currentX;
    float distY = s.b.currentY - s.a.currentY;
    
    float distance = sqrt(distX*distX + distY*distY);
    
    float difference = s.currentLength - distance;
    float percentage = difference / distance / 2;
    
    float offsetX = distX * percentage;
    float offsetY = distY * percentage;
    
    if(!s.a.locked){
    s.a.currentX -= offsetX;
    s.a.currentY -= offsetY;
    }
    if(!s.b.locked){
    s.b.currentX += offsetX;
    s.b.currentY += offsetY;
    }
   
   
   
    
    //stick destruction
    
    if(isSimulating && checkboxTear.getState(0)){
      float percentageExceed = ((distance / s.currentLength) * 100) - 100;
      
      //println(percentageExceed);
      
      if(percentageExceed > tearSlider.getValue()){
        if(s.a != heldpoint && s.b != heldpoint && !s.a.locked && !s.b.locked)  sticks.remove(i);
      }
      
      
      
    }
    
    if(checkboxCut.getState(0) &&  mousePressed && mouseButton == RIGHT){
        if(StickCircleIntersect(new PVector(s.a.currentX, s.a.currentY), new PVector(s.b.currentX, s.b.currentY), new PVector(mouseX, mouseY), 2)){
        sticks.remove(i);
        }
      }
  }
}

boolean calcBorderFriction(Point p){
  
  
  
  boolean xColliding = false;
  if(p.currentX < 0 + radius){
    xColliding = true;
  }
  else if(p.currentX > width - radius){
    xColliding = true;
  }
  else xColliding = false;
  
  boolean yColliding = false;
  if(p.currentY < 0 + radius) {
        yColliding = true;

  }
  else if(p.currentY > height - radius){
        yColliding = true;
  }
  else yColliding = false;
  
  if(xColliding || yColliding) return true;
  else return false;
}

void calcBorderCollision(){
  
  for(int i = 0; i < points.size(); i++){
    
    Point p = points.get(i);
    
  float velX = (p.currentX - p.oldX) + windSlider.getValue() * 0.05 * abs(sin(inc));
  float velY = (p.currentY - p.oldY);
  
  if(p.currentX < 0 + radius){
    p.currentX = 0 + radius;

    p.oldX = p.currentX + velX * bounceSlider.getValue();
  }
  else if(p.currentX > width - radius){
    
    p.currentX = width - radius;
    
    
    p.oldX = p.currentX + velX * bounceSlider.getValue();
  }
  if(p.currentY < 0 + radius) {
    p.currentY = 0 + radius;
    
    
    p.oldY = p.currentY + velY * bounceSlider.getValue();
  }
  else if(p.currentY > height - radius){
    
    p.currentY = height - radius;
   
    
    p.oldY = p.currentY + velY * bounceSlider.getValue();
  }
  }
  
  
  
}

void ClearObjects(){
  sticks.clear();
  points.clear();
  placeHolderPoints.clear();
  lines.clear();
}

/*
PVector getMouseLineIntersect(float mousePosX, float mousePosY, Stick segment){
  
  vec2 returnedPos = new vec2(0, 0);
  PVector pointA = new PVector(segment.a.currentX, segment.a.currentY);
  PVector pointB = new PVector(segment.b.currentX, segment.b.currentY);
  
  PVector segmentVec = pointB - pointA;
  PVector circCenter = new PVector(mousePosX, mousePosY);
  PVector pt_v = circCenter - pointA;
  
  PVector scalar = pt_v * (segmentVec / 
  
  return scalar;
}
*/
