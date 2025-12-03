class Obstacle {

  float x, y, w, h;

  Obstacle(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void display() {
    noFill();
    // change to stroke if you want visible/debug rectangles:
    // stroke(255, 0, 0);
    noStroke();
    rect(x, y, w, h);
  }
}
