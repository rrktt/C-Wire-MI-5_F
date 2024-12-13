
#ifndef FCTS_AVL_H
    #define FCTS_AVL_H
#endif

typedef struct Station{
    int type;
    int identifiant;
    int centrale_parente;
    int station_hvb_parente;
    int station_hva_parente;
    int capacite;
    int charge;
    int consomateurs_total; 

}Station;



struct Arbre{
    struct Arbre* fg;
    struct Arbre* fd;   
    Station s; 
};

typedef struct Arbre Arbre;
typedef Arbre* pArbre;


pArbre creationAvl(int e);
int recherche(pArbre a,int e);

