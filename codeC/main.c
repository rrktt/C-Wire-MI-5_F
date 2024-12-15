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

Station * createStation(int nb, long int capa, long int give){

    Station * stat = malloc(sizeof(Station));

    if(stat == NULL){
        exit(2);
    }


    stat->nb = nb;
    stat->capacity = capa;
    stat->give = give;

    return stat;

}


pAvl createAvl(Station * x){
    
    pAvl pa = malloc(sizeof(Avl));

    if(pa == NULL){
        exit(1);
    }


    pa->sta = x;
    pa->rightson = NULL;
    pa->leftson = NULL;
    pa->balance = 0;

    return pa;

}

int max(int a, int b){
    if(a>=b){
        return a;
    }
    else{
        return b;
    }
}

int min(int a, int b){

    if(a<b){
        return a;
    }

    else{
        return b;
    }

}

pAvl LeftRota(pAvl a){

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

pAvl RightRota(pAvl a){

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

pAvl dLeftRota(pAvl a){

    a->rightson = RightRota(a->rightson);
    return LeftRota(a);

}

pAvl dRightRota(pAvl a){
    a->leftson = LeftRota(a->leftson);
    return RightRota(a);
}

pAvl balAvl(pAvl a){

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

FILE * openFile(){

    FILE * file = NULL;
    file = fopen("tmp/tmpc.txt", "r");
    if(file == NULL){
        printf("Impossible to open the file\n");
        printf("error code = %d\n", errno);
        printf("error message = %s\n", strerror(errno));
        exit(3);
    }

    return file;

}

void browsefile(){

    FILE * file = openFile();

    pAvl a = NULL;
    Station * s;

    int h;

    int central = 0;
    int testcentral = EOF+1;

    long int capa = 0;
    int testcapa = EOF+1;

    long int giv = 0;
    int testgiv = EOF+1;

    pAvl nv = NULL;

    while (testcentral != EOF && testcapa != EOF && testgiv != EOF){
        
        testcentral = fscanf(file, "%d", &central);
        

        if (testcentral != EOF){

        
            //printf("%d\n\n", central);



            testcapa = fscanf(file, "%ld", &capa);
            //printf("%ld\n", capa);



            testgiv = fscanf(file, "%ld", &giv);
            //printf("%ld\n", giv);


            nv = searchAvl(a, central);

            if(nv == NULL){

                s = createStation(central, capa, giv);
                a = insertAvl(a, s, &h);
                
            }
            else{
                nv->sta->give += giv;
                nv->sta->capacity += capa;
            }
        
        }

    }


    FILE * output = NULL;
    output = fopen("test.csv", "w");
    if(output == NULL){
        printf("Impossible to open the output file\n");
        printf("error code = %d\n", errno);
        printf("error message = %s\n", strerror(errno));
        exit(4);
    }

    infix(output, a);

    freePostfix(a);


}


int main(){

    browsefile();

    return 0;

}