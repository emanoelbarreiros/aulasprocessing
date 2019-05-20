import java.util.ArrayList;
import java.util.List;

int raio = 20;
Grafo grafo;
int vertices = 0;
int MODO_VERTICE = 0;
int MODO_ARESTA = 1;
int MODO_EXECUCAO_LARGURA = 2;
int MODO_EXECUCAO_PROFUNDIDADE = 3;
int modoEdicao = MODO_VERTICE;
Vertice verticeOrigem = null;
Vertice verticeDestino = null;
Thread algoritmo = null;
boolean rodando = false;
boolean verticeSelecionado = false;
ArrayList<Widget> widgets;

void setup(){
  size(600, 400);
  grafo = new Grafo();
  widgets = new ArrayList<Widget>();
  //widgets.add(new Botao(20, 20, 50, 20, "Ola mundo")); //<>//
}


void draw() {
  background(200);
  int corTexto = 0;
  
  strokeWeight(1);
  for(Vertice v : grafo.getVertices()) {
    if(v.getCor() == Vertice.BRANCO) {
      fill(255);
      corTexto = 0;
    } else if (v.getCor() == Vertice.CINZA){
      fill(180);
      corTexto = 0;
    } else {
      fill(0);
      corTexto = 255;
    }
    //pinta circulo do vertice
    if (v.getFoco()) {
      strokeWeight(3);
    } else {
      strokeWeight(1);
    }
    ellipse(v.getX(), v.getY(), 2*raio, 2*raio);
    textSize(18);
    fill(corTexto);
    //pinta texto dentro do vertice
    text(v.getId(), v.getX()-5, v.getY()+6);
    
    //pinta tempo de descoberta
    textSize(12);
    fill(0);
    String descoberta;
    if (v.getDescoberta() == Integer.MAX_VALUE){
      descoberta = "inf"; 
    } else {
      descoberta = "" + v.getDescoberta();
    }
    text(descoberta, v.getX() - 5, v.getY() - raio - 5);
    //pinta tempo de finalizacao
    text(v.getFinalizacao(), v.getX() - 5, v.getY() + raio + 15);
    
    //pinta predecessor
    String predecessor = null;
    if (v.getPredecessor() != null){
      predecessor = v.getPredecessor().getId() + "";
    } else {
      predecessor = "*";
    }
    text(predecessor, v.getX() - 30, v.getY() + 5);
  }
  
  strokeWeight(1);
  for(Aresta a : grafo.getArestas()) {
    seta(a.getOrigem().getX(), a.getOrigem().getY(), a.getDestino().getX(), a.getDestino().getY()); 
  }
  
  if((modoEdicao == MODO_EXECUCAO_PROFUNDIDADE || modoEdicao == MODO_EXECUCAO_LARGURA) && !rodando) {
    rodando = true;
    if (modoEdicao == MODO_EXECUCAO_PROFUNDIDADE) {
      BuscaEmProfundidade bf = new BuscaEmProfundidade();
      bf.setGrafo(grafo);
      algoritmo = bf;
    } else if (modoEdicao == MODO_EXECUCAO_LARGURA) {
      BuscaEmLargura bl = new BuscaEmLargura();
      bl.setGrafo(grafo);
      algoritmo = bl;
    }
    algoritmo.start();
  }
  
  for (Widget w : widgets){
    w.desenhar();
  }
}

void seta(int x1, int y1, int x2, int y2) {
  float distancia = dist(x1, y1, x2, y2);
  pushMatrix();
  PVector p2 = new PVector(x2, y2);
  PVector direcao = p2.sub(new PVector(x1, y1));
  translate(x1, y1);
  rotate(direcao.heading());
  line(raio, 0, distancia - raio, 0);
  translate(distancia - raio, 0);
  line(-8, -8, 0, 0);
  line(-8, 8, 0, 0);
  popMatrix();
} 

void setaCurva(int x1, int y1, int x2, int y2) {
  curve(x1, y1, x1, y1, 30, 30, x2, y2);
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -10, -10);
  line(0, 0, 10, -10);
  popMatrix();
}


void mouseReleased(){
  for (Widget w : widgets){
    if (w.click(mouseX, mouseY)){
      return;
    }
  }
  
  if (verticeSelecionado){
    verticeSelecionado = false;
    return;
  }
  
  if(modoEdicao == MODO_VERTICE) {
    grafo.adicionarVertice(vertices++, mouseX, mouseY);
  } else if (modoEdicao == MODO_ARESTA) {
    Vertice v = grafo.obterVertice(mouseX, mouseY);
    if(v != null && verticeOrigem == null) {
      verticeOrigem = v;
      verticeOrigem.setFoco(true);
    } else if (v != null && verticeDestino == null) {
      verticeDestino = v;
      if (!verticeOrigem.equals(verticeDestino)){
        grafo.adicionarAresta(verticeOrigem.getId(), verticeDestino.getId());
        verticeOrigem.setFoco(false);
        verticeOrigem = null;
        verticeDestino = null;
      } else {
        verticeOrigem.setFoco(false);
        verticeOrigem = null;
        verticeDestino = null;
      }
    }
  }
}

void mouseDragged(){
  for (Vertice v : grafo.getVertices()){
    if (dist(v.getX(), v.getY(), mouseX, mouseY) < raio){
      v.setX(mouseX);
      v.setY(mouseY);
      verticeSelecionado = true;
    }
  }
}

void keyPressed(){
  if (key == 'a' || key == 'A'){
    modoEdicao = MODO_ARESTA;
  }
  
  if (key == 'p' || key == 'P') {
    modoEdicao = MODO_EXECUCAO_PROFUNDIDADE;
  }
  
  if (key == 'l' || key == 'L') {
    modoEdicao = MODO_EXECUCAO_LARGURA;
  }
  
  if (algoritmo != null ){
    synchronized(algoritmo) {
      if (key == 'n' || key == 'N') {
        algoritmo.notifyAll();
      }
    }
  }
}
