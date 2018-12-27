 abstract class Enemy{
   abstract void display();
   abstract void move();
   abstract void shoot();
   abstract void addScore();
      int stop;
      int number;
      int intcount;
      int time;
      int health;
      int count;
  boolean alive;
  boolean stopped;
  boolean greenEnemy0;
  PVector pos;
  PVector vel;
  float angle;
  float dAngle;
}