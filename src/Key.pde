class Kay {
  // --- Attributes ---
  float x, y;
  float size;
  boolean isCollected;

  // --- Constructor ---
  Kay(float startX, float startY) {
    x = startX;
    y = startY;
    size = 20;
    isCollected = false;
  }

  // --- Display the key ---
  void display() {
    if (!isCollected) {
      fill(255, 215, 0);  // gold
      ellipse(x, y, size, size);
      fill(150, 120, 0);  // handle color
      rect(x + size / 4, y - size / 8, size / 2, size / 4);
    }
  }

  // --- Check if Player collides with the key ---
  boolean checkCollision(Player p) {
    if (!isCollected) {
      if (p.x < x + size &&
          p.x + p.width > x &&
          p.y < y + size &&
          p.y + p.height > y) {
        collect();
        p.collectedKeys++;
        return true;
      }
    }
    return false;
  }

  // --- Mark key as collected ---
  void collect() {
    isCollected = true;
  }
}
