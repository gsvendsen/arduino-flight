float ballY = 0;
float gravity = .05;
float velocity = 0;
float obstacleY = random(50,400);
float obstacleX = 500;

float obstacleY2 = random(50,400);
float obstacleX2 = 750;

boolean alive = true;
int score = 0;
int val;
import processing.serial.*;
Serial myPort;  // Create object from Serial class
PImage webImg;
PImage webImg2;
PImage obstacleImg;
PImage bgImg;
PImage spriteImg2;

void setup(){
  size(1000,500);
  refresh();
  obstacle();
  ballY = 0;
  gravity = .025;
  velocity = 0;
  obstacleY = random(50, 200);
  obstacleX = 1000;
  obstacleY2 = random(50, 400);
  obstacleX2 = 1500;
  alive = true;
  score = 0;
  String portName = Serial.list()[1];
  myPort = new Serial(this, portName, 9600);
  println(Serial.list());
  String sprite1 = "https://i.imgur.com/E1IIypI.png";
  String sprite2 = "https://i.imgur.com/kbbO8Zm.png";
  String url2 = "https://i.imgur.com/vNCHsZE.png";
  String obstacleUrl = "https://i.imgur.com/rQdRwrn.png";
  String bgUrl = "https://www.soapoperalaundromats.com/wp-content/uploads/2012/01/Woodridge-2019-front.jpg";
  // Load image from a web server
  webImg = loadImage(sprite1, "png");
  spriteImg2 = loadImage(sprite2, "png");
  webImg2 = loadImage(url2, "png");
  obstacleImg = loadImage(obstacleUrl, "png");
  bgImg = loadImage(bgUrl, "jpg");

}

void refresh(){
  if(ballY > 450){
    alive = false;
  }
  if(ballY < -50){
    ballY = -50;
  }
  if (alive==true){
    velocity = velocity + gravity;
    ballY = ballY+velocity;
    background(246,218,99);
    
    fill(100,100,255);
  }
}

void jump(){
  val = myPort.read();
  if (val > 0||keyPressed == true){
      velocity = -1.5;
  }
}  

void obstacle(){
  if(obstacleX+75<0){
    obstacleY = random(50,300);
    obstacleX = 1000;
  }
  
  if(obstacleX2+75<0){
    obstacleY2 = random(50,300);
    obstacleX2 = 1000;
  }
}

void collisionCheck(){
  if((obstacleX - 250 < 40 && 250 - obstacleX < 40) && ((ballY > obstacleY && ballY - obstacleY < 140) || (obstacleY > ballY && obstacleY - ballY < 50))){
    alive = false;
  }
  
  if((obstacleX2 - 250 < 40 && 250 - obstacleX2 < 40) && ((ballY > obstacleY2 && ballY - obstacleY2 < 140) || (obstacleY2 > ballY && obstacleY2 - ballY < 50))){
    alive = false;
  }
}

void restartScreen(){
  textSize(35);
  fill(10,10,10);
  text("Game Over",370,65);
}


void scoreCheck(){
  if(obstacleX == 150 || obstacleX2 == 150){
    score++;
  }
  fill(10,10,10);
  textSize(35);
  text(score,950,55);
}

void draw(){
  if (alive){
    obstacle();
    refresh();

    if(second() % 2 == 0){
      image(webImg, 250, ballY);
    } else {
      image(spriteImg2, 250, ballY);
    }
    
    image(obstacleImg, obstacleX, obstacleY);
    obstacleX = obstacleX-2;
    
    image(obstacleImg, obstacleX2, obstacleY2);
    obstacleX2 = obstacleX2-2;
    
    jump();
    collisionCheck();
  }else{
   restartScreen();
  }
  scoreCheck();
}