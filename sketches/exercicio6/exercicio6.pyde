# exercicio 6
#Desenhe a figura abaixo usando a chamada à função 
#rect(x, y, largura, altura), sendo invocada exatamente 3 vezes: 
#um quadrado com 9 subquadrados, lembrando um tabuleiro de jogo da velha

def setup():
  size(300,300)
  noFill()

def draw():
  offset = 20
  tamanhoQuadrado = 40
  rect(offset, offset, tamanhoQuadrado*2, tamanhoQuadrado*3)
  rect(offset+tamanhoQuadrado, offset, tamanhoQuadrado*2, tamanhoQuadrado*3)
  rect(offset, offset+tamanhoQuadrado, tamanhoQuadrado*3, tamanhoQuadrado)
  