class Playar {
  PApplet parent;

  PImage[] marioFrames;
  PImage[] backMarioFrames;
  PImage[] currentFrames;

  int frameCount;
  float currentFrame = 0;
  float animationSpeed = 1.2f;

  float x, y;
  float vx = 0, vy = 0;
  float speed = 10; 
  float width = 64, height = 96;

  boolean movingLeft = false;
  boolean movingRight = false;
  boolean movingUp = false;
  boolean movingDown = false;

  // MAP LIMITS
  float leftLimit = 550;
  float rightLimit = 1370;
  float topLimit = 140;
  float bottomLimit = 1100;

  // Hitbox
  float hitboxXOffset = 10;
  float hitboxYOffset = -5;
  float hitboxWidth = 40;
  float hitboxHeight = 70;

  Playar(PApplet p, float startX, float startY, PImage[] front, PImage[] back) {
    parent = p;
    x = startX;
    y = startY;
    marioFrames = front;
    backMarioFrames = back;
    currentFrames = marioFrames;
    frameCount = marioFrames.length;
  }

  void update(ArrayList<Obstacle> obstacles) {
    float oldX = x, oldY = y;
    vx = vy = 0;

    if (movingLeft)  vx = -speed;
    if (movingRight) vx = speed;
    if (movingUp)    vy = -speed;
    if (movingDown)  vy = speed;

    x += vx;
    y += vy;

    // Collision with obstacles
    for (Obstacle o : obstacles) {
      if (collidesWith(o.x, o.y, o.w, o.h)) {
        x = oldX;
        y = oldY;
      }
    }

    // Map boundaries
    x = parent.constrain(x, leftLimit, rightLimit - width);
    y = parent.constrain(y, topLimit, bottomLimit - height);

    // Animation frames
    if (movingRight) currentFrames = backMarioFrames;
    else if (movingLeft) currentFrames = marioFrames;

    if (vx != 0 || vy != 0) {
      currentFrame += animationSpeed * (Math.abs(vx) + Math.abs(vy)) / 10.0f;
      if (currentFrame >= frameCount) currentFrame = 0;
    } else currentFrame = 0;
  }

  void display() {
    parent.image(currentFrames[(int)currentFrame], x, y, width, height);

    // Optional hitbox display
    parent.noFill();
    parent.stroke(255, 0, 0);
    parent.rect(x + hitboxXOffset, y + hitboxYOffset, hitboxWidth, hitboxHeight);
  }

  boolean collidesWith(float ox, float oy, float ow, float oh) {
    float hx = x + hitboxXOffset;
    float hy = y + hitboxYOffset;
    return !(hx + hitboxWidth <= ox || hx >= ox + ow || hy + hitboxHeight <= oy || hy >= oy + oh);
  }
}
