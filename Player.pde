 class Player {
  PVector pos;
  PVector vel;
   boolean left;
   boolean right;
   boolean isShooting;
       
       // position and velocity of player
   Player() {
    pos= new PVector(width/2, height-83);
    vel= new PVector(8, 0);
  }
  
  // player ship 
   void display() {
    image(player1, pos.x, pos.y, 37, 52);
    if (left && pos.x>20)
      pos.sub(vel);
    if (right && pos.x<width-20)
      pos.add(vel);
    if (isShooting && frameCount%5==0){
      Blast blast = new Blast();
      blasts.add(blast);
      
                laserSound.play();

    }
  }
  // the ship can only move left or right
   void move() {
    if (keyCode == LEFT) {
      left=true;
      right=false;
    }
    if (keyCode == RIGHT) {
      right=true;
      left=false;
    }
  }
   void halt(){
    if (keyCode == LEFT){
       left=false;
     }
     if (keyCode == RIGHT){
       right=false;
     }
  }
  // shooting with space bar
   void shoot(){
    if (key == ' ')

      isShooting=true;
  }
   void ceaseFire(){
    if (key == ' ')
      isShooting=false;
  }
}