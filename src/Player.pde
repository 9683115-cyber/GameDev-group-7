class Player {
  PApplet parent;
  PImage[] frames;
  int frameCount;
  int currentFrame = 0;
  int frameDelay = 6;
  int frameTimer = 0;
 
  float x, y;
  float vx = 0, vy = 0;
  float width = 64, height = 96;

  boolean movingRight = false;
  boolean movingLeft = false;
  boolean movingUp = false;
  boolean movingDown = false;
  
  Player(PApplet p, float startX, float startY, PImage[] f) {
    parent = p;
    x = startX;
    y = startY;
    frames = f;
    frameCount = frames.length;
  }

  void update() {
    vx = 0;
    vy = 0;
    if (movingRight) vx = 3;
    if (movingLeft)  vx = -3;
    if (movingUp)    vy = -3;
    if (movingDown)  vy = 3;

    x += vx;
    y += vy;

    // Animation
    if (vx != 0 || vy != 0) {
      frameTimer++;
      if (frameTimer >= frameDelay) {
        currentFrame = (currentFrame + 1) % frameCount;
        frameTimer = 0;
      }
    } else {
      currentFrame = 0;
    }
  }

  void display() {
    parent.image(frames[currentFrame], x, y, width, height);
  }
}

