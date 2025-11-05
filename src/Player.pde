class Player {
  float x, y, w, h, speed;
  PImage scoobydoo; 
  Player() {
    x = width/2;
    y = width/2;
    w = 50;
    h = 50;
    speed = 30;
    scoobydoo = loadImage("scoobydoo.png");
  }
  
  void display() {
    imageMode(CENTER);
    scoobydoo.resize(w, h);
    image(scoobydoo, x, y);
  }
  
  void move() {}
}
