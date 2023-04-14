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
    vel.x = x; vel.y = y;
    println(vel);
    vel.normalize();
    vel.mult(2);
    println(vel);
  }
}
