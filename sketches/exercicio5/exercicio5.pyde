#exercicio 5
#Estenda o programa anterior para que sejam desenhadas quatro linhas, 
#agora ligando o mouse aos quatro cantos da tela.

def setup():
  size(300,300)

def draw():
  background(0)
  stroke(255)
  line(0,0, mouseX, mouseY)
  line(width, 0, mouseX, mouseY)
  line(0, height, mouseX, mouseY)
  line(width, height, mouseX, mouseY)