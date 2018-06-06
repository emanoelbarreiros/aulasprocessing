import processing.sound.*;

class Tanque {
  float anguloZero = 0;
  PVector localizacao;
  int larguraTanque = 0;
  PVector direcao;
  SoundFile tiro;
  SoundFile morte;
  int tamanhoBala = 0;
  boolean sniper = false;


  Tanque(int xCentro, int yCentro, int larguraTanque, int tamanhoBala, SoundFile tiro, SoundFile morte) {
    this.localizacao = new PVector(xCentro, yCentro);
    this.larguraTanque = larguraTanque;
    //carregar arquivo de audio da pasta /data do sketch
    this.tiro = tiro;
    this.morte = morte;
    this.tamanhoBala = tamanhoBala;
  } 

  void atualizar() {
    PVector alvo = new PVector(mouseX, mouseY); //para onde o tanque deve olhar e girar
    this.direcao = PVector.sub(alvo, this.localizacao);//calculo da direcao para onde o tanque vai olhar e girar
    this.anguloZero = this.direcao.heading();
  }

  void pintar() {
    pushMatrix();
    translate(this.localizacao.x, this.localizacao.y);
    rotate(this.anguloZero);
    rectMode(CENTER);
    if (this.sniper) {
      strokeWeight(1);
      stroke(200);
      line(0, 0, height, 0);
    }
    strokeWeight(4);
    stroke(0, 0, 0);
    fill(255);
    rect(0, 0, this.larguraTanque, this.larguraTanque);
    line(0, 0, 30, 0);
    popMatrix();
  }

  Bala atirar() {
    float d = 30 * cos(-this.direcao.heading());
    float c = 30 * sin(-this.direcao.heading());
    float velHBala = velocidadeLinearBala * cos(this.direcao.heading());
    float velVBala = velocidadeLinearBala * sin(this.direcao.heading());
    Bala bala = new Bala(this.localizacao.x + d, this.localizacao.y - c, velHBala, velVBala, this.tamanhoBala);
    this.tiro.play();
    return bala;
  }

  void morrer() {
    this.morte.play();
  }
}
