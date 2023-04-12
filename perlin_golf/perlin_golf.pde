float ball_x, ball_y;
float hole_x, hole_y;
float speed_x, speed_y;
PVector mouse, ball, velocity;
int mouse_val;

void setup() {
  size(500,800);
  background(0);
  ball_x = width / 2;
  ball_y = height - 50;
  hole_x = random(50, width - 50);
  hole_y = 50;
  ball = new PVector(ball_x, ball_y);
  mouse = new PVector(mouseX, mouseY);
}

PVector direction_vec(float x, float y) {
  PVector vel = new PVector(x,y);
  vel.sub(ball).normalize().mult(2);
  return vel;
}

void draw() {
  background(#25C12E);
  mouse.x = mouseX; mouse.y = mouseY;
  
  if (mousePressed == true) {
    mouse_val = 1;
    if (mouse_val == 1) {
      speed_x = mouseX;
      speed_y = mouseY;
    }
  }
  if (mouse_val == 1) {
    ball.add(direction_vec(speed_x, speed_y));
  } else {
    // aim line
    mouse.sub(ball);
    mouse.normalize();
    mouse.mult(60);
    pushMatrix();
      translate(ball.x, ball.y);
      stroke(255);
      strokeWeight(4);
      line(0, 0, mouse.x, mouse.y);
    popMatrix();
  }
  
  // draw ball
  fill(255);
  noStroke();
  circle(ball.x, ball.y, 20);
  
  // draw hole
  fill(51);
  circle(hole_x, hole_y, 30);
  
  
}
