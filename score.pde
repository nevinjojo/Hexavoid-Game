//CGRA 151 - Assignment 5/ Game - "Hexavoid"
//By Nevin Jojo
//This is where all the menus scores etc are created

boolean play = true;

//all the instructions, title and buttons needed for start menu
void startMenu() {
  background(bg);
  fill(255);
  textFont(title);
  text("HEXAVOID", (width/2), height*0.2);
  pushMatrix();
  textFont(subTitle);
  textSize(17);
  textAlign(CENTER);
  text("Press 's' to", (width/2), (height/2)-130);
  textSize(21);
  text("START", (width/2), (height/2)-100);
  scale(1.9, 1.9);
  drawMenu(1.2, -width/2+65, -height/2+180);
  popMatrix();
  fill(255);
  textSize(17);
  text("INSTRUCTIONS", (width/2), (height/2)+50);
  stroke(255);
  line(width/2-40, (height/2)+55, width/2+40, (height/2)+55);
  textSize(14);
  text("#Use mouse to control the Rocket.", (width/2), (height/2)+90);
  text("#Click on mouse to shoot", (width/2), (height/2)+120);
  text("#Avoid the Hexagons as long as you can.", (width/2), (height/2)+150);
  text("#Collect coins to Level Up", (width/2), (height/2)+180);
  text("#Each bullet will reduce the score by 1", (width/2), (height/2)+210);
  text("#Good Luck!", (width/2), (height/2)+240);
}

//draws the score at the top of the screen
void drawScore(int level, int score) {
  fill(255);
  textSize(20);
  if (score<=0) score=0;
  text("Level: "+level+" Score: "+score, width/2, 20);
}

//if the player leveled up, change the background colour
void nextLevel () {
  bg = loadImage("bg"+bgFileNumber+".jpg"); 
  if (bgFileNumber>7) {
    bgFileNumber =1;
  }
}

//if the collision occured, show game over screen with an option to restart
void gameOver() {
  if (play==false) {
    background(bg);
    drawMenu(2, -width/2, -height/2);
    fill(255);
    textSize(25);
    text("Mission Failed", width/2, height/2-20);
    textSize(17);
    text("Your score is "+score, (width/2), (height/2)+10);
    textSize(17);
    text("Press N to restart", (width/2), (height/2)+40);
  }
}

//all the keys used in the game and what they are supposed to do
void keyPressed() {
  if (key == 'p' || key == 'P') { //pauses the game
    drawMenu(1.5, -width/2+100, -height/2+150);
    fill(255);
    textSize(14);
    text("Press 'S' to", width/2, height/2-20);
    textSize(20);
    text("START", width/2, (height/2)+20);
    noLoop();
  } else if (key == 'S' || key == 's') { //starts/ resume the game
    play=true;
    loop();
    reset(score);
  } else if (key == 'N' || key == 'n') {//restarts the game
    //file.loop();
    play=true;
    reset(0);
  }
}


//this is the basic method that will be used to draw the hexagons necessary for the menus
void drawMenu (float scale, float translateX, float translateY) {
  fill(70, 180);
  noStroke();
  pushMatrix();
  translate(translateX, translateY);
  scale(scale);
  beginShape();
  vertex(width/2, (height/2)-75);
  vertex(width*0.675, (height/2)-37.5);
  vertex(width*0.675, (height/2)+37.5);
  vertex(width/2, (height/2)+75);
  vertex(width*0.325, (height/2)+37.5);
  vertex(width*0.325, (height/2)-37.5);
  endShape();
  popMatrix();
}