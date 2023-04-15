float hole_x, hole_y;
float dir_x, dir_y;
boolean success = false, fail = false;
PVector slope[] = new PVector[500/10];
float bg_col[] = new float[500/10];

void setup() {
  size(500,800);
  background(0);
  hole_x = random(50, width - 50);
  hole_y = 50;
  
  float xoff = 0;
  float factor = 0.005;
  for (int i = 0; i < width/10; i++) {
    pushMatrix();
      translate(i*10,0);
      slope[i] = new PVector(0,0);
      slope[i] = PVector.fromAngle(noise(xoff));
      slope[i].mult(factor);
    popMatrix();
    
    bg_col[i] = noise(xoff) * 255;
    xoff += 0.01;
  }
}

void mouseReleased()
{
  dir_x = (ball.pos.x - mouseX)/30;
  dir_y = (ball.pos.y - mouseY)/30;
}

void complete_screen() {
  float ball_hole = dist(ball.pos.x, ball.pos.y, hole_x, hole_y);
  if (ball_hole < 25) {
    success = true;
  } else if (ball.pos.y <= 0) {
    fail = true;
  }
  
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

void draw_terrain() {
  float col;
  noiseSeed(1);
  noiseDetail(2,0.5);
  int offset = 10;
  float xoff = 0;
  float n;
  
  // looks better, but burns up my mac...
  loadPixels();
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        n = 50 + 205 * noise(xoff);
        pixels[x+y*width] = color(0,n,0);
      }
      xoff += 0.005;
    }
  updatePixels();
  
  // looks worse, but does not burn up my mac
  for (int i = 0; i < bg_col.length; i++) {
    //fill(0,0,0, bg_col[i]*0.9);
    //noStroke();
    //rect(i*10,0,10,height);
    
    pushMatrix();
        translate(i*10, height/2);
        rotate(slope[i].heading());
        stroke(0);
        strokeWeight(3);
        point(0,0);
        strokeWeight(1);
        line(0,0, 8, 0);
        //println(slope[i]);
    popMatrix();
  }
}

Ball ball = new Ball();

void draw() {
  background(#29B748);
  draw_terrain();
 
  // draw hole
  fill(51);
  noStroke();
  circle(hole_x, hole_y, 30);
  
  ball.display();
  ball.aim(mouseX, mouseY);
  ball.forward_speed(dir_x, dir_y);
  dir_x = dir_y = 0;
  
  if (ball.vel.y != 0) {
    ball.apply_break(slope);
  }

  
  complete_screen();
}
