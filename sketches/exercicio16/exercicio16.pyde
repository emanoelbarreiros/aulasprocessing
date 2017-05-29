xPontos = []
yPontos = []
fazerPoligono = False

def setup():
    size(300,300)
    
def draw():
    fill(0)
    strokeWeight(1)
    for i in range(len(xPontos)):
        point(xPontos[i], yPontos[i])
        
    if fazerPoligono:
        for i in range(len(xPontos) - 1):
            line(xPontos[i], yPontos[i], xPontos[i+1], yPontos[i+1])
        
        line(xPontos[0], yPontos[0], xPontos[-1], yPontos[-1])
    
def mouseReleased():
    xPontos.append(mouseX)
    yPontos.append(mouseY)
    
def keyPressed():
    global fazerPoligono
    if key == 'd' or key == 'D':
        fazerPoligono = True