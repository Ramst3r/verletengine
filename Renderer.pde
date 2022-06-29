void renderPoints(){
  strokeWeight(radiusSlider.getValue()*2);
  beginShape(POINTS);
  for(int i = 0; i < points.size(); i++){
    Point p = points.get(i);
    
    
    if(p.locked) {
    fill(255, 50, 50);
    stroke(200, 50,50);
    }
    else {
    fill (255);
    stroke (255);
    }
    
    if(!p.hidden) {
      //circle(p.currentX, p.currentY, radiusSlider.getValue());
      
      vertex(p.currentX, p.currentY);
      
    }
    
  }
  endShape();
  for(int i = 0; i < placeHolderPoints.size(); i++){
    circle(placeHolderPoints.get(i).x, placeHolderPoints.get(i).y, radius);
  }
}

void renderSticks(){
  //ellipseMode(RADIUS);
  //strokeWeight(1);
  //stroke (255);
  //background(40);
  beginShape(LINES);
  for(int i = 0; i < sticks.size(); i++){
    
    Stick s = sticks.get(i);
    if(s.hidden) continue;
    
    if(!s.clothStick) strokeWeight(linethickSlider.getValue());
    else strokeWeight(1);
    stroke(255);
    vertex(s.a.currentX, s.a.currentY);
    vertex(s.b.currentX, s.b.currentY);
    //ine(s.a.currentX, s.a.currentY, s.b.currentX, s.b.currentY);
  }
  endShape();
  if(canDrawLines) {
      for(int l = 0; l < lines.size(); l++){
        vec2 a = lines.get(l).a;
        vec2 b = lines.get(l).b;
        strokeWeight(10);
        stroke(255);
        line(a.x, a.y, b.x, b.y);
      }
      if(lines.size() > 0 && checkbox.getState(0) && !checkbox2.getState(0)) line(placeHolderPoints.get(placeHolderPoints.size() - 1).x, placeHolderPoints.get(placeHolderPoints.size() - 1).y, placeHolderPoints.get(0).x, placeHolderPoints.get(0).y);
    }
}

void updateCheckbox(){
  
  //if(checkbox.isMouseOver()) cursor(HAND);
  
  if(checkboxAdvancedMode.getState(0)){
       checkboxHideSupports.setVisible(false);
     checkbox2.setVisible(false);
     checkbox.setVisible(false);
     checkbox.deactivate(0);
     checkbox2.deactivate(0);
     checkboxHideSupports.deactivate(0);
  }
  else {
    checkbox.setVisible(true);
     if(checkbox.getState(0)){
    checkbox2.setVisible(true);
    checkboxHideSupports.setVisible(true);
    } else {
   checkbox2.setVisible(false);
   checkboxHideSupports.setVisible(false);
    }
  }
}




void renderP5(){
  cp5 = new ControlP5(this);
  
  PFont pfont = createFont("Arial",12,true); // use true/false for smooth/no-smooth
  
  cp5.setFont(pfont);
  
  
  spawnBox = cp5.addButton("spawnBox")
         .setValue(0)
         .setPosition(400,30)
         .setColorBackground(color(50))
                .setColorForeground(color(180))
                .setColorActive(color(255))
                .setColorLabel(color(240))
               .setSize(100,20)
         ;
  
  spawnRope = cp5.addButton("spawnRope")
         .setValue(0)
         .setPosition(540,30)
         .setColorBackground(color(50))
                .setColorForeground(color(180))
                .setColorActive(color(255))
                .setColorLabel(color(240))
         .setSize(100,20)
         ;
  
  spawnCloth = cp5.addButton("spawnCloth")
         .setValue(0)
         .setPosition(680,30)
         .setColorBackground(color(50))
                .setColorForeground(color(180))
                .setColorActive(color(255))
                .setColorLabel(color(240))
         .setSize(100,20)
         ;
  
  spawnSoftbody = cp5.addButton("softbody (wip)")
         .setValue(0)
         .setPosition(820,30)
         .setColorBackground(color(50))
                .setColorForeground(color(180))
                .setColorActive(color(255))
                .setColorLabel(color(240))
         .setSize(120,20)
         ;
  
  
  checkbox = cp5.addCheckBox("checkBox")
                .setPosition(30, 230)
                .setColorBackground(color(50))
                .setColorForeground(color(180))
                .setColorActive(color(230))
                .setColorLabel(color(240))
                .setSize(20, 20)
                
                //.setItemsPerRow(3)
                // .setSpacingColumn(50)
                //.setSpacingRow(20)
                .addItem("Close off Verlet shapes", 0)
                .toUpperCase(false)
                ;
  
  checkboxHideSupports = cp5.addCheckBox("checkBoxHS")
                .setPosition(190, 230)
                .setColorBackground(color(50))
                .setColorForeground(color(180))
                .setColorActive(color(230))
                .setColorLabel(color(240))
                .setSize(20, 20)
                
                //.setItemsPerRow(3)
                // .setSpacingColumn(50)
                //.setSpacingRow(20)
                .addItem("Hide supports", 0)
                .toUpperCase(false)
                ;
                
  checkbox2 = cp5.addCheckBox("checkBox2")
                .setPosition(30, 260)
                .setColorBackground(color(50))
                .setColorForeground(color(180))
                .setColorActive(color(230))
                .setColorLabel(color(240))
                .setSize(20, 20)
                
                //.setItemsPerRow(3)
                // .setSpacingColumn(50)
                //.setSpacingRow(20)
                .addItem("Close off to most nearby point", 0)
                .toUpperCase(false)
                ;
                
  checkboxRenderPoints = cp5.addCheckBox("checkBoxRP")
                .setPosition(30, 290)
                .setColorBackground(color(50))
                .setColorForeground(color(180))
                .setColorActive(color(230))
                .setColorLabel(color(240))
                .setSize(20, 20)
                
                //.setItemsPerRow(3)
                // .setSpacingColumn(50)
                //.setSpacingRow(20)
                .addItem("Render Verlet points", 0)
                .toUpperCase(false)
                ;
                
                
  checkboxAdvancedMode = cp5.addCheckBox("checkBoxAM")
                .setPosition(30, 320)
                .setColorBackground(color(50))
                .setColorForeground(color(180))
                .setColorActive(color(230))
                .setColorLabel(color(240))
                .setSize(20, 20)
                
                //.setItemsPerRow(3)
                // .setSpacingColumn(50)
                //.setSpacingRow(20)
                .addItem("Advanced mode", 0)
                .toUpperCase(false)
                ;
   
   gravSlider = cp5.addSlider("gravity")
     .setPosition(30,350)
     .setRange(-1,1)
     .setSliderMode(Slider.FLEXIBLE)
      .setColorBackground(color(50))
                .setColorForeground(color(180))
                .setColorActive(color(230))
                .setColorLabel(color(240))
                .setValue(0.3);
     ;
   
   windSlider = cp5.addSlider("wind")
     .setPosition(30,370)
     .setRange(-10,10)
     .setSliderMode(Slider.FLEXIBLE)
      .setColorBackground(color(50))
                .setColorForeground(color(180))
                .setColorActive(color(230))
                .setColorLabel(color(240))
     ;
   frictionCEslider = cp5.addSlider("friction")
     .setPosition(30,390)
     .setRange(0,1)
     .setSliderMode(Slider.FLEXIBLE)
      .setColorBackground(color(50))
                .setColorForeground(color(180))
                .setColorActive(color(230))
                .setColorLabel(color(240))
                .setValue(0.1);
     ;
     
   bounceSlider = cp5.addSlider("bounce")
     .setPosition(30,430)
     .setRange(0,1)
     .setSliderMode(Slider.FLEXIBLE)
      .setColorBackground(color(50))
                .setColorForeground(color(180))
                .setColorActive(color(230))
                .setColorLabel(color(240))
                .setValue(0.3);
     ;
     
     dragSlider = cp5.addSlider("airdrag")
     .setPosition(30,410)
     .setRange(0,1)
     .setSliderMode(Slider.FLEXIBLE)
      .setColorBackground(color(50))
                .setColorForeground(color(180))
                .setColorActive(color(230))
                .setColorLabel(color(240))
                .setValue(0.05);
     ;
     
    checkboxTear = cp5.addCheckBox("checkBoxT")
                .setPosition(30, 460)
                .setColorBackground(color(50))
                .setColorForeground(color(180))
                .setColorActive(color(230))
                .setColorLabel(color(240))
                .setSize(20, 20)
                
                //.setItemsPerRow(3)
                // .setSpacingColumn(50)
                //.setSpacingRow(20)
                .addItem("Ripping / Tearing", 0)
                .toUpperCase(false)
                ;
    
    checkboxCut = cp5.addCheckBox("checkBoxCut")
                .setPosition(30, 510)
                .setColorBackground(color(50))
                .setColorForeground(color(180))
                .setColorActive(color(230))
                .setColorLabel(color(240))
                .setSize(20, 20)
                
                //.setItemsPerRow(3)
                // .setSpacingColumn(50)
                //.setSpacingRow(20)
                .addItem("Mouse Cutting", 0)
                .toUpperCase(false)
                ;
                
    tearSlider = cp5.addSlider("break self %")
     .setPosition(30,490)
     .setRange(30,200)
     .setSliderMode(Slider.FLEXIBLE)
      .setColorBackground(color(50))
                .setColorForeground(color(180))
                .setColorActive(color(230))
                .setColorLabel(color(240))
                //.setValue(0.3);
     ;
     
    linethickSlider = cp5.addSlider("linewidth")
     .setPosition(30,550)
     .setRange(1,22)
     .setSliderMode(Slider.FLEXIBLE)
      .setColorBackground(color(50))
                .setColorForeground(color(180))
                .setColorActive(color(230))
                .setColorLabel(color(240))
                .setValue(10);
     ;
     
     radiusSlider = cp5.addSlider("radius")
     .setPosition(30,580)
     .setRange(5,50)
     .setSliderMode(Slider.FLEXIBLE)
      .setColorBackground(color(50))
                .setColorForeground(color(180))
                .setColorActive(color(230))
                .setColorLabel(color(240))
                .setValue(10);
     ;
     
     rapidFire = cp5.addCheckBox("checkBoxRapidFire")
                .setPosition(30, 640)
                .setColorBackground(color(50))
                .setColorForeground(color(180))
                .setColorActive(color(230))
                .setColorLabel(color(240))
                .setSize(20, 20)
                
                //.setItemsPerRow(3)
                // .setSpacingColumn(50)
                //.setSpacingRow(20)
                .addItem("Rapid Fire", 0)
                .toUpperCase(false)
                ;
     
     
     iterSlider = cp5.addSlider("iterations")
     .setPosition(30,height - 30)
     .setRange(1,10)
     //.setSliderMode(Slider.FLEXIBLE)
      .setColorBackground(color(50))
                .setColorForeground(color(180))
                .setColorActive(color(230))
                .setColorLabel(color(240))
                .setValue(3)
                .setNumberOfTickMarks(10);
     ;
     
     checkboxCollision = cp5.addCheckBox("checkBoxCollision")
                .setPosition(30, height - 60)
                .setColorBackground(color(50))
                .setColorForeground(color(180))
                .setColorActive(color(230))
                .setColorLabel(color(240))
                .setSize(20, 20)
                
                //.setItemsPerRow(3)
                // .setSpacingColumn(50)
                //.setSpacingRow(20)
                .addItem("C/C Collision", 0)
                .toUpperCase(false)
                ;
                
     checkboxCollisionL = cp5.addCheckBox("checkBoxCollisionL")
                .setPosition(30, height - 90)
                .setColorBackground(color(50))
                .setColorForeground(color(180))
                .setColorActive(color(230))
                .setColorLabel(color(240))
                .setSize(20, 20)
                
                //.setItemsPerRow(3)
                // .setSpacingColumn(50)
                //.setSpacingRow(20)
                .addItem("L/C Collision", 0)
                .toUpperCase(false)
                ;
}
