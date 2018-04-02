//exercicio 7
//Faça uma animação do PacMan usando a função arc. Como o
//PacMan se move é uma decisão sua.

int x = 0;
float anguloMaximo = TWO_PI/3; //120 graus
float anguloAtual = 0;
boolean abrindo = true;
float anguloZero = 0;
float incrementoAngulo = 0.1;

void setup(){
  size (500, 200);
  noStroke();
}

void draw(){
  background(125);
  int tamanhoCirculo = 30;
  if (abrindo){
    anguloAtual += incrementoAngulo;
    if (anguloAtual >= anguloMaximo){
      abrindo = false;
    }
  } else {
    anguloAtual -= incrementoAngulo;
    if (anguloAtual <= 0) {
      abrindo = true;
    }
  }
  arc(x, 100, tamanhoCirculo, tamanhoCirculo, anguloAtual/2, TWO_PI - anguloAtual/2);
  x += 2;
}
