/*Game Development Class Project by:
 - Rusty Spendlove
 - Malcolm Kyle
 - Kai Li Cantwell
 - Dave Martinez Valencia
 
 Notes:
 - All graphics are inspired by Ao Oni.
 - Some game mechanics and code logic were implemented with the help of ChatGPT. */
PImage[] marioFrames = new PImage[5];
PImage[] marioFramesBack = new PImage[5];

Room foyer;
Room kitchen;
Room libraryRoom;
//Room rightRoom;

Room currentRoom;

int roomIndex = 0;
Room[] rooms;


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
PImage backgroundImg;
PImage doorImg;

PImage kitchenImg;
PImage libraryImg;
PImage foyerImg;


boolean gamePaused = false;
boolean gameWon = false;
boolean gameLost = false;
boolean gamestart = false;


int spawnProtection = 60;


void setup() {
  fullScreen();
  //size(800,600);
  background(0);
  

  // Load Mario frames
  for (int i = 0; i < 5; i++) {
    marioFrames[i] = loadImage("mario" + (i+1) + ".png");
    marioFramesBack[i] = loadImage("backmario" + (i+1) + ".png");
  }

  // Images
  keyImg = loadImage("key.png");
  enemyImg = loadImage("maltigi better.png");
  winImg = loadImage("AlexWinga.png");
  loseImg = loadImage("WEGALOSE-1-1.png.png");
  pauseImg = loadImage("PauseScreen.png");
  startImg = loadImage("start .png");
  backgroundImg = loadImage("background.png");
  doorImg = loadImage("door.png");

  kitchenImg = loadImage("k2.png");
  libraryImg = loadImage("Library-1.png.png");
  foyerImg = loadImage("Foyer.png");

  player = new Player(this, width/2, height/2, marioFrames, marioFramesBack);


  foyer = new Room(
    this,
    foyerImg, doorImg,
    430, 420, 190, 270, // door x,y,w,h
    new Key(this, 600, 200, keyImg),
    new Task(this, 50, 50, "Take the first key from NPC"),
    2, 200, // enemy speed & range
    550, 1370, 140, 870, // room boundaries (minX, maxX, minY, maxY)
    enemyImg, 1500, 250, 64, 96   // enemy image and starting x,y,width,height
    );

  kitchen = new Room(
    this, // PApplet
    kitchenImg, doorImg, // background & door images
    480, 440, 190, 260, // door x, y, w, h
    new Key(this, 700, 300, keyImg),
    new Task(this, 50, 50, "Find kitchen key"),
    2.5, 260, // enemy speed & range
    100, width-100, 120, height-120, // room boundaries
    enemyImg, 1500, 250, 64, 96        // enemy image and starting x,y,width,height
    );

  libraryRoom = new Room(
    this, // PApplet
    libraryImg, doorImg, // background & door images
    500, 450, 190, 260, // door x, y, w, h
    new Key(this, 620, 260, keyImg),
    new Task(this, 50, 50, "Solve puzzle"),
    3, 320, // enemy speed & range
    100, width-100, 120, height-120, // room boundaries
    enemyImg, 1500, 250, 64, 96        // enemy image and starting x, y, width, height
    );


  rooms = new Room[] { foyer, kitchen, libraryRoom };
  currentRoom = rooms[0];

  // Reset player to center of current room
  player.x = (currentRoom.minX + currentRoom.maxX) / 2;
  player.y = (currentRoom.minY + currentRoom.maxY) / 2;

  // Reset enemy position inside the current room's wander area
  currentRoom.resetEnemyToWanderZoneCenter();
}

void draw() {
  // Background & room drawing uses currentRoom
  imageMode(CORNER);

  currentRoom.drawRoom();
//Dave Dave Martinez Valencia, Rusty Spendlove (graphics)
  if (!gamestart) {
    imageMode(CENTER);
    image(startImg, width/2, height/2, width, height);
    imageMode(CORNER); // reset so nothing else breaks
    return;
  }

//Malcom Kyle
  if (gamePaused) {
    imageMode(CENTER);
    image(pauseImg, width/2, height/1.5);
    return;
  }
//Rusty Spendlove, Malcolm Kyle (graphics)
  if (gameWon) {
    imageMode(CENTER);
   image(winImg, width/2, height/2);
    return;
  }
//Kai Li Cantwell, Malcolm Kyle (graphics)
  if (gameLost) {
    imageMode(CENTER);
    image(loseImg, width/2, height/2);
    return;
  }

 player.update(currentRoom.obstacles, currentRoom.minX, currentRoom.maxX, currentRoom.minY, currentRoom.maxY);
  player.display();


  currentRoom.roomKey.display();
  currentRoom.roomKey.checkCollision(player);

  if (currentRoom.roomKey.isCollected) currentRoom.roomTask.complete = true;

  currentRoom.roomTask.display();
  currentRoom.roomTask.checkInteraction(player);

//Makes sure enemys speed and range is set to current room
  currentRoom.roomEnemy.speed = currentRoom.enemySpeed;
  currentRoom.roomEnemy.range = currentRoom.enemyRange;

 
  currentRoom.roomEnemy.update(player, currentRoom.obstacles, currentRoom.getWanderZone());
  currentRoom.roomEnemy.display();

  // If task & key complete and player at door, move to next room
  if (currentRoom.roomTask.complete && currentRoom.roomKey.isCollected) {
    if (currentRoom.playerAtDoor()) {
      roomIndex++;

      if (roomIndex >= rooms.length) {
        gameWon = true;
        return;
      }

      currentRoom = rooms[roomIndex];

      // Reset player to center of new room
      player.x = (currentRoom.minX + currentRoom.maxX) / 2;
      player.y = (currentRoom.minY + currentRoom.maxY) / 2;

      // reset enemy position to the center of the new room's wander zone
      currentRoom.resetEnemyToWanderZoneCenter();

      // Reset spawn protection so player doesn't instantly die
      spawnProtection = 60;
    }
  }

  // Spawn protection prevents instant kill after starting in a new room
  if (spawnProtection > 0) {
    spawnProtection--;
  } else {
    if (currentRoom.roomEnemy.checkCollision(player)) {
      gameLost = true;
    }
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
  if (!gamestart) {
    gamestart = true;
    spawnProtection = 60; // RESET protection when start is pressed
  }
}
