'''
Autor: Emanoel Barreiros, Univesidade de Pernambuco
Este código é uma possível implementação para o desafio 4, proposto em https://github.com/emanoelbarreiros/aulasprocessing como
parte do material de aula da disciplina Programação 1 (introdução à programação) do curso de Licenciatura em Computação da 
Universidade de Pernambuco, Campus Garanhuns

Para salvar a execução do sketch, a qualquer momento pressione a tecla Z do teclado. Pressione Z novamente para parar de salvar.
Utilize a ferramenta Movie Maker no próprio Processing para construir um vídeo a partir das imagens salvas pelo sistema.

Descrição do desafio: Implemente o jogo da vida (também conhecido como Conway's Game of Life), criado pelo matemático 
John Conway. O jogo da vida não é um jogo tradicional, pois não há jogador, na realidade está mais para uma simulação, 
pois a cada iteração algumas regras são avaliadas e decide-se o próximo estado do mapa. As regras do jogo podem ser 
encontradas neste link (https://pt.wikipedia.org/wiki/Jogo_da_vida). Um exemplo do jogo da vida implementado pode 
ser encontrado aqui (https://bitstorm.org/gameoflife/). Para mais informações, você também pode assistir esses 
videos aqui (https://www.youtube.com/watch?v=R9Plq-D1gEk) e aqui (https://www.youtube.com/watch?v=E8kUJL04ELA).

Como o programa funciona:
    *Use o mouse para clicar nas células que você deseja popular com indivídios
    * A qualquer momento pressione no teclado:
        - S para iniciar a simulação
        - P para pausar a simulação
        - R para reiniciar a partir do estado inicial (pause antes de reiniciar para um melhor resultado)
        - Z para iniciar o salvamento dos frames da execução. Ao pressionar Z novamente o programa deixa de salvar os frames.

DICA: Utilize a ferramenta Movie Maker do próprio Processing para fazer um vídeo com as imagens salvas.
'''

largura = 600
linhas = 60
colunas = 60
celulas = [[False for x in range(colunas)] for y in range(linhas)]
configuracaoInicial = []
simulando = False
salvar = False

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
        
    if salvar:
        saveFrame('frames/###########.png')
                
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
    global salvar
    
    if key == 's' or key == 'S':
        configuracaoInicial = list(celulas)
        simulando = True
        
    if key == 'p' or key == 'P':
        simulando = False
        
    if key == 'r' or key == 'R':
        simulando = False
        celulas = list(configuracaoInicial)
        
    if key == 'z' or key == 'Z':
        salvar = not salvar