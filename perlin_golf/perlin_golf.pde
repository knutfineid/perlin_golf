float hole_x, hole_y;
float dir_x, dir_y;
boolean success = false, fail = false;

void setup() {
  size(500,800);
  background(0);
  hole_x = random(50, width - 50);
  hole_y = 50;
}

void mouseReleased()
{
  dir_x = (ball.pos.x - mouseX)/30;
  dir_y = (ball.pos.y - mouseY)/30;
}

void complete_check() {
  float ball_hole = dist(ball.pos.x, ball.pos.y, hole_x, hole_y);
  if (ball_hole < 25) {
    success = true;
  } else if (ball.pos.y <= 0) {
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

Ball ball = new Ball();

void draw() {
  background(#29B748);
 
  // draw hole
  fill(51);
  noStroke();
  circle(hole_x, hole_y, 30);
  
  ball.display();
  ball.aim(mouseX, mouseY);
  ball.forward_speed(dir_x, dir_y);
  
  complete_check();
  complete_screen();
}
