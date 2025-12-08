class Room {
  PApplet parent;
  PImage backgroundImg;
  PImage doorImg;
  ArrayList<Obstacle> obstacles;

  Room(PApplet p, PImage bg, PImage door){
    parent = p;
    backgroundImg = bg;
    doorImg = door;
    obstacles = new ArrayList<Obstacle>();
  }

  void run(Playar player) {
    parent.image(backgroundImg, 0, 0, parent.width, parent.height);
    if (doorImg != null) parent.image(doorImg, 430, 491, 190, 270);

    for (Obstacle o : obstacles) o.display();
    player.update(obstacles);
    player.display();
  }

  boolean isComplete() {
    return true;
  }
}
