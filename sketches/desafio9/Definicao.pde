static class Definicao{
  public static final byte[][][] O = {{{1,1},{1,1}},
                                      {{1,1},{1,1}},
                                      {{1,1},{1,1}},
                                      {{1,1},{1,1}}};

  public static final byte[][][] I = {{{1},{1},{1},{1}},
                                      {{1,1,1,1}},
                                      {{1},{1},{1},{1}},
                                      {{1,1,1,1}}};

  public static final byte[][][] J = {{{0,1},{0,1},{1,1}},
                                      {{1,0,0},{1,1,1}},
                                      {{1,1},{1,0},{1,0}},
                                      {{1,1,1},{0,0,1}}};

  public static final byte[][][] L = {{{1,0},{1,0},{1,1}},
                                      {{1,1,1},{1,0,0}},
                                      {{1,1},{0,1},{0,1}},
                                      {{0,0,1},{1,1,1}}};

  public static final byte[][][] S = {{{1,0},{1,1},{0,1}},
                                      {{0,1,1},{1,1,0}},
                                      {{1,0},{1,1},{0,1}},
                                      {{0,1,1},{1,1,0}}};

  public static final byte[][][] Z = {{{0,1},{1,1},{1,0}},
                                      {{1,1,0},{0,1,1}},
                                      {{0,1},{1,1},{1,0}},
                                      {{1,1,0},{0,1,1}}};

  public static final byte[][][] T = {{{0,1,0},{1,1,1}},
                                      {{1,0},{1,1},{1,0}},
                                      {{1,1,1},{0,1,0}},
                                      {{0,1},{1,1},{0,1}}};

  public static final byte[][][] B = {{{1}},
                                      {{1}},
                                      {{1}},
                                      {{1}}};

  public static final byte FORMA_O = 0;
  public static final byte FORMA_I = 1;
  public static final byte FORMA_J = 2;
  public static final byte FORMA_L = 3;
  public static final byte FORMA_S = 4;
  public static final byte FORMA_Z = 5;
  public static final byte FORMA_T = 6;
  public static final byte FORMA_B = 7;

  /*
  public static final byte ORIENTACAO_N = 0;
  public static final byte ORIENTACAO_S = 1;
  public static final byte ORIENTACAO_L = 2;
  public static final byte ORIENTACAO_O = 3;
  */
  public static final byte ORIENTACAO_N = 0;
  public static final byte ORIENTACAO_L = 1;
  public static final byte ORIENTACAO_S = 2;
  public static final byte ORIENTACAO_O = 3;

  private static int id = 0;

  public static int obterId(){
    return id++;
  }

  public static byte[][] obterMatrizFormato(byte forma, byte orientacao){
    switch(forma){
      case FORMA_O:
        return O[orientacao];
      case FORMA_I:
        return I[orientacao];
      case FORMA_J:
        return J[orientacao];
      case FORMA_L:
        return L[orientacao];
      case FORMA_S:
        return S[orientacao];
      case FORMA_Z:
        return Z[orientacao];
      case FORMA_T:
        return T[orientacao];
      case FORMA_B:
        return B[orientacao];
      default:
        return null;
    }
  }
}
