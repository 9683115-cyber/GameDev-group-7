class Room1 extends Room {
  Enemy enemy;
  Task task;
  Key key;

  Room1(PApplet p, PImage bgImg, PImage doorImg, PImage enemyImg, PImage keyImg) {
    super(p, bgImg, doorImg); // initialize parent

    key = new Key(parent, 600, 200, keyImg);
    task = new Task(parent, 520, 580, "Find the Key");
    enemy = new Enemy(parent, 750, 200, 64, 96, 2, 200, enemyImg);

    obstacles.add(new Obstacle(882, 320, 255, 329));
    obstacles.add(new Obstacle(780, 350, 60, 60));
    obstacles.add(new Obstacle(788, 569, 55, 55));
    obstacles.add(new Obstacle(1170, 426, 55, 55));
    obstacles.add(new Obstacle(1170, 565, 55, 55));
    obstacles.add(new Obstacle(1080, 835, 100, 165));
    obstacles.add(new Obstacle(950, 237, 400, 79));
  }

  @Override
  void run(Playar player) {
    parent.image(backgroundImg, 0, 0, parent.width, parent.height);
    if (doorImg != null) parent.image(doorImg, 430, 491, 190, 270);

    for (Obstacle o : obstacles) o.display();

    player.update(obstacles);
    player.display();

    if (key != null) { key.display(); key.checkCollision(player); }
    if (task != null) task.checkInteraction(player);
    if (enemy != null) enemy.update(player, obstacles);
    if (enemy != null) enemy.display();
  }

  @Override
  boolean isComplete() {
    return key.isCollected && task.complete;
  }
}
