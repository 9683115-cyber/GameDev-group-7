// Kai Li Cantwell
class Enemy {
  // --- Attributes ---
  float x, y;
  float width, height;
  float speed;
  float range;
  boolean chasing;
  float dirX, dirY; 
  PImage maltigi;

  // --- Constructor ---
  Enemy(float startX, float startY, float w, float h, float spd, float rng) {
    x = startX;
    y = startY;
    width = w;
    height = h;
    speed = spd;
    range = rng;
    chasing = false;
    dirX = random(-1, 1);
    dirY = random(-1, 1);
    maltigi = loadImage("maltigi better.png");
  }


  void display() {
    //fill(255, 0, 0);
    //rect(100, 100, width, height);
    maltigi.resize(100,100);
    image(maltigi, x,y);
    
  }

  
  boolean detectPlayer(Player p) {
    float distance = dist(x, y, p.x, p.y);
    chasing = distance < range;
    return chasing;
  }


  void chasePlayer(Player p) {
    float angle = atan2(p.y - y, p.x - x);
    x += cos(angle) * speed;
    y += sin(angle) * speed;
  }

  
  void moveRandomly() {
    x += dirX * speed * 0.5;
    y += dirY * speed * 0.5;

  
    if (x < 0 || x + width > width) dirX *= -1;
    if (y < 0 || y + height > height) dirY *= -1;
  }


  void update(Player p) {
    if (detectPlayer(p)) {
      chasePlayer(p);
    } else {
      moveRandomly();
    }
  }
}
