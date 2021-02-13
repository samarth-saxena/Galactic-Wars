const int trigPin1 = 3;
const int echoPin1 = 4;
int sensorPin1=5;
boolean val1 =0;

const int trigPin2 = 6;
const int echoPin2 = 7;
int sensorPin2=8;
boolean val2 =0;

long duration1,duration2;
int distance1,distance2,i;
float sum;

void setup() 
{
  i=0;
  sum=0;
  pinMode(trigPin1, OUTPUT);
  pinMode(echoPin1, INPUT);
  pinMode(sensorPin1, INPUT);

  pinMode(trigPin2, OUTPUT);
  pinMode(echoPin2, INPUT);
  pinMode(sensorPin2, INPUT);

  Serial.begin(9600);
  //pinMode(ledPin1, OUTPUT);
}

void loop() 
{
  //val1 =digitalRead(sensorPin1); 
  //val2 =digitalRead(sensorPin2);
  
  /*if(val==HIGH) {
    digitalWrite(ledPin, HIGH);
  }
  else {
    digitalWrite(ledPin, LOW);
  }*/
 
  digitalWrite(trigPin1, LOW);
  //digitalWrite(trigPin2, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin1, HIGH);
  //digitalWrite(trigPin2, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin1, LOW);
  //digitalWrite(trigPin2, LOW);

  duration1 = pulseIn(echoPin1, HIGH);
  //duration2 = pulseIn(echoPin2, HIGH);
  distance1= duration1*0.034/2;
  //distance2= duration2*0.034/2;
  
  if(distance1>30)
  { 
    distance1=30;
  }
  /*if(distance2>30)
  { 
    distance2=30;
  }*/
  
  /*if(i<20)
  {
    sum+=distance1;
    i++;
  }
  else
  {
    sum=sum/20;
    Serial.println(sum);
    i=0;
  }*/
Serial.print(distance1);
Serial.print('-');
Serial.println(val1);
//Serial.print(',');
//Serial.print(distance2);
//Serial.print('-');
//Serial.println(val2);
 }
