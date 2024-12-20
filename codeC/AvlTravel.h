#ifndef AVLTRAVEL


    #define AVLTRAVEL
    #include "foncAvl.h"

    pAvl insertAvl(pAvl a, Station * s, int * h);
    pAvl searchAvl(pAvl a, int nb);
    void infix(FILE * file, pAvl a);
    void freePostfix(pAvl a);


#endif