class ship
{
  PImage shipimg;
  float sx,sy, ssize;
  int score;
  int id;
  

  ship(int y, int a)
  {
    if(a==1)  
      shipimg =loadImage("Player1.png");
    else
      shipimg =loadImage("Player2.png");
    
    sy=y;
    score=0;
    ssize=100;
    id=a;
  }
  
  void display()
  {
    sy=mouseY;
    image(shipimg,sx,sy/id,ssize,ssize);  
  }
  
  void details(int x)
  {
    textFont(font1);
    textSize(32);
    if(id==1)
      fill(0,255,0);
    else
      fill(255,0,0);
    text("PLAYER"+id+": "+score,x,100); 
  }
}

class enemy
{
  PImage enemyimg;
  float ex,ey,speed, esize;
  boolean control;
  
  enemy()
  {
    enemyimg =loadImage("Enemy.png");
    ex=width;
    ey=170*counter;
    counter++;
    esize=100;
    speed=4;
    control=true;
  }
  
  void display()
  {
    image(enemyimg,ex,ey,esize,esize);  
  }
  
  void move()
  {
    ex=ex-speed; 
    if(ex<-esize)
    {
      if(counter>5)
        counter=1;
      ex=width;
      esize=100;
      ey=170*counter;
      counter++;
    }
  }
  
  void collision(laser l)
  {
   if(((ex + esize) > l1.x) && (ey < (l1.y + 10)) && ((ey + esize) > l1.y) &&  (ex < (l1.x + 80)) )  
   {
     if(control==true)
     {
       Player1.score+=20;
       control=false;
     }
   }
   else
      control=true;
   
  }
}


class rock 
{
  PImage rockimg;
  float rx,ry,speed,rsize;
  boolean [] control= new boolean[2];
  
  rock() 
  {
    rsize=random(60)+100;
    rx=width;
    ry=random(height-rsize)+rsize/2;
    speed=random(9)+7;
    rockimg=loadImage("ast1.png"); 
    control[0]=true;
    control[1]=true;
  }
  void display()
  {
    image(rockimg,rx,ry,rsize,rsize);
  }
  void move()
  {
    rx=rx-speed; 
    if(rx<-rsize)
    {
      rx=width;
      ry=random(height-rsize)+rsize/2;
      rsize=random(60)+100;
      speed=random(9)+7;
    }
  }
  void collision(ship Player)
  {
   if(((rx + rsize) > Player.sx) && (ry < (Player.sy + Player.ssize)) && ((ry + rsize) > Player.sy) &&  (rx < (Player.sx + Player.ssize)) )  
   {
    if(control[Player.id-1])
    {
      Player.score-=10;
      control[Player.id-1]=false;
    }
   }
   else
   {
     control[Player.id-1]=true;
   }
  }
}


class laser
{
  float x,y;
  laser(ship Player)
  {
    x=Player.sx+Player.ssize;
    y=Player.sy+(Player.ssize/2);
  }
  void shoot(ship Player)
  {
    fill(255,50,0);
    rect(x,Player.sy+(Player.ssize/2),80,10,10);
    x+=80;
    if(x>=width)
    {
     x=Player.sx+Player.ssize;
     value=0;
    }
  }
  
}

PFont font1, font2;
int astno=5, enemyno=4;
int counter=1, value=0;
String DataIn;
ship Player1, Player2;
enemy [] e1;
rock [] ast1;
laser l1,l2;
//import processing.serial.*; 
//Serial myPort;

void setup()
{
  fullScreen();
  frameRate(60);
  noCursor();
  
  //myPort = new Serial(this, Serial.list()[0], 9600); 
  //myPort.bufferUntil(10);
  font1=createFont("moonhouse.ttf",50);
  startgame();
  Player1 = new ship(500, 1);
  Player2 = new ship(800, 2);
  l1= new laser(Player1);
  l2= new laser(Player2);
  e1 = new enemy[4];
  for(int i=0;i<enemyno;i++)
  {
    e1[i]= new enemy(); 
  }
  ast1 = new rock[astno];
  for(int i=0;i<astno;i++)
  {
    ast1[i]= new rock(); 
  }
}

int begin=1;

void draw()
{
  if(begin==1)
  {
    startgame();
    begin=0;
  }
  background(20,20,20);
  heading();
  if(value==1)
  {
    l1.shoot(Player1);
    //l2.shoot(Player2);
  }
  
  Player1.display();
  //Player2.display();
  for(int i=0;i<enemyno;i++)
  {
    e1[i].display();
    e1[i].move();
    e1[i].collision(l1);
  }
  for(int i=0;i<astno;i++)
  {
    ast1[i].display(); 
    ast1[i].move();
    ast1[i].collision(Player1);
    //ast1[i].collision(Player2);
  }
  
}

void mousePressed() {
  if (value == 0) {
    value = 1;
  } else {
    value = 0;
  }
}

float sum;
int abc=0;

/*void serialEvent(Serial p) 
{ 
    DataIn = p.readString();
    //print(DataIn);
    if(abc<20)
  {
    sum+=int(trim(DataIn));
    abc++;
  }
  else
  {
    sum=sum/20;
    Player1.sy = sum*32.66;
    abc=0;
  }
    //Player1.sy = int(trim(DataIn))*32.66;
}
*/
void heading()
{
  textSize(50);
  fill(255);
  textFont(font1);
  text("GALACTIC WARS",650,60);
  Player1.details(200);
  //Player2.details(1500);
}

void startgame()
{
  background(20,20,20);
  fill(255);
  textFont(font1);
  textSize(100);
  text("GALACTIC WARS",750,800);
  delay(3000);
}
