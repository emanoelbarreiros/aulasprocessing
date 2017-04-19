#exercicio 8
#Use a função arc para criar um gráfico de pizza dividido em 3 
#pedaços: um pedaço com 50% da pizza, outro pedaço com 20% da 
#pizza e um terceiro pedaço com os 30% restantes da pizza. Cada 
#pedaço deve ter cores diferentes.

size(300,300)

xCentro = width/2
yCentro = height/2

diametro = 100

fill(255, 0, 0)
arc(xCentro, yCentro, diametro, diametro, 0, PI)

fill(0, 255, 0)
arc(xCentro, yCentro, diametro, diametro, PI, PI+2*PI/5)

fill(0, 0, 255)
arc(xCentro, yCentro, diametro, diametro, PI+2*PI/5, 2*PI)