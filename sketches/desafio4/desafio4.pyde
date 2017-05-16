largura = 600
linhas = 60
colunas = 60
celulas = [[False for x in range(colunas)] for y in range(linhas)]
configuracaoInicial = []
simulando = False

def setup():
    size(largura, largura)
    
def draw():
    global celulas
    
    # desenha grid
    background(255)
    stroke(200)
    fill(0)
    for i in range(0, largura, largura/colunas):
        line(i, 0, i, height)
        
    for i in range(0, largura, largura/linhas):
        line(0, i, width, i)
        
    #pinta de branco os quadrados vivos
    for i in range(len(celulas)):
        for j in range(len(celulas[i])):
            if celulas[i][j]:
                rect(i*(largura/colunas), j*(largura/linhas), largura/colunas, largura/colunas)
    
    if frameCount % 5 == 0 and simulando:
        #estrutura temporaria para guardar o novo estado da matrix
        #eh feito assim para que durante a analise o resultado parcial influencie no resultado final
        celulasTemp = [[False for x in range(colunas)] for y in range(linhas)]
        #analisa quais celulas devem morrer, quais devem permanecer e quais devem nascer
        for i in range(len(celulas)):
            for j in range(len(celulas[i])):
                vizinhos = contaVizinhos(i, j)
                if vizinhos < 2 and celulas[i][j]:
                    celulasTemp[i][j] = False
                elif vizinhos < 4 and celulas[i][j]:
                    celulasTemp[i][j] = celulas[i][j]
                elif vizinhos > 4 and celulas[i][j]:
                    celulasTemp[i][j] = False
                elif not celulas[i][j] and vizinhos == 3:
                    celulasTemp[i][j] = True
                    
        celulas = celulasTemp
                
def contaVizinhos(x, y):
    qtdVizinhos = 0
    if x - 1 >= 0 and y - 1 >= 0 and celulas[x - 1][y - 1]:
        qtdVizinhos += 1
        
    if y - 1 >= 0 and celulas[x][y - 1]:
        qtdVizinhos += 1
        
    if y - 1 >= 0 and x + 1 <= len(celulas) - 1 and celulas[x + 1][y - 1]:
        qtdVizinhos += 1
        
    if x + 1 <= len(celulas) - 1 and celulas[x + 1][y]:
        qtdVizinhos += 1
        
    if x + 1 <= len(celulas) - 1 and y + 1 <= len(celulas[x + 1]) - 1 and celulas[x + 1][y + 1]:
        qtdVizinhos += 1
        
    if y + 1 <= len(celulas[x]) - 1 and celulas[x][y + 1]:
        qtdVizinhos += 1
        
    if x - 1 >= 0 and y + 1 <= len(celulas[x - 1]) - 1 and celulas[x - 1][y + 1]:
        qtdVizinhos += 1
        
    if x - 1 >= 0 and celulas[x - 1][y]:
        qtdVizinhos += 1
        
    return qtdVizinhos
        
def mouseReleased():
    indiceX = mouseX / (largura/colunas)
    indiceY = mouseY / (largura/linhas)
    celulas[indiceX][indiceY] = not celulas[indiceX][indiceY]

def keyPressed():
    global simulando
    global configuracaoInicial
    global celulas
    
    if key == 's' or key == 'S':
        configuracaoInicial = list(celulas)
        simulando = True
        
    if key == 'p' or key == 'P':
        simulando = False
        
    if key == 'r' or key == 'R':
        simulando = False
        celulas = list(configuracaoInicial)