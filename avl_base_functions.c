#include<stdio.h>
#include<stdio.h>
#include"avl_base_functions.h"
#include"main.h"





struct Avl{
    struct Avl* ls;
    struct Avl* rs;   
    int balance;
    Station s; 
};

typedef struct Avl Avl;
typedef Avl* pAvl;


pAvl AvlCreation(Station e){
    pAvl new;
    new=malloc(sizeof(Avl));
    if(new ==NULL){
        exit('ALLOCATION_ERROR');
    }
    new->s = e;
    new->ls = NULL;
    new->rs = NULL;
    new->balance = 0;
    return new;
}

int leftSonExists(pAvl a){
    if(a==NULL){
        exit('ERROR_NULL_NOD');
    }
    else if(a->ls !=NULL){
        return 1;
    }
    return 0;
}
int rightSonExists(pAvl a){
    if(a==NULL){
        exit('ERROR_NULL_NOD');
    }
    else if(a->rs !=NULL){
        return 1;
    }
    return 0;
}
int recherche(pAvl a,int e){
    if(a==NULL){
        return 0;
    }
    else if(a->s.id==e){
        return 1;
    }
    else if(e<a->s.id){
       return recherche(a->ls,e);
    }
    else{
        return recherche(a->ls,e);
    }
}
int max(int a,int b){
    if(a>b){
        return a;
    }
    return b;
}
int min(int a,int b){
    if(a>b){
        return b;
    }
    return a;
}
pAvl rightRotation(pAvl a){
    pAvl pivot;
    int bal_a,bal_p;
    if(a==NULL){
        exit('ERROR_NULL_NOD');
    }
    pivot = a->ls;
    a->ls = pivot->rs;
    bal_a = a->balance;
    bal_p = pivot->balance; 
    a->balance = bal_a - max(bal_p,0)-1;
    pivot->balance = min(bal_a-2,min(bal_a+bal_p-2,bal_p-1));
    a = pivot;
    return a;
}
pAvl leftRotation(pAvl a){
    pAvl pivot;
    int bal_a,bal_p;
    if(a==NULL){
        exit('ERROR');
    }
    pivot = a->rs;
    a->rs = pivot->ls;
    bal_a = a->balance;
    bal_p= pivot->balance;
    a->balance = bal_a-min(bal_p,0)+1;
    pivot->balance = max(bal_a+2,max(bal_a+bal_p+2,bal_p+1));
    return a;
}
pAvl leftDoubleRotation(pAvl a){
    a->rs = leftRotation(a->rs);
    return rightRotation(a);
}
pAvl rightDoubleRotation(pAvl a){
    a->ls = rightRotation(a->ls);
    return leftRotation(a);
}
pAvl balancing(pAvl a){
    if(a->balance >=2){
        if(a->balance>=0){
            return leftRotation(a);
        }
        else{
            return leftDoubleRotation(a);
        }

    }
    else if(a->balance<=-2){
        if(a->balance <=0){
            return rightRotation(a);
        }
        else{
            return rightDoubleRotation(a);
        }
    }

}
pAvl avlInsertion(pAvl a, Station e,int* h){
    if(a==NULL){ 
        *h = 1;

        return AvlCreation(e);
    }
    else if(e.id<a->s.id){
        a->ls = avlInsertion(a->ls,e,h);
        *h = -*h;
    }
    else if(e.id>a->s.id){
        a->rs = avlInsertion(a->rs,e,h);
    }
    else{
        *h=0;
        return a;
    }
    printf("Test\n");
    if(*h!=0){
    
        a->balance = a->balance + *h;
        a = balancing(a);
        if(a->balance ==0){
            *h = 0;
        }
        else {
            *h = 1;
        }

    }
    return a;

}
pAvl delMinAvl(pAvl a,int *h, Station *pe){
    pAvl temp;
    if(a->ls==NULL){
        *pe = a->s;
        *h = -1;
        temp = a;
        a = a->rs;
    free(temp);
    return a;
    if((*h!=0)){
        a->balance = a->balance +*h;
        if(a->balance ==0){
            *h = -1;
        }
        else{
            *h = 0;
        }
    }
}
}
pAvl delete(pAvl a,Station e,int *h){
    pAvl temp;
    if(a==NULL){
        *h =0;
        return a;
    }
    else if(e.id >a->s.id){
        a->rs = delete(a->rs,e,h);
    }
    else if(e.id< a->s.id){
        a-> ls = delete(a->ls,e,h);
        *h = -*h;
    }
    else if(rightSonExists(a)){
        a->rs = delMinAvl(a->rs,h,&e);
    }
    else{
        temp = a;
        a = a->ls;
        *h = -1;
        return a;
    }
    if (a==NULL){
        return a;
    }
    if(*h !=0){
        a->balance = a->balance +*h;
        a = balancing(a);
        if(a->balance ==0){
            *h=0;
        }
        else{
            *h = 0;
        }

    }
    return a;
    }
void delete_all(pAvl a){
    if(a==NULL){
        return;
    }
    delete_all(a->ls);
    delete_all(a->rs);
    free(a);
}
    

