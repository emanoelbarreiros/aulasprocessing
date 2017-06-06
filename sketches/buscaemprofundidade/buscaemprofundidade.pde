import java.util.ArrayList;
import java.util.List;

int largura = 40;
Grafo grafo;
int vertices = 0;
int MODO_VERTICE = 0;
int MODO_ARESTA = 1;
int MODO_EXECUCAO = 2;
int modoEdicao = MODO_VERTICE;
Vertice verticeOrigem = null;
Vertice verticeDestino = null;
BuscaEmProfundidade bep = null;
boolean rodando = false;

void setup(){
  size(400, 400);
  grafo = new Grafo();
  bep = new BuscaEmProfundidade();
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
    ellipse(v.getX(), v.getY(), largura, largura);
    textSize(18);
    fill(corTexto);
    //pinta texto dentro do vertice
    text(v.getId(), v.getX()-5, v.getY()+6);
    
    //pinta tempo de descoberta
    textSize(12);
    fill(0);
    text(v.getDescoberta(), v.getX() - 5, v.getY() - largura/2 - 5);
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
  
  if(modoEdicao == MODO_EXECUCAO && !rodando) {
    rodando = true;
    bep.setGrafo(grafo);
    bep.start();
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
  
  if (key == 'e' || key == 'E') {
    modoEdicao = MODO_EXECUCAO;
  }
  
  synchronized(bep) {
    if (key == 'p' || key == 'P') {
      bep.notifyAll();
    }
  }
}

class Vertice {
  
  public static final int BRANCO = 0;
  public static final int CINZA = 1;
  public static final int PRETO = 2;
  
  private int x;
  
  private int y;
  
  private int id;
  
  private int cor;
  
  private Vertice predecessor;
  
  private int descoberta;
  
  private int finalizacao;
  
  public Vertice(int id, int x, int y) {
    this.id = id;
    this.x = x;
    this.y = y;
  }

  public int getCor() {
    return cor;
  }

  public void setCor(int cor) {
    this.cor = cor;
  }

  public Vertice getPredecessor() {
    return predecessor;
  }

  public void setPredecessor(Vertice predecessor) {
    this.predecessor = predecessor;
  }

  public int getDescoberta() {
    return descoberta;
  }

  public void setDescoberta(int descoberta) {
    this.descoberta = descoberta;
  }

  public int getFinalizacao() {
    return finalizacao;
  }

  public void setFinalizacao(int finalizacao) {
    this.finalizacao = finalizacao;
  }

  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }
  
  public int getX() {
    return this.x;
  }

  public void setX(int x) {
    this.x = x;
  }
  
  public int getY() {
    return this.y;
  }

  public void setY(int y) {
    this.y = y;
  }

  @Override
  public int hashCode() {
    final int prime = 31;
    int result = 1;
    result = prime * result + id;
    return result;
  }

  @Override
  public boolean equals(Object obj) {
    if (this == obj)
      return true;
    if (obj == null)
      return false;
    if (getClass() != obj.getClass())
      return false;
    Vertice other = (Vertice) obj;
    if (id != other.id)
      return false;
    return true;
  }
  
  public String toString() {
    String idPred = "-";
    if(predecessor != null) {
      idPred = String.valueOf(predecessor.getId());
    }
    
    String sCor = "";
    switch(cor) {
      case Vertice.BRANCO:
        sCor = "B";
        break;
      case Vertice.CINZA:
        sCor = "C";
        break;
      case Vertice.PRETO:
        sCor = "P";
        break;
    }
    
    String retorno = id 
        + "(c:" + sCor 
        + ",p:" + idPred
        + ",d:" + descoberta 
        + ",f:" + finalizacao + ")";
    
    return retorno;
  }

}

class Aresta {
  
  private Vertice origem;
  
  private Vertice destino;

  public Vertice getOrigem() {
    return origem;
  }

  public void setOrigem(Vertice origem) {
    this.origem = origem;
  }

  public Vertice getDestino() {
    return destino;
  }

  public void setDestino(Vertice destino) {
    this.destino = destino;
  }
  
  public String toString() {
    String retorno = "(" + origem.getId() + "," 
        + destino.getId() + ")";
    return retorno;
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

class Grafo {
  
  private List<Vertice> vertices;
  private List<Aresta> arestas;
  
  public Grafo() {
    vertices = new ArrayList<Vertice>();
    arestas = new ArrayList<Aresta>();
  }
  
  public void adicionarVertice(int id, int x, int y) {
    for (Vertice v : vertices) {
      if (v.getId() == id) {
        throw new VerticeException("Vertice já existe: " + id);
      }
    }
    
    vertices.add(new Vertice(id, x, y));
  }
  
  public Vertice obterVertice(int id) {
    Vertice retorno = null;
    for (Vertice v : vertices) {
      if (v.getId() == id) {
        retorno = v;
        break;
      }
    }
    
    return retorno;
  }
  
  public Vertice obterVertice(int x, int y) {
    Vertice retorno = null;
    for (Vertice v : vertices) {
      if (dist(v.getX(), v.getY(), x, y) <= largura/2) {
        retorno = v;
        break;
      }
    }
    
    return retorno;
  }
  
  public void adicionarAresta(int origem, int destino) {
    Vertice vOrigem = obterVertice(origem);
    if (origem < 0 || vOrigem == null) {
      throw new VerticeException("Vertice origem invalido: " + origem);
    }
    
    Vertice vDestino  = obterVertice(destino);
    if (destino < 0 || vDestino == null) {
      throw new VerticeException("Vertice destino invalido: " + destino);
    }
    
    for (Aresta aresta : arestas) {
      if (aresta.getOrigem().getId() == origem && aresta.getDestino().getId() == destino) {
            return;
      }
    }
    
    Aresta a = new Aresta();
    a.setOrigem(vOrigem);
    a.setDestino(vDestino);
    arestas.add(a);
    
  }
  
  public List<Vertice> adjacentes(Vertice vertice) {
    ArrayList<Vertice> adjacentes = new ArrayList<Vertice>();
    
    for(Aresta a : arestas) {
      if(a.getOrigem().equals(vertice) 
          && !adjacentes.contains(a.getDestino())){
        adjacentes.add(a.getDestino());
      }
    }
    
    return adjacentes;
  }

  public List<Vertice> getVertices() {
    return vertices;
  }

  public void setVertices(List<Vertice> vertices) {
    this.vertices = vertices;
  }

  public List<Aresta> getArestas() {
    return arestas;
  }

  public void setArestas(List<Aresta> arestas) {
    this.arestas = arestas;
  }
  
  public String toString(){
    StringBuilder builder = new StringBuilder();
    builder.append("G = { \nV{");
    for (int i = 0; i < vertices.size(); i++) {
      builder.append(vertices.get(i).toString());
      if(i < vertices.size() - 1 ) {
        builder.append(", ");
      }
    }
    
    builder.append("}\n");
    builder.append("A{");
    for (int i = 0; i < arestas.size(); i++) {
      builder.append(arestas.get(i).toString());
      if(i < arestas.size() - 1 ) {
        builder.append(", ");
      }
    }
    builder.append("}\n}");
    
    return builder.toString();
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