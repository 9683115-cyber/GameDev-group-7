// Kai Li Cantwell, Dave Martinez Valencia
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
      boolean colliding = !(
        p.x + p.width < x - size/2 ||
        p.x > x + size/2 ||
        p.y + p.height < y - size/2 ||
        p.y > y + size/2
      );
      if (colliding) isCollected = true;
    }
  }
}


