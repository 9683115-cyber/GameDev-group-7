class Enemy {
  PApplet parent;
  PImage img;
  float x, y, w, h, speed, range;
  float dirX, dirY;

  Enemy(PApplet p, float startX, float startY, float w_, float h_, float spd, float rng, PImage i) {
    parent = p; 
    x = startX; y = startY; w = w_; h = h_; speed = spd; range = rng; img = i;
    dirX = parent.random(-1, 1); 
    dirY = parent.random(-1, 1);
  }

  void display() {
    parent.image(img, x, y, w, h);
  }

  void update(Playar p) {
    float distance = parent.dist(x + w/2, y + h/2, p.x + p.width/2, p.y + p.height/2);
    if (distance < range) {
      float angle = parent.atan2(p.y + p.height/2 - (y + h/2), p.x + p.width/2 - (x + w/2));
      x += parent.cos(angle) * speed; 
      y += parent.sin(angle) * speed;
    } else {
      x += dirX * speed * 0.5; 
      y += dirY * speed * 0.5;
      if (x < 0 || x + w > parent.width) dirX *= -1;
      if (y < 0 || y + h > parent.height) dirY *= -1;
    }
  }

  boolean checkCollision(Playar p) {
    return !(p.x + p.width < x || p.x > x + w || p.y + p.height < y || p.y > y + h);
  }
}
