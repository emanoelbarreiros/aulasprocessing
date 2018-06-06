//classe que define o que eh o pacman
class Pacman {
    //vetores de localizacao, velocidade e aceleracao do pacman
    PVector localizacao;
    PVector velocidade;
    PVector aceleracao;
    
    int tamanhoCirculo = 0; //diametro do pacman
    float anguloZero = 0; //angulo usado como referencia para a abertura da boca
    
    float anguloMaximo = 0; //angulo maximo de abertura da boca
    float anguloAtual = anguloMaximo; //angulo atual de abertuda da boca; comeca aberta no maximo
    boolean abrindo = true; //variavel que define se a boca esta abrindo ou fechando
    float incrementoAngulo = 0; // o incremento ou decremento da abertura da boca a cada frame
    int velocidadeMaxima;
    
    Pacman(int velocidadeMaxima, int tamanhoCirculo, float anguloMaximo, int xCentro, int yCentro){
        this.velocidadeMaxima = velocidadeMaxima;
        this.anguloMaximo = anguloMaximo;
        this.anguloAtual = anguloMaximo;
        this.incrementoAngulo = anguloMaximo/10; //1/10 da abertura maxima da boca
        this.tamanhoCirculo = tamanhoCirculo;
        //inicializacao dos vetores posicional e de deslocamento
        this.localizacao = new PVector(xCentro, yCentro);
        this.velocidade = new PVector(1, 1);
        this.aceleracao = new PVector(random(-1,1), random(-1,1)); // inicia com um valor aleatorio entre -1 e 1 para ambas as direcoes
        this.aceleracao.normalize();//normaliza para vetores de tamanho 1, mantendo a direcao
    }

    public void atualizar(){
        PVector alvo = new PVector(mouseX, mouseY); //para onde o pacman deve olhar e se mover
        PVector direcao = PVector.sub(alvo, this.localizacao); //calculo da direcao para onde o pacman vai olhar e se mover
    
        direcao.normalize();//#normaliza o vetor para ter tamanho 1, mantendo a sua direcao 
        direcao.mult(5); //depois de normalizar, faco ela ter tamanho 5
        this.aceleracao = direcao; //a aceleracao eh o resultado destas operacoes
        
        //determinando se o pacman ainda deve se mover ou apenas parar se chegou perto do mouse 
        if (PVector.dist(this.localizacao, alvo) > 10) {
            this.velocidade.add(this.aceleracao); //determina o novo valor da velocidade baseado na aceleracao
            this.velocidade.limit(this.velocidadeMaxima); //limita à maxima velocidade permitida
        } else {
            //para o pacman
            this.aceleracao = new PVector(0,0);
            this.velocidade = new PVector(0,0);
        }

        //decidindo se o pacman esta abrindo ou fechando a boca e atualizando
        //o angulo da abertura para cada caso
        if (this.abrindo){
            this.anguloAtual += this.incrementoAngulo;
            if (this.anguloAtual >= this.anguloMaximo){
                this.abrindo = false;
            }
        } else {
            this.anguloAtual -= this.incrementoAngulo;
            if (this.anguloAtual <= 0){
                this.abrindo = true;
            }
        }

        //atualizando a localizacao de acordo com a aceleracao e velocidades calculadas
        this.localizacao.add(this.velocidade);
        
        //determinando para onde o pacman deve olhar
        this.anguloZero = direcao.heading();
    }

    public void pintar(){
        //pintar o arc, que representa o pacman em si
        arc(this.localizacao.x, this.localizacao.y, this.tamanhoCirculo, this.tamanhoCirculo, this.anguloZero + this.anguloAtual/2, 
            this.anguloZero + 2*PI - this.anguloAtual/2);
    }
}
