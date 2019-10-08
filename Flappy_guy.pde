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
void setup(){
  size(1000,500);
  refresh();
  obstacle();
  ballY = 0;
  gravity = .025;
  velocity = 0;
  obstacleY = random(50, 400);
  obstacleX = 1000;
  obstacleY2 = random(50, 400);
  obstacleX2 = 1500;
  alive = true;
  score = 0;
  String portName = Serial.list()[1];
  myPort = new Serial(this, portName, 9600);
  println(Serial.list());
  String url = "https://i.imgur.com/C6qp1SN.png";
  String url2 = "https://i.imgur.com/vNCHsZE.png";
  String obstacleUrl = "https://i.imgur.com/Kxm0kBi.png";
  String bgUrl = "https://www.soapoperalaundromats.com/wp-content/uploads/2012/01/Woodridge-2019-front.jpg";
  // Load image from a web server
  webImg = loadImage(url, "png");
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
    background(20,20,20);
    
    fill(100,100,255);
  }
}
void jump(){
  val = myPort.read();
  if (val == 1||keyPressed == true){
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
  if(obstacleY - ballY < 30 && obstacleX - 250 < 30 && 250 - obstacleX < 30 && ballY - obstacleY < 30){
    alive = false;
  }
  
  if(obstacleY2 - ballY < 30 && obstacleX2 - 250 < 30 && 250 - obstacleX2 < 30 && ballY - obstacleY2 < 30){
    alive = false;
  }
}
void restartScreen(){
  textSize(40);
  fill(152,38,205);
  text("You died",350,250);
}
void scoreCheck(){
  if(obstacleX == 60){
    score++;
  }
  fill(150,50,0);
  textSize(40);
  text(score,800,60);
}
void draw(){
  if (alive){
    obstacle();
    refresh();
    if(velocity < 0 ){
      image(webImg2, 250, ballY);
    } else {
      image(webImg, 250, ballY);
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
  //scoreCheck();
}
