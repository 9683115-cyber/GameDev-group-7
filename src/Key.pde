// Malcom Kyle
class Key {
  PApplet parent;
  float x, y;
  float size = 40;
  boolean isCollected = false;
  PImage img;

  Key(PApplet p, float startX, float startY, PImage keyImage) {
    parent = p;
    x = startX;
    y = startY;
    img = keyImage;
  }

  void display() {
    if (!isCollected) {
      parent.imageMode(CENTER);
      parent.image(img, x, y, size, size);
    }
  }

  void checkCollision(Player p) {
    if (!isCollected) {
      float px = p.x + p.hitboxXOffset;
      float py = p.y + p.hitboxYOffset;
      if (!(px + p.hitboxWidth <= x - size/2 || px >= x + size/2 || py + p.hitboxHeight <= y - size/2 || py >= y + size/2)) {
        isCollected = true;
      }
    }
  }
}

