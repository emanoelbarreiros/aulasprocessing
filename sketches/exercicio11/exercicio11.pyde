posicaoY = 0
largura = 50
velocidade = 0
aceleracao = 0.1
elasticidade = 0.9

xBolas = []
yBolas = []
velBolas = []
corBolas = []

def setup():
    size(600, 600)
    
def draw():
    global posicaoY
    global velocidade
    global aceleracao
    
    background(120) 

    for i in range(len(xBolas)):
        velBolas[i] = velBolas[i] + aceleracao
        yBolas[i] = yBolas[i] + velBolas[i]
        print 'i=' + str(i) + ': ' + str(xBolas[i]) + ' ' + str(yBolas[i])
        fill(corBolas[i][0], corBolas[i][1], corBolas[i][2])
        ellipse(xBolas[i], yBolas[i], largura, largura)      
    
        if yBolas[i] >= height - largura/2:
            velBolas[i] = -(velBolas[i] * elasticidade)
            yBolas[i] = height - largura/2
            
def mouseReleased():
    xBolas.append(mouseX)
    yBolas.append(mouseY)
    velBolas.append(0)
    corBolas.append((random(0,256), random(0,256), random(0,256)))
    