s = second()
m = minute()
h = hour()
#h = 23
#m = 59
#s = 0
anguloHoras = 0
anguloMinutos = 0
anguloSegundos = 0
sAnterior = s-1
sAtual = s
salvar = False

def setup():
    global anguloHoras
    global anguloSegundos
    global anguloMinutos
    size(300,300)
    anguloHoras = h*30.0 + (m/60.0)*30.0 + (s/360.0)*30.0
    anguloMinutos = m*6.0 + (s/60.0)*6.0
    anguloSegundos = s * 6.0
    
def draw():
    global anguloSegundos
    global anguloMinutos
    global anguloHoras
    global sAnterior
    global sAtual
    global salvar
    
    fill(200)
    translate(width/2, height/2)
    strokeWeight(4)
    stroke(0)
    ellipse(0, 0, 200, 200)
    #desenha o relogio
    pushMatrix()
    for i in range(60):
        if i % 5 == 0:
            strokeWeight(2)
        else:
            strokeWeight(1)
        line(90, 0, 99, 0)
        rotate(radians(6))
    popMatrix()    
    
    #seta os ponteiros
    sAtual = second()
    if sAtual != sAnterior:#virou o segundo
        sAnterior = sAtual
        anguloSegundos += 6.0
        anguloMinutos += 0.1
        anguloHoras += 0.001666667
        '''s += 1
        if s == 60:
            s = 0
            m += 1
        if m == 60:
            m = 0
            h += 1
        if h == 24:
            h = 0
            '''
    print anguloHoras
    pushMatrix()
    rotate(-HALF_PI)
    rotate(radians(anguloHoras))
    strokeWeight(3)
    line(0, 0, 40, 0)
    popMatrix()
    
    pushMatrix()
    rotate(-HALF_PI)
    rotate(radians(anguloMinutos))
    line(0, 0, 80, 0)
    popMatrix()
    
    pushMatrix()
    rotate(-HALF_PI)
    strokeWeight(1)
    stroke(255, 0, 0)
    rotate(radians(anguloSegundos))
    stroke(255, 0, 0)
    fill(255,0,0)
    ellipse(0, 0, 5, 5)
    line(0, 0, 85, 0)
    popMatrix()
    
    if salvar:
        saveFrame('frames/#########.png')
    
def keyPressed():
    global salvar
    if key == 's' or key == 'S':
        salvar = not salvar
    