class Ball {
  PVector pos, vel, acc;
  color col;
  int size;
  
  Ball() {
    pos = new PVector(250, 650);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    col = 255;
    size = 25;
  }
  
  void display() {
    fill(col);
    noStroke();
    circle(pos.x, pos.y, size);
    
    pos.add(vel);
    vel.add(acc);
    
    vel.limit(2);
    acc.mult(0);
    //println(pos);
  }
  
  void aim(float x, float y) {
    PVector mouse = new PVector(x,y);
    if (mousePressed == true) {
      // translate
      mouse.sub(pos);
      mouse.normalize();
      mouse.mult(60);
      pushMatrix();
        translate(pos.x, pos.y);
        stroke(255);
        strokeWeight(4);
        // draw line
        line(0, 0, -mouse.x, -mouse.y);
      popMatrix();
    }
  }
  
  void forward_speed(float x, float y) {
    acc.x = x; acc.y = y;
    
    // wrap around the screen
    if (pos.x < size/2) {
      pos.x = size/2;
      //pos.x = width+(size/2);
      vel.x = -vel.x;
    } else if (pos.x > width-(size/2)) {
      pos.x = width-(size/2);
      vel.x = -vel.x;
    } 
  }
  
  void apply_break(PVector [] slope) {
    //acc.add(slope);
    int x = (int)pos.x / 10;
    acc.x += slope[x].x;
  }
}
