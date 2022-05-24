#include "tablesOfVariables.h"

int getVariableType(char* s) {

     struct boolVariable* spb;
     for (spb = boolVariablesTable; spb < &boolVariablesTable[MAX_NUMBER_OF_VARIABLES]; spb++) {

          if(spb->name && !strcmp(spb->name, s)) {
           
               return 1;
          }
     }

     struct intVariable* spi;
     for (spi = intVariablesTable; spi < &intVariablesTable[MAX_NUMBER_OF_VARIABLES]; spi++) {

          if(spi->name && !strcmp(spi->name, s)) {
           
               return 2;
          }
     }

     struct stringVariable* sps;
     for (sps = stringVariablesTable; sps < &stringVariablesTable[MAX_NUMBER_OF_VARIABLES]; sps++) {

          if(sps->name && !strcmp(sps->name, s)) {
           
               return 3;
          }
     }

     return -1; 
}

struct boolVariable* getBoolVariablePointer(char *s) {

     struct boolVariable *sp;
     for (sp = boolVariablesTable; sp < &boolVariablesTable[MAX_NUMBER_OF_VARIABLES]; sp++) {

          if(sp->name && !strcmp(sp->name, s)) {
           
               return sp;
          }
     }
}

struct intVariable* getIntVariablePointer(char *s) {

     struct intVariable *sp;
     for (sp = intVariablesTable; sp < &intVariablesTable[MAX_NUMBER_OF_VARIABLES]; sp++) {

          if(sp->name && !strcmp(sp->name, s)) {
           
               return sp;
          }
     }
}

struct stringVariable* getStringVariablePointer(char *s) {

     struct stringVariable *sp;
     for (sp = stringVariablesTable; sp < &stringVariablesTable[MAX_NUMBER_OF_VARIABLES]; sp++) {

          if(sp->name && !strcmp(sp->name, s)) {
           
               return sp;
          }
     }
}

void createBoolVariable(char* s, bool value) {

  struct boolVariable* sp;
  
  for(sp = boolVariablesTable; sp < &boolVariablesTable[MAX_NUMBER_OF_VARIABLES]; sp++) {

    if(!sp->name) {

      sp->name = s;
      sp->value = value;
      return ;
    }
  }
  
  printf("warning!\n");
  printf("Maximum number of bool variables was already reached!\n");
  printf("The creation of %s variable failed!\n", s);
}

void createIntVariable(char* s, int value) {

  struct intVariable* sp;
  
  for(sp = intVariablesTable; sp < &intVariablesTable[MAX_NUMBER_OF_VARIABLES]; sp++) {

    if(!sp->name) {

      sp->name = s;
      sp->value = value;
      return ;
    }
  }
  
  printf("warning!\n");
  printf("Maximum number of int variables was already reached!\n");
  printf("The creation of %s variable failed!\n", s);
}

void createStringVariable(char* s, char* value) {

  struct stringVariable* sp;
  
  for(sp = stringVariablesTable; sp < &stringVariablesTable[MAX_NUMBER_OF_VARIABLES]; sp++) {

    if(!sp->name) {

      sp->name = s;
      sp->value = value;
      return ;
    }
  }
  
  printf("warning!\n");
  printf("Maximum number of int variables was already reached!\n");
  printf("The creation of %s variable failed!\n", s);
}