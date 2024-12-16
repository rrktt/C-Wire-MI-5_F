#include "AvlTravel.h"

pAvl insertAvl(pAvl a, Station * s, int * h){
    if(a == NULL){
        *h = 1;
        return createAvl(s);
    }
    else if (s->nb < a->sta->nb){
        a->leftson = insertAvl(a->leftson, s, h);
        *h = -(*h);
    }
    else if (s->nb > a->sta->nb){
        a->rightson = insertAvl(a->rightson, s , h);
    }
    else{
        *h=0;
        return a;
    }

    if(*h != 0){
        a->balance = a->balance + *h;
        a = balAvl(a);
        if(a->balance == 0){
            *h = 0;
        }
        else{
            *h = 1;
        }
    }
    return a;

}

pAvl searchAvl(pAvl a, int nb){

    if(a == NULL){
        return NULL;
    }
    else if( a->sta->nb == nb ){
        return a;
    }
    else if( nb < a->sta->nb){
        return searchAvl(a->leftson, nb);
    }
    else{
        return searchAvl(a->rightson, nb);
    }

}

void infix(FILE * file, pAvl a){

    if(a != NULL){
        
        infix(file, a->leftson);

        fprintf(file, "%d:%ld:%ld\n",a->sta->nb, a->sta->capacity, a->sta->give);

        infix(file, a->rightson);

    }

}

void freePostfix(pAvl a){

    if(a != NULL){

        freePostfix(a->leftson);

        freePostfix(a->rightson);

        free(a->sta);
        free(a);

    }

}