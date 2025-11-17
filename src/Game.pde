//Rusty Spendlove, Malcolm Kyle, Kai Li Cantwell, Dave Martinez Valencia
PImage[] marioFrames = new PImage[5];
Playar player;
Key key;
Task task;
Enemy enemy;
PImage keyImg;
PImage enemyimg;
void setup() {
  size(800, 600);

  // Load player frames
  for (int i = 0; i < 5; i++) {
    marioFrames[i] = loadImage("mario" + (i+1) + ".png");
  }

  keyImg = loadImage("key.png");
  enemyimg = loadImage("maltigi better.png");

  // Create player at center
  player = new Playar(this, width/2, height/2, marioFrames);

  // Key and task
  key = new Key(this, 600, 200, keyImg);
  task = new Task(this, 200, 100, "Find the Key");

  // Enemy
enemy = new Enemy(this, 100, 100, 64, 96, 2, 200, enemyimg);

}

void draw() {
  background(80, 180, 250);

  // Update & display player
  player.update();
  player.display();

  // Key
  key.display();
  key.checkCollision(player);

  // Task
  task.display();
  task.checkInteraction(player);

  // Enemy
  enemy.update(player);
  enemy.display();
}

void keyPressed() {
  if (keyCode == RIGHT) player.movingRight = true;
  if (keyCode == LEFT)  player.movingLeft = true;
  if (keyCode == UP)    player.movingUp = true;
  if (keyCode == DOWN)  player.movingDown = true;
}

void keyReleased() {
  if (keyCode == RIGHT) player.movingRight = false;
  if (keyCode == LEFT)  player.movingLeft = false;
  if (keyCode == UP)    player.movingUp = false;
  if (keyCode == DOWN)  player.movingDown = false;
}
