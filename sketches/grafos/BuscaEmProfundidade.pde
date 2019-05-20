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
