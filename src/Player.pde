// Kai Li Cantwell, Dave Martinez Valencia
class Player {
  PApplet parent;

  PImage[] marioFrames;
  PImage[] backMarioFrames;
  PImage[] currentFrames;

  int frameCount;
  int currentFrame = 0;

  int frameDelay = 2;
  int frameTimer = 0;

  float x, y;
  float vx = 0, vy = 0;
  float speed = 10;

  float width = 64, height = 96;

  boolean movingLeft = false;
  boolean movingRight = false;
  boolean movingUp = false;
  boolean movingDown = false;

  // MAP LIMITS (from your screenshot)
  float leftLimit   = 550;
  float rightLimit  = 1370;
  float topLimit    = 140;
  float bottomLimit = 870;

  Player(PApplet p, float startX, float startY, PImage[] front, PImage[] back) {
    parent = p;
    x = startX;
    y = startY;
    marioFrames = front;
    backMarioFrames = back;
    currentFrames = marioFrames;
    frameCount = marioFrames.length;
  }

  void update() {
    vx = vy = 0;

    if (movingLeft)  vx = -speed;
    if (movingRight) vx = speed;
    if (movingUp)    vy = -speed;
    if (movingDown)  vy = speed;

    x += vx;
    y += vy;

    // Enforce invisible wall boundaries
    x = parent.constrain(x, leftLimit, rightLimit - width);
    y = parent.constrain(y, topLimit, bottomLimit - height);

    // Animation switching
    currentFrames = movingRight ? backMarioFrames : marioFrames;

    // Animation logic
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
    parent.image(currentFrames[currentFrame], x, y, width, height);
  }
}


