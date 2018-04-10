import java.util.Arrays;

ArrayList<Figura> figuras;
int qtdCelulasLargura = 10;
int qtdCelulasAltura = 20;
byte[][] celulas = new byte[qtdCelulasAltura][qtdCelulasLargura];//tamanho da janela
int tamanhoCelula = 30;
Figura figuraLivre;

final byte MODO_NORMAL = 0;
final byte MODO_POSICIONAR = 1;
final byte MODO_DERROTA = 2;

byte modo = MODO_NORMAL;
byte contFrames = 60;

public final color[] cores = {color(5, 255, 240),//ciano
                              color(43, 40, 250),//azul
                              color(250, 166, 40),//laranja
                              color(250,240,40),//amarelo
                              color(44, 198, 2),//verde
                              color(107, 12, 242),//roxo
                              color(247, 27, 27)};//vermelho

void setup(){
  size(500,600);
  background(200);
  textSize(10);
  figuras = new ArrayList<Figura>();
  figuraLivre = new Figura(4,0, escolherCor(), tamanhoCelula, this);
  figuras.add(figuraLivre);
  atualizarCelulas();
}

void draw(){
  if (modo == MODO_NORMAL){
    contFrames = 60;
  } else if (modo == MODO_POSICIONAR){
    contFrames = 1;
  }

  if(frameCount % contFrames == 0){
    if(!figuraLivre.getBloqueada()){
      figuraLivre.moverBaixo();
    } else {
      modo = MODO_NORMAL;
      checaLinhasCompletas();
      figuraLivre = new Figura(4,0, escolherCor(), tamanhoCelula, this);
      figuras.add(figuraLivre);
    }

    //pintar todas as figuras
    atualizarVisualizacao();
  }
}

void atualizarVisualizacao(){
  desenharFundo();
  for(Figura fig : figuras){
    fig.pintar();
  }
}

void desenharFundo(){
  background(200);
  stroke(240);
  for (int i = 1; i < qtdCelulasLargura+1; i++){
    line(i*tamanhoCelula, 0, i*tamanhoCelula, height);
  }
  for (int i = 1; i < qtdCelulasAltura; i++){
    line(0, i*tamanhoCelula, qtdCelulasLargura*tamanhoCelula, i*tamanhoCelula);
  }
}

void atualizarCelulas(){
  celulas = new byte[qtdCelulasAltura][qtdCelulasLargura];
  for(Figura fig : figuras){
    byte[][] formato = fig.obterMatrizFormato();
    for(int i = 0; i < formato.length; i++){
      for (int j = 0; j < formato[i].length; j++){
        if(fig.getPosicaoX()+j < qtdCelulasLargura && fig.getPosicaoY()+i < qtdCelulasAltura){
          celulas[fig.getPosicaoY()+i][fig.getPosicaoX()+j] += formato[i][j];
        }
      }
    }
  }
}

public boolean checarColisao(){
  for(int i = 0; i < celulas.length; i++){
    for (int j = 0; j < celulas[i].length; j++){
      if (celulas[i][j] > 1){
        return true;
      }
    }
  }
  return false;
}

//retorna true se movimento levou a figura para fora dos limites da area de jogo
public boolean checarLimitesLaterais(){
  if((figuraLivre.getPosicaoX() + figuraLivre.qtdColunasForma()) > qtdCelulasLargura
      || figuraLivre.getPosicaoX() < 0){
    return true;
  }

  return false;
}

public boolean checarLimiteVertical(){
  if((figuraLivre.getPosicaoY() + figuraLivre.qtdLinhasForma()) > qtdCelulasAltura){
    return true;
  }
  return false;
}

color escolherCor(){
  return cores[figuras.size() % cores.length];
}

void checaLinhasCompletas(){
  int[] linhas = new int[20];
  for(int i = 0; i < celulas.length; i++){
    if(Arrays.equals(celulas[i], new byte[]{1,1,1,1,1,1,1,1,1,1})){
      linhas[i] = 1;
    }
  }

  for(int i = linhas.length - 1; i >= 0; i--){
    if(linhas[i] == 1){
      for(Figura fig : figuras){
        fig.deletar(i);
      }
    }
  }
}

void keyPressed(){
  if(keyCode == LEFT){
    figuraLivre.moverEsquerda();
  }

  if(keyCode == RIGHT){
    figuraLivre.moverDireita();
  }

  if(keyCode == UP){
    figuraLivre.rotacionar();
  }

  if(keyCode == DOWN){
    modo = MODO_POSICIONAR;
  }

  atualizarVisualizacao();
}
