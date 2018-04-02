// exercicio 9
//Escreva um programa que realize desenhos simétricos usando elipses.
//A cada frame, desenhe uma elipse na posição do mouse e a espelhe
//verticalmente na metade direita da tela. As elipses só devem ser
//desenhadas quando o mouse for pressionado.

void setup(){
  size(500, 500);
}

void draw(){
  if (mousePressed){
    ellipse(mouseX, mouseY, 10, 10);
    ellipse(width-mouseX, mouseY, 10, 10);
  }
}
