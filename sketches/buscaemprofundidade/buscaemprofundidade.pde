import java.util.ArrayList;
import java.util.List;

int largura = 40;
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

void setup(){
  size(600, 400);
  grafo = new Grafo();
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
    ellipse(v.getX(), v.getY(), largura, largura);
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
    text(descoberta, v.getX() - 5, v.getY() - largura/2 - 5);
    //pinta tempo de finalizacao
    text(v.getFinalizacao(), v.getX() - 5, v.getY() + largura/2 + 15);
    
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
}

void seta(int x1, int y1, int x2, int y2) {
  float distancia = dist(x1, y1, x2, y2);
  pushMatrix();
  PVector p2 = new PVector(x2, y2);
  PVector direcao = p2.sub(new PVector(x1, y1));
  translate(x1, y1);
  rotate(direcao.heading());
  line(largura/2, 0, distancia - largura/2, 0);
  translate(distancia - largura/2, 0);
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
  if(modoEdicao == MODO_VERTICE) {
    grafo.adicionarVertice(vertices++, mouseX, mouseY);
  } else if (modoEdicao == MODO_ARESTA) {
    Vertice v = grafo.obterVertice(mouseX, mouseY);
    if(v != null && verticeOrigem == null) {
      verticeOrigem = v;
    } else if (v != null && verticeDestino == null) {
      verticeDestino = v;
      grafo.adicionarAresta(verticeOrigem.getId(), verticeDestino.getId());
      verticeOrigem = null;
      verticeDestino = null;
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





class ArestaException extends RuntimeException {
  
  public ArestaException(String mensagem) {
    super(mensagem);
  }

}

class VerticeException extends RuntimeException{

  public VerticeException(String mensagem) {
    super(mensagem);
  }
  
}



class BuscaEmProfundidade extends Thread {
  
  private int tempo = 0;
  private Grafo grafo;
  
  public void run(){
    try {
      tempo = 0;
      
      for (Vertice v : grafo.getVertices()) {
        v.setCor(Vertice.BRANCO);
        v.setPredecessor(null);
      }
      
      for (Vertice v : grafo.getVertices()) {
        if(v.getCor() == Vertice.BRANCO) {
          visitar(grafo, v);
        }
      }
    } catch (InterruptedException e) {
      System.out.println("Deu pau:" + e.getMessage());
    }
    
  }
  
  public void visitar(Grafo grafo, Vertice vertice) throws InterruptedException {
    tempo++;
    vertice.setDescoberta(tempo);
    vertice.setCor(Vertice.CINZA);
    synchronized(this){
      wait();
    }
    for (Vertice v : grafo.adjacentes(vertice)) {
      if (v.getCor() == Vertice.BRANCO) {
        v.setPredecessor(vertice);
        visitar(grafo, v);
      }
    }
    
    synchronized(this){
      vertice.setCor(Vertice.PRETO);
      vertice.setFinalizacao(++tempo);
      wait();
    }
  }
  
  public Grafo getGrafo() {
    return this.grafo;
  }
  
  public void setGrafo(Grafo grafo){
    this.grafo = grafo;
  }

}
