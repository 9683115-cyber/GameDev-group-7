class Player {
  // --- Attributes ---
  float x, y, width, height;
  float speed;         
  int collectedKeys;   
  boolean isCaught;    

  // --- Constructor ---
  Player(float startX, float startY) {
    x = startX;
    y = startY;
    width = 30;
    height = 30;
    speed = 2.5;
    collectedKeys = 0;
    isCaught = false;
  }

  // --- Methods ---

  // Draw the player
  void display() {
    fill(0, 200, 255);
    rect(x, y, width, height);
  }

  // Player movement using WASD keys
  void move() {
    if (keyPressed) {
      if (key == 'w' || keyCode == UP)    y -= speed;
      if (key == 's' || keyCode == DOWN)  y += speed;
      if (key == 'a' || keyCode == LEFT)  x -= speed;
      if (key == 'd' || keyCode == RIGHT) x += speed;
    }

    // Makes sure player stays within screen boundaries
    x = constrain(x, 0, width - this.width);
    y = constrain(y, 0, height - this.height);
  }

  // Check collision with enemy (Maltigi)
  boolean checkCollision(Enemy e) {
    if (x < e.x + e.width &&
        x + width > e.x &&
        y < e.y + e.height &&
        y + height > e.y) {
      isCaught = true;
      return true;
    }
    return false;
  }

  // Complete a task
  void completeTask(Task t) {
    if (!t.isCompleted) {
      t.isCompleted = true;
      collectedKeys++;
    }
  }
}
