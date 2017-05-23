xCirculos = []
yCirculos = []
largura = 20

def setup():
    size(300,300)
    
def draw():
    background(200)
        
    for i in range(len(xCirculos)):
        ellipse(xCirculos[i], yCirculos[i], largura, largura)
        
def mouseReleased():
    remover = -1
    if len(xCirculos) > 0:
        for i in range(len(xCirculos)):
            if dist(xCirculos[i], yCirculos[i], mouseX, mouseY) <= largura/2:
                remover = i
        
    if remover >= 0:
        xCirculos.pop(remover)
        yCirculos.pop(remover)
    else:
        xCirculos.append(mouseX)
        yCirculos.append(mouseY)