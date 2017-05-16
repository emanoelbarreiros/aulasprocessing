'''
Autor: Emanoel Barreiros, Univesidade de Pernambuco
Este código é uma possível implementação para o desafio 5, proposto em https://github.com/emanoelbarreiros/aulasprocessing como
parte do material de aula da disciplina Programação 1 (introdução à programação) do curso de Licenciatura em Computação da 
Universidade de Pernambuco, Campus Garanhuns

Para salvar a execução do sketch, a qualquer momento pressione a tecla Z do teclado. Pressione Z novamente para parar de salvar.
Utilize a ferramenta Movie Maker no próprio Processing para construir um vídeo a partir das imagens salvas pelo sistema.
'''

largura = 600
linhas = 60
colunas = 60
celulas = [[False for x in range(colunas)] for y in range(linhas)]
celulasTemp = []
direcaoX = 1
direcaoY = 0
elementos = []
xAlimento = -1
yAlimento = -1
salvar = False

def setup():
    global elementos
    size(largura,largura)
    celulas[len(celulas)/2][len(celulas)/2] = True
    celulas[len(celulas)/2 - 1][len(celulas)/2] = True
    celulas[len(celulas)/2 - 2][len(celulas)/2] = True
    elementos.append((len(celulas)/2,len(celulas)/2))
    elementos.append((len(celulas)/2 - 1,len(celulas)/2))
    elementos.append((len(celulas)/2 - 2,len(celulas)/2))
    
def draw():
    global xAlimento
    global yAlimento
    
    # desenha grid
    background(255)
    stroke(200)
    fill(0)
    for i in range(0, largura, largura/colunas):
        line(i, 0, i, height)
        
    for i in range(0, largura, largura/linhas):
        line(0, i, width, i)
        
    for i in range(len(elementos)):
        rect(elementos[i][0]*(largura/colunas), elementos[i][1]*(largura/linhas), largura/colunas, largura/colunas)
        
    #desenhar alimento
    fill(255,0,0)
    rect(xAlimento*(largura/colunas), yAlimento*(largura/linhas), largura/colunas, largura/colunas)
              
    if frameCount % 5 == 0:
        #a logica do movimento eh que a cabeca se move na direcao pra onde o usuario pressionou a tecla
        #e todo o resto se move pra a posicao do elemento anterior na cobra
        anterior = None
        for i in range(len(elementos)):
            if i == 0:#estamos manipulando a cabeca
                anterior = elementos[i]
                if elementos[i][0] + direcaoX < 0:#a cobra quer sair pela borda da esquerda
                    elementos[i] = (colunas, elementos[i][1] + direcaoY)
                elif elementos[i][0] + direcaoX > colunas:#a cobra quer sair pela borda da direita
                    elementos[i] = (0, elementos[i][1] + direcaoY)
                elif elementos[i][1] + direcaoY < 0:#a cobra quer sair pela borda do topo
                    elementos[i] = (elementos[i][0] + direcaoX, linhas)
                elif elementos[i][1] + direcaoY > linhas:#a cobra quer sair pela borda de baixo
                    elementos[i] = (elementos[i][0] + direcaoX, 0)
                else:#condicao normal de operacao
                    if elementos[i][0] + direcaoX == xAlimento and elementos[i][1] + direcaoY == yAlimento:#adicionar elemento na cobra
                        elementos.insert(0, (elementos[i][0] + direcaoX, elementos[i][1] + direcaoY))
                        xAlimento = -1
                        yAlimento = -1
                        break
                    else:
                        elementos[i] = (elementos[i][0] + direcaoX, elementos[i][1] + direcaoY)        
            else:#estamos manipulando o resto do corpo
                antesAlteracao = elementos[i]
                elementos[i] = (anterior[0], anterior[1])
                anterior = antesAlteracao
    
    #criar alimento
    if xAlimento == -1:
        xAlimento = int(random(0,colunas))
        yAlimento = int(random(0,linhas))
        print xAlimento
        print yAlimento
        
    if salvar:
        saveFrame('frames/###########.png')
        
def keyPressed():
    global direcaoX
    global direcaoY
    global salvar

    if keyCode == UP and direcaoY == 0:
        direcaoX = 0
        direcaoY = -1
    if keyCode == DOWN and direcaoY == 0:
        direcaoX = 0
        direcaoY = 1
    if keyCode == LEFT and direcaoX == 0:
        direcaoX = -1
        direcaoY = 0
    if keyCode == RIGHT and direcaoX == 0:
        direcaoX = 1
        direcaoY = 0
    if key == 'z' or key == 'Z':
        salvar = not salvar
    