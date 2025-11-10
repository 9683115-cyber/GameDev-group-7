Player player;
Enemy enemy;
Task task;
Key k;

void setup() {
  size(800, 600);

  player = new Player(width/2, height/2, 40, 40);
  enemy = new Enemy(100, 100, 30, 30, 2, 200);
  task = new Task(400, 300, "Find the Key");
  k = new Key(500, 200);
}

void draw() {
  background(50);

  // Player
  player.update();
  player.display();

  // Enemy
  enemy.update(player);
  enemy.display();

  // Task
  task.display();
  task.checkInteraction(player);

  // Key
  k.display();
  k.checkCollision(player);
}
