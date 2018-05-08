float[] px = new float[10];
float[] py = new float[10];
float[] vx = new float[10];
float[] vy = new float[10];
float[] ax = new float[10];
float[] ay = new float[10];
color[] cores = new color[10];
int indice = 0;

int pXMouse;
int pYMouse;
boolean arrastando = false;
int massaSol = 100;
int raioSol = 25;
float G = 500;
void setup() {
  size(600, 600);
}

void draw() {
  translate(width/2, height/2);
  background(255);
  noStroke();
  fill(#FFFA62);
  ellipse(0, 0, 2*raioSol, 2*raioSol);
  //calcular aceleracao na superficie
  //g = G*M/R*R
  //G == constante de gravitacao universal
  //M == massa do astro
  //R == raio do astro
  //calcular aceleracao a uma distancia h
  //gh = g * R/((R+h)^2)
  for (int i = 0; i < indice; i++) {
    float distancia = dist(px[i], py[i], 0, 0);
    float cosa = px[i]/distancia;
    float cosb = py[i]/distancia;
    float g = G*massaSol/(raioSol*raioSol);
    float gh = g * raioSol/pow(raioSol + distancia, 2);
    ax[i] = gh*cosa;
    ay[i] = gh*cosb;
    vx[i] = vx[i] - ax[i];
    vy[i] = vy[i] - ay[i];
    px[i] = px[i] + vx[i];
    py[i] = py[i] + vy[i];
    fill(cores[i]);
    ellipse(px[i], py[i], 10, 10);
  }

  if (arrastando) {
    fill(0);
    stroke(0);
    line(pXMouse, pYMouse, mouseX-width/2, mouseY-height/2);
    ellipse(pXMouse, pYMouse, 10, 10); 
  }
}

void mousePressed() {
  arrastando = true;
  pXMouse = mouseX-width/2;
  pYMouse = mouseY-height/2;
}

void mouseReleased() {
  arrastando = false;
  px[indice] = pXMouse;
  py[indice] = pYMouse;
  
  float distancia = dist(pXMouse, pYMouse, mouseX-width/2, mouseY-height/2);
  float cosa = (pXMouse-(mouseX-width/2))/distancia;
  float cosb = (pYMouse-(mouseY-height/2))/distancia;;
  vx[indice] = distancia*cosa/20;
  vy[indice] = distancia*cosb/20;
  cores[indice] = color(random(30, 255), random(30, 255), random(30, 255));
  indice++;
}
