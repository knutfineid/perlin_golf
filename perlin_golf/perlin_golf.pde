float ball_x, ball_y;
float hole_x, hole_y;
float speed_x, speed_y;
PVector mouse, ball, slope;
int mouse_val;
boolean success = false, fail = false;

void setup() {
  size(500,800);
  background(0);
  ball_x = width / 2;
  ball_y = height - 150;
  hole_x = random(50, width - 50);
  hole_y = 50;
  ball = new PVector(ball_x, ball_y);
  mouse = new PVector(mouseX, mouseY);
}

void mouseReleased()
{
  speed_x = (ball_x - mouseX)/30;
  speed_y = (ball_y - mouseY)/30;
}

void complete_check() {
  float ball_hole = dist(ball_x, ball_y, hole_x, hole_y);
  if (ball_hole < 25) {
    success = true;
  } else if (ball_y <= 0) {
    fail = true;
  }
}

void complete_screen() {
  if (success) {
    background(100);
    fill(0,255,0);
    circle(width/2, height/2, 100);
  } else if (!success && fail) {
    background(100);
    fill(255,0,0);
    circle(width/2, height/2, 100);
  }
}
void aiming() {
  mouse.x = mouseX; mouse.y = mouseY;
  if (mousePressed == true) {
    // aim line
    mouse.sub(ball);
    mouse.normalize();
    mouse.mult(60);
    pushMatrix();
      translate(ball_x, ball_y);
      stroke(255);
      strokeWeight(4);
      line(0, 0, -mouse.x, -mouse.y);
    popMatrix();
  }
}

void draw() {
  background(#29B748);
  
  // draw hole
  fill(51);
  noStroke();
  circle(hole_x, hole_y, 30);
  
  // draw ball
  fill(255);
  noStroke();
  circle(ball_x, ball_y, 20);
  
  // initial movement
  ball_x += speed_x;
  ball_y += speed_y;
  
  aiming();
  complete_check();
  complete_screen();
}
