class Playar {
  PApplet parent;

  PImage[] marioFrames;
  PImage[] backMarioFrames;
  PImage[] currentFrames;

  int frameCount;
  int currentFrame = 0;
  int frameDelay = 6;
  int frameTimer = 0;

  public float x, y; // public for Enemy access
  float vx = 0, vy = 0;
  float width = 64, height = 96;

  boolean movingLeft = false;
  boolean movingRight = false;
  boolean movingUp = false;
  boolean movingDown = false;

  Playar(PApplet p, float startX, float startY, PImage[] front, PImage[] back) {
    parent = p;
    x = startX;
    y = startY;
    marioFrames = front;
    backMarioFrames = back;
    currentFrames = marioFrames;
    frameCount = marioFrames.length;
  }

  void update() {
    vx = 0; vy = 0;

    if (movingLeft) vx = -3;
    if (movingRight) vx = 3;
    if (movingUp) vy = -3;
    if (movingDown) vy = 3;

    x += vx;
    y += vy;

    // Animation rules
    if (movingRight) {
      currentFrames = backMarioFrames;
    } else {
      currentFrames = marioFrames;
    }

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
