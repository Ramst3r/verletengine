import controlP5.*;
import java.time.LocalDate;

ControlP5 cp5;

CheckBox checkbox;
CheckBox checkbox2;
CheckBox checkboxHideSupports;
CheckBox checkboxRenderPoints;
CheckBox checkboxAdvancedMode;
CheckBox checkboxTear;
CheckBox checkboxCollision;
CheckBox checkboxCollisionL;
CheckBox checkboxCut;
CheckBox rapidFire;

Slider windSlider;
Slider frictionCEslider;
Slider gravSlider;
Slider bounceSlider;
Slider tearSlider;
Slider dragSlider;
Slider linethickSlider;
Slider radiusSlider;
Slider iterSlider;

Button spawnBox;
Button spawnRope;
Button spawnCloth;
Button spawnSoftbody;

vec2 clothPoints = new vec2(25, 25);
vec2 softbPoints = new vec2(10, 10);

vec2 center = new vec2(width / 2, height / 2);

ArrayList<Point> points = new ArrayList<Point>();
ArrayList<Stick> sticks = new ArrayList<Stick>();

float bounciness = 0.7;
float airDrag = 0.1;
float radius = 10;

void setup(){
  //fullScreen();
  //smooth(4);
  size(1000, 900); //window size
  //sphereDetail(10);
  //camera();
  frameRate(144); // fps
  surface.setTitle("Ramster's Verlet Engine");
  //surface.setResizable(true);
  renderP5();
  checkboxRenderPoints.activate(0);
  cp5.addFrameRate().setInterval(9).setPosition(width - 70, 10);
  //camera();
}

float time = 0;
float lastTime = 0;

void draw(){
  //lights();
  background(100);
  PausePlayGraphics();
  ellipseMode(RADIUS);
  //directionalLight(51, 102, 126, 0, 1, 0);

  radius = radiusSlider.getValue();
  if(isSimulating){
    updatePoints();
    for(int i = 0; i < iterSlider.getValue(); i++) {
    updateSticks();
    calcBorderCollision();
    }
  }
  
  renderSticks();
  if(checkboxRenderPoints.getState(0)) renderPoints();
  updateInput();
  updateCheckbox();
  
  fill(255);
  textSize(30);
  text("Ramster's Verlet Engine", 30, 50);
  textSize(20);
  
  if(checkboxAdvancedMode.getState(0)){
  text("Press LMB to spawn Verlet points", 30, 100);
  text("Hold RMB to define sticks from point to point", 30, 130);
  textSize(13);
  }
  else {
  text("Press LMB to fire Verlet balls", 30, 100);
  text("Hold mouse and press Enter to define Verlet shapes", 30, 130);
  textSize(13);
  }
  
  text("Press L to lock Verlet points", 30, 180);
  text("Press SPACE to pause the simulation at any point", 30, 200);
  text("(Press backspace to clear objects)", 30, 160);
  text("Hold LMB near any point to drag it", 30, 220);
  
  textSize(13);
  
  
  
  text("fps", width - 40, 22);
  
  incrementTime += 0.01;
  if(incrementTime > 1) {
    ms = String.valueOf((int)time - lastTime);
    incrementTime = 0;
  }
  text(ms + " ms", width - 60, 40);
  lastTime = time;
  time = millis();
  
  //println(time - lastTime);
}
String ms = "";
float incrementTime = 0;

void PausePlayGraphics(){
  noStroke();
  if(!isSimulating) {
    
    incrementPlay = 0;
    
    rectMode(CENTER);
    if(increment < 1) increment += 0.015;
    if(increment > 1) increment = 1;
    fill(lerp(255, 100, increment));
    stroke(lerp(255, 100, increment));
    rect(width/2 - 40, height/2, 40, 140);
    rect(width/2 + 40, height/2, 40, 140);
  }
  else {
  
    increment = 0;
    
    if(incrementPlay < 1) incrementPlay += 0.015;
    if(incrementPlay > 1) incrementPlay = 1;
    
    fill(lerp(255, 100, incrementPlay));
    stroke(lerp(255, 100, incrementPlay));

    triangle(width / 2 - 40, height / 2 - 70, width / 2 - 40, height / 2 + 70, width / 2 + 60, height / 2);
  }
}

float increment = 0;
float incrementPlay = 0;
