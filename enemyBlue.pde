 class enemyBlue extends Enemy{
   int side;
   enemyBlue(int num){
    health=(int) random(1,2);
    greenEnemy0=false;
    number=num;
    stopped=false;
    alive=true;
    count = 0;
    dAngle=0.05;
    
    // the height and widjt of buenemy
    if(num%2==0){
      pos=new PVector(width/6+16*(num+1), -16*(num+1));
      stop=(2*height-660)-(16*(num+1));
      side=-1;
    }
    if(num%2!=0){
      pos=new PVector(5*width/6-16*(num), -16*(num));
      stop=(2*height-660)-(16*(num));
      side=1;
    }
    vel=new PVector(0, 10);
  }
   void display(){
     
    if(alive){
      image(enemyBlue, pos.x, pos.y);
    }
    // sprite for enemy explosion
    else{
      count++;
      if (count<16)
        image(explosionAnim[count], pos.x, pos.y, 64, 64);
    }
  }
  // movement patterns for blue enmy
  public void move(){
    if(!stopped && pos.y<stop){
      pos.add(vel);      
  
  }
    if (!stopped && pos.y==stop)
      stopped=true;
    if(stopped){
      time++;
  
      if (time>=0 && angle>-TWO_PI && angle<TWO_PI){
        angle+=dAngle;
        pos.add(side*10*cos(angle),0);
      }
      
      if (angle<=-TWO_PI || angle>=TWO_PI){
        angle=0;
        time=-180;
      }
    }
  }  
  // enemyBlue shoots at random intervals between 0-91
   void shoot(){
    int roll = (int) random (0,91);
    if (roll==1 && pos.x>0 && pos.x<width){
     Blast blast = new Blast(this);
      blasts.add(blast);
  
    }
  }
   void addScore(){
    score+=100;
  }
}