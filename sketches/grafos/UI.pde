interface Widget {
  boolean click(int x, int y);
  void desenhar();
}

class Botao implements Widget{
  private int x;
  private int y;
  private int largura;
  private int altura;
  private String texto;
  private ArrayList<Escutador> listeners;
  
  public Botao(int x, int y, int largura, int altura, String texto){
    this.x = x;
    this.y = y;
    this.largura = largura;
    this.altura = altura;
    this.texto = texto;
    this.listeners = new ArrayList<Escutador>();
  }
  
  public boolean click(int x, int y) {
    if (x >= this.x && x <= this.x+this.largura && y >= this.y && y <= this.y+this.altura){
      //click dentro do componente
      for (Escutador e : this.listeners){
        e.executarAcao();
      }
      print("botao clicado");
      return true;
    }
    //nao houve click
    return false;
  }
  
  public void desenhar(){
    fill(180);
    rect(this.x, this.y, this.largura, this.altura);
    fill(0);
    text(this.texto, this.x, this.y, this.largura, this.altura); //<>//
  }
  
  
  public void registrarListener(Escutador escutador){
    this.listeners.add(escutador);
  }
  
  public void setX(int x){
    this.x = x;
  }
  
  public int getX(){
    return this.x;
  }
  
  public void setY(int y){
    this.y = y;
  }
  
  public int getY(){
    return this.y;
  }
  
  public void setLargura(int l){
    this.largura = l;
  }
  
  public int getLargura(){
    return this.largura;
  }
  
  public void setAltura(int a){
    this.altura = a;
  }
  
  public int getAltura(){
    return this.altura;
  }
  
  public void setX(String texto){
    this.texto = texto;
  }
  
  public String getTexto(){
    return this.texto;
  }
}

interface Escutador {
  void executarAcao();
}
