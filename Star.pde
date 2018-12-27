
 class Star{
   int x;
   int y;
   int clr;
   int brightness;
   
   Star(){
    x=(int) random(0,width+1);
    y=(int) random(0,height+1);
    clr=(int) random(0,3);
    // brightness goes randomly rom 1-3 and the colors range from i-255
    brightness=(int) random(1,255);
  }
  public void display(){
    if (frameCount%10==0)
    
      brightness=(int) random(1,255);
    if (clr==0)
      fill(brightness, 0, 0);
    if (clr==1)
      fill(0, brightness, 0);
    if (clr==2)
      fill(0, 0, brightness);
    rectMode(CENTER);
    rect(x, y, 3, 3);
    y++;
    if (y==height)
      y=0;
  }
}