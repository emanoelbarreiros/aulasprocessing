'''
Autor: Emanoel Barreiros, Univesidade de Pernambuco
Este código é uma possível implementação para o desafio 3, proposto em https://github.com/emanoelbarreiros/aulasprocessing como
parte do material de aula da disciplina Programação 1 (introdução à programação) do curso de Licenciatura em Computação da 
Universidade de Pernambuco, Campus Garanhuns

Para salvar a execução do sketch, a qualquer momento pressione a tecla Z do teclado. Pressione Z novamente para parar de salvar.
Utilize a ferramenta Movie Maker no próprio Processing para construir um vídeo a partir das imagens salvas pelo sistema.

Descrição do desafio: Faça um jogo onde você controle um tanque no centro da tela. Este tanque não deve se mexer, mas 
seu canhão sim. Ele deve apontar para o mouse. A cada X segundos (você define o X), faça surgir um inimigo em um lugar 
aleatorio na borda da tela. Este inimigo deve se movimentar em linha reta até você com velocidade constante. Ao clique 
do mouse seu tanque deve atirar uma bala. Se suas balas disparadas atingirem um inimigo, ele deve desaparecer, assim como 
sua bala. Se algum inimigo atingir você, todo o jogo acaba.

Como o programa funciona:
    * Use o mouse para definir a direção da arma do tanque
    * Clique no mouse para o tanque atirar
    * A qualquer momento pressione no teclado:
        - S para ativar o modo sniper
        - R para reiniciar a partir do estado inicial
        - Z para iniciar o salvamento dos frames da execução. Ao pressionar Z novamente o programa deixa de salvar os frames.

DICA: Utilize a ferramenta Movie Maker do próprio Processing para fazer um vídeo com as imagens salvas.
'''

add_library('sound')

tanque = None
balas = []
inimigos = []
largura = 500
altura = 500
atirar = False
velocidadeLinearBala = 7
timer = None
timerRedutor = None
larguraTanque = 30
tiro = None
tamanhoBala = 5
mira = None
morreu = False
sniper = False
salvar = False

def setup():
    # global eh necessario para acessar a variavel chamada pacman de escopo global
    global tanque
    global timer
    global timerRedutor
    
    # inicializacao dos parametros globais de tela e pintura
    size(largura, altura)
    
    mira = loadImage('target.png')
    cursor(mira)
    
    #criacao do objeto que vai armazenar o as informacoes sobre o pacman
    tanque = Tanque(largura/2, altura/2, larguraTanque, tamanhoBala)
    
    timer = Timer(criarInimigo, 2)
    timer.iniciar()
    
    timerRedutor = Timer(reduzirSpawn, 5)
    timerRedutor.iniciar()

def draw():
    global tanque
    global balas
    global timer
    global inimigos
    
    #limpando a tela a cada frame
    if not morreu:
        background(120)
        
        tanque.atualizar()
        tanque.pintar()
        
        timer.tick()
        timerRedutor.tick()
        
        #bolar como fazer a deteccao de colisao entre os inimigos e as balas
        checaColisaoInimigosBalas(inimigos, balas)
        
        checaColisaoInimigosTanque(inimigos, tanque)
        
        #remover inimigos atingidos por balas
        inimigos = filter(filtrarInimigosVisiveis, inimigos)
        #remover balas que sairam da janela
        balas = filter(filtrarBalasVisiveis, balas)
        
        #atualiza a posicao das balas
        for i in range(len(balas)):
            balas[i].atualizar()
            balas[i].pintar()
        
        #atualiza a posicao dos inimigos
        for i in range(len(inimigos)):
            inimigos[i].atualizar()
            inimigos[i].pintar()
            
    if salvar:
        saveFrame('frames/##########.tiff')
            
def keyPressed():
    global morreu
    global inimigos
    global balas
    global timer
    global salvar
    
    if key == 'r' or key == 'R':
        morreu = False
        inimigos = []
        balas = []
        timer.definirTempoAlarme(2)
    if key == 's' or key == 'S':
        tanque.sniper = not tanque.sniper
    if key == 'z' or key == 'Z':
        salvar = not salvar
        
def reduzirSpawn():
    global timer
    timer.reduzirTempoAlarme(0.2)

def criarInimigo():
    global tanque
    borda = int(random(4))    
    if borda == 0 :#borda superior
        x = int(random(0, width))
        y = 0
    elif borda == 2 :#borda inferior
        x = int(random(0, width))
        y = height        
    elif borda == 1: #borda direita 
        y = int(random(0, height))
        x = width
    elif borda == 3: #borda esquerda
        y = int(random(0, height))
        x = 0
    inimigo = Inimigo(x, y, tanque.localizacao)
    inimigos.append(inimigo)
            
def filtrarBalasVisiveis(bala):
    return bala.localizacao.x < width and bala.localizacao.x > 0 and bala.localizacao.y < height and bala.localizacao.y > 0

def filtrarInimigosVisiveis(inimigo):
    return not inimigo.remover

def checaColisaoInimigosBalas(inimigos, balas):
    for i in range(len(inimigos)):
        for j in range(len(balas)):
            if PVector.dist(inimigos[i].localizacao, balas[j].localizacao) <= inimigos[i].diametro/2 + balas[j].diametro/2:
                inimigos[i].remover = True
                
def checaColisaoInimigosTanque(inimigos, tanque):
    global morreu
    for i in range(len(inimigos)):
        if PVector.dist(inimigos[i].localizacao, tanque.localizacao) < tanque.larguraTanque + inimigos[i].diametro/2 - 10:
            morreu = True
            tanque.morrer()
            
            
def mouseReleased():
    if not morreu:
        bala = tanque.atirar()
        balas.append(bala)
    
class Inimigo(object):
    localizacao = None
    velocidade = None
    velocidadeLinearInimigo = 1
    diametro = 20
    remover = False
    
    def __init__(self, xCentro, yCentro, alvo):
        self.localizacao = PVector(xCentro, yCentro)
        
        direcao = PVector.sub(alvo, self.localizacao)
        
        d = 30 * cos(direcao.heading())
        c = 30 * sin(direcao.heading())         
        velH = self.velocidadeLinearInimigo * cos(direcao.heading())
        velV = self.velocidadeLinearInimigo * sin(direcao.heading())
        self.velocidade = PVector(velH, velV)      
        
    def atualizar(self):
        self.localizacao.add(self.velocidade)
        
    def pintar(self):
        noStroke()
        fill(255, 0, 0)
        ellipse(self.localizacao.x, self.localizacao.y, self.diametro, self.diametro)
    
class Bala(object):
    localizacao = None
    velocidade = None
    remover = False
    diametro = 0
    
    def __init__(self, xCentro, yCentro, velocidadeX, velocidadeY, diametro):
        self.localizacao = PVector(xCentro, yCentro)
        self.velocidade = PVector(velocidadeX, velocidadeY)
        self.diametro = diametro
        
    def atualizar(self):
        self.localizacao.add(self.velocidade)
        
    def pintar(self):
        strokeWeight(4)
        stroke(255, 255, 0)
        ellipse(self.localizacao.x, self.localizacao.y, self.diametro, self.diametro)
        
    
class Tanque(object):
    anguloZero = 0
    localizacao = None
    larguraTanque = 0
    direcao = None
    tiro = None
    morte = None
    tamanhoBala = 0
    sniper = False
    
    
    def __init__(self, xCentro, yCentro, larguraTanque, tamanhoBala):
        self.localizacao = PVector(xCentro, yCentro)
        self.larguraTanque = larguraTanque
        #carregar arquivo de audio da pasta /data do sketch
        self.tiro = SoundFile(this, 'tiro.mp3')
        self.morte = SoundFile(this, 'morte.mp3')
        self.tamanhoBala = tamanhoBala
        
        
    def atualizar(self):
        alvo = PVector(mouseX, mouseY) #para onde o tanque deve olhar e girar
        self.direcao = PVector.sub(alvo, self.localizacao)#calculo da direcao para onde o tanque vai olhar e girar
        self.anguloZero = self.direcao.heading()
        
    def pintar(self):
        pushMatrix()
        translate(self.localizacao.x, self.localizacao.y)
        rotate(self.anguloZero)
        rectMode(CENTER)
        if self.sniper:
            strokeWeight(1)
            stroke(200)
            line(0,0,height,0)
        strokeWeight(4)
        stroke(0,0,0)
        fill(255)
        rect(0, 0, self.larguraTanque, self.larguraTanque)
        line(0, 0, 30, 0)
        popMatrix()
        
    def atirar(self):
        d = 30 * cos(-self.direcao.heading())
        c = 30 * sin(-self.direcao.heading())         
        velHBala = velocidadeLinearBala * cos(self.direcao.heading())
        velVBala = velocidadeLinearBala * sin(self.direcao.heading())
        bala = Bala(self.localizacao.x + d, self.localizacao.y - c, velHBala, velVBala, self.tamanhoBala)
        self.tiro.play()
        return bala
    
    def morrer(self):
        self.morte.play()

class Timer(object):
    callback = None
    tempoAlarme = 0
    tempoInicial = 0
    
    def __init__(self, callback, tempoAlarme):
        self.tempoAlarme = tempoAlarme * 1000
        self.callback = callback
        
    def iniciar(self):
        self.tempoInicial = millis()
        
    def definirTempoAlarme(self, valor):
        self.tempoAlarme = valor * 1000
        
    def reduzirTempoAlarme(self, percentual):
        self.tempoAlarme *=  1 - percentual
        
    def tick(self):
        tempoAtual = millis()
        tempoDecorrido = tempoAtual - self.tempoInicial
        if tempoDecorrido >= self.tempoAlarme:
            self.callback()
            self.tempoInicial = tempoAtual