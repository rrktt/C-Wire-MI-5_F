#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include"main.h"
#include"data_fetching.h"
//This file serves to extract data from a ligne from the filtered file and to send them into a structure


Station stationCreation(int powerplant_f,int hvb_stationf,int hva_stationf,int lv_stationf,int companyf,int individualf,int capacityf,int loadf){
    Station new;
    new.power_plant = powerplant_f;
    new.hva_station = hva_stationf;
    new.lv_station = lv_stationf;
    new.company = companyf;
    new.individual = individualf;
    new.capacity = capacityf;
    new.load = loadf;
     if(new.individual!=0){
        new.id = new.individual;
        new.type = 5;
    }
    else if(new.company!=0){
        new.id = new.company;
        new.type = 4;
    }
   
    else if(new.lv_station!=0){                 //sets type and id value according to the other values
        new.id = new.lv_station;
        new.type =3;
    }
    else if(new.hva_station!=0){
        new.id = new.hva_station;
        new.type = 2;
    }
    else{
        new.id = new.power_plant;
        new.type = 1;
    }
    return new;
}
Station single_line(char *string){    //takes values from a single line and asign them to integers
    Station new;
    int power_plantf,hvb_stationf,hva_stationf,lv_stationf,companyf,individualf,capacityf,loadf,temp;
    const char* separator=";"; //defines the separation character
    char strtoken =   strtok(string,separator); //use strtok to collect each number string from a single line 
    int i = 0;
    while(strtoken!=NULL){
        if(strtoken!=NULL){
            if(strtoken=='-'){         //if there's no value in that column its value become 0
                temp = 0;
            }
        }
        else{
            sscanf(strtoken,"%d",&temp);
        }
        strtoken = strtok(NULL,separator);
        if(temp<0){                     //test if the in put are negative numbers
            printf("Wrong input value(s)\n");
            exit(67);
        }
        switch(i){
            case 0:
                power_plantf = temp;
                break;
            case 1:
                hvb_stationf =temp;
                break;
            case 2:
                hva_stationf = temp;
                break;
            case 3: 
                lv_stationf= temp;
                break;
            case 4:
                companyf = temp;   
                break;            
            case 5:
                individualf= temp;
                break;
            case 6:
                capacityf = temp;
                break;
            case 7:
                loadf = temp;
                break;
        }
        
    }
    new = stationCreation(power_plantf,hvb_stationf,hva_stationf,lv_stationf,companyf,individualf,capacityf,loadf);
    return new;
}



