xBola = []
yBola = []
vx = []
vy = []
xComida = []
yComida = []
remover = []
raio = 15
raioComida = 5
espera = True
def setup():
    size(500,500)
    
def draw():
    global vx, vy, xBola, yBola, espera
    
    background(200)
    
    if frameCount % 60 == 0:
        espera = False
        xComida.append(random(0,width))
        yComida.append(random(0,height))
    
    for i in range(len(xBola)):
        maisProximo = -1
        menorDistancia = float('inf')
            
        for j in range(len(xComida)):
            if dist(xBola[i], yBola[i], xComida[j], yComida[j]) < menorDistancia:
                maisProximo = j
                menorDistancia = dist(xBola[i], yBola[i], xComida[j], yComida[j])
            
        tangente = abs(xComida[maisProximo] - xBola[i])/abs(yComida[maisProximo] - yBola[i])
        if abs(yComida[maisProximo] - yBola[i]) >= abs(xComida[maisProximo] - xBola[i]):
            novovy = constrain(abs(yComida[maisProximo] - yBola[i]),0.1,0.5)
            novovx = tangente*novovy
        else:
            novovx = constrain(abs(xComida[maisProximo] - xBola[i]),0.1,0.5)
            novovy = tangente*novovx
        
        sinalX = sinal(xComida[maisProximo] - xBola[i])
        sinalY = sinal(yComida[maisProximo] - yBola[i])
        vx[i] = novovx * sinalX
        vy[i] = novovy * sinalY
        
        '''    
        if xBola[i] >= width - raio or xBola[i] <= raio:
            vx[i] = -vx[i]
            
        if yBola[i] >= height - raio or yBola[i] <= raio:
            vy[i] = -vy[i]
        '''
        
        xBola[i] = constrain(xBola[i] + vx[i], raio, width - raio)
        yBola[i] = constrain(yBola[i] + vy[i], raio, height - raio)
        
        remover = []
        for j in range(len(xComida)):
            if dist(xComida[j], yComida[j], xBola[i], yBola[i]) <= raio + raioComida:
                remover.append(j)
                
        for j in range(len(remover)):
            indice = remover.pop()
            xComida.pop(indice)
            yComida.pop(indice)
            
        if len(xComida) == 0 and not espera:
            espera = True
            vx[i] = random(-3, 3)
            vy[i] = random(-3, 3)
            vx[i] = 0
            vy[i] = 0
            
        
    for i in range(len(xComida)):
        fill(0, 255, 0)
        ellipse(xComida[i], yComida[i], 2*raioComida, 2*raioComida)
    
    for i in range(len(xBola)):
        noFill()
        ellipse(xBola[i], yBola[i], 2*raio, 2*raio)
        
def sinal(valor):
    if valor < 0:
        return -1
    else:
        return 1
    
def mouseReleased():
    global vx, vy, xBola, yBola
    inspecionar = False
    
    for i in range(len(xBola)):
        if dist(mouseX, mouseY, xBola[i], yBola[i]) <= raio:
            print vx[i], vy[i], xBola[i], yBola[i]
            inspecionar = True
            
    if not inspecionar:
        vx.append(random(-3, 3))
        vy.append(random(-3, 3))
        xBola.append(mouseX)
        yBola.append(mouseY)