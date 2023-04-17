Ship player;
ArrayList<Centipede> centipedes = new ArrayList<Centipede>();
ArrayList<Explosion> explosions = new ArrayList<Explosion>();
int size = 10;
int score = 0;
int level = 1;
PImage[] head = new PImage[3];
PImage[] straight_body = new PImage[6];
PImage[] curved_body = new PImage[8];
PImage spaceship;
PVector block_size;
int frame_rate;


void setup() {
  size(800, 800);
  block_size = new PVector(width/20, height/20);
  for (int i = 1; i < 4; i++) {
    head[i-1] = loadImage("Images/head" + i + ".png");
    head[i-1].resize((int)block_size.x, (int)block_size.y);
  }
  for (int i = 1; i < 7; i++) {
    straight_body[i-1] = loadImage("Images/straight_body" + i + ".png");
    straight_body[i-1].resize((int)block_size.x, (int)block_size.y);
  }
  
  for (int i = 1; i < 9; i++) {
    curved_body[i-1] = loadImage("Images/curved_body" + i + ".png");
    curved_body[i-1].resize((int)block_size.x, (int)block_size.y);
  }
  spaceship = loadImage("Images/spaceship.png");
  centipedes.add(new Centipede(size, true));
  player = new Ship(height/15);
  noCursor();
}

void draw() {
  background(0);
  frame_rate = 20 - level;
  player.show();
  textSize(30);
  fill(255);
  text(score, width - 50, 50);
  text("level " + level, width / 2, 50);
  for (Centipede c : centipedes) {
    c.show();
    if (frameCount % frame_rate == 0) {
      c.update();
    }
    if (c.body.get(0).y + block_size.y >= height) {
      background(0);
      fill(255, 0, 0);
      textSize(60);
      text("lose", width/4, height/2);
      fill(255);
      text(score, 3*width/4, height/2);
      noLoop();
      break;
    }
  }
  
  for (int i = explosions.size() - 1; i > -1; i--) {
    explosions.get(i).show();
    if (explosions.get(i).lifespan < 0) {
      explosions.remove(i);
    }
  }
  
  if (centipedes.size() < 1) {
    size += 5;
    level++;
    centipedes.add(new Centipede(size, true));
  }
}


void clearCentipedes() {
  for (int i = centipedes.size() - 1; i > -1; i--) {
    if (centipedes.get(i).body.size() == 0) {
      centipedes.remove(i);
    }
  }
}
