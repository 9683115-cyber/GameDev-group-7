//Rusty Spendlove
class Task {
  PApplet parent;
  float x, y;
  String description;
  boolean complete = false;
  float size = 40;

  Task(PApplet p, float startX, float startY, String desc) {
    parent = p;
    x = startX;
    y = startY;
    description = desc;
  }

  void display() {
    parent.textAlign(LEFT, TOP);
    parent.textSize(28);
    if (complete) {
      parent.fill(100, 255, 100); // green when complete
    } else {
      parent.fill(255); // white otherwise
    }
    parent.text(description, 50, 50);
  }

  void checkInteraction(Player p) {
    // simple proximity using player's center and task size
    float distance = parent.dist(x, y, p.x + p.width/2, p.y + p.height/2);
    if (distance < 50) complete = true;
  }
}
