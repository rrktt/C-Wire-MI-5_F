#include<stdio.h>
#include<stdlib.h>
#ifndef MAIN_H
    #define MAIN_H
    #include "main.h"




typedef struct Station{
   int power_plant;
   int hvb_station;
   int hva_station;
   int lv_station;
   int company;
   int individual;
   int capacity; 
   int load;
   int id; 
   int type;
   int consumers;

}Station;



struct Arbre{
    struct Arbre* fg;
    struct Arbre* fd;   
    Station s; 
};

typedef struct Arbre Arbre;
typedef Arbre* pArbre;

#endif
