import java.util.Arrays;

ArrayList<Figura> figuras;
ArrayList<Figura> paraRemover;
int[] linhasRemover;
int qtdCelulasLargura = 10;
int qtdCelulasAltura = 20;
byte[][] celulas = new byte[qtdCelulasAltura][qtdCelulasLargura];//tamanho da janela
int tamanhoCelula = 30;
Figura figuraLivre;
Figura proximaFigura;

final byte MODO_NORMAL = 0;
final byte MODO_POSICIONAR = 1;
final byte MODO_DERROTA = 2;
final byte MODO_REMOVER = 3;
final byte MODO_GAME_OVER = 4;

byte modo = MODO_NORMAL;
byte contFrames = 60;
byte frameRemover = 0;

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
  figuraLivre = new Figura(4,0, escolherCor(), tamanhoCelula, this, false);
  proximaFigura = new Figura(4,0, escolherCor(), tamanhoCelula, this, false);
  figuras.add(figuraLivre);
  atualizarCelulas();
  textSize(25);
}

void draw(){
  if (modo == MODO_NORMAL){
    contFrames = 60;
  } else if (modo == MODO_POSICIONAR){
    contFrames = 1;
  } else if (modo == MODO_REMOVER){
    contFrames = 10;
  } 
  
  if(checaGameOver()){
    modo = MODO_GAME_OVER;
  }

  if(frameCount % contFrames == 0 && modo != MODO_GAME_OVER){
    if (modo == MODO_REMOVER){
      if (frameRemover < 6){//realçar linhas a serem removidas
        for (Figura fig : paraRemover){
          if(frameRemover % 2 == 0){
            fig.realcar(true);
          } else {
            fig.realcar(false);
          }
        }
        frameRemover++;
      } else {//remover linhas completas após a realce
        for (Figura f : paraRemover){
          figuras.remove(f);
        }
        atualizarLinhasRemovidas();
        frameRemover = 0;
        modo = MODO_NORMAL;
      }
    } else {
      if(!figuraLivre.getBloqueada()){
        figuraLivre.moverBaixo();
      } else {
        modo = MODO_NORMAL;
        checaLinhasCompletas();
        if (paraRemover.isEmpty()){
          figuraLivre = proximaFigura;
          proximaFigura = new Figura(4,0, escolherCor(), tamanhoCelula, this, false);
          figuras.add(figuraLivre);
        }
      }
    }
  }
  //pintar todas as figuras
  atualizarVisualizacao();
}

void atualizarLinhasRemovidas(){
  for (int i = 0; i < linhasRemover.length; i++){
    if (linhasRemover[i] == 1){
      for(Figura fig : figuras){
        if(fig.getPosicaoY() < i){
          fig.moverBaixo(1);
        }
      }
    }
  }
}

void atualizarVisualizacao(){
  desenharFundo();
  for(Figura fig : figuras){
    fig.pintar();
  }
  
  pintarProximaFigura();
}

void pintarProximaFigura(){
  int padding = qtdCelulasLargura*tamanhoCelula;
  int centro = padding + (width - padding)/2;
  proximaFigura.pintar(centro - proximaFigura.qtdColunasForma()*tamanhoCelula/2, 50);
  fill(0);
  text("Próxima", 350, 30);
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

boolean checaGameOver(){
  for (Figura f : figuras){
    if(f.getBloqueada() && f.getPosicaoY() == 0){
      return true;
    }
  }
  
  return false;
}

void checaLinhasCompletas(){
  linhasRemover = new int[20];
  for(int i = 0; i < celulas.length; i++){
    if(Arrays.equals(celulas[i], new byte[]{1,1,1,1,1,1,1,1,1,1})){
      linhasRemover[i] = 1;
    }
  }

  paraRemover = new ArrayList<Figura>();
  for(int i = 0; i < linhasRemover.length; i++){
    if(linhasRemover[i] == 1){
      for(Figura fig : figuras){
        if (fig.getPosicaoY() == i){
          paraRemover.add(fig);
        }
      }
    }
  }

  modo = MODO_REMOVER;
}

void adicionarFigura(Figura f){
  figuras.add(f);
}

void removerFigura(Figura f) {
  figuras.remove(f);
}

color escolherCor(){
  return cores[floor(random(cores.length))];
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
