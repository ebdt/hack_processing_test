// Arcade Startup Screen in Processing

int screen = 0;  // 0 = menu, 1 = game1, 2 = game2, 3 = game3, 4 = game4
int startTime;

void setup() {
  size(600, 750);
  textAlign(CENTER, CENTER);
}

void draw() {
  background(0);

  if (screen == 0) {
    drawMenu();
  } else if (screen == 1) {
    game1();
  } else if (screen == 2) {
    game2();
  } else if (screen == 3) {
    game3();
  } else if (screen == 4) {
    game4();
  }
}

// ---- MENU ----
void drawMenu() {
  fill(255);
  textSize(40);
  text("🎮 Arcade Hub 🎮", width/2, 100);

  textSize(24);
  int start_y = 300;
  drawButton("Game 1: Skee-Ball", width/2, start_y, 200, 50, 1);
  drawButton("Game 2: Whac-a-Mole", width/2, start_y+80, 200, 50, 2);
  drawButton("Game 3: Snake", width/2, start_y + 160, 200, 50, 3);
  drawButton("Game 4: Pong", width/2, start_y + 240, 200, 50, 4);
}

void drawButton(String label, float x, float y, float w, float h, int gameScreen) {
  if (mouseOver(x, y, w, h)) {
    fill(150, 200, 255);
  } 
  else 
  {
    fill(100, 150, 200);
  }
  rectMode(CENTER);
  rect(x, y, w, h, 10);
  fill(0);
  textSize(18);
  text(label, x, y);

  // Handle click
  if (mousePressed && mouseOver(x, y, w, h)) {
    screen = gameScreen;
  }
}

boolean mouseOver(float x, float y, float w, float h) {
  return (mouseX > x - w/2 && mouseX < x + w/2 &&
          mouseY > y - h/2 && mouseY < y + h/2);
}

// ---- GAME PLACEHOLDERS ----
void game1() {
  background(80, 109, 209);
  fill(255);
  text("Skee-Ball Game Placeholder", width/2, height/2);
  //draw_skee();
  backButton();
}

void game2() {
  if (startTime == 0){
     startTime = millis();
  }
  playWackARetreiver();
  strokeWeight(6);
  backButton();
}

void game3() {
  background(100, 200, 100);
  fill(0);
  text("Snake Game Placeholder", width/2, height/2);
  backButton();
}

void game4() {
  background(180, 180, 50);
  fill(0);
  text("Pong Game Placeholder", width/2, height/2);
  backButton();
}

// ---- BACK BUTTON ----
void backButton() {
  drawButton("⬅ Back to Menu", width/2, height - 50, 200, 40, 0);
}
