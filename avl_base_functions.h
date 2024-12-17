
#include<stdio.h>
#include<stdlib.h>
#include"main.h"




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

