#include "AvlTravel.h"

pAvl insertAvl(pAvl a, Station * s, int * h){ //insert a station in the AVL
    if(a == NULL){ //place to put the node is find
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

    if(*h != 0){//checks the stability of the AVL
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

pAvl searchAvl(pAvl a, int nb){ // search a station in the AVL

    if(a == NULL){ //if the station is not found
        return NULL;
    }
    else if( a->sta->nb == nb ){ //if the station is found
        return a;
    }
    else if( nb < a->sta->nb){
        return searchAvl(a->leftson, nb);
    }
    else{
        return searchAvl(a->rightson, nb);
    }

}

void infix(FILE * file, pAvl a){ // infix path and place the values in the output file

    if(a != NULL){
        
        infix(file, a->leftson);

        fprintf(file, "%d:%ld:%ld\n",a->sta->nb, a->sta->capacity, a->sta->give);

        infix(file, a->rightson);

    }

}

void freePostfix(pAvl a){ // free all the AVL and always starts by freeing the leaves

    if(a != NULL){

        freePostfix(a->leftson);

        freePostfix(a->rightson);

        free(a->sta);
        free(a);

    }

}