Point heldpoint;

boolean pressCheck = true;


ArrayList<vec2> placeHolderPoints = new ArrayList<vec2>();
ArrayList<Point> storedPoints = new ArrayList<Point>();
ArrayList<exLine> lines = new ArrayList<exLine>();

ArrayList<Stick> tempSticks = new ArrayList<Stick>();
ArrayList<Point> tempPoints = new ArrayList<Point>();

ArrayList<vec2> tempVecs = new ArrayList<vec2>();

vec2 mousePos = new vec2(mouseX, mouseY);
vec2 oldPos = new vec2(0, 0);

Point cachedbp = new Point(0,0,0,0);
Point cachedep = new Point(0,0,0,0);
Point cachedmousePoint;
int cachedi = -1;

boolean startedDrawing = false;
boolean canDrawLines = false;
int curPointIndex = -1;

boolean toggle = true;
boolean usingAdvancedMode = false;

int lastpointindex = -1;
int storelpi = 0;

//int screenshotindex =0;
void updateInput(){
  
  
  
  if(keyPressed){
    
    if(keyCode == java.awt.event.KeyEvent.VK_F12 && enterReleased) {
      //println("bra");
      
      save("screenshots/screenshot "  + hour() + "." + minute() + "."+ second() + "-" + LocalDate.now().toString() + ".jpg");
      enterReleased = false;
    }
    
    
    if(key == ' ' && enterReleased){
      enterReleased = false;
      
      if(isSimulating) isSimulating = false;
      else {
      isSimulating = true;
      
      for(int i = 0; i < sticks.size(); i++){
        sticks.get(i).recalcLength();
      }
      }
    }
    else if(key == BACKSPACE){
      ClearObjects();
      
      if(checkboxAdvancedMode.getState(0)) isSimulating = false;
      windSlider.setValue(0);
      dragSlider.setValue(0.05);
      gravSlider.setValue(0);
      frictionCEslider.setValue(0.1);
      bounceSlider.setValue(0.3);
      gravSlider.setValue(0.3);
    }
  }
  //println(curPointIndex);
  if(mousePressed && mouseButton == LEFT) {
    
    int additionRange;
    
    if(checkboxAdvancedMode.getState(0)) additionRange = 0;
    else additionRange = 40;
    
    for(int i = 0; i < points.size(); i++){
      float distM = dist(mouseX, mouseY, points.get(i).currentX, points.get(i).currentY);
      if(distM < radius + additionRange || curPointIndex == i){
        if(curPointIndex == -1 || curPointIndex == i) {
        //cursor(WAIT);
        heldpoint = points.get(i);
        test = false;
        heldpoint.currentX = mouseX;
        heldpoint.currentY = mouseY;
        heldpoint.oldX = pmouseX;
        heldpoint.oldY = pmouseY;
        curPointIndex = i;
        if(keyPressed) {
          if(key == 'l' && enterReleased){
            enterReleased = false;
            if(!heldpoint.locked) heldpoint.locked = true;
            else heldpoint.locked = false;
          }
        }
      }
      } 
      
    }
  } 
  else {
    curPointIndex = -1;
  }
  
  
  
  
  
  
  mousePos = new vec2(mouseX, mouseY);
  if(checkboxAdvancedMode.getState(0)){
    if(!usingAdvancedMode) {
      usingAdvancedMode = true;
      isSimulating = false;
      ClearObjects();
    }
    
    if(mousePressed && curPointIndex == -1 && !isSimulating){
      

      if(mouseButton == LEFT && mouseReleased && mouseX > 120) {
        mouseReleased = false;
        
        
        points.add(new Point(mouseX, mouseY, pmouseX, pmouseY));
        
        startedDrawing = true;
      }
       else if(mouseButton == RIGHT){
        canDrawLines = true;
        
        if(points.size() > 0){
        //vec2 beginPos = new vec2(0,0);
        
        if(toggle){
            toggle = false;
            
            int pointindex = -1;
            float smallestDist = 100000;
            for(int i = 0; i < points.size(); i++){
              float dist = dist(mouseX, mouseY, points.get(i).currentX, points.get(i).currentY);
              if(dist < smallestDist) {
                smallestDist = dist;
                pointindex = i;
                cachedi = pointindex;
              }
            }
            if(pointindex == -1) return;
            //beginPos.x = points.get(pointindex).currentX;
            //beginPos.y = points.get(pointindex).currentY;
            
            //Point beginPoint = new Point(beginPos.x, beginPos.y, beginPos.x, beginPos.y);
            cachedbp = points.get(pointindex);
          }
         
         Point endPoint = new Point(mouseX, mouseY, mouseX, mouseY);
         cachedmousePoint = endPoint;
         for(int i = 0; i < points.size(); i++){
           float dist = dist(mousePos.x, mousePos.y, points.get(i).currentX, points.get(i).currentY);
           if(i == cachedi) continue;
           //if(lastpointindex == i) continue;
           if(dist < 45) {
           endPoint = points.get(i);
           //storelpi = i;
           }
         }
         cachedep = endPoint;
         
         line(cachedbp.currentX, cachedbp.currentY, endPoint.currentX, endPoint.currentY);
        }
          
      }
    }
    else if(!toggle && mouseReleased && cachedep.currentX != cachedmousePoint.currentX) {
        
        toggle = true;
        //if(cachedep.currentX == mouseX && cachedep.currentY == mouseY) return;
        mouseReleased = false;
         //lines.add(new exLine(cachedbp, cachedep));
         //lastpointindex = storelpi;
         sticks.add(new Stick(cachedbp, cachedep, false));
         
         //tempSticks.add(new Stick(a, b, false));
         
         //dont forget to clear tempsticks
      }
      
   if(keyPressed){ 
           if(key == ENTER && enterReleased){
             
             enterReleased = false;
             
             /*
             for(int pt = 0; pt < tempPoints.size(); pt++){
               Point p = tempPoints.get(pt);

               for(int op = 0; op < tempPoints.size(); op++){
                 if(pt == op) continue;
                 Point other = tempPoints.get(op);
                 if(p.currentX == other.currentX){
                   other = p; 
                   
                   other.locked = true;
                   tempPoints.set(op, other);
                   println(":)");
                 }
               }
               points.add(p);
             }
             */
             
             for(int i = 0; i < sticks.size(); i++){
               sticks.get(i).recalcLength();
             }
             
             
             isSimulating = true;
            
             
             tempSticks.clear();
             tempPoints.clear();
             lines.clear();
             placeHolderPoints.clear();
           }
         }
  }
  else {
    if(usingAdvancedMode) {
      usingAdvancedMode = false;
      isSimulating = true;
      ClearObjects();
    }
    
    if(mousePressed){
    
    if(keyPressed){
      if(key == ENTER && enterReleased){
        points.remove(heldpoint);
        if(curPointIndex != -1 && points.size() > 0) {
        
        curPointIndex = -1;
        }
        
        mousePos = new vec2(mouseX, mouseY);
        canDrawLines = true;
        
        placeHolderPoints.add(mousePos);
        enterReleased = false;
        
        if(startedDrawing) lines.add(new exLine(oldPos, mousePos));
        oldPos = mousePos;
        startedDrawing = true;
        
        
      }
    }
    else if(mouseButton == LEFT && mouseX > 150 && mouseY > 50) {
      if(curPointIndex == -1 && !rapidFire.getState(0)) points.add(new Point(mouseX, mouseY, pmouseX, pmouseY));
      else if (rapidFire.getState(0))  points.add(new Point(mouseX, mouseY, pmouseX, pmouseY));
    }
  }
  else if(mousePressed) {
    
    
  }
  else {
    startedDrawing = false;
    canDrawLines = false;
    if(placeHolderPoints.size() > 0){
      
      vec2 midPoint = new vec2(0, 0);
      float midX = 0;
      float midY = 0;
        //placeHolderPoints.remove(0);
        for(int i = 0; i < placeHolderPoints.size(); i++){
        vec2 point = placeHolderPoints.get(i);
        //placeHolderPoints.remove(placeHolderPoints.size() - 1);
        Point p = new Point(point.x, point.y, point.x, point.y);
        //Point np = new Point(npoint.x, npoint.y, npoint.x, npoint.y);
        points.add(p);
        storedPoints.add(p); 
        
        midX += point.x;
        midY += point.y;
        
        }
        
      midX = midX / placeHolderPoints.size();
      midY= midY / placeHolderPoints.size();
      
      midPoint.x = midX;
      midPoint.y = midY;
      
      Point centroid = new Point(midPoint.x, midPoint.y, midPoint.x, midPoint.y);
      if(checkbox.getState(0) && !checkbox2.getState(0)) points.add(centroid);
      
      for(int i = 0; i < storedPoints.size(); i++){
      Point thisPoint = storedPoints.get(i);
      Point lastPoint = storedPoints.get(i);
      if(i > 0) lastPoint = storedPoints.get(i - 1);
      
      if(i != storedPoints.size() -1) sticks.add(new Stick(thisPoint, storedPoints.get(i+1), false));
      else if(checkbox.getState(0)) {
        
      
      if(!checkbox2.getState(0)) {
        sticks.add(new Stick(thisPoint, storedPoints.get(0), false));
        
        //connect each point to the centroid
        for(int other = 0; other < storedPoints.size(); other++){
          if(checkboxHideSupports.getState(0)) sticks.add(new Stick(storedPoints.get(other), centroid, true));
          else sticks.add(new Stick(storedPoints.get(other), centroid, false));
        }
        
      }
      else {
        
        float smallestDist = 100000000;
        for(int op = 0; op < storedPoints.size(); op++){
          float distance = dist(thisPoint.currentX, thisPoint.currentY, storedPoints.get(op).currentX, storedPoints.get(op).currentY);
          if(lastPoint == storedPoints.get(op)) continue;
          if(storedPoints.get(op) == thisPoint) continue;
          if(distance < smallestDist) smallestDist = distance;
        }
        
        for(int op = 0; op < storedPoints.size(); op++){
            float distance = dist(thisPoint.currentX, thisPoint.currentY, storedPoints.get(op).currentX, storedPoints.get(op).currentY);
            if(distance == smallestDist) {
              sticks.add(new Stick(thisPoint, storedPoints.get(op), false));
            }
        }
      }
      
      
        
        
        
        
      }
      
      
      }
      
      storedPoints.clear();
      placeHolderPoints.clear();
      lines.clear();
    }
    
    
  }
  }  
  
  
 // code for dragging points
 
 
  
  
  
  
  if(spawnBox.isPressed() && boxButtontoggle){
    boxButtontoggle = false;
    float midX = width / 2;
    float midY = height / 2;
    float extents = 50;
    
    Point a = new Point(midX + extents, midY + extents, midX + extents, midY + extents);
    Point b = new Point(midX - extents, midY + extents, midX - extents, midY + extents);
    Point c = new Point(midX - extents, midY - extents, midX - extents, midY - extents);
    Point d = new Point(midX + extents, midY - extents, midX + extents, midY - extents);
    
    a.hidden = true;
    b.hidden = true;
    c.hidden = true;
    d.hidden = true;
    
    points.add(a);
    points.add(b);
    points.add(c);
    points.add(d);
    
    sticks.add(new Stick(a,b, false));
    sticks.add(new Stick(b,c, false));
    sticks.add(new Stick(c,d, false));
    sticks.add(new Stick(d,a, false));
    
    sticks.add(new Stick(a,c, true));
    sticks.add(new Stick(b,d, true));

  }
  else if(!spawnBox.isPressed()) {
    boxButtontoggle = true;
  }
  
  
  
  if(spawnRope.isPressed() && ropeButtontoggle){
    ropeButtontoggle = false;
    float midX = width / 2 - 300;
    float midY = height / 2;
    float spacing = 10;
    int pointCount = 100;
    ArrayList<Point> ropePoints = new ArrayList<Point>();
    
    
    for(int i = 0; i < pointCount; i++){
      //placeHolderPoints.add(new vec2(midX + i * spacing, midY + i));
      ropePoints.add(new Point(midX + i * spacing, midY + i, midX + i * spacing, midY + i));
    }
    
    for(int i = 0; i < ropePoints.size(); i++){
      Point p = ropePoints.get(i);
      p.hidden = true;
      if(i == 0) p.locked = true;
      points.add(p);
    }
    for(int i = 0; i < ropePoints.size(); i++){
      if(i < ropePoints.size() -1) sticks.add(new Stick(ropePoints.get(i), ropePoints.get(i+1), false));
    }
  }
  else if(!spawnRope.isPressed()) {
    ropeButtontoggle = true;
  }
  
  if(spawnCloth.isPressed() && clothButtontoggle){
    float spacing = 20;
    float midX = width / 2 - 200;
    float midY = 200;
    ArrayList<Point> cpoints = new ArrayList<Point>();
    clothButtontoggle = false;
    
    for(int x = 0; x < clothPoints.x; x++){
        
        for(int y = 0; y < clothPoints.y; y++){
          boolean locked = y == 0 && x % 2 == 0;
          Point p = new Point((x + 1) * spacing + midX, (y + 1) * spacing + midY, (x + 1) * spacing + midX, (y + 1) * spacing + midY);
          p.locked = locked;
          p.hidden = true;
          cpoints.add(p);
          
        }
    }
    
    for(int x = 0; x < clothPoints.x; x++){
        
        for(int y = 0; y < clothPoints.y; y++){
          
          points.add(cpoints.get(IndexFrom2DCoord(x, y, clothPoints)));
          
        if (x < clothPoints.x - 1)
        {
          Stick s = new Stick(cpoints.get(IndexFrom2DCoord(x, y, clothPoints)), cpoints.get(IndexFrom2DCoord(x + 1, y, clothPoints)), false);
          s.clothStick = true;
          sticks.add(s);
        }
        if (y < clothPoints.y - 1)
        {
          Stick s = new Stick(cpoints.get(IndexFrom2DCoord(x, y, clothPoints)), cpoints.get(IndexFrom2DCoord(x, y + 1, clothPoints)), false);
          s.clothStick = true;
          sticks.add(s);
        }          
        }
    }
    
    cpoints.clear();
  }
  else if(!spawnCloth.isPressed()) {
    clothButtontoggle = true;
  }
  
  if(spawnSoftbody.isPressed() && softbButtontoggle){
    float spacing = 40;
    float midX = width / 2 - 100;
    float midY = 300;
    ArrayList<Point> cpoints = new ArrayList<Point>();
    softbButtontoggle = false;
    
    for(int x = 0; x < softbPoints.x; x++){
        
        for(int y = 0; y < softbPoints.y; y++){
          //boolean locked = y == 0 && x % 2 == 0;
          Point p = new Point((x + 1) * spacing + midX, (y + 1) * spacing + midY, (x + 1) * spacing + midX, (y + 1) * spacing + midY);
          //p.locked = locked;
          p.hidden = true;
          cpoints.add(p);
        }
    }
    
    for(int x = 0; x < softbPoints.x; x++){
        
        for(int y = 0; y < softbPoints.y; y++){
          
          points.add(cpoints.get(IndexFrom2DCoord(x, y, softbPoints)));
          
            if (x < softbPoints.x - 1)
        {
          if(y == 0 || y == softbPoints.y - 1)  sticks.add(new Stick(cpoints.get(IndexFrom2DCoord(x, y, softbPoints)), cpoints.get(IndexFrom2DCoord(x + 1, y, softbPoints)), false));
          else sticks.add(new Stick(cpoints.get(IndexFrom2DCoord(x, y, softbPoints)), cpoints.get(IndexFrom2DCoord(x + 1, y, softbPoints)), false));
          
         
            if(y < softbPoints.y - 1) sticks.add(new Stick(cpoints.get(IndexFrom2DCoord(x, y, softbPoints)), cpoints.get(IndexFrom2DCoord(x + 1, y + 1, softbPoints)), false));
            if(y > 0) sticks.add(new Stick(cpoints.get(IndexFrom2DCoord(x, y, softbPoints)), cpoints.get(IndexFrom2DCoord(x + 1, y - 1, softbPoints)), false));                      
        
          
        }
        if (y < softbPoints.y - 1)
        {
          if(x == 0 || x == softbPoints.x - 1)  sticks.add(new Stick(cpoints.get(IndexFrom2DCoord(x, y, softbPoints)), cpoints.get(IndexFrom2DCoord(x, y + 1, softbPoints)), false));
          else sticks.add(new Stick(cpoints.get(IndexFrom2DCoord(x, y, softbPoints)), cpoints.get(IndexFrom2DCoord(x, y + 1, softbPoints)), false));
        }          
        }
    }
  }
  else if(!spawnSoftbody.isPressed()) {
    softbButtontoggle = true;
  }
  
}
boolean boxButtontoggle = true;
boolean ropeButtontoggle = true;
boolean clothButtontoggle = true;
boolean softbButtontoggle = true;

boolean test = true;

boolean enterReleased = true;
void keyReleased(){
  enterReleased = true;
}

boolean mouseReleased = false;
void mouseReleased(){
mouseReleased = true;
}

class exLine{
  vec2 a;
  vec2 b;
  
  public exLine (vec2 a, vec2 b){
    this.a = a;
    this.b = b;
  }
   public exLine (PVector a, PVector b){
    this.a = new vec2(0,0);
    this.b = new vec2(0,0); 
     
    this.a.x = a.x;
    this.a.y = a.y;

    this.b.x = b.x;
    this.b.y = b.y;
  }
  public exLine(Point a, Point b){
    this.a.x = a.currentX;
    this.a.y = a.currentY;
    this.b.x = b.currentX;
    this.b.y = b.currentY;
  }
}

int IndexFrom2DCoord(int x, int y, vec2 points)
  {
    return y * (int)points.x + x;
  }
