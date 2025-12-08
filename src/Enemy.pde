// Dave Martinez Valencia, Kai Li Cantwell
//(Some game mechanics and code logic were implemented with the help of ChatGPT)
class Enemy {
  PApplet parent;
  PImage img;
  float x, y, w, h;
  float speed;
  float range;
  float dirX, dirY;
  float chaseMultiplier = 1.2f; // tuned for smoother chase
  float wanderMultiplier = 0.6f; // slower wandering

  float hitboxXOffset = 7;
  float hitboxYOffset = 5;
  float hitboxWidth = 40;
  float hitboxHeight = 60;

  int wanderTimer = 0;
  int wanderDelay = 60;

  // Current movement area limits 
  float leftLimit, rightLimit, topLimit, bottomLimit;


  Enemy(PApplet p, float startX, float startY, float w_, float h_, float spd, float rng, PImage i) {
    parent = p;
    x = startX;
    y = startY;
    w = w_;
    h = h_;
    speed = spd;
    range = rng;
    img = i;
    dirX = parent.random(-1, 1);
    dirY = parent.random(-1, 1);
   
    leftLimit = 0;
    rightLimit = parent.width;
    topLimit = 0;
    bottomLimit = parent.height;
  }


  void update(Player p, ArrayList<Obstacle> obstacles, float[] wanderZone) {
    float moveX = 0, moveY = 0;

    float distance = parent.dist(
      x + w/2, y + h/2,
      p.x + p.width/2,
      p.y + p.height/2
      );

    // Enemy Chase function
    if (distance < range) {
      float angle = parent.atan2(
        p.y + p.height/2 - (y + h/2),
        p.x + p.width/2 - (x + w/2)
        );
      moveX = parent.cos(angle) * speed * chaseMultiplier;
      moveY = parent.sin(angle) * speed * chaseMultiplier;
    }
    //Enemy wander function
    else {
      wanderTimer++;
      if (wanderTimer >= wanderDelay) {
        dirX = parent.random(-1, 1);
        dirY = parent.random(-1, 1);
        wanderTimer = 0;
      }
      moveX = dirX * speed * wanderMultiplier;
      moveY = dirY * speed * wanderMultiplier;
    }

    float oldX = x;
    float oldY = y;

    // Checks for obstacle collision when along moving X
    x += moveX;
    for (Obstacle o : obstacles) {
      if (collidesWith(o.x, o.y, o.w, o.h)) {
        x = oldX;
        dirX *= -1;
        break;
      }
    }

    // Checks for obstacle collision when along moving Y
    y += moveY;
    for (Obstacle o : obstacles) {
      if (collidesWith(o.x, o.y, o.w, o.h)) {
        y = oldY;
        dirY *= -1;
        break;
      }
    }

    // Enforce wandering zone 
    if (wanderZone != null && wanderZone.length == 4) {
      float wzMinX = wanderZone[0];
      float wzMaxX = wanderZone[1];
      float wzMinY = wanderZone[2];
      float wzMaxY = wanderZone[3];

      if (x < wzMinX) {
        x = wzMinX;
        dirX *= -1;
      }
      if (x + w > wzMaxX) {
        x = wzMaxX - w;
        dirX *= -1;
      }
      if (y < wzMinY) {
        y = wzMinY;
        dirY *= -1;
      }
      if (y + h > wzMaxY) {
        y = wzMaxY - h;
        dirY *= -1;
      }
    } else {
      // fallback to full room limits
      if (x < leftLimit) {
        x = leftLimit;
        dirX *= -1;
      }
      if (x + w > rightLimit) {
        x = rightLimit - w;
        dirX *= -1;
      }
      if (y < topLimit) {
        y = topLimit;
        dirY *= -1;
      }
      if (y + h > bottomLimit) {
        y = bottomLimit - h;
        dirY *= -1;
      }
    }
  }

  void display() {
    parent.image(img, x, y, w, h);
    // debug hitbox 
    parent.noFill();
    parent.stroke(255, 0, 0);
    parent.rect(x + hitboxXOffset, y + hitboxYOffset, hitboxWidth, hitboxHeight);
  }

  boolean collidesWith(float ox, float oy, float ow, float oh) {
    float hx = x + hitboxXOffset;
    float hy = y + hitboxYOffset;
    return !(hx + hitboxWidth <= ox || hx >= ox + ow || hy + hitboxHeight <= oy || hy >= oy + oh);
  }

  boolean checkCollision(Player p) {
    // Use player's hitbox vs enemy's hitbox for accurate collision
    float ex = x + hitboxXOffset;
    float ey = y + hitboxYOffset;
    return !(p.x + p.hitboxWidth < ex || p.x + p.hitboxXOffset > ex + hitboxWidth || p.y + p.hitboxHeight < ey || p.y + p.hitboxYOffset > ey + hitboxHeight);
  }
}
