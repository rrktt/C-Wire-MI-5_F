#ifndef FONCAVL

    #define FONCAVL
    #include <stdio.h>
    #include <stdlib.h>
    #include <unistd.h>
    #include <errno.h>
    #include <string.h>

    typedef struct {

        int nb;
        long int capacity;
        long int give;
    
    }Station;


    typedef struct avl{

        Station * sta;
        struct avl * rightson;
        struct avl * leftson;
        int balance;

    }Avl;

    typedef Avl* pAvl;


    Station * createStation(int nb, long int capa, long int give);
    pAvl createAvl(Station * x);
    int max(int a, int b);
    int min(int a, int b);
    pAvl LeftRota(pAvl a);
    pAvl RightRota(pAvl a);
    pAvl dLeftRota(pAvl a);
    pAvl dRightRota(pAvl a);
    pAvl balAvl(pAvl a);

#endif