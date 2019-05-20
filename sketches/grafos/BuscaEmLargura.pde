class BuscaEmLargura extends Thread {
  private Grafo grafo;
  private Vertice raiz;
  private ArrayList<Vertice> auxiliar;
  
  public void run() {
    raiz = grafo.getVertices().get(0);
    for(Vertice v : grafo.getVertices()){
      if(!v.equals(raiz)){
        v.setDescoberta(Integer.MAX_VALUE);
        v.setPredecessor(null);
        v.setCor(Vertice.BRANCO);
      }
    }
    
    raiz.setCor(Vertice.CINZA);
    raiz.setDescoberta(0);
    raiz.setPredecessor(null);
    
    auxiliar = new ArrayList<Vertice>();
    auxiliar.add(raiz);
    
    Vertice u = null;
    while(auxiliar.size() > 0) {
      synchronized(this){
        try {
          u = auxiliar.remove(0);
              for (Vertice v : grafo.adjacentes(u)) {
                wait();
                if(v.getCor() == Vertice.BRANCO) {
                  v.setCor(Vertice.CINZA);
                  v.setDescoberta(u.getDescoberta() + 1);
                  v.setPredecessor(u);
                  auxiliar.add(v);
                } else {
                  v.setFoco(true);
                  wait();
                  v.setFoco(false);
                }
              }
          wait();
          u.setCor(Vertice.PRETO);
        } catch(Exception e) {
          System.out.println(e.getMessage());
        }
      }
    }
  }
  
  public Grafo getGrafo() {
    return this.grafo;
  }
  
  public void setGrafo(Grafo grafo){
    this.grafo = grafo;
  }
}
