//CGRA 151 - Assignment 5/ Game - "Hexavoid"
//By Nevin Jojo

import processing.sound.*; //use this library to add background music. commented out for marking
SoundFile file;
String audioName = "audio.mp3", path; //background music file
PImage bg, rocket, bullet; //images displayed
PFont title, subTitle; //fonts used
//parameters of rocket
float xRocket, yRocket;
int rocketWidth = 23, rocketHeight = 40, level, score, bgFileNumber=1;
//                                                        0                                                1                                        2                                          3                                                    4                                              5                                              6                                        7                                    8                                    9                                          10                                            11                                12                                      13                                        14            
boolean[][] position = new boolean[][] { { false, false, false, false, false, false }, { false, false, false, false, false, false }, { false, false, false, false, false, false }, { false, false, false, false, false, false }, { false, false, false, false, false, false }, { false, true, false, false, true, false }, {true, false, false, false, false, true}, {true, true, false, false, true, true}, {true, false, false, false, false, true}, {false, false, false, false, false, false}, {false, false, true, true, false, false}, {true, true, true, false, false, false}, {false, false, false, true, true, true}, {true, true, false, false, true, true}, {true, true, false, true, true, true} };
hexagon[][] h = new hexagon[position.length][position[0].length];
coin[][] c = new coin[position.length][position[0].length];
ArrayList<bullet> bullets = new ArrayList<bullet>();
boolean hexagonCollision=false, nextLevel=false;

void setup() {
  size(400, 650); // smart phone screen size
  smooth();
  frameRate(60);
  //runs the audio, font, images etc to begin the game
  path = sketchPath(audioName);
  file = new SoundFile(this, path);
  file.loop();
  bg = loadImage("bg"+bgFileNumber+".jpg"); //background image
  rocket = loadImage("rocket.png");
  title = createFont("hyped.ttf", 50);
  subTitle = createFont("arvo.ttf", 20);
  xRocket = width/2+20; // initial x position of rocket
  yRocket = height*0.7;
  level = 1; //initial score and level
  score = 0;

  //create hexagons
  for (int i = 0; i < position.length; i++) {
    for (int j=0; j<position[0].length; j++) {
      if (position[i][j]==true) {
        h[i][j] = new hexagon(i, j, true);
      }
    }
  }

  //creates coins
  for (int i = 0; i < position.length; i++) {
    for (int j=0; j<position[0].length; j++) {
      float chance = random(0, 1);
      if (position[i][j]==false && chance < 0.2) {
        c[i][j] = new coin(i, j);
      }
    }
  }

  // Create the particles
  for (int x = particleCount; x >= 0; x--) { 
    particles[x] = new Particle();
  }
}

void draw() {
  background(bg);
  if (bgFileNumber>=7) {
    bgFileNumber=1;
  }
  if (key == 'S' || key == 's') {
    drawHexagons(); //draws the moving hexagons on the screen 
    if (play) {
      drawCoins(); //draws the moving coins on the screen 
      coinCollision ();
      bulletCollision();
      rocketHexagonCollision();
    }
    drawRocket(); // draws the rocket on the screen
    drawBullets(); //draws the bullets if mouse pressed
    drawScore(level, score);
    if (hexagonCollision) {
      explode();
    }
    gameOver();
  } else {
    startMenu();
  }
  if (score>=5*level) {
    level++;
    bgFileNumber++;
    nextLevel();
  }
}

//resets the entire game  when the 'n' button is pressed
void reset(int s) {
  bgFileNumber=1;
  score=s;
  //                                                        0                                                1                                        2                                          3                                                    4                                              5                                              6                                        7                                    8                                    9                                          10                                            11                                12                                      13                                        14            
  boolean[][] position = new boolean[][] { { false, false, false, false, false, false }, { false, false, false, false, false, false }, { false, false, false, false, false, false }, { false, false, false, false, false, false }, { false, false, false, false, false, false }, { false, true, false, false, true, false }, {true, false, false, false, false, true}, {true, true, false, false, true, true}, {true, false, false, false, false, true}, {false, false, false, false, false, false}, {false, false, true, true, false, false}, {true, true, true, false, false, false}, {false, false, false, true, true, true}, {true, true, false, false, true, true}, {true, true, false, true, true, true} };
  bg = loadImage("bg"+bgFileNumber+".jpg"); //background image
  rocket = loadImage("rocket.png"); //rocket which is controlled by user/ player
  xRocket = width/2+20; // initial x position of rocket
  yRocket = height*0.7;
  hexagonCollision=false;
  //create hexagons
  for (int i = 0; i < position.length; i++) {
    for (int j=0; j<position[0].length; j++) {
      if (position[i][j]==true) {
        h[i][j] = new hexagon(i, j, true);
      }
    }
  }

  //creates coins
  for (int i = 0; i < position.length; i++) {
    for (int j=0; j<position[0].length; j++) {
      float chance = random(0, 1);
      if (position[i][j]==false && chance < 0.2) {
        c[i][j] = new coin(i, j);
      }
    }
  }

  // Create the particles
  for (int x = particleCount; x >= 0; x--) { 
    particles[x] = new Particle();
  }
}

//draws the rocket on the screen
void drawRocket() {
  image(rocket, xRocket-rocketWidth/2, yRocket);
  xRocket = mouseX;
  //checks if rocket is within the boundaries
  if (xRocket>=width-rocketWidth) {
    xRocket=width-rocketWidth;
  }
}