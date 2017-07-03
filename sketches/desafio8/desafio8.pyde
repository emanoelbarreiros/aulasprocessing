from Fisica import *
botaoClicado = None
botoesTime1 = []
botoesTime2 = []
fisica = None

def setup():
    global fisica
    size(600, 400)
    
    fisca = Fisica(0.2, False)
    
    botao = Botao(width/2, height/2, 1)
    botoesTime1.append(botao)
    
    fisica.adicionar
    
def draw():
    
def mousePressed():
    print 'clicou', mouseX, mouseY

def mouseReleased():
    print 'soltou', mouseX, mouseY
    
def mouseDragged():
    print 'arrastou',mouseX, mouseY
        
    
class Botao(object):
    def __init__(self, x, y, cor):
        self.posicao = PVector(x,y)
        self.velocidade = PVector(0,0)
        self.aceleracao = PVector(0,0)
        
        if cor == 1:
            self.cor = Color(0, 0, 255)
        else:
            self.cor = Color(255, 0, 0)
            
            
            
            