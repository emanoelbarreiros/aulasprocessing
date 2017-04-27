posicaoY = 0
largura = 50
velocidade = 0
aceleracao = 0
elasticidade = 0.8

def setup():
    size(400,400)
    
def draw():
    global posicaoY
    global velocidade
    global aceleracao
    
    background(120) 
    
    if mousePressed and velocidade == 0:
        velocidade = 2
        aceleracao = 0.1
    
    ellipse(width/2, posicaoY, largura, largura)
    velocidade = velocidade + aceleracao
    posicaoY = posicaoY + velocidade
    
    if posicaoY >= height - largura/2:
        velocidade = -(velocidade * elasticidade)
        posicaoY = height - largura/2
    