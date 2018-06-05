int largura = 50;
float aceleracao = 0.3;
float elasticidade = 0.7;

float[] xBolas = new float[100];
float[] yBolas = new float[100];
float[] velBolas = new float[100];
float[] corBolas = new float[100];
int novaPosicao = 0;

void setup(){
  size(600, 600);
}

void draw(){
  background(120);

  for (int i = 0; i < novaPosicao; i++){
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
  xBolas[novaPosicao] = mouseX;
  yBolas[novaPosicao] = mouseY;
  velBolas[novaPosicao] = 0;
  corBolas[novaPosicao] = random(256);
  novaPosicao++;
}
