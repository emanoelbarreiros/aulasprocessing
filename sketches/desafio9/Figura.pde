class Figura{
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
  
  public Figura(int posX, int posY, color cor, int tamanhoParte, desafio9 jogo){
    this.posicaoX = posX;
    this.posicaoY = posY;
    this.forma = (byte)floor(random(7));
    this.orientacao = (byte)floor(random(4));
    this.formato = Definicao.obterMatrizFormato(forma, orientacao);
    println(forma + " " + orientacao);
    this.bloqueada = false;
    this.cor = cor;
    this.tamanhoParte = tamanhoParte;
    this.jogo = jogo;
  }
  
  public int getPosicaoX(){
    return posicaoX;
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
     //converterBlocos();
    }
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
    //fill(cor);
    stroke(240);
    for (int i = 0; i < formato.length;i++){          
      for (int j = 0; j < formato[i].length; j++){
        if (formato[i][j] == 1){
          fill(cor);
          rect((posicaoX+j)*tamanhoParte, (posicaoY+i)*tamanhoParte, tamanhoParte, tamanhoParte);
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
  
  public void deletar(int linha){
    if(linha >= posicaoY && linha <= posicaoY + qtdLinhasForma()){
      byte[][] novoFormato = new byte[qtdLinhasForma() - 1][qtdColunasForma()];
      int k = 0;
      for (int i = 0; i < formato.length; i++){
        //pular caso seja a linha a ser deletada, ou seja, não copio para o novo array
        if (i + posicaoY == linha){
          continue;
        }
        for (int j = 0; j < formato[i].length; j++){
          novoFormato[k][j] = formato[i][j];
        }
        k++;
      }
      formato = novoFormato;
    }
  }
}
