// Kai Li Cantwell
class Enemy {
  PApplet parent;
  PImage img;   // <-- add this
  float x, y;
  float width, height;
  float speed;
  float range;
  boolean chasing = false;
  float dirX, dirY;

  // Constructor now includes PImage
  Enemy(PApplet p, float startX, float startY, float w, float h, float spd, float rng, PImage i) {
    parent = p;
    img = i;              // store image
    x = startX;
    y = startY;
    width = w;
    height = h;
    speed = spd;
    range = rng;
    dirX = parent.random(-1,1);
    dirY = parent.random(-1,1);
  }

  void display() {
    parent.image(img, x, y, width, height);
  }

  void update(Playar p) {
    float distance = parent.dist(x, y, p.x, p.y);
    if (distance < range) {
      // chase player
      float angle = parent.atan2(p.y - y, p.x - x);
      x += parent.cos(angle) * speed;
      y += parent.sin(angle) * speed;
    } else {
      // random movement
      x += dirX * speed * 0.5;
      y += dirY * speed * 0.5;
      if (x < 0 || x + width > parent.width) dirX *= -1;
      if (y < 0 || y + height > parent.height) dirY *= -1;
    }
  }
}

