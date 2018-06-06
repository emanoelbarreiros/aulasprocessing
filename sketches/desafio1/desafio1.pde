Pacman pacman;

void setup(){
    // variaveis usadas para configuracao 
    float anguloMaximo = 2*PI/3; //120 graus
    int tamanhoCirculo = 30;
    int velocidadeMaxima = 2;
    
    // inicializacao dos parametros globais de tela e pintura
    size(500, 500);
    noStroke();
    
    //criacao do objeto que vai armazenar o as informacoes sobre o pacman
    pacman = new Pacman(velocidadeMaxima, tamanhoCirculo, anguloMaximo, width/2, height/2);
}

void draw(){
    //limpando a tela a cada frame
    background(120);
    
    //atualizando a posicao do pacman e mandando ele ser pintado na nova posicao
    pacman.atualizar();
    pacman.pintar();
}
