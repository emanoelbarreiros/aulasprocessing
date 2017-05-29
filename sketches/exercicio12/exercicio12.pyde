xBola = 0
yBola = 0
vx = 0
vy = 0
raio = 10

def setup():
    global vx
    global vy
    global xBola
    global yBola
    size(300,300)
    vx = random(-5, 5)
    vy = random(-5, 5)
    xBola = width/2
    yBola = height/2
    
def draw():
    global vx
    global vy
    global xBola
    global yBola
    
    if xBola >= width - raio:
        vx = -vx
        
    if xBola <= raio:
        vx = -vx
        
    if yBola <= raio:
        vy = -vy
        
    if yBola >= height - raio:
        vy = -vy
    
    xBola = xBola + vx
    yBola = yBola + vy
    
    background(200)
    
    ellipse(xBola, yBola, 2*raio, 2*raio)
    
    
    
    
    
    
    