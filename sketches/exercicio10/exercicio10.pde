// exercicio 10
//Implemente um programa que simula uma bola caindo
//e quicando no chao. A bola deve iniciar no centro
//(horizontalmente) e no topo da janela do programa,
//com a bola parada. Esta deve iniciar a descida com
//o clique do mouse.
float posicaoY = 0;
int largura = 50;
float velocidade = 0;
float aceleracao = 0;
float elasticidade = 0.8;

void setup(){
  size(400,400);
}

void draw(){
  background(120);

  if (mousePressed && velocidade == 0){
    velocidade = 2;
    aceleracao = 0.5;
  }
  ellipse(width/2, posicaoY, largura, largura);
  velocidade = velocidade + aceleracao;
  posicaoY = posicaoY + velocidade;

  if (posicaoY >= height - largura/2){
    velocidade = -(velocidade * elasticidade);
    posicaoY = height - largura/2;
  }
}
