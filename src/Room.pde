class Room {
  PApplet parent;

  Key roomKey;
  Enemy roomEnemy;
  Task roomTask;

  float doorX, doorY;   // where player goes to next room
  float doorSize = 60;

  Room(PApplet p, Key k, Enemy e, Task t, float dX, float dY) {
    parent = p;
    roomKey = k;
    roomEnemy = e;
    roomTask = t;
    doorX = dX;
    doorY = dY;
  }

  void display() {
    // Background for room (change if needed)
    parent.background(80, 180, 250);

    // Display objects
    roomKey.display();
    roomTask.display();
    roomEnemy.display();

    // Draw the "door"
    parent.fill(255, 220, 0);
    parent.rectMode(CENTER);
    parent.rect(doorX, doorY, doorSize, doorSize * 1.5);
  }

  void update(Player p) {
    roomEnemy.update(p);
    roomTask.checkInteraction(p);
    roomKey.checkCollision(p);
  }

  boolean reachedDoor(Player p) {
    return dist(p.x + p.width/2, p.y + p.height/2, doorX, doorY) < doorSize;
  }
}
