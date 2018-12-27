// The orginal game doesn't have a time clock , I added it because I like to keep track of how long I spend playing games
class Timer {
  
  int startTime = 0, stopTime = 0;
  boolean running = false; 
  // time is in milliseceonds
  void start() {
    startTime = millis();
    running = true;
  }
  void stop() {
    stopTime = millis();
    running = false;
  }
  
  int getElapsedTime() {
    int elapsed;
    if (running) {
      elapsed = (millis() - startTime);
    }
    else {
      elapsed = (stopTime - startTime);
    }
    return elapsed;
  }
  // seconds and minutes, could have added an hour function but that would rarely be used
  int second() {
    return (getElapsedTime() / 1000) % 60;
  }
  int minute() {
    return (getElapsedTime() / (1000*60)) % 60;
  }
 
}