float hole_x, hole_y;
float dir_x, dir_y;
boolean success = false, fail = false;
PVector slope[] = new PVector[500/10];
float bg_col[] = new float[500/10];
int press = 0;

void setup() {
  size(500,800);
  background(0);
  noiseSeed(1);
  noiseDetail(2,0.5);
  hole_x = random(50, width - 50);
  hole_y = 50;
  
  // Initializing the break and the background color
  float xoff = 0;
  float factor = 0.005;
  for (int i = 0; i < width/10; i++) {
    pushMatrix();
      translate(i*10,0);
      slope[i] = new PVector(0,0);
      slope[i] = PVector.fromAngle(noise(TWO_PI * xoff));
      slope[i].mult(factor);
    popMatrix();
    
    bg_col[i] = (1 - noise(xoff)) * 255;
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

void start_screen() {
  background(51);
  textSize(25);
  textAlign(CENTER);
  text("Press space to play", width/2, height/2 - 30);
  text("Aim towards the darkness", width/2, height/2);
  text("or follow the arrows to the hole", width/2, height/2 + 30);
}

void draw_terrain() {
  float col;
  int offset = 10;
  float xoff = 0;
  float n;
  
  // looks better, but burns up my mac...
  //loadPixels();
  //  for (int x = 0; x < width; x++) {
  //    for (int y = 0; y < height; y++) {
  //      n = 50 + 205 * noise(xoff);
  //      pixels[x+y*width] = color(0,n,0);
  //    }
  //    xoff += 0.005;
  //  }
  //updatePixels();
  
  // looks worse, but does not burn up my mac
  for (int i = 0; i < bg_col.length; i++) {
    fill(0,0,0, bg_col[i]*0.9);
    noStroke();
    rect(i*10,0,10,height);
    
    // drawing a line/rectangle for each 10th
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
  
  // all the ball physics
  ball.display();
  ball.aim(mouseX, mouseY);
  ball.forward_speed(dir_x, dir_y);
  dir_x = dir_y = 0;
  
  // adding break to the ball if there is motion to it
  if (ball.vel.y != 0) {
    ball.apply_break(slope);
  }

  //complete screen and start screen
  complete_screen();
  if (press == 0) {
    start_screen();
  }
}

void keyPressed() {
  if (keyCode == 32) {
    press += 1;
    if (press > 1) {
      press = 0;
    }
  }
}

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
