import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Animated_Tiles extends PApplet {

boolean DEBUG = true;
int w, h, tileW, tileH, offsetX, offsetY;
float amplitude, amplitudeMax, speed, frequency;
PImage tile;

public void setup() {
  w = 800;
  h = 600;
  tile = loadImage("tile_001.png");
  tileW = tile.width;
  tileH = tile.height;
  offsetX = 0;
  offsetY = 0;
  amplitude = 0;
  amplitudeMax = 16;
  speed = 0.1f;
  frequency = 0.01f;
  noCursor();
  size(w, h);
  frameRate(60);
  fill(255);
}

public void draw() { 
  amplitude = 5+abs(amplitudeMax*sin(PApplet.parseFloat(frameCount)/80));
  background(0); // clear
  for(int i=0; i<w; i+=tileW){
    for(int j=0; j<h; j+=tileH){
      image(tile, i, j, tileW, tileH);
    }
  }
  loadPixels();
  int[] pixelsCopy = new int[pixels.length];
  arrayCopy(pixels, pixelsCopy);
  for (int i = 0; i < w; i+=1) { // every other column
    for (int j = 0; j < h; j+=1){
      // Earthbound distortion function:
      // Offset (y, t) = A sin ( F*y + S*t )
      offsetX = PApplet.parseInt(amplitude*sin((i*frequency)+(frameCount*speed)));
      offsetY = PApplet.parseInt(amplitude*sin((j*frequency)+(frameCount*speed)));
      int previousTile = i+(j*w)+(w*offsetY)+offsetX;
      if (previousTile < 0){
        previousTile = pixels.length + previousTile; // wrap-around
      }
       pixels[i+(j*w)] = pixelsCopy[previousTile%pixels.length];
    }
  }
updatePixels();
  
  if(DEBUG){
    text(frameRate,10,20);
  }
}

public boolean sketchFullScreen() {
  return true;
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Animated_Tiles" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
