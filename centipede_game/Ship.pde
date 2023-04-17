class Ship {
  float size;
  ArrayList<PVector> bullets = new ArrayList<PVector>();
  PVector bullet_speed = new PVector(0, -10);
  int shoot = 0;
  int boost = 0;
  float shootRate = 40;
  Ship(float size_) {
    size = size_;
    spaceship.resize((int)size, (int)size);
  }

  void show() {
    image(spaceship, mouseX - size/2, height - size);
    //fill(255, 255, 0);
    //noStroke();
    //beginShape();
    //vertex(mouseX - size/2, height);
    //vertex(mouseX, height - size/2);
    //vertex(mouseX + size/2, height);
    //endShape();

    for (PVector p : bullets) {
      stroke(255, 255, 0);
      strokeWeight(3);
      line(p.x, p.y, p.x - bullet_speed.x, p.y - bullet_speed.y);
    }

    update_bullets();
    if (boost > 0) {
      boost--;
    }
  }

  void shoot() {
    shootRate = frame_rate * 1.9 + .05 * level;
    if (shoot < 0) {
      bullets.add(new PVector(mouseX, height - size));
      if (boost <= 0) {
        shoot = (int)shootRate;
      } else {
        shoot = (int)(shootRate / 1.8);
      }
    }
  }

  void update_bullets() {
    shoot--;
    if (shoot <= 0) {
      shoot();
    }
    for (int i = bullets.size() - 1; i > -1; i--) {
      boolean hit = false;
      if (bullets.get(i).x < 0) {
        bullets.remove(i);
      } else {
        bullets.get(i).add(bullet_speed);
        PVector bullet = bullets.get(i);
        for (Centipede centipede : centipedes) {
          for (int j = 0; j < centipede.body.size(); j++) {
            PVector p = centipede.body.get(j);
            if (p.x <= bullet.x && p.x + block_size.x >= bullet.x && p.y <= bullet.y && p.y + block_size.y >= bullet.y && p.y >= 0) {
              centipede.kill(j);
              if (j == 0) {
                explosions.add(new Explosion(bullet.x, bullet.y, color(255, 0, 0)));
              } else {
                explosions.add(new Explosion(bullet.x, bullet.y, color(0, 255, 0)));
              }
              bullets.remove(i);
              hit = true;
              if (j == 0) {
                score += level;
                boost = 60;
              }
              break;
            }
          }
          if (hit) {
            score += level;
            break;
          }
        }
      }
    }
  }
}
