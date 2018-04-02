float xBola = 0;
float yBola = 0;
float vx = 0;
float vy = 0;
int raio = 10;

void setup(){
  size(300,300);
  vx = random(-5, 5);
  vy = random(-5, 5);
  xBola = width/2;
  yBola = height/2;
}

void draw(){
  if (xBola >= width - raio){
    vx = -vx;
  }

  if (xBola <= raio){
    vx = -vx;
  }

  if (yBola <= raio){
    vy = -vy;
  }

  if (yBola >= height - raio){
    vy = -vy;
  }

  xBola = xBola + vx;
  yBola = yBola + vy;

  background(200);

  ellipse(xBola, yBola, 2*raio, 2*raio);
}
