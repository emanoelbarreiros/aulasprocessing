distanciaChao = 50
localizacaoBala = None
velVBala = 0
velHBale = 0
atirar = False
balas = []
velocidades = []
diametroBala = 10

def setup():
    size(700, 400)
    
def draw():
    global pintaBala
    global localizacaoBala
    global velHBala
    global velVBala
    global atirar
    
    background(200)
    
    centroCanhao = PVector(45, height - distanciaChao - 15)
    gravidade = 0.2
    velocidadeLinearBala = 10  
    alvo = PVector(mouseX, mouseY) #para onde o tanque deve olhar e girar   
    direcao = PVector.sub(alvo, centroCanhao)#calculo da direcao para onde o tanque vai olhar e girar
    
    #desenha o chao
    fill(0)
    rect(0, height - distanciaChao, width, distanciaChao)
    
    #desenha canhao    
    fill(100)
    pushMatrix()     
    translate(centroCanhao.x, centroCanhao.y)        
    rotate(direcao.heading())
    rect(0, -5, 40, 10)
    popMatrix()    
    rect(30, height - distanciaChao - 30, 30, 30)
    
    #atira bala?
    if atirar:
        d = 40 * cos(-direcao.heading())
        c = 40 * sin(-direcao.heading())
        localizacaoBala = PVector(centroCanhao.x + d, centroCanhao.y - c)
        velHBala = velocidadeLinearBala * cos(direcao.heading())
        velVBala = velocidadeLinearBala * sin(direcao.heading())
        atirar = False
        balas.append(localizacaoBala)
        velocidades.append(PVector(velHBala, velVBala))
        
    for i in range(0, len(balas)):            
        if bateuChao(balas[i], distanciaChao):
            velocidades[i] = PVector(0,0)
        else:
            velocidades[i].y += gravidade        
            balas[i].add(velocidades[i])
        ellipse(balas[i].x, balas[i].y, diametroBala, diametroBala)   
                
def mouseReleased():
    global atirar
    atirar = True
    
def bateuChao(bala, distanciaChao):
    if bala.y + diametroBala/2 >= height - distanciaChao:
        return True
    else:
        return False
    
    