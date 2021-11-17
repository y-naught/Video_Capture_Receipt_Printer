
import processing.video.*;
import processing.serial.*;

Capture cam;

int counter = 0;
boolean isTakingImages = true;

//constant for how many frames the capture system records
static final int MAX_FRAMES = 60;

//camera Buffer and font unfortunately need to be global variables in this setup
PGraphics cameraBuffer;
PFont thisFont;

void setup(){
  //size(960,540);
  fullScreen(1);
  background(0);
  
  //PICK FONT HERE
  //Change the string here for your font
  thisFont = createFont("Arial Black.ttf", 48);
  
  println("Setup Running...");
  
  //instantiate camera buffer
  cameraBuffer = createGraphics(960, 540);
  
  //get list of camera options from the OS
  String[] cameras = Capture.list(); 
  
  //print options to console
  if(cameras.length == 0){
     println("No Cameras Available"); 
  }else{
     for(int i = 0; i < cameras.length; i++){
       println(cameras[i]);
    }
  }
  
  
  println("Camera setting [3] chosen by default");
  
  //instantiate camera object and start the system
  cam = new Capture(this, cameras[3]);
  cam.start();
  
}

void draw(){
  //check if a new frame is available from the camera
  if(cam.available()){
    cam.read();
    
    //check to see if we should be capturing frames
    if(counter < MAX_FRAMES){
      isTakingImages = true;
      String tempName = "frame_" + counter +".jpg";
      //saves off to frame buffer
      cameraBuffer.beginDraw();
      cameraBuffer.image(cam,0,0);
      cameraBuffer.endDraw();
      cameraBuffer.save(tempName);
      counter++;
    }
    //if we have reached the number of frames we want to capture, run the print function
    if(counter == MAX_FRAMES){
       isTakingImages = false;
       println("Compiling Graphics!");
       compileGraphics();
       counter++;
    }
  }
  
  //display image on screen
  image(cam, 0,0, width, height);
  
  //JOSH ADJUSTS IF DESIRIED
  //center text attributes to change
  float textLocX = width/2;
  float textLocY = height * 3 / 4;
  float dropShadow = 2;
  float thisTextSize = 50;
  
  //sets font
  textFont(thisFont);
  
  //runs text animation while recording frames 
  //please excuse this very ugly code, this should be placed into a more modular fuction but there is no budget for this project.
  if((counter < MAX_FRAMES) && (counter % 4 == 0)){
    textSize(thisTextSize);
    textAlign(CENTER);
    fill(0);
    text("Analyzing", textLocX + dropShadow, textLocY - 50 / 2 + dropShadow);
    text("Please Sit Still", textLocX + dropShadow, textLocY + 50 / 2 + dropShadow);
    fill(0);
    text("Analyzing", textLocX - dropShadow, textLocY - 50 / 2 + dropShadow);
    text("Please Sit Still", textLocX - dropShadow, textLocY + 50 / 2 + dropShadow);
    fill(255);
    text("Analyzing", textLocX, textLocY - 50 / 2);
    text("Please Sit Still", textLocX, textLocY + 50 / 2);
  }else if((counter < MAX_FRAMES) && (counter % 4 == 1)){
    textSize(thisTextSize);
    textAlign(CENTER);
    fill(0);
    text(".Analyzing.", textLocX + dropShadow, textLocY - 50 / 2 + dropShadow);
    text("Please Sit Still", textLocX + dropShadow, textLocY + 50 / 2 + dropShadow);
    fill(0);
    text(".Analyzing.", textLocX - dropShadow, textLocY - 50 / 2 + dropShadow);
    text("Please Sit Still", textLocX - dropShadow, textLocY + 50 / 2 + dropShadow);
    fill(255);
    text(".Analyzing.", textLocX, textLocY - 50 / 2);
    text("Please Sit Still", textLocX, textLocY + 50 / 2);
  }else if((counter < MAX_FRAMES) && (counter % 4 == 2)){
    textSize(thisTextSize);
    textAlign(CENTER);
    fill(0);
    text("..Analyzing..", textLocX + dropShadow, textLocY - 50 / 2 + dropShadow);
    text("Please Sit Still", textLocX + dropShadow, textLocY + 50 / 2 + dropShadow);
    fill(0);
    text("..Analyzing..", textLocX - dropShadow, textLocY - 50 / 2 + dropShadow);
    text("Please Sit Still", textLocX - dropShadow, textLocY + 50 / 2 + dropShadow);
    fill(255);
    text("..Analyzing..", textLocX, textLocY - 50 / 2);
    text("Please Sit Still", textLocX, textLocY + 50 / 2);
  }else if((counter < MAX_FRAMES) && (counter % 4 == 3)){
    textSize(thisTextSize);
    textAlign(CENTER);
    fill(0);
    text("...Analyzing...", textLocX + dropShadow, textLocY - 50 / 2 + dropShadow);
    text("Please Sit Still", textLocX + dropShadow, textLocY + 50 / 2 + dropShadow);
    fill(0);
    text("...Analyzing...", textLocX - dropShadow, textLocY - 50 / 2 + dropShadow);
    text("Please Sit Still", textLocX - dropShadow, textLocY + 50 / 2 + dropShadow);
    fill(255);
    text("...Analyzing...", textLocX, textLocY - 50 / 2);
    text("Please Sit Still", textLocX, textLocY + 50 / 2);
  }
  
  //Circle animations vairables
  float thisCircleStroke = 8;
  float thisLineStroke = 3;
  float thisCircleSize = 50;
  
  //draws the circles and leads to the screen while the system is recording frames
  if(counter < MAX_FRAMES){
    drawCircleLead(0, 0, width / 2, 0, height / 2, thisCircleSize, thisCircleStroke, thisLineStroke);
    drawCircleLead(1, width/2, width, 0, height / 2, thisCircleSize, thisCircleStroke, thisLineStroke);
    drawCircleLead(2, 0, width / 2, height/2, height, thisCircleSize, thisCircleStroke, thisLineStroke);
    drawCircleLead(3, width / 2, width, height / 2, height, thisCircleSize, thisCircleStroke, thisLineStroke);
  }
  
}

//used to draw a circle and lead on the screen at a random location during the animation
void drawCircleLead(int quadrant, float wMin, float wMax, float hMin, float hMax, float circleSize, float circleStroke, float lineStroke){
    strokeWeight(circleStroke);
    stroke(255);
    noFill();
    float thisX = random(wMin, wMax);
    float thisY = random(hMin, hMax);
    float linePlacementDivider = 3;
    
    
    ellipse(thisX, thisY, circleSize, circleSize);
    
    //please excuse thsi very ugly code.
    if(quadrant == 0){
      stroke(255);
      strokeWeight(lineStroke);
      line(-5,-5, thisX - circleSize / linePlacementDivider, thisY - circleSize / linePlacementDivider);
    }else if(quadrant == 1){
      stroke(255);
      strokeWeight(lineStroke);
      line(width + 5, -5, thisX + circleSize / linePlacementDivider, thisY - circleSize / linePlacementDivider);
    }else if(quadrant == 2){
      stroke(255);
      strokeWeight(lineStroke);
      line( -5, height + 5, thisX - circleSize / linePlacementDivider, thisY + circleSize / linePlacementDivider);
    }else{
      stroke(255);
      strokeWeight(lineStroke);
      line(width + 5, height + 5, thisX + circleSize / linePlacementDivider, thisY + circleSize / linePlacementDivider); 
    }
}

//called upon the keypressed event
void keyPressed(){
  if(key == 'p'){
    counter = 0;
  }
  if(key == 's'){
    println("s!");
    compileGraphics();
  }
}

//blends the captured photos into a PGraphics object, then picks a pre-generated overlay to place on top, prints the image
void compileGraphics(){
  PGraphics g;
  g = createGraphics(600, 1000);
  g.beginDraw();
  
  g.blendMode(LIGHTEST);
  for(int i = 0; i < MAX_FRAMES; i++){
    String tempName = "frame_" + i +".jpg";
    PImage tempImage = loadImage(tempName);
    tempImage.resize(1152,648);
    g.image(tempImage, -276 - 50, 176);
   
  }
  
  //pick one of the 5 overlays created via Photoshop
  String randomOverlay = getRandomOverlay();
  PImage overlay = loadImage(randomOverlay);
  
  g.image(overlay,0,0);
  g.endDraw();
  //image(g, 0, 0);
  g.save("BlendedImage.jpg");
  
  printImage("/Users/DaveyJones/Desktop/RECEIPT_PRINTER_APPLICATION/BlendedImage.jpg");    
}

//prints the image at the given path to the system printer via the commant execute function in java
void printImage(String path) {
  
  String mediaType = "-o media=Legal";
  
  Process p = exec("lp", mediaType, path);
  try {
     int result = p.waitFor();
     println("The process returns: ", result);
  }catch (InterruptedException e){
      println("error : ", e);
  }
}

//returns one of the 5 random overlays local path as a string
String getRandomOverlay(){
  String temp;
  
  //generate random variable
  float rand = random(0, 1);
  
  //structure an evenly weighted average for each image overlay
  if(rand <= 1 && rand > 0.8){
    temp = "1 Overlay.png";
  }else if(rand <= 0.8 && rand > 0.6){
    temp = "2 Overlay.png";
  }else if(rand <= 0.6 && rand > 0.4){
    temp = "3 Overlay.png";
  }else if(rand <= 0.4 && rand > 0.2){
    temp = "4 Overlay.png";
  }else{
    temp = "5 Overlay.png";
  }
  
  return temp;
}
