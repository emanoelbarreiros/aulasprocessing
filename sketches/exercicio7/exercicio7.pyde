#exercicio 7
#Faça uma animação do PacMan usando a função arc. Como o 
#PacMan se move é uma decisão sua.
x = 0
anguloMaximo = 2*PI/3 #120 graus
anguloAtual = 0
abrindo = True
anguloZero = 0

def setup():
    size (500, 200)
    
def draw():
    global x
    global anguloAtual
    global abrindo
    
    background(125)
    tamanhoCirculo = 30
    if abrindo:
        anguloAtual += incrementoAngulo
        if anguloAtual >= anguloMaximo:
            abrindo = False
    else:
        anguloAtual -= incrementoAngulo
        if anguloAtual <= 0:
            abrindo = True
            
    arc(x, 100, tamanhoCirculo, tamanhoCirculo, anguloAtual/2, 2*PI - anguloAtual/2)
    
    x += 2