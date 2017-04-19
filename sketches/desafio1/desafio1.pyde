pacman = None
largura = 500
altura = 500

def setup():
    # global eh necessario para acessar a variavel chamada pacman de escopo global
    global pacman
    
    # variaveis usadas para configuracao 
    anguloMaximo = 2*PI/3 #120 graus
    tamanhoCirculo = 30
    velocidadeMaxima = 2
    
    # inicializacao dos parametros globais de tela e pintura
    size(largura, altura)
    noStroke()
    
    #criacao do objeto que vai armazenar o as informacoes sobre o pacman
    pacman = PacMan(velocidadeMaxima, tamanhoCirculo, anguloMaximo, largura/2, altura/2)


def draw():
    global pacman
    
    #limpando a tela a cada frame
    background(120)
    
    #atualizando a posicao do pacman e mandando ele ser pintado na nova posicao
    pacman.atualizar()
    pacman.pintar()
    
#classe que define o que eh o pacman
class PacMan(object):
    # vetores de localizacao, velocidade e aceleracao do pacman
    localizacao = None
    velocidade = None
    aceleracao = None
    
    tamanhoCirculo = 0 #diametro do pacman
    anguloZero = 0 #angulo usado como referencia para a abertura da boca
    
    anguloMaximo = 0 #angulo maximo de abertura da boca
    anguloAtual = anguloMaximo #angulo atual de abertuda da boca; comeca aberta no maximo
    abrindo = True #variavel que define se a boca esta abrindo ou fechando
    incrementoAngulo = 0 # o incremento ou decremento da abertura da boca a cada frame
    
    
    def __init__(self, velocidadeMaxima, tamanhoCirculo, anguloMaximo, xCentro, yCentro):
        self.velocidadeMaxima = velocidadeMaxima
        self.anguloMaximo = anguloMaximo
        self.anguloAtual = anguloMaximo
        self.incrementoAngulo = anguloMaximo/10 #1/10 da abertura maxima da boca
        self.tamanhoCirculo = tamanhoCirculo
        #inicializacao dos vetores posicional e de deslocamento
        self.localizacao = PVector(xCentro, yCentro)
        self.velocidade = PVector(1, 1)
        self.aceleracao = PVector(random(-1,1), random(-1,1)) # inicia com um valor aleatorio entre -1 e 1 para ambas as direcoes
        self.aceleracao.normalize() #normaliza para vetores de tamanho 1, mantendo a direcao
    
    def atualizar(self):
        alvo = PVector(mouseX, mouseY) #para onde o pacman deve olhar e se mover
        direcao = PVector.sub(alvo, self.localizacao)#calculo da direcao para onde o pacman vai olhar e se mover
    
        direcao.normalize() #normaliza o vetor para ter tamanho 1, mantendo a sua direcao 
        direcao.mult(5) #depois de normalizar, faco ela ter tamanho 5
        self.aceleracao = direcao #a aceleracao eh o resultado destas operacoes
        
        #determinando se o pacman ainda deve se mover ou apenas parar se chegou perto do mouse 
        if PVector.dist(self.localizacao, alvo) > 10:
            self.velocidade.add(self.aceleracao) #determina o novo valor da velocidade baseado na aceleracao
            self.velocidade.limit(self.velocidadeMaxima) #limita à maxima velocidade permitida
        else:
            #para o pacman
            self.aceleracao = PVector(0,0)
            self.velocidade = PVector(0,0)
            
        #decidindo se o pacman esta abrindo ou fechando a boca e atualizando
        #o angulo da abertura para cada caso
        if self.abrindo:
            self.anguloAtual += self.incrementoAngulo
            if self.anguloAtual >= self.anguloMaximo:
                self.abrindo = False
        else:
            self.anguloAtual -= self.incrementoAngulo
            if self.anguloAtual <= 0:
                self.abrindo = True
        
        #atualizando a localizacao de acordo com a aceleracao e velocidades calculadas
        self.localizacao.add(self.velocidade)
        
        #determinando para onde o pacman deve olhar
        self.anguloZero = direcao.heading()
        
    def pintar(self):
        #pintar o arc, que representa o pacman em si
        arc(self.localizacao.x, self.localizacao.y, self.tamanhoCirculo, self.tamanhoCirculo, self.anguloZero + self.anguloAtual/2, 
            self.anguloZero + 2*PI - self.anguloAtual/2)