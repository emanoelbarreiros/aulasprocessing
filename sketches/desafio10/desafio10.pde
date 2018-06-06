import game2dai.*;
import game2dai.entities.*;
import game2dai.entityshapes.*;
import game2dai.entityshapes.ps.*;
import game2dai.fsm.*;
import game2dai.graph.*;
import game2dai.maths.*;
import game2dai.steering.*;
import game2dai.utils.*;
import g4p_controls.*;

int larguraCampo = 880;
int alturaCampo = 480;
World world;
StopWatch sw;
Vehicle mover0;

void setup(){
  size(950,550);
  world = new World(width, height);
  sw = new StopWatch();
  //GButton botao = new GButton(this, width/2, height/2, 100,50);
  
  // Create the mover
  mover0 = new Vehicle(
      new Vector2D(width/2, height/2), // position
      15,                              // collision radius
      new Vector2D(40, 40),            // velocity
      40,                              // maximum speed
      new Vector2D(1, 1),              // heading
      1,                               // mass
      0.5,                             // turning rate
      200                              // max force
  );
  // Start wandering
  mover0.AP().wanderOn().wanderFactors(60, 30, 20);
  // What does this mover look like
  PersonPic view = new PersonPic(this);
  // Show collision and movement hints
  view.showHints(Hints.HINT_COLLISION | Hints.HINT_HEADING | Hints.HINT_VELOCITY);
  // Add the renderer to our MovingEntity
  mover0.renderer(view);
  // Constrain movement
  Domain d = new Domain(0, 0, width, height);
  mover0.worldDomain(d, SBF.REBOUND);
  // Finally we want to add this to our game domain
  world.add(mover0);
  
  //esta linha deve ser a última da funcao setup
  sw.reset();
}

void draw(){
  desenharFundo();
  double elapsedTime = sw.getElapsedTime();
  world.update(elapsedTime);
  // Make the movers constraint area visible
  Domain d = mover0.worldDomain();
  fill(255, 200, 200);
  noStroke();
  rect((float)d.lowX, (float)d.lowY, (float)d.width, (float)d.height);
  world.draw(elapsedTime);
}

void desenharFundo(){
  int padding = 35;
  fill(#27A010);
  stroke(255);
  strokeWeight(3);
  rect(padding, padding, larguraCampo, alturaCampo);
  line(padding+larguraCampo/2, padding, padding+larguraCampo/2, padding+alturaCampo);
  //bolinha central
  fill(255);
  ellipse(width/2, height/2, 10,10);
  //circulo central
  noFill();
  ellipse(width/2, height/2, 150, 150);
  //grande area esquerda
  rect(padding, 115+padding, 150, 250);
  //pequena area esquerda
  rect(padding, 115+padding+75, 50, 100);
  //grande area direita
  rect(width-padding-150, 115+padding, 150, 250);
  //pequena area direita
  rect(width-padding-50, 115+padding+75, 50, 100);
  //corners do escanteio
  arc(padding, padding, 30, 30, 0, HALF_PI);
  arc(width-padding, padding, 30, 30, HALF_PI, PI);
  arc(width-padding, height-padding, 30, 30, PI, PI+HALF_PI);
  arc(padding, height-padding, 30, 30, PI+HALF_PI, TWO_PI);
}
