#include <stdbool.h>
#include <string.h>
#include <stdio.h>

#define MAX_NUMBER_OF_VARIABLES 20 

struct boolVariable {

    char* name;
    bool value;              
     
} boolVariablesTable[MAX_NUMBER_OF_VARIABLES];

struct intVariable {

    char* name;     
    int value;                    
     
} intVariablesTable[MAX_NUMBER_OF_VARIABLES];

struct stringVariable {

    char* name;       
    char* value;         
     
} stringVariablesTable[MAX_NUMBER_OF_VARIABLES];

int getVariableType(char* s);
struct boolVariable* getBoolVariablePointer(char* s);
struct intVariable* getIntVariablePointer(char* s);
struct stringVariable* getStringVariablePointer(char* s);
void createBoolVariable(char* s, bool value);
void createIntVariable(char* s, int value);
void createStringVariable(char* s, char* value);