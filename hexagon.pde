//CGRA 151 - Assignment 5/ Game - "Hexavoid"
//Hexagon class
//By Nevin Jojo

class hexagon {
  //position and 6 x & y positions needed to draw hexaon
  int w;
  int row, col;
  float xPos, yPos, yInitial;
  float[] vertX = new float[6]; 
  float[] vertY = new float[6];
  boolean disappear = false;


  hexagon (int i, int j, boolean d) {
    w = 67;
    row = i; 
    disappear=d;
    col = j;
    xPos = j*w +32;
    yPos = -height + (row*2*w);
    yInitial = -height + (row*2*w);
    vertX[0] = xPos - w/4; 
    vertX[1] = xPos + w/4; 
    vertX[2] = xPos + 2 * w/4; 
    vertX[3] = xPos + w/4; 
    vertX[4] = xPos - w/4; 
    vertX[5] = xPos - 2 * w/4;
    vertY[0] = yPos - sqrt(3) * w/4;
    vertY[1] = yPos - sqrt(3) * w/4;
    vertY[2] = yPos;
    vertY[3] = yPos + sqrt(3) * w/4;
    vertY[4] = yPos + sqrt(3) * w/4;
    vertY[5] = yPos;
  }

  void display () {
    if (yPos<height*10) {
      noStroke();
      if (disappear) {
        fill(70, 180);
      } else {
        noFill();
      }
      beginShape();
      vertex(xPos - w/4, yPos - sqrt(3) * w/4);
      vertex(xPos + w/4, yPos - sqrt(3) * w/4);
      vertex(xPos + 2 * w/4, yPos);
      vertex(xPos + w/4, yPos + sqrt(3) * w/4);
      vertex(xPos - w/4, yPos + sqrt(3) * w/4);
      vertex(xPos - 2 * w/4, yPos);
      endShape(CLOSE);
    }
  }

  //updates the positon of the hexagon
  void update (int speed) {
    yPos = yPos+speed;
    if (yPos > height) {
      yPos = -2*height+ yInitial;
      disappear=true;
    }
  }
}

//draws all the hexagons if the index is not null
void drawHexagons() {
  for (int i=h.length-1; i>=0; i--) {
    for (int j=h[0].length-1; j>=0; j--) {
      if (h[i][j]!=null) {
        h[i][j].display();
        h[i][j].update(4);
        if (h[i][j].disappear) {
          position[i][j]=true;
        }
      }
    }
  }
}