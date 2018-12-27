              // Game Prgramming Project Galaga by Luis Fuentes and Devendrasinh Varachhia , Professor Ling Xu
Timer sw;

import ddf.minim.*;
Minim minim;
AudioPlayer intro;
AudioPlayer explosion1;
AudioPlayer explosionShip;
AudioPlayer laserSound;
AudioPlayer song0;
AudioPlayer song1;
AudioPlayer song2;
AudioPlayer gameOver;

// image files 
PImage blast;
PImage blast2;
PImage galaga;
PImage player1;
PImage enemyRed1;
PImage enemyBlue;
PImage greenEnemy;
PImage explosion;
PImage[] explosionAnim = new PImage[16];
PFont futura;

//Global vars
Star[] stars;
Player player;
ArrayList<Blast> blasts;
ArrayList<Enemy> enemies;
int diffCursor ;
int gameState; 
int gameTime; 
int stage;
int stageTime; 
int lives;
int restart;
int enemyCount;
int plusOneTime; 
int score; 
int musicCount;
boolean newStage;
boolean enemiesSpawned ;
boolean plusOne ;
boolean greenEnemySpawned ;

void setup() {
  //Data loading
     minim= new Minim(this);
       println (millis());
            sw = new Timer();
            sw.start();
            //sound files
            intro = minim.loadFile("intro.mp3");
            explosion1 = minim.loadFile("explosion1.mp3");
            explosionShip = minim.loadFile("explosion2.mp3");
            laserSound = minim.loadFile("laserSound.mp3");
            song0 = minim.loadFile("containerpark.mp3");
            song1 = minim.loadFile("bornSlippy.mp3");
            song2 = minim.loadFile("lustForLife.mp3");
            gameOver = minim.loadFile("gameOver.mp3");

  //Images
  blast = loadImage("blast.png");
  blast2 = loadImage("tieBlast.png");
  galaga = loadImage("galaga.png");
  player1 = loadImage("player1.png");
  enemyRed1 = loadImage("enemyRed1.png");
  enemyBlue = loadImage("enemyBlue.png");
  greenEnemy = loadImage("greenEnemy.png");
  explosion = loadImage("explode.png");
  // explosion sprite 
  for (int i=0; i<explosionAnim.length/4;i++){
      for (int j=0; j<explosionAnim.length/4;j++){
        explosionAnim[j+4*i]=explosion.get(j*128, i*128, 128, 128);
      }
  }

  //Processing settings
  size(720, 690);
  imageMode(CENTER);
  textAlign(CENTER);

  //star background
  stars = new Star[height/4];
  for (int i=0; i<stars.length; i++) {
    Star star= new Star();
    stars[i]=star;
  }

  //Game settings
  gameState=0;
  gameTime=0;
  stage=1;
  stageTime=0;
  newStage=false;
  restart=0;
  lives=5;
  enemyCount=22;
  plusOne=false;
  plusOneTime=0;
  enemiesSpawned=false;
 greenEnemySpawned=false;
  score=0;
}

//         gamestate for game in total its 5 different gamestates                                            
void draw() {
  bg();
  if (gameState<2)
    menu();
  if (gameState==2)
    game();
  if (gameState==3)
    gameOver();
    if (gameState==4)
    drawScreen("GAME PAUSED", "\nPress p to resume");
    if (gameState==5)
     drawScreen("Credits: \nGame Programming Project Galaga  \nBy Luis Fuentes \n&\n Devendrasinh Varachhia\n\n\n All rights reserved to Namco ", "\nPress c to resume"); 
}
//                                                                   END OF DRAW METHOD

void keyPressed() {
  //Menus
  if (gameState<2) {
    
    //Next menu
    if (key == ' '){
      gameState++;
    }
      
    //Select diff
    if (keyCode==DOWN) {
      if (diffCursor<2)
        diffCursor++;
      else
        diffCursor=0;
      lives=3-diffCursor;
    }
    if (keyCode==UP) {
      if (diffCursor>0)
        diffCursor--;
      else
        diffCursor=2;
      lives=3-diffCursor;
    }    
  }
  
  //In-game
  if (gameTime>150 || stage>1){
    player.move();
    if (gameTime>270)
      player.shoot();
  }
    // p tp pause game s to see the credits
  if(key=='p' && gameState==2)
      gameState=4;
          else if(key=='p' && gameState==4)
      gameState=2;
          if(key=='c' && gameState==2)
      gameState=5;
          else if(key=='c' && gameState==5)
       gameState=2;
  
  // MUSIC FOR GAME
  if (key == 'm'){
    musicCount++;
    if(musicCount==1){
          song0.play();

    }else if (musicCount==2){
     song0.pause();
     song1.play();
    }
    else if (musicCount==3){
    song1.pause();
     song2.play();
    }
    else if (musicCount==4){
     song0.pause();
     song1.pause();
     song2.pause();
           musicCount=0;

    }
  }
  
  //Endgame
  if (gameState==3){
    if (keyCode == LEFT || keyCode == RIGHT){
      if (restart==0)
        restart=1;
      else
        restart=0;
    }
    if (key==' '){
      if (restart==0){
        gameTime=0;
        gameState=1;
        stage=1;
        lives=5;
        enemiesSpawned=false;
        greenEnemySpawned=false;
        score=0;
      }
      else
        exit();
    }
  }
}

void keyReleased() {
  if (gameTime>150 || stage>1){
    player.halt();
    player.ceaseFire();
  }
}

void bg() {
  background(0);
  for (int i=0; i<stars.length; i++)
    stars[i].display();
}

void menu() {
  //Main menu
  if (gameState==0) {
    
    //Logo
    image(galaga, width/2, height/4+150, 384, 216);
    
    //Start o' game
    if (frameCount%100<50) {
      fill(0,10,255);  
      textSize(29);
      text("\nSTOP THE INSECT ARMY FROM REACHING EARTH \nENDLESS WAVES OF INSECTS COMING TO ATTACK \nHOW LONG CAN YOU DEFEND EARTH!!!\n\n\n\n\n\n\nCONTROLS: \nleft = left arrow key right = right arrow key\nspace bar =shoot laser\n Press m for music\n PRESS SPACE TO START", width/2, height-660);
      intro.play();
    }
  }

  //Diff menu
  if (gameState==1) {
    fill(255);
    textSize(36);
        fill(0,255,7);
        textAlign(CENTER);
    text("SELECT DIFFICULTY:", width/2, height/3);
    text("EASY : 5 LIVES", width/2, height/3+90);
    text("MEDIUM : 4 LIVES", width/2, height/3+180);
    text("HARD 2 LIVES", width/2, height/3+270);
    if (diffCursor==0)
      text(">", width/2-180, height/3+90);
    if (diffCursor==1)
      text(">", width/2-180, height/3+180);
    if (diffCursor==2)
      text(">", width/2-180, height/3+270);
  }
}

void game(){
  //Timer
  gameTime++;
  
  //Pregame
  if (gameTime<150 && stage==1){
    newStage=false;
    textAlign(CENTER);
    textSize(48);
    fill(0,0,233);
    text("STAGE "+stage, width/2, height/2);
    player = new Player();
    blasts = new ArrayList<Blast>();
    enemies = new ArrayList<Enemy>();
  }
  else if(gameTime<150 && stage>1){
    newStage=false;
    textAlign(CENTER);
    textSize(46);
    fill(0,0,233);
    text("STAGE "+stage, width/2, height/2);
    player.display();
    blasts = new ArrayList<Blast>();
    enemies = new ArrayList<Enemy>();
  }
  else if (gameTime<270){
    fill(233,0,0);
    textAlign(CENTER);
    textSize(46);
    text("READY", width/2, height/2);
    player.display();
  
   if (!enemiesSpawned && stage<6){       
        for(int i=0;i<40;i++){
          if(i<16)
            enemies.add(new enemyRed1(i));
          else if(i<32)
            enemies.add(new enemyBlue(i));
          else if (!greenEnemySpawned &&i>32){
            enemies.add(new greenEnemy(i));

           greenEnemySpawned=true;
          }
        }
        enemiesSpawned=true;
      }
  }else if (gameTime>=270 && enemies.size()>0){
    
  //Stage starts
   newStage=true;
    player.display();
    for (int j=0;j<blasts.size();j++){
      blasts.get(j).display();
      for (int i=0;i<enemies.size();i++){
        blasts.get(j).hurt(enemies.get(i));
        if (blasts.get(j).hitEnemy(enemies.get(i))){
          enemies.remove(i).addScore();
           laserSound.rewind();
            explosion1.rewind();
          blasts.get(j).explode=true; 
        }
        blasts.get(j).hitPlayer(player);        
           

      }
      if (blasts.get(j).removeExtraBlasts())
        blasts.remove(j);
    }
    for (Enemy e: enemies){
      e.display();
      e.move();
      e.shoot();
    }
    if (enemies.size()==1)
      if (enemies.get(0).greenEnemy0)
        for(int i=0;i<10;i++){
          if(i<6)
            enemies.add(new enemyRed1(i));
          else if(i<10)
            enemies.add(new enemyBlue(i));          
        }
  }
  if (newStage && enemies.size()==0){
    gameTime=0;
    stage++;
    enemiesSpawned=false;
   greenEnemySpawned=false;
    player.isShooting=false;
  }
  if (lives<=0){
    gameState++;
  }
 
  //Lives
  for(int i=1; i<=lives; i++)
    image(player1, 25*i-12, height-18, 25, 35);
  //Stage
  if (gameTime>=270 && enemies.size()>0){
    fill(255);
    textSize(24);
    textAlign(LEFT, TOP);
    fill(255, 0, 0);
    text("STAGE "+stage, 0, 0);
    textSize(24);
    textAlign(RIGHT, TOP);
    text("SCORE: "+score, width, 0); 
      text(nf(sw.minute(), 2)+":"+nf(sw.second(), 2), 400, 1);

  }
  if (plusOne){
    plusOneTime++;
    if(plusOneTime<100 && plusOneTime>0){
      fill(255);
      textSize(36);
      textAlign(CENTER);
      text("+1", width/2,height/2);
    }
    if(plusOneTime==100){
      plusOne=false;
      plusOneTime=0;
    }
      
  }
  
}
void gameOver(){
  textAlign(CENTER);
  textSize(48);
  fill(255);
  gameOver.play();
  if (frameCount%100<50) {
  fill(3,255,17);
  text("GAME OVER", width/2, height/3);
  textSize(42);
  text("HIGH SCORE: "+score, width/2, height/2);
  text("Play Again", width/2, height/2+150);
  textSize(36);
  text("Y     N", width/2, height/2+180);
  if (restart==0)
    text(">         ", width/2-20, height/2+180);
  if (restart==1)
    text("      >   ", width/2-20, height/2+180);
}
}


void drawScreen(String title, String instructions) 
{
      background(0,0,0); 
  // draw title
      fill(255,100,0);
      textSize(41);
      textAlign(CENTER, BOTTOM);
      text(title, width/2, 4*height/5);
  // draw instructions
      fill(255,255,255);
      if (frameCount%100<50) {
      textSize(29);
      textAlign(CENTER, TOP);
      text(instructions, width/2, 2*height/3 + 55);
      }
}