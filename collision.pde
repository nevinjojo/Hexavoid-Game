//CGRA 151 - Assignment 5/ Game - "Hexavoid"
//By Nevin Jojo
//these are all the collision tests for the game

//checks collision between bullet and hexagons
void bulletCollision() {
  ArrayList<bullet> tempBullets = bullets;
  hexagon[][] hTemp = h;
  //compares all hexagons with all bullets and check if they collided
  for (int i=0; i<h.length; i++) {
    for (int j=0; j<h[0].length; j++) {
      if (h[i][j]!=null && position[i][j]!=false) {
        for (int k=0; k<bullets.size(); k++) {
          bullet b = bullets.get(k);
          float hx = h[i][j].xPos, hy = h[i][j].yPos, hr = h[i][j].w/2;
          float bx = b.x, by = b.y, br = b.r;
          if (sq(bx-hx) + sq(hy-by) <= sq(hr+br)) {
            //if collision occures, remove bullets from arraylist, remove the hexagon from 2d array, and make the hexagon disappear
            tempBullets.remove(b);
            h[i][j].disappear=false;
            position[i][j]=false;
            hTemp[i][j].col = color(0, 0);
          }
        }
      }
    }
  }
  bullets=tempBullets;
  h=hTemp;
}

//checks collision between rocket and hexagons
void rocketHexagonCollision() {
  //compares all hexagons with the rocket and check if they collided
  for (int i = 0; i < h.length; i++) {
    for (int j = 0; j<h[0].length; j++) {
      if (position[i][j]!=false) {
        float rx = xRocket, ry = yRocket, rw = rocketWidth, rh = rocketHeight;
        float cx = h[i][j].xPos, cy = h[i][j].yPos, cd = h[i][j].w/2;
        if (cx+cd/2 >=rx-rw/2 && cx-cd/2<=rx+rw/2 && abs(ry-cy) <cd/2) {
          hexagonCollision=true;
        } else if (cy+cd/2 >= ry-rh/2 && cy-cd/2 <= ry+rh/2 && abs(rx-cx) <= cd/2) {
          hexagonCollision=true;
        }
        //upper left
        float xDist = (rx-rw/2)-cx, yDist = (ry-rh/2)-cy, shortest = sqrt((xDist*xDist) + (yDist*yDist));

        // upper-right
        xDist = (rx+rw/2) - cx;
        yDist = (ry-rh/2) - cy;
        float distanceUR = sqrt((xDist*xDist) + (yDist * yDist));
        if (distanceUR < shortest) {  // if this new distance is shorte
          shortest = distanceUR;      //update
        }

        // lower-right
        xDist = (rx+rw/2) - cx;
        yDist = (ry+rh/2) - cy;
        float distanceLR = sqrt((xDist*xDist) + (yDist * yDist));
        if (distanceLR < shortest) {
          shortest = distanceLR;
        }

        // lower-left
        xDist = (rx-rw/2) - cx;
        yDist = (ry+rh/2) - cy;
        float distanceLL = sqrt((xDist*xDist) + (yDist * yDist));
        if (distanceLL < shortest) {
          shortest = distanceLL;
        }

        // test for collision
        if (shortest < cd/2) {  // if less than radius
          hexagonCollision=true;
        }
      }
    }
  }
}

//checks collision between rocket and coins
void coinCollision () {
  //compares all coins with the rocket and check if they collided
  for (int i=0; i<c.length; i++) {
    for (int j=0; j<c[0].length; j++) {
      if (c[i][j]!=null) {
        float cx = c[i][j].xPos, cy = c[i][j].yPos, cr = c[i][j].r;
        float rx = mouseX-(rocketWidth/2), ry = height*0.7, rw = rocketWidth, rh = rocketHeight;
        float testX=cx, testY=cy;
        if (cx<rx) testX=rx;
        else if (cx>rx+rw)testX=rx+rw;
        if (cy < ry)         testY = ry;
        else if (cy > ry+rh) testY = ry+rh;
        float distX = cx-testX, distY = cy-testY, distance = sqrt((distX*distX)+(distY*distY));
        if (distance<=cr) {
          //if they colided, increment score and remove coin
          c[i][j]=null;
          score++;
        }
      }
    }
  }
}