class Task {
  // --- Attributes ---
  float x, y;
  String description;
  boolean complete;
  float size = 40;  

  // --- Constructor ---
  Task(float startX, float startY, String desc) {
    x = startX;
    y = startY;
    description = desc;
    complete = false;
  }

 
  void display() {
    if (complete) {
      fill(100, 200, 100); // green = complete
    } else {
      fill(200, 100, 100); // red = incomplete
    }
    ellipse(x, y, size, size);

    fill(255);
    textAlign(CENTER);
    text(description, x, y - size);
  }

  
  void checkInteraction(Player p) {
    float distance = dist(x, y, p.x + p.width/2, p.y + p.height/2);
    if (distance < size/2 + max(p.width, p.height)/2) {
      complete = true;
    }
  }
}
