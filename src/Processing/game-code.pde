int i, j; 

float pheight; //en Y
float Angle;
int DistanceUltra;
int IncomingDistance;
float Pas; //pour deplacements X

float enemyX;
float enemyY;




String DataIn; //incoming data

//5 a 32 cm


float [] CloudX = new float[6];
float [] CloudY = new float[6];

//vitesse constante hein


PImage Cloud;
PImage enemy;
PImage Ship;



// serial port config
import processing.serial.*; 
Serial myPort;    



//preparation
void setup() 
{

    myPort = new Serial(this, Serial.list()[0], 9600); 


    myPort.bufferUntil(10);   //end the reception as it detects a carriage return

    frameRate(30); 

    size(1850,1000);
    rectMode(CORNERS) ; //we give the corners coordinates 
    noCursor(); //why not ?
    textSize(16);

    pheight = 300; //initial plane value


    Cloud = loadImage("abc.png");  //load a picture
    enemy = loadImage("enemy.png"); 
    Ship = loadImage("Ship3.png");

    //int clouds position
    for  (int i = 1; i <= 5; i = i+1) {
        CloudX[i]=random(1000);
        CloudY[i]=random(400);
    }
}



//incoming data event on the serial port
void serialEvent(Serial p) { 
    DataIn = p.readString(); 
    // println(DataIn);

    IncomingDistance = int(trim(DataIn)); //conversion from string to integer

    println(IncomingDistance); //checks....

    if (IncomingDistance>1  && IncomingDistance<30 ) {
        DistanceUltra = IncomingDistance; //save the value only if its in the range 1 to 100     }
    }
}


//main drawing loop
void draw() 
{
    background(100,0,0);
    fill(5, 72, 0);

  
  
    if (pheight < 30) {
        pheight=30;
    }

   
    if (pheight > 880) {
        pheight=880;
    }

    TraceAvion(pheight);
    

    enemyX =   enemyX -  cos(radians(Angle))*10;

    if (enemyX < -30) {
        enemyX=900;
        enemyY = random(600);
    }

    //draw and move the clouds
    for  (int i = 1; i <= 5; i = i+1) {
        CloudX[i] =   CloudX[i] -  cos(radians(Angle))*(10+2*i);

        image(Cloud, CloudX[i], CloudY[i], 300, 200);

        if (CloudX[i] < -300) {
            CloudX[i]=1000;
            CloudY[i] = random(400);
        }
    }

    image(enemy, enemyX, enemyY, 59, 38); //displays the useless enemy. 59 and 38 are the size in pixels of the picture
}



void TraceAvion(float Y) {
    //draw the plane at given position and angle

    noStroke();
    pushMatrix();
    translate(400, Y);
    rotate(radians(90)); //in degres  ! 

image(Ship,0,300,100,100);
 
 

    popMatrix();
}

//file end
