import ketai.ui.*;
import ketai.camera.*;
import ketai.sensors.*;

KetaiCamera camera;
int camera_numbers;
boolean manyCamera;

boolean refresh = false;

void setup(){
  fullScreen();
  colorMode(RGB, 255, 255, 255);
  orientation(PORTRAIT);
  
  // Center mode for camera visibility
  imageMode(CENTER); 
  textAlign(CENTER, CENTER);
  
  // Font mode for font visibility
  textSize(displayDensity * 25);
  
  // Setup for camera
  camera = new KetaiCamera(this, 1280, 720, 24);
  if(camera != null){
    camera_numbers = camera.getNumberOfCameras();
    manyCamera = (camera_numbers > 1);
  }
  
}

void draw(){
  if(camera != null && camera.isStarted()){
    if(refresh){
      refresh = false;
      camera.read();
      camera.updatePixels();
    }
    
    image(camera, width/2, height/2, width, height);
  }else{
    background(#D16363);
  }
  printButtonsOnScreen();
}

void onCameraPreviewEvent(){
  camera.read();
  refresh = true;
}

void mousePressed(){
  if(mouseY < height / 5){
    if(mouseX >= 0 && mouseX <= width){
      if(camera.isStarted()){
        camera.stop();
      }else{
        camera.start();
      }
    }
  }
}

void printButtonsOnScreen(){
  rect(0,0, width/3, 100);
  fill(0);
  stroke(255);
  if(camera.isStarted()){
    text("Camera Off", width/2, 100);
  }else{
    text("Camera On", width/2, 100);
  }
}
