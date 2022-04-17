import ketai.ui.*;
import ketai.camera.*;
import ketai.sensors.*;
import processing.vr.*;

import java.util.*;

KetaiCamera camera;
int camera_numbers;
boolean manyCamera;

color red         = color(255, 0, 0);
color transparent = color(255, 255, 255, 0);

color teinte      = red; 

ArrayList<Integer> position = new ArrayList();

boolean refresh = false;

void setup(){
  fullScreen(MONO);
  colorMode(RGB, 255, 255, 255);
  orientation(LANDSCAPE);
  
  // Center mode for camera visibility
  imageMode(CENTER); 
  textAlign(CENTER, CENTER);
  
  // Font mode for font visibility
  textSize(displayDensity * 50);
  
  strokeWeight(10);
    
  // Setup for camera
  camera = new KetaiCamera(this, 1280, 720, 24);
  if(camera != null){
    camera_numbers = camera.getNumberOfCameras();
    manyCamera = (camera_numbers > 1);
  }
  
}

void draw(){
  if(camera!= null){
    camera.start();
    if(camera.isStarted()){
      background(0);
      if(refresh){
        refresh = false;
        camera.read();
        camera.updatePixels();
      }
      
      image(camera, width/2, height/2, width, height);
      background(0); // Remove for camera 
      
      // Drawing the different lines
      if(!position.isEmpty()){
        for(int x = 0; x < position.size(); x+=4){
          line(position.get(x), 
               position.get(x+1),
               position.get(x+2),
               position.get(x+3));
        }
      }
    }else{
      background(#D16363);
    }
    printEraserButtonOnScreen();
  }
}

void onCameraPreviewEvent(){
  camera.read();
  refresh = true;
}

void mousePressed(){
  if(mouseY < height/5){
    if(mouseX >= 0 && mouseX <= width){
      position.clear();
    }
  }
}

// Drawing something on the screen
void mouseDragged(){
  stroke(teinte);
  line(pmouseX, pmouseY, mouseX, mouseY);
  position.add(pmouseX);
  position.add(pmouseY);
 
  position.add(mouseX);
  position.add(mouseY);

}

// Eraser button
void printEraserButtonOnScreen(){
  pushStyle();
  noFill();
  stroke(255);
  rect(100, 0, width/3, 100);
  if(camera.isStarted()){
    text("Eraser", 350, 50);
  }
  popStyle();
}
