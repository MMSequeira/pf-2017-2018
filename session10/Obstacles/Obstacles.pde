float obstacle1X;
float obstacle1Y;
float obstacle1W;
float obstacle1H;

float obstacle2X;
float obstacle2Y;
float obstacle2W;
float obstacle2H;

float playerX;
float playerY;
float playerW;
float playerH;
float playerVX;
float playerVY;

void setup() {
  size(500, 500);
  
  obstacle1X = width / 5;
  obstacle1Y = 4 * height / 5;
    obstacle1W = width / 10;
  obstacle1H = height / 20;

  obstacle2X = 4 * width / 5;
  obstacle2Y = height / 5;
  obstacle2W = width / 20;
  obstacle2H = height / 10;
  
  playerX = width / 2;
  playerY = height / 2;
  playerW = width / 25;
  playerH = width / 25;
  playerVX = 5;
  playerVY = 3;
}

void draw() {
  background(0);
  
  playerX += playerVX;
  playerY += playerVY;
  
  if (playerX <= 0) {
    playerX = 0;
    playerVX = -playerVX;
  } else if (playerX + playerW >= width) {
    playerX = width - playerW;
    playerVX = -playerVX;
  }
  if (playerY <= 0) {
    playerY = 0;
    playerVY = -playerVY;
  } else if (playerY + playerH >= height) {
    playerY = height - playerH;
    playerVY = -playerVY;
  }
    
  if (playerX <= obstacle1X + obstacle1W && playerX + playerW >= obstacle1X &&
    playerY <= obstacle1Y + obstacle1H && playerY + playerH >= obstacle1Y)
    fill(255, 0, 0);
  else
    fill(127, 0, 0);
  rect(obstacle1X, obstacle1Y, obstacle1W, obstacle1H);
  
  if (playerX <= obstacle2X + obstacle2W && playerX + playerW >= obstacle2X &&
    playerY <= obstacle2Y + obstacle2H && playerY + playerH >= obstacle2Y)
    fill(0, 255, 0);
  else
    fill(0, 127, 0);
  rect(obstacle2X, obstacle2Y, obstacle2W, obstacle2H);

  fill(255);
  rect(playerX, playerY, playerW, playerH);
}