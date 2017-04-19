#exercicio 4
#Escreva um programa que desenha uma linha na tela, ligando a 
#posição (0,0) da tela com a posição do mouse. Caso o mouse se 
#mova, a linha deve mudar para acompanhar o movimento do mouse. 
#Não deve deixar rastro.
def setup():
  size(300,300)

def draw():
  background(0)
  stroke(255)
  line(0,0, mouseX, mouseY)