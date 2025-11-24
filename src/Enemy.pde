// Malcom Kyle (graphics), Kai Li Cantwell, Dave Martinez Valencia
class Enemy {
  PApplet parent;
  PImage img;
  float x, y, w, h, speed, range;
  float dirX, dirY;

  // Same invisible walls as player
  float leftLimit   = 550;
  float rightLimit  = 1370;
  float topLimit    = 140;
  float bottomLimit = 870;

  Enemy(PApplet p, float startX, float startY, float w_, float h_, float spd, float rng, PImage i) {
    parent = p;
    x = startX; 
    y = startY; 
    w = w_; 
    h = h_; 
    speed = spd; 
    range = rng; 
    img = i;

    dirX = parent.random(-1, 1);
    dirY = parent.random(-1, 1);
  }

  void update(Player p) {
    float distance = parent.dist(x + w/2, y + h/2, p.x + p.width/2, p.y + p.height/2);

    if (distance < range) {
      float angle = parent.atan2(
        p.y + p.height/2 - (y + h/2),
        p.x + p.width/2 - (x + w/2)
      );
      x += parent.cos(angle) * speed;
      y += parent.sin(angle) * speed;

    } else {
      x += dirX * speed * 0.5;
      y += dirY * speed * 0.5;

      // Turn around when hitting edges
      if (x < leftLimit || x + w > rightLimit) dirX *= -1;
      if (y < topLimit || y + h > bottomLimit) dirY *= -1;
    }

    // Enforce wall limits
    x = parent.constrain(x, leftLimit, rightLimit - w);
    y = parent.constrain(y, topLimit, bottomLimit - h);
  }

  void display() {
    parent.image(img, x, y, w, h);
  }

  boolean checkCollision(Player p) {
    return !(p.x + p.width < x ||
             p.x > x + w ||
             p.y + p.height < y ||
             p.y > y + h);
  }
}
