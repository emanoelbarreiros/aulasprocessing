class Inimigo {
  PVector localizacao;
  PVector velocidade;
  int velocidadeLinearInimigo = 1;
  int diametro = 20;
  boolean remover = false;

  public Inimigo(int xCentro, int yCentro, PVector alvo) {
    this.localizacao = new PVector(xCentro, yCentro);

    PVector direcao = PVector.sub(alvo, this.localizacao);

    float d = 30 * cos(direcao.heading());
    float c = 30 * sin(direcao.heading());
    float velH = this.velocidadeLinearInimigo * cos(direcao.heading());
    float velV = this.velocidadeLinearInimigo * sin(direcao.heading());
    this.velocidade = new PVector(velH, velV);
  }

  void atualizar() {
    this.localizacao.add(this.velocidade);
  }

  void pintar() {
    noStroke();
    fill(255, 0, 0);
    ellipse(this.localizacao.x, this.localizacao.y, this.diametro, this.diametro);
  }
}
