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
    // Límites del jugador dentro de la biblioteca
    player.setLimits(80, 1200, 80, 900);

    // ===============================
    // OBSTÁCULOS DE LA BIBLIOTECA
    // (hitboxes generados del JSON)
    // ===============================
    obstacles.clear();

    // Estantes grandes
    
    obstacles.add(new Obstacle(600, 300, 280, 90));
    obstacles.add(new Obstacle(600, 450, 280, 90));

    // Escritorios
    obstacles.add(new Obstacle(950, 200, 180, 120));
    obstacles.add(new Obstacle(950, 450, 180, 120));

    // Sillones
    obstacles.add(new Obstacle(1100, 250, 90, 70));
    obstacles.add(new Obstacle(1100, 500, 90, 70));

    // Mesa circular
    obstacles.add(new Obstacle(750, 650, 150, 150));

    // ===============================

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
