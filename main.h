#include<stdio.h>
#include<stdlib.h>


typedef struct Station{
    int type;
    int identifiant;
    int centrale_parente;
    int capacite;
    int charge;

}Staion;



struct Arbre{
    struct Arbre* fg;
    struct Arbre* fd;    
};

typedef struct Arbre Arbre;
typedef Arbre* pArbre;
