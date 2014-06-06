int NUM = 1000 ;
PVector[] loc = new PVector [NUM] ;
PVector[] vel = new Pvector [NUM] ;

void setup() {
  size(960, 640) ;
  frameRate(60) ;
  for (int i = 0; i < NUM; i ++) {
    loc[i] = new PVector(random(width), random(height)) ;
    vel[i] = new PVector(random(-5, 5), random(-5, 5)) ;
  }
}

void draw() {
  background(0) ;
  stroke(0, 240, 200) ;
  fill(150, 130, 180) ;
  for (int i = 0; i < NUM; i ++) {
    ellipse(loc[i].x, loc[i].y, 20, 20) ;
    loc[i].x = loc[i].x + vel[i].x ;
    loc[i].y = loc[i].y + vel[i].y ;
    if (loc[i].x < 0 || loc[i].x > width) {
      vel[i].x = vel[i].x * -1 ;
    }
    if (loc[i].y < 0 || loc[i].y > height) {
      vel[i].y = vel[i].y * -1 ;
    }
  }
}


