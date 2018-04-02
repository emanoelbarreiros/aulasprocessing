int posicaoY = 0;
int largura = 50;
float velocidade = 0;
float aceleracao = 0.3;
float elasticidade = 0.7;

float[] xBolas = new float[100];
int iXBolas = 0;
float[] yBolas = new float[100];
int iYBolas = 0;
float[] velBolas = new float[100];
int iVelBolas = 0;
float[] corBolas = new float[100];
int iCorBolas = 0;

void setup(){
  size(600, 600);
}

void draw(){
  background(120);

  for (int i = 0; i < xBolas.length; i++){
    velBolas[i] = velBolas[i] + aceleracao;
    yBolas[i] = yBolas[i] + velBolas[i];
    fill(corBolas[i]);
    ellipse(xBolas[i], yBolas[i], largura, largura);

    if (yBolas[i] >= height - largura/2){
      velBolas[i] = -(velBolas[i] * elasticidade);
      yBolas[i] = height - largura/2;
    }
  }
}

void mouseReleased(){
  xBolas[iXBolas++] = mouseX;
  yBolas[iYBolas++] = mouseY;
  velBolas[iVelBolas++] = 0;
  corBolas[iCorBolas++] = random(256);
}
