//CGRA 151 - Assignment 5/ Game - "Hexavoid"
//Bullet class
//By Nevin Jojo

class bullet {
  float x, y, speed = 4, r = 2.5; //x, y, speed and radius of bullet

  bullet(float xPos, float yPos) {
    this.x = xPos;
    this.y = yPos;
  }

  void display() {
    fill(255);
    ellipse(x, y, 2*r, 2*r);
  }

  void move() { //changes the position of the bullet 
    y =(y-speed);
  }

  boolean bounds() { //checks if bullet is out of the boundary
    if (y <0 ) return true;
    return false;
  }
}

void drawBullets () { //if there are bullets in the arraylist, draw and update their positions
  if (!bullets.isEmpty()) {
    for (bullet b : bullets) {
      b.display();
      b.move();
    }
  }
}

//method that will fire bullets using bullet class
void mouseClicked() {
  if (!hexagonCollision && bullets.size()<5) {
    bullets.add(new bullet(xRocket, yRocket));
    score--;
  }
}