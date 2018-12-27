 class greenEnemy extends Enemy{
     int side;

  public greenEnemy(int num){
    health=(int) random(1,2);
    greenEnemy0=true;
    number=num;
    stopped=false;
    alive=true;
    count = 4;
    dAngle=0.05;
    if(num%2==0){
      pos=new PVector(width/4+8*(num+1), -12*(num+1));
      stop=(height/2)-((num+1));
      side=-1;
    }
    if(num%2!=0){
      pos=new PVector(2*width -1075, -8*(num));
      stop=(2*height/3)-(4*(num));
      side=1;
    }
    vel=new PVector(0, 10);
  }
  public void display(){
    if(alive){
      image(greenEnemy, pos.x, pos.y);
    }else{
      count++;
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
    }}
// the green enmy is a bit harder to kill , it fires at a fater rate than the other enemies
public void shoot(){
    int roll = (int) random (0,37);
    if (roll==1 && pos.x>0 && pos.x<width){
 Blast blast = new Blast(this);
      blasts.add(blast);
    }
  }
  public void addScore(){
    score+=500;
  }
}