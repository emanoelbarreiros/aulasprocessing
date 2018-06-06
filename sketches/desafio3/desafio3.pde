
/*
Autor: Emanoel Barreiros, Univesidade de Pernambuco
 Este código é uma possível implementação para o desafio 3, proposto em https://github.com/emanoelbarreiros/aulasprocessing como
 parte do material de aula da disciplina Programação 1 (introdução à programação) do curso de Licenciatura em Computação da 
 Universidade de Pernambuco, Campus Garanhuns
 
 Para salvar a execução do sketch, a qualquer momento pressione a tecla Z do teclado. Pressione Z novamente para parar de salvar.
 Utilize a ferramenta Movie Maker no próprio Processing para construir um vídeo a partir das imagens salvas pelo sistema.
 
 Descrição do desafio: Faça um jogo onde você controle um tanque no centro da tela. Este tanque não deve se mexer, mas 
 seu canhão sim. Ele deve apontar para o mouse. A cada X segundos (você define o X), faça surgir um inimigo em um lugar 
 aleatorio na borda da tela. Este inimigo deve se movimentar em linha reta até você com velocidade constante. Ao clique 
 do mouse seu tanque deve atirar uma bala. Se suas balas disparadas atingirem um inimigo, ele deve desaparecer, assim como 
 sua bala. Se algum inimigo atingir você, todo o jogo acaba.
 
 Como o programa funciona:
 * Use o mouse para definir a direção da arma do tanque
 * Clique no mouse para o tanque atirar
 * A qualquer momento pressione no teclado:
 - S para ativar o modo sniper
 - R para reiniciar a partir do estado inicial
 - Z para iniciar o salvamento dos frames da execução. Ao pressionar Z novamente o programa deixa de salvar os frames.
 
 DICA: Utilize a ferramenta Movie Maker do próprio Processing para fazer um vídeo com as imagens salvas.
 */
import java.util.Arrays;
import processing.sound.*;
import java.lang.reflect.Method;

Tanque tanque;

int indiceBalas = 0;
ArrayList<Inimigo> inimigos = new ArrayList<Inimigo>();
ArrayList<Bala> balas = new ArrayList<Bala>();
int indiceInimigos = 0;
boolean atirar = false;
int velocidadeLinearBala = 7;
Timer timer;
Timer timerRedutor;
int larguraTanque = 30;
int tamanhoBala = 5;
PImage mira;
boolean morreu = false;
boolean sniper = false;
boolean salvar = false;
SoundFile tiro;
SoundFile morte;

void setup() {

  // inicializacao dos parametros globais de tela e pintura
  size(500, 500);

  mira = loadImage("target.png");
  cursor(mira);

  // criacao do objeto que vai armazenar o as informacoes sobre o pacman
  tiro = new SoundFile(this, "tiro.mp3");
  morte = new SoundFile(this, "morte.mp3");
  tanque = new Tanque(width/2, height/2, larguraTanque, tamanhoBala, tiro, morte);

  try {
    timer = new Timer(this, desafio3.class.getMethod("criarInimigo", new Class[]{}), 2);
    timer.iniciar();

    timerRedutor = new Timer(this, desafio3.class.getMethod("reduzirSpawn", new Class[]{}), 5);
    timerRedutor.iniciar();
  } 
  catch(NoSuchMethodException e) {
    println(e.getMessage());
  }
}

void draw() {
  //limpando a tela a cada frame
  if (!morreu) {
    background(120);

    tanque.atualizar();
    tanque.pintar();

    timer.tick();
    timerRedutor.tick();

    //deteccao de colisao entre os inimigos e as balas
    checaColisaoInimigosBalas();

    checaColisaoInimigosTanque(tanque);

    //remover inimigos atingidos por balas
    //inimigos = filter(filtrarInimigosVisiveis, inimigos);
    inimigos = filtrarInimigos();

    //remover balas que sairam da janela
    //balas = filter(filtrarBalasVisiveis, balas);
    balas = filtrarBalas();

    //atualiza a posicao das balas
    for (int i = 0; i < balas.size(); i++) {
      balas.get(i).atualizar();
      balas.get(i).pintar();
    }

    //atualiza a posicao dos inimigos
    for (int i = 0; i < inimigos.size(); i++) {
      inimigos.get(i).atualizar();
      inimigos.get(i).pintar();
    }
  }

  if (salvar) {
    saveFrame("frames/##########.tiff");
  }
}      
void keyPressed() {
  if (key == 'r' || key == 'R') {
    morreu = false;
    inimigos = new ArrayList<Inimigo>();
    balas = new ArrayList<Bala>();
    timer.definirTempoAlarme(2);
  }

  if (key == 's' || key == 'S') {
    tanque.sniper = !tanque.sniper;
  }

  if (key == 'z' || key == 'Z') {
    salvar = !salvar;
  }
}

void reduzirSpawn() {
  timer.reduzirTempoAlarme(0.2);
}

void criarInimigo() {
  int x = 0;
  int y = 0;
  int borda = int(random(4));
  if (borda == 0) { //borda superior
    x = int(random(0, width));
    y = 0;
  } else if (borda == 2) { //borda inferior
    x = int(random(0, width));
    y = height;
  } else if (borda == 1) { //borda direita 
    y = int(random(0, height));
    x = width;
  } else if (borda == 3) { //borda esquerda
    y = int(random(0, height));
    x = 0;
  }

  inimigos.add(new Inimigo(x, y, tanque.localizacao));
}

ArrayList<Bala> filtrarBalas() {
  ArrayList<Bala> novos = new ArrayList<Bala>();
  for (int i = 0; i < balas.size(); i++) {
    if (balas.get(i) != null 
      && balas.get(i).localizacao.x < width 
      && balas.get(i).localizacao.x > 0 
      && balas.get(i).localizacao.y < height 
      && balas.get(i).localizacao.y > 0) {
      novos.add(balas.get(i));
    }
  }
  return novos;
}

ArrayList<Inimigo> filtrarInimigos() {
  ArrayList<Inimigo> novos = new ArrayList<Inimigo>();
  for (int i = 0; i < inimigos.size(); i++) {
    if (inimigos.get(i) != null && !inimigos.get(i).remover) {
      novos.add(inimigos.get(i));
    }
  }

  return novos;
}

void checaColisaoInimigosBalas() {
  for (int i = 0; i < inimigos.size(); i++) {
    for (int j = 0; j < balas.size(); j++) {
      if (inimigos.get(i) != null
        && balas.get(j) != null
        && PVector.dist(inimigos.get(i).localizacao, balas.get(j).localizacao) <= inimigos.get(i).diametro/2 + balas.get(j).diametro/2) {
        inimigos.get(i).remover = true;
      }
    }
  }
}

void checaColisaoInimigosTanque(Tanque tanque) {
  for (int i = 0; i < inimigos.size(); i++) {
    if (inimigos.get(i) != null
      && PVector.dist(inimigos.get(i).localizacao, tanque.localizacao) < tanque.larguraTanque + inimigos.get(i).diametro/2 - 10) {
      morreu = true;
      tanque.morrer();
    }
  }
}


void mouseReleased() {
  if (!morreu) {
    Bala bala = tanque.atirar();
    balas.add(bala);
  }
}
