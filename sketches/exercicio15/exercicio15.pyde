xPingos = []
yPingos = []
largura = 300
altura = 300
velocidades = []
aceleracao = 0.2

def setup():
    size(largura, altura)
    
def draw():
    background(200)
    if frameCount % 5 == 0:
        xPingos.append(random(0, largura))
        yPingos.append(0)
        velocidades.append(3)
        
    for i in range(len(xPingos)):
        line(xPingos[i], yPingos[i], xPingos[i], yPingos[i] - 4)
        if yPingos[i] >= altura:
            yPingos[i] = 0
            velocidades[i] = 3
        else:
            velocidades[i] = velocidades[i] + aceleracao
            yPingos[i] = yPingos[i] + velocidades[i]
        