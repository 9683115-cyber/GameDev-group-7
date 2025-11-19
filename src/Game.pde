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

RoomManager roomManager;


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

  Room room1 = new Room(this,
    new Key(this, 600, 200, keyImg),
    new Enemy(this, 100, 100, 64, 96, 2, 200, enemyImg),
    new Task(this, 200, 100, "Find the Key"),
    width - 100, height/2  // door location
    );

  Room room2 = new Room(this,
    new Key(this, 300, 400, keyImg),
    new Enemy(this, 500, 200, 64, 96, 2, 200, enemyImg),
    new Task(this, 200, 100, "Find Second Key"),
    width - 100, height/2
    );

  Room room3 = new Room(this,
    new Key(this, 200, 200, keyImg),
    new Enemy(this, 600, 300, 64, 96, 3, 200, enemyImg),
    new Task(this, 200, 100, "Final Key"),
    width - 100, height/2
    );

  Room[] rooms = { room1, room2, room3 };

  roomManager = new RoomManager(this, rooms);
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


  Room current = roomManager.getCurrentRoom();

  // Update and draw room contents
  current.display();
  roomManager.update(player);

  // Draw player on top
  player.update();
  player.display();

  // Enemy collision loss
  if (current.roomEnemy.checkCollision(player)) {
    gameLost = true;
  }

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
