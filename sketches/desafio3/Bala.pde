class Bala{
    PVector localizacao;
    PVector velocidade;
    boolean remover = false;
    int diametro = 0;
    
    public Bala(float xCentro, float yCentro, float velocidadeX, float velocidadeY, int diametro){
        this.localizacao = new PVector(xCentro, yCentro);
        this.velocidade = new PVector(velocidadeX, velocidadeY);
        this.diametro = diametro;
    }
        
    void atualizar(){
        this.localizacao.add(this.velocidade);
    }
        
    void pintar(){
        strokeWeight(4);
        stroke(255, 255, 0);
        ellipse(this.localizacao.x, this.localizacao.y, this.diametro, this.diametro);
    }
  }
