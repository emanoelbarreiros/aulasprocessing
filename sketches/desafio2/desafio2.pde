/*
Autor: Emanoel Barreiros, Univesidade de Pernambuco
Este código é uma possível implementação para o desafio 2, proposto em https://github.com/emanoelbarreiros/aulasprocessing como
parte do material de aula da disciplina Programação 1 (introdução à programação) do curso de Licenciatura em Computação da 
Universidade de Pernambuco, Campus Garanhuns

Para salvar a execução do sketch, a qualquer momento pressione a tecla Z do teclado. Pressione Z novamente para parar de salvar.
Utilize a ferramenta Movie Maker no próprio Processing para construir um vídeo a partir das imagens salvas pelo sistema.

Descrição do desafio: Simule um sistema físico, onde um canhão atira balas e estas fazem uma trajetória curva, 
como seria no mundo real. Use o conceito de aceleração para simular a gravidade. O canhão deve ser fixo na tela, 
mas o angulo do tiro deve ser determinado pela posição do mouse. As balas que são atiradas devem permanecer na tela, 
mas param quando atingem o chão.

Como o programa funciona:
    * Use o mouse para definir a inclinação do canhão
    * Clique com o mouse para atirar
    * A qualquer momento pressione no teclado:
        - Z para iniciar o salvamento dos frames da execução. Ao pressionar Z novamente o programa deixa de salvar os frames.

DICA: Utilize a ferramenta Movie Maker do próprio Processing para fazer um vídeo com as imagens salvas.
*/

int distanciaChao = 50;
PVector localizacaoBala;
float velVBala = 0;
float velHBala = 0;
boolean atirar = false;
PVector[] balas = new PVector[100];
PVector[] velocidades = new PVector[100];
int indice;
int diametroBala = 10;
boolean salvar = false;

void setup(){
    size(700, 400);
}
    
void draw(){
    background(200);
    
    PVector centroCanhao = new PVector(45, height - distanciaChao - 15);
    float gravidade = 0.2;
    float velocidadeLinearBala = 10;
    PVector alvo = new PVector(mouseX, mouseY); //para onde o tanque deve olhar e girar   
    PVector direcao = PVector.sub(alvo, centroCanhao); //calculo da direcao para onde o tanque vai olhar e girar
    
    //desenha o chao
    fill(0);
    rect(0, height - distanciaChao, width, distanciaChao);
    
    //desenha canhao    
    fill(100);
    pushMatrix();
    translate(centroCanhao.x, centroCanhao.y);
    rotate(direcao.heading());
    rect(0, -5, 40, 10);
    popMatrix();
    rect(30, height - distanciaChao - 30, 30, 30);
    
    //atira bala?
    if (atirar){
        float d = 40 * cos(-direcao.heading());
        float c = 40 * sin(-direcao.heading());
        localizacaoBala = new PVector(centroCanhao.x + d, centroCanhao.y - c);
        velHBala = velocidadeLinearBala * cos(direcao.heading());
        velVBala = velocidadeLinearBala * sin(direcao.heading());
        atirar = false;
        
        
        balas[indice] = localizacaoBala;
        velocidades[indice] = new PVector(velHBala, velVBala);
        indice++;
    }

    for (int i = 0; i < indice; i++){            
        if (bateuChao(balas[i], distanciaChao)){
            velocidades[i] = new PVector(0,0);
        } else{
            velocidades[i].y += gravidade;
            balas[i].add(velocidades[i]);
        }
        ellipse(balas[i].x, balas[i].y, diametroBala, diametroBala);
    }
    if (salvar){
        saveFrame("frames/##########.png");
    }
}

void mouseReleased(){
    atirar = true;
}
    
boolean bateuChao(PVector bala, int distanciaChao){
    if (bala.y + diametroBala/2 >= height - distanciaChao){
        return true;
    } else {
        return false;
    }
}

void keyPressed(){
    if (key == 'Z' || key == 'z'){
        salvar = !salvar;
    }
}
    
