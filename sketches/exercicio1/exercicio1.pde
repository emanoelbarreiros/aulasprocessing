//exercicio 1
//Escreva um programa que desenha um quadrado onde quer que o mouse esteja na tela,
//centralizado na posição do mouse. O quadrado deve deixar um rastro na tela
//quando você mover o mouse.
void setup() {
  size(300,300);
}

void draw() {
  int tamanhoLado = 30;
  rect(mouseX-tamanhoLado/2, mouseY - tamanhoLado/2, tamanhoLado, tamanhoLado);
}
