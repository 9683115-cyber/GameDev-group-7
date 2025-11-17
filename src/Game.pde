// Rusty Spendlove, Malcolm Kyle, Kai Li Cantwell, Dave Martinez Valencia
PImage[] marioFrames = new PImage[5];
Player player;
Key gameKey;
Task task;
Enemy enemy;
PImage keyImg;
PImage enemyImg;
PImage winImg;
PImage loseImg;
PImage pauseImg;
PImage startImg;

boolean gamePaused = false;
boolean gameWon = false;
boolean gameLost = false;
boolean gamestart = false;

void setup() {
  fullScreen();
  background(0);

  // Load images
  for (int i = 0; i < 5; i++) {
    marioFrames[i] = loadImage("mario" + (i+1) + ".png");
  }

  keyImg = loadImage("key.png");
  enemyImg = loadImage("maltigi better.png");
  winImg = loadImage("win.png");
  loseImg = loadImage("WEGALOSE-1-1.png");
  pauseImg = loadImage("PauseScreen-1-1.png");
  startImg = loadImage("start .png");

  player = new Player(this, width/2, height/2, marioFrames);
  gameKey = new Key(this, 600, 200, keyImg);
  task = new Task(this, 200, 100, "Find the Key");
  enemy = new Enemy(this, 100, 100, 64, 96, 2, 200, enemyImg);
}

void draw() {
  background(80, 180, 250);

  if (!gamestart) {
  imageMode(CORNER);   
  image(startImg, 0, 0, width, height); 
  return;
}

  if (gamePaused) {
    imageMode(CENTER);
    image(pauseImg, width/2, height/1.5);
    return;
  }

  
  if (gameWon) {
    imageMode(CENTER);
    image(winImg, width/2, height/2);
    return;
  }
  if (gameLost) {
    imageMode(CENTER);
    image(loseImg, width/2, height/2);
    return;
  }

  
  player.update();
  player.display();

  gameKey.display();
  gameKey.checkCollision(player); 

  task.display();
  task.checkInteraction(player);

  enemy.update(player);
  enemy.display();
  if (enemy.checkCollision(player)) {
    gameLost = true; 
  }
}

void keyPressed() {
  // Pause toggle
  if (key == 'p' || key == 'P') {
    gamePaused = !gamePaused;
  }

  if (!gamePaused && !gameWon && !gameLost) {
    if (keyCode == RIGHT) player.movingRight = true;
    if (keyCode == LEFT)  player.movingLeft = true;
    if (keyCode == UP)    player.movingUp = true;
    if (keyCode == DOWN)  player.movingDown = true;
  }
}

void keyReleased() {
  if (!gamePaused && !gameWon && !gameLost) {
    if (keyCode == RIGHT) player.movingRight = false;
    if (keyCode == LEFT)  player.movingLeft = false;
    if (keyCode == UP)    player.movingUp = false;
    if (keyCode == DOWN)  player.movingDown = false;
  }
}


void mousePressed() {
  if (!gamestart) {
    gamestart = true;
  }
}
