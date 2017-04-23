# processing.py

este repositório guarda sketches do processing.py, utilizados na disciplina Programação 1, do curso de Licenciatura em Computação da UPE, Campus Garanhuns.

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

# Desafios
1. Faça com que o pacman do Exercício 7 oriente-se em relação ao mouse (olhe para o mouse) e persiga o mouse como seu alvo de movimento. [Código do desafio 1](https://github.com/emanoelbarreiros/aulasprocessing/tree/master/sketches/desafio1 "clique :)")
2. Simule um sistema físico, onde um canhão atira balas e estas fazem uma trajetória curva, como seria no mundo real. Use o conceito de aceleração para simular a gravidade. O canhão deve ser fixo na tela, mas o angulo do tiro deve ser determinado pela posição do mouse. As balas que são atiradas devem permanecer na tela, mas param quando atingem o chão.
3. Faça um jogo onde você controle um tanque no centro da tela. Este tanque não deve se mexer, mas seu canhão sim. Ele deve apontar para o mouse. A cada X segundos (você define o X), faça surgir um inimigo em um lugar aleatorio na borda da tela. Este inimigo deve se movimentar em linha reta até você com velocidade constante. Ao clique do mouse seu tanque deve atirar uma bala. Se suas balas disparadas atingirem um inimigo, ele deve desaparecer, assim como sua bala. Se algum inimigo atingir você, todo o jogo acaba. 
   * BONUS 1: implemente um placar, de forma que cada inimigo morto mais proximo do tanque vale mais pontos, mais distante vale menos pontos. Exiba o placar na tela.
   * BONUS 2: implemente uma barra de vida. Agora, um inimigo apenas não o mata, mas retira uma quantidade de pontos de vida. Quando seus pontos de vida chegam a zero, você morre.
