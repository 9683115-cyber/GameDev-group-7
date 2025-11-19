PImage[] marioFrames = new PImage[5];
PImage[] marioFramesBack = new PImage[5];

Playar player;
Key gameKey;
Task task;
Enemy enemy;

PImage keyImg;
PImage enemyImg;
PImage winImg;
PImage loseImg;
PImage pauseImg;
PImage startImg;
PImage backgroundImg;

boolean gamePaused = false;
boolean gameWon = false;
boolean gameLost = false;
boolean gamestart = false;

void setup() {
  fullScreen();
  background(0);

  // Load Mario frames
  for (int i = 0; i < 5; i++) {
    marioFrames[i] = loadImage("mario" + (i+1) + ".png");
    marioFramesBack[i] = loadImage("backmario" + (i+1) + ".png");
  }

  // Load other images
  keyImg = loadImage("key.png");
  enemyImg = loadImage("maltigi better.png");
  winImg = loadImage("win.png");
  loseImg = loadImage("WEGALOSE-1-1.png");
  pauseImg = loadImage("PauseScreen-1-1.png");
  startImg = loadImage("start .png");
  backgroundImg = loadImage("background.png"); // your full-screen background

  player = new Playar(this, width/2, height/2, marioFrames, marioFramesBack);

  gameKey = new Key(this, 600, 200, keyImg);
  task = new Task(this, 200, 100, "Find the Key");
  enemy = new Enemy(this, 100, 100, 64, 96, 2, 200, enemyImg);
}

void draw() {
  // Draw background
  imageMode(CORNER);
  image(backgroundImg, 0, 0, width, height);

  if (!gamestart) {
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

  // Update and display game objects
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

  // Move to next room if task complete
  if (task.complete && gameKey.isCollected) {
    // Reset or load next room logic here
    println("Next room!");
  }
}

void keyPressed() {
  if (key == 'p' || key == 'P') gamePaused = !gamePaused;

  if (!gamePaused && !gameWon && !gameLost) {
    if (key == 'a' || key == 'A') player.movingLeft = true;
    if (key == 'd' || key == 'D') player.movingRight = true;
    if (key == 'w' || key == 'W') player.movingUp = true;
    if (key == 's' || key == 'S') player.movingDown = true;
  }
}

void keyReleased() {
  if (!gamePaused && !gameWon && !gameLost) {
    if (key == 'a' || key == 'A') player.movingLeft = false;
    if (key == 'd' || key == 'D') player.movingRight = false;
    if (key == 'w' || key == 'W') player.movingUp = false;
    if (key == 's' || key == 'S') player.movingDown = false;
  }
}

void mousePressed() {
  if (!gamestart) gamestart = true;
}
