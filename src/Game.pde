// Color Fade from Black to White
// Processing boilerplate code

float brightness = 0;    // starting color value
float speed = 0.5;  
int gamestate; 
void setup() {
  size(800, 600);        // set window size
  colorMode(HSB, 255);   // use Hue, Saturation, Brightness mode
  noStroke();
  gamestate = 0; 
}

void draw() {
  // Set background color using current brightness
  if(gamestate == 0){
    // startscreen
  }
  else if (gamestate == 1){
      // pause screen 
  }
  else{
    // you lose screen
  }
}
