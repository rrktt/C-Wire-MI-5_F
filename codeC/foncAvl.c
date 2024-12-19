#include "foncAvl.h"


Station * createStation(int nb, long int capa, long int give){ //create a station

    Station * stat = malloc(sizeof(Station)); //allocation 

    if(stat == NULL){ //verification
        exit(2);
    }

    //give the values
    stat->nb = nb;
    stat->capacity = capa;
    stat->give = give;

    return stat;

}


pAvl createAvl(Station * x){ //create AVL node
    
    pAvl pa = malloc(sizeof(Avl));//allocation 

    if(pa == NULL){//verification
        exit(1);
    }

    //give the values
    pa->sta = x;
    pa->rightson = NULL;
    pa->leftson = NULL;
    pa->balance = 0;

    return pa;

}

int max(int a, int b){ // give the max between a and b
    if(a>=b){
        return a;
    }
    else{
        return b;
    }
}

int min(int a, int b){// give the min between a and b

    if(a<b){
        return a;
    }

    else{
        return b;
    }

}

pAvl LeftRota(pAvl a){ // A left rotation for a ALV

    pAvl piv = a->rightson;
    int eq_a, eq_p;


    a->rightson = piv->leftson;

    piv->leftson = a;

    eq_a = a->balance;
    eq_p = piv->balance;

    a->balance = eq_a - max(eq_p, 0) - 1;
    piv->balance = min(min(eq_a-2, eq_a+eq_p-2), eq_p-1);


    a = piv;

    return a;
    

}

pAvl RightRota(pAvl a){ // A right rotation for a ALV

    pAvl piv = a->leftson;
    int eq_a, eq_p;


    a->leftson = piv->rightson;

    piv->rightson = a;

    eq_a = a->balance;
    eq_p = piv->balance;

    a->balance = eq_a - min(eq_p, 0) + 1;
    piv->balance = max(max(eq_a+2, eq_a+eq_p+2), eq_p+1);


    a = piv;

    return a;

}

pAvl dLeftRota(pAvl a){// A double left rotation for a ALV

    a->rightson = RightRota(a->rightson);
    return LeftRota(a);

}

pAvl dRightRota(pAvl a){ // A double right rotation for a ALV
    a->leftson = LeftRota(a->leftson);
    return RightRota(a);
}

pAvl balAvl(pAvl a){ // fonction to balance the AVL

    if(a->balance >= 2){
        if(a->rightson->balance >= 0){
            return LeftRota(a);
        }
        else{
            return dLeftRota(a);
        }
    }
    else if (a->balance <= -2){
        if(a->leftson->balance <= 0){
            return RightRota(a);
        }
        else{
            return dRightRota(a);
        }
    }
    return a;

}