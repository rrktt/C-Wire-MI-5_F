#include<stdio.h>
#include<stdlib.h>


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


pAvl AvlCreation(Station s);
int leftSonExists(pAvl a);
int rightSonExists(pAvl a);
pAvl rightRotation(pAvl a);
pAvl leftRotation(pAvl a);
pAvl rightDoubleRotation(pAvl a);
pAvl leftDoubleRotation(pAvl a);
pAvl balance(pAvl a);
pAvl insertion(pAvl a,Station s);
pAvl delMinAvl(pAvl a,int* h,Station* pe );
pAvl delete(pAvl a,Station e,int*h);
int search(pAvl a,int e);
void delete_all(pAvl a);

