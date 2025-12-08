class Room2 extends Room {
  Enemy2 enemy;
  Task task;
  Key key;

  Room2(PApplet p, PImage bgImg, PImage doorImg, PImage enemyImg, PImage keyImg) {
    super(p, bgImg, doorImg);

    key = new Key(parent, 250, 350, keyImg);
    task = new Task(parent, 600, 500, "Escape Biblioteca");
    enemy = new Enemy2(parent, 900, 200, 64, 96, 2, 200, enemyImg);
  }

  @Override
  void run(Playar player) {
    
    player.setLimits(80, 1200, 80, 900);

    obstacles.clear();


    
    obstacles.add(new Obstacle(1450, 530, 270, 220));
    obstacles.add(new Obstacle(1165, 530, 270, 220));
    obstacles.add(new Obstacle(870, 530, 270, 220));
    obstacles.add(new Obstacle(1450, 22, 270, 220));
    obstacles.add(new Obstacle(1170, 22, 270, 220));
    obstacles.add(new Obstacle(200, 22, 270, 220));
    obstacles.add(new Obstacle(200, 22, 270, 220));
    obstacles.add(new Obstacle(185, 400, 380, 400));


    parent.image(backgroundImg, 0, 0, parent.width, parent.height);
    if (doorImg != null) parent.image(doorImg, 430, 491, 190, 270);

    for (Obstacle o : obstacles) o.display();

    player.update(obstacles);
    player.display();

    if (key != null) {
      key.display();
      key.checkCollision(player);
    }

    if (task != null) {
      task.checkInteraction(player);
    }

    if (enemy != null) {
      enemy.update(player, obstacles);
      enemy.display();
    }
  }

  @Override
  boolean isComplete() {
    return key.isCollected && task.complete;
  
  }
}
