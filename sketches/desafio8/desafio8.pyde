clicadas = 0
pontosOrigem = []
pontosDestino = []
posicoes = []
velocidades = []
aceleracao = 0.1

def setup():
    
def draw():
    
def mouseReleased():
    if clicadas == 0:
        ponto1x = mouseX
        ponto1y = mouseY
        clicadas += 1
    elif clicadas == 1:
        ponto2x = mouseX
        ponto2y = mouseY
        clicadas += 1
    else:
        bolasX.append(mouseX)
        bolasY.append(mouseY)