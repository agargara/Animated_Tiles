boolean DEBUG = true;
int w, h, tileW, tileH, offsetX, offsetY;
float amplitude, amplitudeMax, speed, frequency;
PImage tile;

void setup() {
  w = 800;
  h = 600;
  tile = loadImage("tile_001.png");
  tileW = tile.width;
  tileH = tile.height;
  offsetX = 0;
  offsetY = 0;
  amplitude = 0;
  amplitudeMax = 16;
  speed = 0.1;
  frequency = 0.01;
  noCursor();
  size(w, h);
  frameRate(60);
  fill(255);
}

void draw() { 
  amplitude = 5+abs(amplitudeMax*sin(float(frameCount)/80));
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
      offsetX = int(amplitude*sin((i*frequency)+(frameCount*speed)));
      offsetY = int(amplitude*sin((j*frequency)+(frameCount*speed)));
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

boolean sketchFullScreen() {
  return true;
}
