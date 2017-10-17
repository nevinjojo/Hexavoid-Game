//CGRA 151 - Assignment 5/ Game - "Hexavoid"
//By Nevin Jojo
//Particle Class where exploding rockket is made

int particleCount = 2500; //number of particles that explode
Particle[] particles = new Particle[particleCount+1];

void explode () {
  //removes the rocket image, replace it with the exploding particles and update the particle's position
  pushMatrix();
  rocket = loadImage("rocketEmpty.png");
  translate((1+(mouseX/width))*width, 1.9*height);
  for (int i = particleCount; i >= 0; i--) { 
    Particle particle = (Particle) particles[i];
    particle.update();
    if (particle.current.y>4.5*height) {
      play=false;
    }
  }
  popMatrix();
}


//particle class for exploding rocket
class Particle {
  PVector current = new PVector(-width/2, height, 0);
  PVector previous = current.get();

  float speed; //speed and angles of the particle
  float phi;
  float theta;
  float gravity = 0;

  Particle() {
    theta = random(0, 628) * 0.01;
    phi = random(0, 314) * 0.01;
    speed = random(1, 40);
  }

  void update() {
    previous = current.get();
    float sctheta = speed * cos(theta);
    PVector next = new PVector(sctheta * cos(phi) - 0.035 * current.z, speed * sin(theta) - gravity, sctheta * sin(phi) + 0.035 * current.x);
    current.add(next);
    gravity += 0.3;
    speed *= 0.999;
    drawLine(current, previous);
  }
}  

//connects the previous and current position of the particle to draw a line
void drawLine(PVector begin, PVector end) {
  PVector newBegin = new PVector(int(begin.x - begin.z), int((begin.x + begin.z)/2 - begin.y));
  PVector newEnd = new PVector(int(end.x - end.z), int((end.x + end.z)/2 - end.y));
  float chance = random(0, 1);
  color c1 = #feac1c, c2 = #bc3442, c3 = #17a6a5, c4 = #ffffff, col; //4 colours of the particle
  if (chance<=0.32) col=c1;
  else if (chance>0.32 && chance<=0.64) col=c2;
  else if (chance>0.64 && chance<0.96) col=c3;
  else col=c4;
  
  stroke(col);
  line (newBegin.x, newBegin.y, newEnd.x, newEnd.y);
}