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
  
  private boolean foco;
  
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
  
  public boolean getFoco() {
    return this.foco;
  }
  
  public void setFoco(boolean foco){
    this.foco = foco;
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
