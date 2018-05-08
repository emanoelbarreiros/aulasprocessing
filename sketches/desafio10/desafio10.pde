int larguraCampo = 880;
int alturaCampo = 480;

void setup(){
  size(950,550);
}

void draw(){
  desenharFundo();
}

void desenharFundo(){
  int padding = 35;
  fill(#27A010);
  stroke(255);
  strokeWeight(3);
  rect(padding, padding, larguraCampo, alturaCampo);
  line(padding+larguraCampo/2, padding, padding+larguraCampo/2, padding+alturaCampo);
  //bolinha central
  fill(255);
  ellipse(width/2, height/2, 10,10);
  //circulo central
  noFill();
  ellipse(width/2, height/2, 150, 150);
  //grande area esquerda
  rect(padding, 115+padding, 150, 250);
  //pequena area esquerda
  rect(padding, 115+padding+75, 50, 100);
  //grande area direita
  rect(width-padding-150, 115+padding, 150, 250);
  //pequena area direita
  rect(width-padding-50, 115+padding+75, 50, 100);
  //corners do escanteio
  arc(padding, padding, 30, 30, 0, HALF_PI);
  arc(width-padding, padding, 30, 30, HALF_PI, PI);
  arc(width-padding, height-padding, 30, 30, PI, PI+HALF_PI);
  arc(padding, height-padding, 30, 30, PI+HALF_PI, TWO_PI);
}
