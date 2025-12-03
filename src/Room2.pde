class Room2 extends Room {
  Enemy enemy;
  Task task;
  Key key;

  Room2(PApplet p, PImage bgImg, PImage doorImg, PImage enemyImg, PImage keyImg) {
    super(p, bgImg, doorImg);

    key = new Key(parent, 300, 300, keyImg);
    task = new Task(parent, 400, 500, "Escape Room 2");
    enemy = new Enemy(parent, 700, 200, 64, 96, 2, 200, enemyImg);

    obstacles.add(new Obstacle(300, 400, 200, 50));
    obstacles.add(new Obstacle(600, 250, 120, 120));
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
