Playar playar;
Room currentRoom;
Room1 room1;
Room2 room2;

PImage[] marioFrames = new PImage[5];
PImage[] marioFramesBack = new PImage[5];
PImage keyImg, enemyImg, winImg, loseImg, pauseImg, startImg, backgroundImg, doorImg;

boolean gamePaused = false;
boolean gameWon = false;
boolean gameLost = false;
boolean gamestart = false;

void setup() {
  fullScreen();

  for (int i = 0; i < 5; i++) {
    marioFrames[i] = loadImage("mario" + (i+1) + ".png");
    marioFramesBack[i] = loadImage("backmario" + (i+1) + ".png");
  }

  keyImg = loadImage("key.png");
  enemyImg = loadImage("maltigi better.png");
  winImg = loadImage("win.png");
  loseImg = loadImage("WEGALOSE-1-1.png");
  pauseImg = loadImage("PauseScreen-1-1.png");
  startImg = loadImage("start.png");
  backgroundImg = loadImage("background.png");
  doorImg = loadImage("door.png");

  playar = new Playar(this, 800, 700, marioFrames, marioFramesBack);

  room1 = new Room1(this, backgroundImg, doorImg, enemyImg, keyImg);
  room2 = new Room2(this, loadImage("Library-1.png.png"), doorImg, enemyImg, keyImg);

  currentRoom = room1;
}

void draw() {
  if (!gamestart) { 
    image(startImg, 0, 0, width, height);
    return; 
  }
  if (gamePaused) { 
    image(pauseImg, width/2, height/2);
    return; 
  }
  if (gameWon) { 
    image(winImg, width/2, height/2); 
    return; 
  }
  if (gameLost) { 
    image(loseImg, 0, 0, width, height); 
    return; 
  }

  currentRoom.run(playar);

  if (currentRoom instanceof Room1) {
    Room1 r = (Room1) currentRoom;
    if (r.enemy != null && r.enemy.checkCollision(playar)) {
      println("PLAYER HIT BY ENEMY! GAME OVER!");
      gameLost = true;
    }
  }
  if (currentRoom instanceof Room2) {
    Room2 r = (Room2) currentRoom;
    if (r.enemy != null && r.enemy.checkCollision(playar)) {
      println("PLAYER HIT BY ENEMY! GAME OVER!");
      gameLost = true;
    }
  }

  if (currentRoom.isComplete() && !gameLost) {
    if (currentRoom == room1) {
      currentRoom = room2;
      playar.x = 200; playar.y = 200;
    } else {
      gameWon = true;
    }
  }
}

void keyPressed() {
  if (key == 'p' || key == 'P') gamePaused = !gamePaused;
  if (!gamePaused) {
    if (key == 'a' || key == 'A') playar.movingLeft = true;
    if (key == 'd' || key == 'D') playar.movingRight = true;
    if (key == 'w' || key == 'W') playar.movingUp = true;
    if (key == 's' || key == 'S') playar.movingDown = true;
  }
}

void keyReleased() {
  if (!gamePaused) {
    if (key == 'a' || key == 'A') playar.movingLeft = false;
    if (key == 'd' || key == 'D') playar.movingRight = false;
    if (key == 'w' || key == 'W') playar.movingUp = false;
    if (key == 's' || key == 'S') playar.movingDown = false;
  }
}

void mousePressed() {
  if (!gamestart) gamestart = true;
}
