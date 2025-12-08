// Dave Martinez Valencia
//(Some game mechanics and code logic were implemented with the help of ChatGPT)
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

  // Hitbox (offsets from player's x,y)
  float hitboxXOffset = 10;
  float hitboxYOffset = -5;
  float hitboxWidth = 40;
  float hitboxHeight = 70;

  Player(PApplet p, float startX, float startY, PImage[] front, PImage[] back) {
    parent = p;
    x = startX;
    y = startY;
    marioFrames = front;
    backMarioFrames = back;
    currentFrames = marioFrames;
    frameCount = marioFrames.length;
  }

  // Pass in obstacles and room limits
  void update(ArrayList<Obstacle> obstacles, float minX, float maxX, float minY, float maxY) {
    float oldX = x;
    float oldY = y;
    vx = vy = 0;

    if (movingLeft)  vx = -speed;
    if (movingRight) vx = speed;
    if (movingUp)    vy = -speed;
    if (movingDown)  vy = speed;

    x += vx;
    // Check horizontal collisions with obstacles
    for (Obstacle o : obstacles) {
      if (collidesWith(o.x, o.y, o.w, o.h)) {
        x = oldX;
        break;
      }
    }

    y += vy;
    // Check vertical collisions with obstacles
    for (Obstacle o : obstacles) {
      if (collidesWith(o.x, o.y, o.w, o.h)) {
        y = oldY;
        break;
      }
    }

    // Enforce room boundaries (invisible walls)
    x = parent.constrain(x, minX, maxX - width);
    y = parent.constrain(y, minY, maxY - height);

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
    // debug hitbox
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
