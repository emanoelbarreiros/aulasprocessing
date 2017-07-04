# processing.py

este repositório guarda sketches do processing.py, utilizados na disciplina Programação 1, do curso de Licenciatura em Computação da UPE, Campus Garanhuns.

Guia de aulas: https://drive.google.com/file/d/0B8qU8zm4IZWkaWMxbnhUTUFOLU0/view?usp=sharing

Todos os scripts são escritos em Python.

# Exercícios

1.	Escreva um programa que desenha um quadrado onde quer que o mouse esteja na tela, centralizado na posição do mouse. O quadrado deve deixar um rastro na tela quando você mover o mouse. [Código do exercício 1](https://github.com/emanoelbarreiros/aulasprocessing/tree/master/sketches/exercicio1 "clique :)")
2.	Altere o código da questão 1 para que ao mover o quadrado, ele não deixe um rastro na tela. [Código do exercício 2](https://github.com/emanoelbarreiros/aulasprocessing/tree/master/sketches/exercicio2 "clique :)")
3.	Escreva um programa que desenha um círculo dentro de um quadrado onde quer que o mouse esteja. Caso o mouse se mova, as figuras devem se mover junto. Não devem deixar rastro. [Código do exercício 3](https://github.com/emanoelbarreiros/aulasprocessing/tree/master/sketches/exercicio3 "clique :)")
4.	Escreva um programa que desenha uma linha na tela, ligando a posição (0,0) da tela com a posição do mouse. Caso o mouse se mova, a linha deve mudar para acompanhar o movimento do mouse. Não deve deixar rastro. [Código do exercício 4](https://github.com/emanoelbarreiros/aulasprocessing/tree/master/sketches/exercicio4 "clique :)")
5.	Estenda o programa anterior para que sejam desenhadas quatro linhas, agora ligando o mouse aos quatro cantos da tela. [Código do exercício 5](https://github.com/emanoelbarreiros/aulasprocessing/tree/master/sketches/exercicio5 "clique :)")
6.	Desenhe um quadrado com 9 subquadrados, lembrando um tabuleiro de jogo da velha, usando a chamada à função rect(x, y, largura, altura), sendo invocada exatamente 3 vezes. [Código do exercício 6](https://github.com/emanoelbarreiros/aulasprocessing/tree/master/sketches/exercicio6 "clique :)")
7.	Faça uma animação do PacMan usando a função arc. Como o PacMan se move é uma decisão sua. [Código do exercício 7](https://github.com/emanoelbarreiros/aulasprocessing/tree/master/sketches/exercicio7 "clique :)")
8.	Use a função arc para criar um gráfico de pizza dividido em 3 pedaços: um pedaço com 50% da pizza, outro pedaço com 20% da pizza e um terceiro pedaço com os 30% restantes da pizza. Cada pedaço deve ter cores diferentes. [Código do exercício 8](https://github.com/emanoelbarreiros/aulasprocessing/tree/master/sketches/exercicio8 "clique :)")
9.	Escreva um programa que realize desenhos simétricos usando elipses. A cada frame, desenhe uma elipse na posição do mouse e a espelhe verticalmente na metade direita da tela. As elipses só devem ser desenhadas quando o mouse for pressionado. [Código do exercício 9](https://github.com/emanoelbarreiros/aulasprocessing/tree/master/sketches/exercicio9 "clique :)")
10. Escreva um programa que simule uma bola caindo e quicando na borda inferior da janela. A bola deve quicar e perder um pouco da energia, de forma que após algumas quicadas, ela para na parte de baixo da tela. OBS: A bola deve iniciar a queda a partir do clique do mouse. Inicie implementando um sistema onde a bola é perfeitamente elástica, ou seja, toda a energia antes do impacto se mantém, mas sua velocidade é invertida após o impacto. Depois disso, implemente um sistema onde após cada impacto a bola perde uma porcentagem da sua energia. Faça a bola cair sempre do ponto mais alto possível da tela.
11. Baseado no código do exercício 10, incremente-o para permitir que (i) ao clicar com o mouse, surja na tela uma bola na posição do mouse e (ii) seja permitido que várias bolas existam ao mesmo tempo com velocidades independentes (não é necessário considerar a colisão entre as bolas). Pesquise sobre listas em Python ([comece por aqui](http://turing.com.br/pydoc/2.7/tutorial/datastructures.html "clique :)")) e tente descobrir como você pode utilizar este conceito no seu programa.
12. Faça um programa que, ao ser executado, crie um círculo em um lugar aleatório da tela e atribua a este círculo uma velocidade também aleatória (aleatória em termos de direção, sentido e intensidade). Tanto no eixo X quanto no eixo Y, a velocidade não deve ser inferior a -5 nem maior que 5. Ao colidir com as bordas, ela deve ser refletida com o mesmo ângulo, como em uma mesa de sinuca. A bola deve continuar se movimentando com velocidade constante enquanto o programa estiver em funcionamento.
13. Baseado no programa do exercício 12, faça com que um novo círculo seja criado a cada clique do mouse. Os círculos devem se mover indefinidamente.
14. Faça um programa que desenhe círculos na tela a cada clique do mouse, mas quando você clicar dentro de um círculo já existente, ele deve ser removido da tela.
15. Faça um programa que simule pingos caindo do topo da janela. Faça com que os pingos sejam adicionados em uma posição aleatória no topo da tela a cada 5 frames. Ao chegar no limite inferior da janela, reposicione aquele pingo no topo da tela, na mesma posicao X. Não perca nenhum pingo, a chuva com o tempo vai ficando cada vez mais "grossa". Inicialmente faça com que os pingos tenham velocidade constante, mas depois adicione o conceito de aceleração de forma a simular a gravidade.
16. Implemente um programa que, ao clicar na tela, ele desenhe um ponto na tela. Após adicionar os pontos que desejar, quando o usuario pressionar uma tecla do teclado (qualquer uma, você escolhe), ele ligue todos os pontos e crie um polígono fechado.
17. Baseado no exercício 13, implemente um programa que a cada 2 segundos (frameCount % 120 == 0) crie um pequeno círculo em um lugar aleatório da tela, simulando um alimento. Quando os círculos maiores (que nesse exercício consideramos como indivíduos) se chocarem com o alimento (nesse momento o alimento é removido). Os indivíduos devem aumentar de raio quando encontrarem alimento.
18. Baseado no exercício 17, incremente o programa para que os indivíduos se desloquem em direção ao alimento mais próximo. Quando não houver alimento disponível o indivíduo fica parado esperando.

# Desafios
1. Faça com que o pacman do Exercício 7 oriente-se em relação ao mouse (olhe para o mouse) e persiga o mouse como seu alvo de movimento. [Código do desafio 1](https://github.com/emanoelbarreiros/aulasprocessing/tree/master/sketches/desafio1 "clique :)")
2. Simule um sistema físico, onde um canhão atira balas e estas fazem uma trajetória curva, como seria no mundo real. Use o conceito de aceleração para simular a gravidade. O canhão deve ser fixo na tela, mas o angulo do tiro deve ser determinado pela posição do mouse. As balas que são atiradas devem permanecer na tela, mas param quando atingem o chão. Vídeo de como fica o projeto depois de pronto: [vídeo](https://youtu.be/XDVuFWP95_Q) [Código fonte aqui](https://github.com/emanoelbarreiros/aulasprocessing/tree/master/sketches/desafio2)
3. Faça um jogo onde você controle um tanque no centro da tela. Este tanque não deve se mexer, mas seu canhão sim. Ele deve apontar para o mouse. A cada X segundos (você define o X), faça surgir um inimigo em um lugar aleatorio na borda da tela. Este inimigo deve se movimentar em linha reta até você com velocidade constante. Ao clique do mouse seu tanque deve atirar uma bala. Se suas balas disparadas atingirem um inimigo, ele deve desaparecer, assim como sua bala. Se algum inimigo atingir você, todo o jogo acaba. Vídeo de como pode ficar o projeto depois de pronto: [video](https://www.youtube.com/watch?v=XDVuFWP95_Q) [Código fonte aqui](https://github.com/emanoelbarreiros/aulasprocessing/tree/master/sketches/desafio3)
   * BONUS 1: implemente um placar, de forma que cada inimigo morto mais proximo do tanque vale mais pontos, mais distante vale menos pontos. Exiba o placar na tela.
   * BONUS 2: implemente uma barra de vida. Agora, um inimigo apenas não o mata, mas retira uma quantidade de pontos de vida. Quando seus pontos de vida chegam a zero, você morre.
4. Implemente o jogo da vida (também conhecido como Conway's Game of Life), criado pelo matemático John Conway. O jogo da vida não é um jogo tradicional, pois não há jogador, na realidade está mais para uma simulação, pois a cada iteração algumas regras são avaliadas e decide-se o próximo estado do mapa. As regras do jogo podem ser encontradas neste [link](https://pt.wikipedia.org/wiki/Jogo_da_vida). Um exemplo do jogo da vida implementado pode ser encontrado [aqui](https://bitstorm.org/gameoflife/). Para mais informações, você também pode assistir esses videos [aqui](https://www.youtube.com/watch?v=R9Plq-D1gEk) e [aqui](https://www.youtube.com/watch?v=E8kUJL04ELA). Exemplo de como ele pode ficar aqui: [vídeo](https://youtu.be/c2lNfb4BxdI) [Código fonte aqui](https://github.com/emanoelbarreiros/aulasprocessing/tree/master/sketches/desafio4)
5. Implemente o famoso joguinho Snake. Exemplo de como ele pode ficar aqui: [vídeo](https://youtu.be/t3OFa5Z9J7I) [Código fonte aqui](https://github.com/emanoelbarreiros/aulasprocessing/tree/master/sketches/desafio5)
6. Implemente um relógio analógico, com ponteiros das horas, minutos e segundos. Use as funções [hour()](https://processing.org/reference/hour_.html), [minute()](https://processing.org/reference/minute_.html) e [second()](https://processing.org/reference/second_.html) para obter os valores de horas, minutos e segundos atuais do sistema, respectivamente. Pinte todos os marcadores de minutos, diferenciando de alguma maneira os marcadores a cada cinco minutos, para ficar mais fácil de ler as horas. Faça o ponteiro dos segundos "ticar" a cada segundo como em um relógio de quartzo. No vídeo parece que o ponteiro dos segundos está bugado, mas é um problema com a captura do vídeo. Executando o código localmente está perfeito.[vídeo](https://youtu.be/tdVnx7T5YCM)
7. Implemente um programa em que, você controla um quadrado preto na tela que simula um carimbo, ou seja, quando você clica na tela, você pinta um quadrado abaixo do carimbo. Mas, o carimbo só pode pintar dentro de uma região delimitada por uma região retangular, cujo centro coincide com o centro da janela, e tem largura e altura correspondentes à metade das largura e altura da janela, respectivamente. [Código fonte aqui](https://github.com/emanoelbarreiros/aulasprocessing/tree/master/sketches/desafio7)
8. Implemente o jogo Centipede, do Atari.
9. Implemente um jogo de futebol de botão.

# Projetos
Criar dois projetos usando o Processing.py, no mesmo nível dos desafios. Um dos projetos vai ser utilizado para uma média aritmética com a nota do 1o EE, e o segundo projeto vai ser a nota do 2o EE. Ambos os projetos devem ser apresentados pelas duplas no dia 18/07/2017.

1. Daniel Sales e José Neto
   * Joguinho da nave, tipo Truxton
   * Breakout
2. Ananda e Hemerson
   * Breakout
   * Asteroids
3. Douglas e Hermyson
   * Pong
   * Flappy bird
4. Ana Cecília e Alexandre
   * Campo minado
   * Pong
5. Victor e Amauri
   * Labirinto
   * Pong
6. Matheus e Alisson
   * Pacman
   * Space invaders
7. Abraão e Jonathan
   * Asteroids
   * Breakout
8. Antônio e Rinaldo
   * A DEFINIR
9. James
   * Cronômetro
   * Tenis