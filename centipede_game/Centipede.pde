class Centipede {
  int size;
  int tic;

  ArrayList<PVector> body = new ArrayList<PVector>();
  PVector dir;
  boolean created;
  boolean turning = false;
  int start = (int) random(20);

  Centipede(int size_, boolean first) {
    size = size_;
    if (first) {
      for (int i = 0; i < size; i++) {
        body.add(new PVector(start * block_size.x, -i * block_size.y));
      }
    } else {
      created = true;
    }
    dir = new PVector(block_size.x, 0);
  }

  void show() {
    tic = frameCount % frame_rate;
    if (tic < frame_rate/2) {
      tic = 0;
    } else {
      tic = 1;
    }
    for (int i = 0; i < body.size(); i++) {
      PVector p = body.get(i);
      if (i == 0) {
        if (turning) {
          image(head[0], p.x, p.y);
        } else if (dir.x > 0) {
          image(head[1], p.x, p.y);
        } else if (dir.x < 0) {
          image(head[2], p.x, p.y);
        }
      } else {
        boolean last = (i == body.size()-1);
        if ( !last) {
          if (body.get(i-1).x < p.x && body.get(i+1).x > p.x) {
            image(straight_body[2 + tic], p.x, p.y);
          } else if (body.get(i-1).x > p.x && body.get(i+1).x < p.x) {
            image(straight_body[0 + tic], p.x, p.y);
          } else if (body.get(i-1).x < p.x) {
            image(curved_body[3 + tic * 4], p.x, p.y);
          } else if (body.get(i-1).x > p.x) {
            image(curved_body[2 + tic * 4], p.x, p.y);
          } else if (body.get(i-1).y > p.y && body.get(i+1).x < p.x) {
            image(curved_body[1 + tic * 4], p.x, p.y);
          } else if (body.get(i-1).y > p.y && body.get(i+1).x > p.x) {
            image(curved_body[0 + tic * 4], p.x, p.y);
          } else {
            image(straight_body[4 + tic], p.x, p.y);
          }
        } else {
          if (body.get(i-1).x < p.x) {
            image(straight_body[2 + tic], p.x, p.y);
          } else if (body.get(i-1).x > p.x) {
            image(straight_body[0 + tic], p.x, p.y);
          } else {
            image(straight_body[4 + tic], p.x, p.y);
          }
        }
      }
    }
  }

  void update() {
    if (turning) {
      turning = false;
    }
    for (int i = body.size() - 1; i > 0; i--) {
      body.get(i).x = body.get(i-1).x;
      body.get(i).y = body.get(i-1).y;
    }
    PVector expected = (body.get(0).copy()).add(dir);
    boolean meet = false;
    for (Centipede c : centipedes) {
      if (c != this) {
        for (PVector p : c.body) {
          if (expected.x == p.x && expected.y == p.y) {
            meet = true;
          }
        }
      }
    }

    float a = random(1);

    if (expected.x < 0 || expected.x >= width || created || meet || a < .1) {
      created = false;
      body.get(0).add(new PVector(0, block_size.y));
      dir.mult(-1);
      turning = true;
    } else {
      body.get(0).x += dir.x;
    }
  }

  void kill(int i) {
    Centipede new_c = new Centipede(size - i, false);
    for (int j = i+1; j < body.size(); j++) {
      new_c.body.add(body.get(j).copy());
    }

    for (int j = body.size() - 1; j >= i; j--) {
      body.remove(j);
    }
    if (i == 0) {
      new_c.created = false;
    }
    new_c.dir = dir.copy();
    centipedes.add(new_c);
    size = i;
    clearCentipedes();
  }
}
