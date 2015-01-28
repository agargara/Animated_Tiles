boolean DEBUG = true;
int w, h, bgColor, numDots, numLayers, maxLayers, maxDots, dotDirection;
int[][][] dots;

void setup() {
  w = displayWidth;
  h = displayHeight;
  bgColor = 0;
  numDots = 8;
  numLayers = 4;
  maxDots = 800;
  maxLayers = 8;
  dots = new int[maxLayers][maxDots][2]; 
  /* Initalize all potential dots */
  for (int i = 0; i<maxLayers; i++){
    for (int j = 0; j<maxDots; j++){
      dots[i][j][0] = 0;  // x
      dots[i][j][1] = int(((float(h)/(numLayers))*(i))+(float(h)/(numLayers)/2));  // y
    }
  }
  dotDirection = 1;
  noCursor();
  size(w, h);
  frameRate(60);
  fill(255);
}

void draw() { 
  background(bgColor);
  for (int i = 0; i<numLayers; i++){
    for (int j = 0; j<numDots; j++){
      set(dots[i][j][0]%w, dots[i][j][1]%h, color(255));
      dots[i][j][1]+=random(0,8);
    }
  }
  numDots+=dotDirection;
  if((numDots > maxDots) || (numDots < 0)){
    dotDirection *= -1;
    numDots+=(dotDirection*2);
  }
  spreadDots();
  if(DEBUG){
    text(frameRate,10,20);
  }
}

void spreadDots(){
  for (int i = 0; i<numLayers; i++){
    for (int j = 0; j<numDots; j++){
      dots[i][j][0] = int(((float(w)/(numDots))*(j))+(float(w)/(numDots)/2));
    }
  }
}

boolean sketchFullScreen() {
  return true;
}
