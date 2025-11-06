class Key {
  // --- Attributes ---
  float x, y;           
  float size;           
  boolean isCollected;  

  // --- Constructor ---
  Key(float startX, float startY) {
    x = startX;
    y = startY;
    size = 20;
    isCollected = false;
  }

  // --- Methods ---
  
  void display() {
    if (!isCollected) {
      fill(255, 215, 0); 
      ellipse(x, y, size, size);
      fill(150, 120, 0);
      rect(x + size/4, y - size/8, size/2, size/4);  
    }
  }

  // Check if player collides with key
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

  void collect() {
    isCollected = true;
  }
}
