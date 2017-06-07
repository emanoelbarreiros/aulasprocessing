lSuperiorX = 500
lInferiorX = 100
lSuperiorY = 500
lInferiorY = 100
largura = 600
altura = 600
myPixels = [[color(200,200,200) for i in range(largura)] for j in range(altura)]

def setup():
    size(largura,altura)
    

def draw():
    global myPixels
    background(200)
    
    for i in range(len(myPixels)):
        for j in range(len(myPixels[i])):
            set(i,j,myPixels[i][j])

    noFill()
    rectMode(CORNER)
    rect(lInferiorX, lInferiorY, lSuperiorX - lInferiorY, lSuperiorY - lInferiorY)
    
    fill(0)
    rectMode(CENTER)
    rect(mouseX, mouseY, 50, 50)
    
def mouseReleased():
    global myPixels, lInferiorX, lInferiorY, lSuperiorX, lSuperiorY
    for i in range(mouseX-25, mouseX+25,1):
        for j in range(mouseY - 25, mouseY + 25,1):
            if i >= lInferiorX and i <= lSuperiorX and j >= lInferiorY and j <= lSuperiorY:
                myPixels[i][j] = color(0)
                
    