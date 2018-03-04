//exercicio 3
///Escreva um programa que desenha um círculo dentro de um quadrado onde
//quer que o mouse esteja. Caso o mouse se mova, as figuras devem se
//mover junto. Não devem deixar rastro.

void setup(){
  size(300,300);
}

void draw() {
  background(0);
  int tamanhoLado = 30;
  rect(mouseX-tamanhoLado/2, mouseY - tamanhoLado/2, tamanhoLado, tamanhoLado);
  ellipse(mouseX, mouseY, tamanhoLado, tamanhoLado);
}
