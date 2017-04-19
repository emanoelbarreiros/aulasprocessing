#exercicio 2
#Altere o código da questão 1 para que ao mover o quadrado, ele não deixe um rastro na tela.
def setup():
  size(300,300)

def draw():
  background(0)
  tamanhoLado = 30
  rect(mouseX-tamanhoLado/2, mouseY - tamanhoLado/2, tamanhoLado, tamanhoLado)