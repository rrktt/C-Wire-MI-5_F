#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include"avl_base_functions"
#ifndef DATA_FETCHING_H
#define DATA_FETCHING_H
#endif


Station stationCreation(int idf,int capacityf,int chargef,int consumersf,int hva_stationf,int hvb_stationf,int power_plantf,int typef);
Station single_line(char *string);