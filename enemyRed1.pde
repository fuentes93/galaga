 class enemyRed1 extends Enemy{
   // enemy health and quantity of enemies
   enemyRed1(int num){
    health=1;
    greenEnemy0=false;
    number=num;
    stopped=false;
    alive=true;
    time=0;
    count = 0;
    // starting of position of enemies
        dAngle=0.05;
    if(num%2==0){
          pos=new PVector(width/6+16*(num+1), -8*(num+1));
          stop=(height/2)-(16*(num+1));
          angle=PI/4;
          dAngle=-0.02;
        }
        if(num%2!=0){
          pos=new PVector(5*width/6-16*(num), -16*(num));
          stop=(height/2)-(16*(num));
          dAngle=0.02;
          angle=-PI/4;
            }
            vel=new PVector(0, 12);  
      }
      
      public void display(){
        if(alive){
          image(enemyRed1, pos.x, pos.y);
        }else{
          count++;
          if (count<16)
            image(explosionAnim[count], pos.x, pos.y, 64, 64);
        }
      }
       void move(){
        if(!stopped && pos.y<stop){
          pos.add(vel);      
        }
        if (!stopped && pos.y==stop)
      stopped=true;
    if(stopped){
      time++;
      if (time>=60*(number+1) && angle>-TWO_PI+PI/4 && angle<TWO_PI-PI/4){
        angle+=dAngle;
        pos.add(10*sin(angle),2*cos(angle));
      }
      if (angle<=-TWO_PI+PI/4 || angle>=TWO_PI-PI/4){
        if(number%2==0)
          angle=PI/4;
        if(number%2!=0)
          angle=-PI/4;
        time=-180;
      }
    }
    
  }
  public void shoot(){
    int roll = (int) random (0,129);
    if (roll==1 && pos.x>0 && pos.x<width){
      Blast blast = new Blast(this);
      blasts.add(blast);
    }
  }
  public void addScore(){
    score+=100;
  }
}