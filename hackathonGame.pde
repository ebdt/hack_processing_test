// Arcade Startup Screen in Processing

int screen = 0;  // 0 = menu, 1 = game1, 2 = game2, 3 = game3, 4 = game4

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
  drawButton("Game 1: Skee-Ball", width/2, 200, 200, 50, 1);
  drawButton("Game 2: Whac-a-Mole", width/2, 280, 200, 50, 2);
  drawButton("Game 3: Flappy Retriever", width/2, 360, 200, 50, 3);
  drawButton("Game 4: Pong", width/2, 440, 200, 50, 4);
}

void drawButton(String label, float x, float y, float w, float h, int gameScreen) {
  if (mouseOver(x, y, w, h)) {
    fill(150, 200, 255);
  } else {
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
  background(30, 120, 200);
  fill(255);
  text("Skee-Ball Game Placeholder", width/2, height/2);
  backButton();
}

void game2() {
  background(200, 80, 100);
  fill(255);
  text("Whac-a-Mole Game Placeholder", width/2, height/2);
  backButton();
}

void game3() {
  flappyDriver();
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
