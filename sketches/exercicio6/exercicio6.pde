// exercicio 6
//Desenhe a figura abaixo usando a chamada à função
//rect(x, y, largura, altura), sendo invocada exatamente 3 vezes:
//um quadrado com 9 subquadrados, lembrando um tabuleiro de jogo da velha

void setup() {
  size(300,300);
  noFill();
}

void draw() {
  int offset = 20;
  int tamanhoQuadrado = 40;
  rect(offset, offset, tamanhoQuadrado*2, tamanhoQuadrado*3);
  rect(offset+tamanhoQuadrado, offset, tamanhoQuadrado*2, tamanhoQuadrado*3);
  rect(offset, offset+tamanhoQuadrado, tamanhoQuadrado*3, tamanhoQuadrado);
}
