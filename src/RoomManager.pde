class RoomManager {
  PApplet parent;
  Room[] rooms;
  int currentRoom = 0;

  RoomManager(PApplet p, Room[] r) {
    parent = p;
    rooms = r;
  }

  Room getCurrentRoom() {
    return rooms[currentRoom];
  }

  void update(Player player) {
    Room r = rooms[currentRoom];
    r.update(player);

    // Player can only enter next room if key is collected
    if (r.roomKey.isCollected && r.reachedDoor(player)) {
      nextRoom();
    }
  }

  void nextRoom() {
    if (currentRoom < rooms.length - 1) {
      currentRoom++;

      player.x = 100;
      player.y = height/2;
    } else {
      println("Game finished! Last room reached.");
    }
  }
}
