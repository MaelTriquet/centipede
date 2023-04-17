class Explosion {
  int nbParticules = (int) random(20, 40);
  color col;
  PVector[] vels = new PVector[nbParticules];
  PVector[] poss = new PVector[nbParticules];
  int lifespan = 40;
  
  Explosion(float x_, float y_, color col_) {
    col = col_;
    for (int i = 0; i < nbParticules; i++) {
      poss[i] = new PVector(x_, y_);
      vels[i] = new PVector(random(-1, 1), random(-1, 1)).mult(3);
    }
  }
  
  void show() {
    lifespan--;
    stroke(col, map(lifespan, 0, 40, 0, 255));
    fill(col, map(lifespan, 0, 40, 0, 255));
    for (int i = 0; i < nbParticules; i++) {
      //point(p.x, p.y);
      rect(poss[i].x, poss[i].y, map(vels[i].mag(), 0, 1, 15, 5), map(vels[i].mag(), 0, 1, 15, 5));
    }
    update();
  }
  
  void update() {
    for (int i = 0; i < nbParticules; i++) {
      vels[i].mult(.95);
      poss[i].add(vels[i]);
    }
  }
}
