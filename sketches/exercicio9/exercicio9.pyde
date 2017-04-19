# exercicio 9
#Escreva um programa que realize desenhos simétricos usando elipses. 
#A cada frame, desenhe uma elipse na posição do mouse e a espelhe 
#verticalmente na metade direita da tela. As elipses só devem ser 
#desenhadas quando o mouse for pressionado.

largura = 500

def setup():
    size(largura, 500)
    
def draw():
    if mousePressed:
        ellipse(mouseX, mouseY, 10, 10)
        ellipse(largura-mouseX, mouseY, 10, 10)