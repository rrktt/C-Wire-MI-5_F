#include "fileCreation.h"

FILE * openFile(char * f, char * w){ //open a file (f) or create the file with the arguments gived (w)

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

void browsefile(char * file_path, char * file_path2){ //fonction to read the file and put the value in a AVL and put AVL values on a new file

    FILE * file = openFile(file_path, "r"); // open the data file

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
        
        testcentral = fscanf(file, "%d", &central); //take the central id
        

        if (testcentral != EOF){


            testcapa = fscanf(file, "%ld", &capa); //take the capacity value



            testgiv = fscanf(file, "%ld", &giv); //take the consomation value


            nv = searchAvl(a, central);//research the central id inside the AVL

            if(nv == NULL){// if it dont found the central

                s = createStation(central, capa, giv); //create the station
                a = insertAvl(a, s, &h); //insert the station in the AVL
                
            }
            else{ //if it found the central
                nv->sta->give += giv; //add the consomation
                nv->sta->capacity += capa; //add the capacity
            }
        
        }

    }

    FILE * output = openFile(file_path2, "w"); //create the output file

    infix(output, a); //place the AVL values in the new file

    freePostfix(a); //free the AVL


}