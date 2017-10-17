//CGRA 151 - Assignment 5/ Game - "Hexavoid"
//Coin class
//By Nevin Jojo

class coin {
  //radius, position, and ccolour of the coin
  int r;
  int row, col;
  float xPos, yPos, yInitial, gap;

  coin (int i, int j) {
    row =i; 
    col = j;
    r=15;
    gap = 67;
    xPos = col*gap +32;
    yPos = -height + (row*2*gap);
  }

  void display() {
    if (yPos<height*10) {
      noStroke();
      fill(#ffcc00);
      ellipse(xPos, yPos, r, r);
    }
  }

//changes the position of the coin
  void update (int speed) {
    yPos = yPos+speed;
    if (yPos > height) {
      yPos = -2*height+ yInitial;
    }
  }
}

//if there are coins in the 2d array, draw and update their position
void drawCoins() {
  for (int i=h.length-1; i>=0; i--) {
    for (int j=h[0].length-1; j>=0; j--) {
      if (position[i][j]==false && c[i][j]!=null) {
        c[i][j].display();
        c[i][j].update(4);
      }
    }
  }
}