class Enemy {
  // --- Attributes ---
  float x, y;
  float width, height;
  float speed;
  float range;
  boolean chasing;
  float dirX, dirY; // for random movement direction

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
  }

  // --- Display Enemy ---
  void display() {
    fill(255, 0, 0);
    rect(x, y, width, height);
  }

  // --- Detect if Player is in Range ---
  boolean detectPlayer(Player p) {
    float distance = dist(x, y, p.x, p.y);
    chasing = distance < range;
    return chasing;
  }

  // --- Chase Player when Detected ---
  void chasePlayer(Player p) {
    float angle = atan2(p.y - y, p.x - x);
    x += cos(angle) * speed;
    y += sin(angle) * speed;
  }

  // --- Move Randomly when Player not Detected ---
  void moveRandomly() {
    x += dirX * speed * 0.5;
    y += dirY * speed * 0.5;

    // bounce off screen edges
    if (x < 0 || x + width > width) dirX *= -1;
    if (y < 0 || y + height > height) dirY *= -1;
  }

  // --- Update Function (for main draw loop) ---
  void update(Player p) {
    if (detectPlayer(p)) {
      chasePlayer(p);
    } else {
      moveRandomly();
    }
  }
}
