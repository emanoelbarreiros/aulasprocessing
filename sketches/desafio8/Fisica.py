class Fisica2D(object):
    def __init__(self, mi, ativo):
        self.mi = mi
        self.ativo = ativo
        self.objetos = []
        self.paredes = []
        
    def adicionarParede(self,xInicio, yInicio, xFim, yFim):
        self.parede.append(Parede(xInicio, yInicio, xFim, yFim))
                        
    def adicionarObjeto(self, objeto):
        self.objetos.append(objeto)
    
    def tick(self):
        for o in self.objetos:
            o.atualizar()
        
    def checarColisao
    
class Parede(object):
    def __init__(self, x1, y1, x2, y2):
        self.x1 = x1
        self.x2 = x2
        self.y1 = y1
        self.y2 = y2