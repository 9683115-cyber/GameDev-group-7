class Player {
  float x, y;
  float width, height;
  float speed;
  int collectedKeys;
  boolean isCaught;

  // --- Constructor (4 parameters) ---
  Player(float startX, float startY, float w, float h) {
    x = startX;
    y = startY;
    width = w;
    height = h;
    speed = 2.5;
    collectedKeys = 0;
    isCaught = false;
  }

  // --- Display ---
  void display() {
    fill(0, 200, 255);
    rect(x, y, width, height);
  }

  // --- Movement ---
  void move() {
    if (keyPressed) {
      char k = Character.toLowerCase(key); // handle uppercase keys too
      if (k == 'w' || keyCode == UP)    y -= speed;
      if (k == 's' || keyCode == DOWN)  y += speed;
      if (k == 'a' || keyCode == LEFT)  x -= speed;
      if (k == 'd' || keyCode == RIGHT) x += speed;
    }

    x = constrain(x, 0, width - this.width);
    y = constrain(y, 0, height - this.height);
  }

  void update() {
    if (!isCaught) move();
  }
}
