#include<stdio.h>
#include<stdlib.h>
#include"main.h"

int main(){
    FILE* input_file= NULL;
    intput_file = fopen("c-wire_v00.dat","r"); //temporary
    if(input_file==NULL){
        printf("Unable to open the file\n");
        exit(1);
    }
    char string[MAX_BUFFER_SIZE];
    Station new;
    pAvl p1=NULL;
    while(fgets(s,MAX_BUFFER_SIZE,input_file)!=NULL){
        new = single_line(string);
        p1 = insertion(p1,new);
    }
    
}