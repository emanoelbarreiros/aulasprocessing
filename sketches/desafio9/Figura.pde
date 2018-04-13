class Figura{
  private int id;
  private desafio9 jogo;
  private int tamanhoParte = 30;

  //posicao da figura
  private int posicaoX;
  private int posicaoY;

  //define se a forma esta livre ou ja colidiu
  //com alguma outra forma, ou a base (bloqueada = true)
  private boolean bloqueada;
  private byte forma;
  private byte orientacao;

  private byte[][] formato;

  private color cor;

  private boolean realcar;

  public Figura(int posX, int posY, int tamanhoParte, desafio9 jogo, boolean bloco){
    this.id = Definicao.obterId();
    this.posicaoX = posX;
    this.posicaoY = posY;
    if (bloco){
      this.forma = Definicao.FORMA_B;
      this.bloqueada = true;
    } else {
      this.forma = (byte)floor(random(7));
      this.orientacao = (byte)floor(random(4));
      this.bloqueada = false;
    }
    this.formato = Definicao.obterMatrizFormato(forma, orientacao);
    this.tamanhoParte = tamanhoParte;
    this.jogo = jogo;
    this.realcar = false;
    this.cor = obterCor(forma);
  }

  public int getPosicaoX(){
    return posicaoX;
  }

  public void realcar(boolean realcar){
    this.realcar = realcar;
  }

  public int getPosicaoY(){
    return posicaoY;
  }

  public boolean getBloqueada(){
    return bloqueada;
  }

  public void setBloqueada(boolean bloqueada){
    this.bloqueada = bloqueada;
  }

  public byte getForma(){
    return forma;
  }

  public byte getOrientacao(){
    return orientacao;
  }

  public int getId(){
    return id;
  }
  
  public void setCor(color cor){
    this.cor = cor;
  }
  
  public color getCor(){
    return this.cor;
  }

  public void decrementarPosicaoX(){
    if(posicaoX>0){
      posicaoX--;
    }
  }

  public void incrementarPosicaoX(){
    if(posicaoX < jogo.qtdCelulasLargura - 1){
      posicaoX++;
    }
  }


  public void moverBaixo(){
    posicaoY++;
    jogo.atualizarCelulas();
    if(jogo.checarColisao() || jogo.checarLimiteVertical()){
     posicaoY--;
     bloquear();
     converterBlocos();
    }
    jogo.atualizarCelulas();
  }

  public void moverBaixo(int celulas){
    posicaoY += celulas;
    jogo.atualizarCelulas();
  }

  public void moverCima(){
    posicaoY--;
    jogo.atualizarCelulas();
  }

  public void moverEsquerda(){
    decrementarPosicaoX();
    jogo.atualizarCelulas();
    if (jogo.checarColisao()){
      incrementarPosicaoX();
    }
    jogo.atualizarCelulas();
  }

  public void moverDireita(){
    incrementarPosicaoX();
    jogo.atualizarCelulas();
    if (jogo.checarLimitesLaterais() || jogo.checarColisao()){
      decrementarPosicaoX();
    }
    jogo.atualizarCelulas();
  }

  public void bloquear(){
    this.bloqueada = true;
  }

  public byte[][] obterMatrizFormato(){
    return formato;
  }

  public int qtdLinhasForma(){
    return obterMatrizFormato().length;
  }

  public int qtdColunasForma(){
    return obterMatrizFormato()[0].length;
  }

  void pintar(){
    pintar(posicaoX*tamanhoParte, posicaoY*tamanhoParte);
  }
  
  void pintar(int x, int y){
    stroke(240);
    for (int i = 0; i < formato.length;i++){
      for (int j = 0; j < formato[i].length; j++){
        if (formato[i][j] == 1){
          if (realcar){
            fill(cor);
          } else {
            fill(red(cor), green(cor), blue(cor),150);
          }
          rect(x + (tamanhoParte*j), y + (tamanhoParte*i), tamanhoParte, tamanhoParte);
        }
      }
    }
  }

  public void rotacionar(){
    byte orientacaoAnterior = orientacao;
    this.orientacao = (byte)((orientacao + 1) % 4);
    this.formato = Definicao.obterMatrizFormato(forma, orientacao);
    jogo.atualizarCelulas();
    if(jogo.checarColisao() || jogo.checarLimitesLaterais()){
      this.orientacao = orientacaoAnterior;
      this.formato = Definicao.obterMatrizFormato(forma, orientacao);
    }
    jogo.atualizarCelulas();
  }

  public void converterBlocos(){
    for (int i = 0; i < formato.length; i++) {
      for (int j = 0; j < formato[i].length; j++) {
        if (formato[i][j] == 1){
          Figura f = new Figura(posicaoX+j, posicaoY+i, tamanhoParte, jogo, true);
          f.setCor(this.cor);
          jogo.adicionarFigura(f);
        }
      }
    }
    jogo.removerFigura(this);//garantir que ao remover esta figura, as celulas sejam atualizadas corretamente
    jogo.atualizarCelulas();
  }
  
  public color obterCor(byte forma){
    switch(forma){
      case Definicao.FORMA_O:
        return color(250,240,40);
      case Definicao.FORMA_I:
        return color(5, 255, 240);
      case Definicao.FORMA_J:
        return color(43, 40, 250);
      case Definicao.FORMA_L:
        return color(250, 166, 40);
      case Definicao.FORMA_S:
        return color(44, 198, 2);
      case Definicao.FORMA_Z:
        return color(247, 27, 27);
      case Definicao.FORMA_T:
        return color(107, 12, 242);
      default:
        return color(0);
    }
  }

  public boolean equals(Figura outra) {
    return this.id == outra.getId();
  }

  public String toString(){
    return " "+id;
  }
}
