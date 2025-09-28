PImage grass, dog, mallet, end;

float[][] holes = {
{300, 190}, // top row
{100, 350}, {300, 350}, {500, 350}, // middle row
{200, 500}, {400, 500} // bottom row
};

int activeHole = -1;
int lastChange = 0;
int rate = 1000; // each hole lights up for 1 sec
int score = 0;
int gameTime = 45000;
int hitTime = 0;


boolean gameOver = true;
boolean whacked = false;


// draw grassy background
void drawBG(){
  grass = loadImage("grassy.jpg");
  imageMode(CORNER);
  image(grass, 0, 0);
  grass.resize(600, 750);
}


// draws one retriever mole
// make it draw 5/6 using for loop
void drawRetrieverMole(){
  dog = loadImage("hackdog_clearbg.png");
  imageMode(CENTER);
  // draw dogs in all holes
  for (int i = 0; i < holes.length; i++) {
    float x = holes[i][0];
    float y = holes[i][1];
    image(dog, x, y, 130, 100);
  }
  //image(dog, 300, 190);
    
}

// draw target circles where retriever moles go
void drawTCircles(){
  // top row
  fill(100);
  strokeWeight(16);
  fill(0);
  ellipse(300, 190, 120, 120);
  
  // middle row
  fill(0);
  ellipse(100, 350, 120, 120);
  ellipse(300, 350, 120, 120);
  ellipse(500, 350, 120, 120);
  
  // bottom row
  fill(0);
  ellipse(200, 500, 120, 120);
  ellipse(400, 500, 120, 120);
}

void timer(){
  if (!gameOver) {
    int timeLeft = (gameTime - (millis() - startTime)) / 1000;  // in seconds
    
    // check if time is up
    if (timeLeft <= 0) {
      gameOver = true;
      timeLeft = 0;
    }
    // draw box
    fill(255, 255, 200);     // light yellow box
    stroke(0);               // black border
    strokeWeight(2);
    rectMode(CORNER);
    rect(15, 12, 215, 40, 8);  // x,y,w,h,rounded corners
  
    // draw timer
    fill(0);
    textSize(24);
    text(" Time Remaining: " + timeLeft, 120, 30);
  } 
}

void score(){
  if (!gameOver){
    // draw box
    fill(255, 255, 200);     // light yellow box
    stroke(0);               // black border
    strokeWeight(2);
    rectMode(CORNER);
    rect(470, 12, 120, 40, 8);  // x,y,w,h,rounded corners
    
    // draw score
    fill(0);
    text("Score: " + score, 530, 30);
  }
}

void drawHammer(){
  mallet = loadImage("mallet.png");
  if (!gameOver){
    noCursor();
    imageMode(CENTER);
    image(mallet, mouseX, mouseY, 100, 100);
  }
}

void resetWackARetriever(){
  score = 0;
  activeHole = -1;
  lastChange = 0;
  whacked = false;
  gameOver = false;
  startTime = millis();
}

void playWackARetreiver(){
  //startTime = millis(); // records start time 
  drawBG();
  drawTCircles();
  drawRetrieverMole();
  
  
  if (!gameOver){
    if (millis() - lastChange > rate) {
    activeHole = (int)random(0, holes.length);
    lastChange = millis();
    whacked = false; // reset hit state for new mole
    }
  } else {
    cursor();
    end = loadImage("end.jpg");
    imageMode(CORNER);
    image(end, 0, 0);
    end.resize(600, 750);
    //background(227, 184, 114);
    fill(255, 255, 200);     // light yellow box
    stroke(0);               // black border
    strokeWeight(2);
    rectMode(CORNER);
    rect(160, 225, 275, 200, 8);  // x,y,w,h,rounded corners
    
    // game over screen
    fill(0);
    textSize(40);
    text("Your time is up!", width/2, height/2 - 100);
    textSize(32);
    text("Final Score: " + score, width/2, height/2 - 50);
    text("Tickets Earned: " + score/20, width/2, height/2);
    textSize(24);
    //noLoop();  // stop the draw loop
    
    activeHole = -1;
  }
  
  // draw highlight circle
  if (activeHole >= 0){
      float x = holes[activeHole][0];
      float y = holes[activeHole][1];
      
      if (whacked){
        // green feedback for 1 sec
        if (millis() - hitTime < 800){
          noFill();
          stroke(0, 255, 0);
          strokeWeight(8);
          ellipse(x, y, 140, 140);
        } else {
          whacked = false;
        }
      } else {
          // red circle
          noFill();
          stroke(255, 0, 0);
          strokeWeight(8);
          ellipse(x, y, 140, 140);
      }
  }
  
  drawHammer();
  timer();
  score();
  
}


void mousePressed() {
  if (activeHole >= 0 && !gameOver && !whacked) {
    float x = holes[activeHole][0];
    float y = holes[activeHole][1];
    float d = dist(mouseX, mouseY, x, y);

    if (d < 60) {   // within circle
      score += 10;
      whacked = true;
      hitTime = millis();
    }
  }
}
