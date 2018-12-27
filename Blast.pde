 // class for laser blasts
 class Blast{
   PVector pos;
   PVector vel;
  boolean explode;
  boolean enemyType;
  boolean hitAlready;
   int count;
   
   
   Blast(){
    hitAlready=false;
    enemyType=false;
    count=0;
    explode=false;
    pos = new PVector(player.pos.x-1, player.pos.y-28);
    vel= new PVector(0, 20);
              }
  
   Blast(Enemy e){
    enemyType=true;
    count=0;
    explode=false;
    pos = new PVector(e.pos.x, e.pos.y+16);
    vel= new PVector(0, -7);
                }
                
   PVector getPos(){
    return pos;
    
  }

   void display(){
    if(!enemyType && pos.y>0 && !explode)
    {
      image(blast, pos.x, pos.y, 12, 12);
    pos.sub(vel);
     }
                                          
    else if(enemyType && pos.y>0 && !explode)
    {
      image(blast2, pos.x, pos.y, 12, 12);
    pos.sub(vel);
      }
    else if (explode)
    {
      count++;
      if (count<16)
        image(explosionAnim[count], pos.x, pos.y, 64, 64);
    }
  }
  
   boolean hitEnemy(Enemy e){
    if (e.greenEnemy0 && e.health==0){
      lives++;
      plusOne=true;
      return true;
    }
    
    return (e.health==0 && !explode && !enemyType && pos.x>e.pos.x-16 && pos.x<e.pos.x+16 && pos.y<e.pos.y+16 && pos.y>e.pos.y-16);
  }  
  // player gets hit - 1 life and an explosion sound plays
   void hitPlayer(Player p){
    if (!hitAlready && !explode && enemyType && pos.x>p.pos.x-19 && pos.x<p.pos.x+19 && pos.y<p.pos.y+26 && pos.y>p.pos.y-26){
      hitAlready=true;
      lives--;
      explosionShip.play();
      explosionShip.rewind();

      explode=true;
    }
  }
   void hurt(Enemy d){
    if (d.health>0 && !hitAlready && !enemyType && pos.x>d.pos.x-19 && pos.x<d.pos.x+19 && pos.y<d.pos.y+26 && pos.y>d.pos.y-26){
      hitAlready=true;
      d.health--;
            explosion1.play();

      explode=true;
    }
  }
   boolean removeExtraBlasts(){
    return (pos.y<0 || pos.y>height);
  }
}