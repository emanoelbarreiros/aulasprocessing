import java.lang.reflect.Method;
import java.lang.reflect.InvocationTargetException;

class Timer {
  Object objeto;
  Method callback;
  int tempoAlarme = 0;
  long tempoInicial = 0;

  public Timer(Object objeto, Method callback, int tempoAlarme) {
    this.objeto = objeto;
    this.tempoAlarme = tempoAlarme * 1000;
    this.callback = callback;
  }

  void iniciar() {
    this.tempoInicial = millis();
  }

  void definirTempoAlarme(int valor) {
    this.tempoAlarme = valor * 1000;
  }

  void reduzirTempoAlarme(float percentual) {
    this.tempoAlarme *=  1 - percentual;
  }

  void tick() {
    long tempoAtual = millis();
    long tempoDecorrido = tempoAtual - this.tempoInicial;
    if (tempoDecorrido >= this.tempoAlarme) {
      try {
        callback.invoke(objeto, (Object[])null);
      } 
      catch(Exception e) {
        println(e.getMessage());
      }
      this.tempoInicial = tempoAtual;
    }
  }
}
