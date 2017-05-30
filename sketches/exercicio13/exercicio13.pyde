xBola = []
yBola = []
vx = []
vy = []
raio = 10

def setup():
    size(300,300)
    
def draw():
    global vx, vy, xBola, yBola
    
    for i in range(len(xBola)):
        if xBola[i] >= width - raio:
            vx[i] = -vx[i]
            
        if xBola[i] <= raio:
            vx[i] = -vx[i]
            
        if yBola[i] <= raio:
            vy[i] = -vy[i]
            
        if yBola[i] >= height - raio:
            vy[i] = -vy[i]
        
        xBola[i] = xBola[i] + vx[i]
        yBola[i] = yBola[i] + vy[i]
        
        background(200)
        
        ellipse(xBola[i], yBola[i], 2*raio, 2*raio)
    
def mouseReleased():
    global vx, vy, xBola, yBola
    vx.append(random(-5, 5))
    vy.append(random(-5, 5))
    xBola.append(mouseX)
    yBola.append(mouseY)