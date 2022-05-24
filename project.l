%{

	#include "y.tab.h"
     #include "tablesOfVariables.h"
	#include <stdio.h>
     #include <stdbool.h>

  	int yyerror(char *errormsg);
  	int yyparse();

%}

%%

true                                                        { yylval.boolType = true; return BOOL; }

false                                                       { yylval.boolType = false; return BOOL; }

type\([a-zA-Z_0-9]*\)                                       { 
                                                                 yytext[strlen(yytext) - 1] = 0;
                                                                 yytext +=5;
                                                                 int k = getVariableType(yytext);

                                                                 if(k == 1) {

                                                                      printf("bool\n");
                                                                 }
                                                                 else if(k == 2) {
                                                                      
                                                                      printf("int\n");
                                                                 }
                                                                 else if(k == 3) {

                                                                      printf("string\n");
                                                                 }
                                                                 else {

                                                                      printf("Undefined variable\n");
                                                                 }

                                                                 return FUNCTION;
                                                            }

add\([ ]*[a-zA-Z_0-9]*[ ]*,[ ]*[a-zA-Z_0-9]*[ ]*\)          { 

                                                                 int val1, val2;
                                                                 int val1_firstIndex, val1_lastIndex, val2_firstIndex, val2_lastIndex;

                                                                 val1_firstIndex = 3;
                                                                 while(!(  (yytext[val1_firstIndex] >= 'a' && yytext[val1_firstIndex] <= 'z') || 
                                                                           (yytext[val1_firstIndex] >= 'A' && yytext[val1_firstIndex] <= 'Z') || 
                                                                           (yytext[val1_firstIndex] >= '0' && yytext[val1_firstIndex] <= '9') || 
                                                                           (yytext[val1_firstIndex] == '_'))) {

                                                                      val1_firstIndex++;
                                                                 }
                                                                 
                                                                 for(int i=val1_firstIndex; i<strlen(yytext); i++) {

                                                                      if(!((yytext[i] >= 'a' && yytext[i] <= 'z') || (yytext[i] >= 'A' && yytext[i] <= 'Z') || (yytext[i] >= '0' && yytext[i] <= '9') || (yytext[i] == '_'))) {

                                                                           val1_lastIndex = i - 1;
                                                                           break;
                                                                      }
                                                                 }

                                                                 val2_firstIndex = val1_lastIndex + 1;
                                                                 while(!(  (yytext[val2_firstIndex] >= 'a' && yytext[val2_firstIndex] <= 'z') || 
                                                                           (yytext[val2_firstIndex] >= 'A' && yytext[val2_firstIndex] <= 'Z') || 
                                                                           (yytext[val2_firstIndex] >= '0' && yytext[val2_firstIndex] <= '9') || 
                                                                           (yytext[val2_firstIndex] == '_'))) {

                                                                      val2_firstIndex++;
                                                                 }

                                                                 for(int i=val2_firstIndex; i<strlen(yytext); i++) {

                                                                      if(!((yytext[i] >= 'a' && yytext[i] <= 'z') || (yytext[i] >= 'A' && yytext[i] <= 'Z') || (yytext[i] >= '0' && yytext[i] <= '9') || (yytext[i] == '_'))) {

                                                                           val2_lastIndex = i - 1;
                                                                           break;
                                                                      }
                                                                 }

                                                                 yytext[val2_lastIndex+1] = 0;
                                                                 int k2 = getVariableType(yytext+val2_firstIndex); 
                                                                 if(k2 == 2) {
                                                                      
                                                                      val2 = getIntVariablePointer(yytext+val2_firstIndex)->value;
                                                                 } 
                                                                 else {

                                                                      printf("Wrong parameters. Only int type allowed\n");
                                                                      return FUNCTION;
                                                                 }
                                                                 
                                                                 yytext[val1_lastIndex+1] = 0;
                                                                 int k1 = getVariableType(yytext+val1_firstIndex); 
                                                                 if(k1 == 2) {
                                                                      
                                                                      val1 = getIntVariablePointer(yytext+val1_firstIndex)->value;
                                                                 } 
                                                                 else {

                                                                      printf("Wrong parameters. Only int type allowed\n");
                                                                      return FUNCTION;
                                                                 }

                                                                 printf("%d\n", val1 + val2);

                                                                 return FUNCTION;
                                                            }

[0-9]+			                                        { yylval.intType = atoi(yytext); return INTEGER; }

\"[^\"]*\"                                                  { yylval.stringType = strdup(yytext); return STRING;}

[a-zA-Z_0-9]*		                                        { 
                                                                 int k = getVariableType(yytext);

                                                                 if(k == 1) {

                                                                      yylval.boolVariableType = getBoolVariablePointer(yytext);
                                                                      return BOOL_VARIABLE;
                                                                 }
                                                                 else if(k == 2) {
                                                                      
                                                                      yylval.intVariableType = getIntVariablePointer(yytext);
                                                                      return INT_VARIABLE;
                                                                 }
                                                                 else if(k == 3) {

                                                                      yylval.stringVariableType = getStringVariablePointer(yytext);
                                                                      return STRING_VARIABLE;
                                                                 }
                                                                 else {

                                                                      yylval.stringType = strdup(yytext);
                                                                      return NEW_VARIABLE;
                                                                 }
                                                            }

[=&|\n]			                                        { return *yytext; }

[ \t]+	        	                                        { ; }

\n|.                                                        { return yytext[0]; }

%%

int main(void)
{
     yyparse();
     return 0;
}

int yywrap(void)
{
     return 0;
}

int yyerror(char *errormsg)
{
      fprintf(stderr, "%s\n", errormsg);
      exit(1);
}