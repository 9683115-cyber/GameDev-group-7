//Kai Li Cantwell
//(Some game mechanics and code logic were implemented with the help of ChatGPT)
class Room {
  PApplet parent;

  PImage bg;
  PImage doorImg;
  float doorX, doorY, doorW, doorH;

  float minX, maxX, minY, maxY;

  Key roomKey;
  Task roomTask;
  Enemy roomEnemy;

  float enemySpeed;
  float enemyRange;

  ArrayList<Obstacle> obstacles;

  // Determines how much of the room the Enemy is allowed to wander in
  final float WANDER_ZONE_PADDING = 0.25f;

  Room(PApplet p, PImage bg, PImage doorImg,
    float doorX, float doorY, float doorW, float doorH,
    Key key, Task task,
    float enemySpeed, float enemyRange,
    float minX, float maxX, float minY, float maxY,
    PImage enemyImg, float enemyStartX, float enemyStartY, float enemyW, float enemyH) {
    parent = p;

    this.bg = bg;
    this.doorImg = doorImg;
    this.doorX = doorX;
    this.doorY = doorY;
    this.doorW = doorW;
    this.doorH = doorH;

    this.roomKey = key;
    this.roomTask = task;

    this.enemySpeed = enemySpeed;
    this.enemyRange = enemyRange;

    this.minX = minX;
    this.maxX = maxX;
    this.minY = minY;
    this.maxY = maxY;

    this.obstacles = new ArrayList<Obstacle>();

    // Create a room-specific enemy
    this.roomEnemy = new Enemy(parent, enemyStartX, enemyStartY, enemyW, enemyH, enemySpeed, enemyRange, enemyImg);

    // Set enemy movement boundaries to room limits 
    this.roomEnemy.leftLimit = this.minX;
    this.roomEnemy.rightLimit = this.maxX;
    this.roomEnemy.topLimit = this.minY;
    this.roomEnemy.bottomLimit = this.maxY;
  }

  void drawRoom() {
    imageMode(CORNER);
    parent.image(bg, 0, 0, parent.width, parent.height);
    parent.image(doorImg, doorX, doorY, doorW, doorH);

    // Draw obstacles 
    for (Obstacle o : obstacles) o.display();


  }

  boolean playerAtDoor() {
    return player.x + player.width > doorX &&
      player.x < doorX + doorW &&
      player.y + player.height > doorY &&
      player.y < doorY + doorH;
  }

  // Creates a smaller wander zone for the enemy so that it doesn’t
// constantly hit walls and obstacles or get stuck in corners
  float[] getWanderZone() {
    float widthRoom = maxX - minX;
    float heightRoom = maxY - minY;
    float padX = widthRoom * WANDER_ZONE_PADDING;
    float padY = heightRoom * WANDER_ZONE_PADDING;
    float wzMinX = minX + padX;
    float wzMaxX = maxX - padX;
    float wzMinY = minY + padY;
    float wzMaxY = maxY - padY;
    return new float[] { wzMinX, wzMaxX, wzMinY, wzMaxY };
  }

  // Place enemy at center of the wander zone
  void resetEnemyToWanderZoneCenter() {
    float[] wz = getWanderZone();
    roomEnemy.x = (wz[0] + wz[1]) / 2.0;
    roomEnemy.y = (wz[2] + wz[3]) / 2.0;
    // reset wander direction randomly
    roomEnemy.dirX = parent.random(-1, 1);
    roomEnemy.dirY = parent.random(-1, 1);
  }
}
