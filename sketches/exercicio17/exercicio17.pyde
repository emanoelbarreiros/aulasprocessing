xBola = []
yBola = []
vx = []
vy = []
xComida = []
yComida = []
remover = []
raio = []
raioComida = 5
def setup():
    size(500,500)
    
def draw():
    global vx, vy, xBola, yBola
    
    background(200)
    
    if frameCount % 120 == 0:
        xComida.append(random(0,width))
        yComida.append(random(0,height))
    
    for i in range(len(xBola)):
        if xBola[i] >= width - raio[i] or xBola[i] <= raio[i]:
            vx[i] = -vx[i]
            
        if yBola[i] >= height - raio[i] or yBola[i] <= raio[i]:
            vy[i] = -vy[i]
        
        xBola[i] = constrain(xBola[i] + vx[i], raio[i], width - raio[i])
        yBola[i] = constrain(yBola[i] + vy[i], raio[i], height - raio[i])
        
        remover = []
        for j in range(len(xComida)):
            if dist(xComida[j], yComida[j], xBola[i], yBola[i]) <= raio[i] + raioComida:
                remover.append(j)
                raio[i] += raioComida
                
        for j in range(len(remover)):
            indice = remover.pop()
            xComida.pop(indice)
            yComida.pop(indice)
            
        
    for i in range(len(xComida)):
        fill(0, 255, 0)
        ellipse(xComida[i], yComida[i], 2*raioComida, 2*raioComida)
    
    for i in range(len(xBola)):
        noFill()
        ellipse(xBola[i], yBola[i], 2*raio[i], 2*raio[i])
    
def mouseReleased():
    global vx, vy, xBola, yBola
    vx.append(random(-3, 3))
    vy.append(random(-3, 3))
    xBola.append(mouseX)
    yBola.append(mouseY)
    raio.append(15)