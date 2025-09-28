// Flappy Retriever Game with Score

PImage backdrop;
PImage dog;
PImage movingPart;
PImage topBone;
PImage bottomBone;

float movingX = 0;
float movingSpeed = 3;

float dogPosY = 300;
float velocity = 0;  
float gravity = 1.5;  
float jump = -13;    
boolean started = false;
boolean initialized = false;
boolean gameOver = false;

float dogX = 180;
float dogW = 100;
float dogH = 100;

int score = 0;  // score counter

ArrayList<Pipe> pipes;

void flappyDriver() {
  if (!initialized) {
    backdrop = loadImage("background.png");
    dog = loadImage("dog.png");
    movingPart = loadImage("movingPart.png");
    topBone = loadImage("topBone.png");
    bottomBone = loadImage("bottomBone.png");
    if (backdrop == null || dog == null || movingPart == null || topBone == null || bottomBone == null) {
      println("failed to load images");
    }
    pipes = new ArrayList<Pipe>();
    pipes.add(new Pipe(width));  // first pipe starts off-screen
    initialized = true;
  }
  drawFlappy();
}

void drawFlappy() {
  // background
  image(backdrop, 0, 0);

  // moving ground
  movingX -= movingSpeed;
  if (movingX <= -600) movingX = 0;
  image(movingPart, movingX, 599, 600, 151);
  image(movingPart, movingX + 600, 599, 600, 151);

  // dog movement (only after start)
  if (started && !gameOver) {
    velocity += gravity;
    dogPosY += velocity;
  }

  // floor collision (touching moving ground ends game)
  float groundY = 599;
  float hitOffset = 10; // dog can go 10 pixels lower before losing
  if (dogPosY + dogH >= groundY + hitOffset) {
    dogPosY = groundY - dogH + hitOffset;
    velocity = 0;
    gameOver = true;
  }

  // ceiling limit
  if (dogPosY < 0) {
    dogPosY = 0;
    velocity = 0;
  }

  // draw dog
  image(dog, dogX, dogPosY, dogW, dogH);

  // pipes
  for (int i = pipes.size()-1; i >= 0; i--) {
    Pipe p = pipes.get(i);

    // move pipes only after the game has started
    if (started && !gameOver) p.movePipe();

    // draw pipes
    p.show();

    // check if dog passes pipe for score
    if (!p.counted && dogX > p.x + p.w) {
      score++;
      p.counted = true;
    }

    // remove off-screen pipes
    if (p.x < -p.w) pipes.remove(i);
  }

  // add new pipes
  if (!gameOver && (pipes.size() == 0 || pipes.get(pipes.size()-1).x < width - 250)) {
    pipes.add(new Pipe(width));
  }

  // display score
  fill(255);
  textSize(30);
  text("Score: " + score, width - 100, 50);

  // lose screen
  if (gameOver) {
    fill(255, 0, 0);
    textSize(40);
    text("GAME OVER", width/2, height/2);
    textSize(20);
    text("Press R to Restart", width/2, height/2 + 50);
    noLoop(); // stop updating until restart
  }
}

class Pipe {
  float x; 
  float w = 120;      // width for both pipes
  float gap = 200;    // space between top and bottom pipe
  float speed = 3;    // how fast pipe moves
  float topHeight;  
  float bottomY;      
  float bottomHeight; 
  float groundY = 610;
  boolean counted = false;  // track if pipe has been passed for score

  Pipe(float startX) {
    x = startX;

    // safe random topHeight
    float minTop = 50;
    float maxTop = groundY - gap - 50;
    topHeight = random(minTop, maxTop);
    bottomY = topHeight + gap;
    bottomHeight = groundY - bottomY;
  }

  void movePipe() {
    x -= speed;
  }

  void show() {
    image(topBone, x, 0, w, topHeight);
    image(bottomBone, x, bottomY, w, bottomHeight);
  }
}

void keyPressed() {
  if (key == ' ') {
    if (!started) started = true;
    if (!gameOver) velocity = jump;
  }
  if (gameOver && key == 'r') {
    // reset game
    dogPosY = 300;
    velocity = 0;
    pipes.clear();
    pipes.add(new Pipe(width));
    score = 0;
    gameOver = false;
    started = false;
    loop(); // resume drawing
  }
}
