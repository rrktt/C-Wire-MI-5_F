#include "fileCreation.h"

FILE * openFile(char * f, char * w){

    FILE * file = NULL;
    file = fopen(f, w);
    if(file == NULL){
        printf("Impossible to open the file\n");
        printf("error code = %d\n", errno);
        printf("error message = %s\n", strerror(errno));
        exit(3);
    }

    return file;

}

void browsefile(char * file_path, char * file_path2){

    FILE * file = openFile(file_path, "r");

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


            testcapa = fscanf(file, "%ld", &capa);



            testgiv = fscanf(file, "%ld", &giv);


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

    FILE * output = openFile(file_path2, "w");

    infix(output, a);

    freePostfix(a);


}