%{

  #include "tablesOfVariables.h"

  int yylex(void);
  int yyerror(const char *s);
  
%}
%union {

  _Bool boolType;
  int intType;
  char* stringType;

  struct boolVariable* boolVariableType;
  struct intVariable* intVariableType;
  struct stringVariable* stringVariableType;
}

%token <boolType> BOOL
%token <intType> INTEGER
%token <stringType> STRING
%token <boolVariableType> BOOL_VARIABLE
%token <intVariableType> INT_VARIABLE
%token <stringVariableType> STRING_VARIABLE
%token <stringType> NEW_VARIABLE
%token FUNCTION

%left '+' '-' 
%left '*' '/' 
%left '|' '&'

%type <boolType> bool_expression
%type <intType> int_expression
%type <stringType> string_expression

%%

program :             program statement '\n'
                      | 
                      ;

statement :           bool_expression                               { if($1) printf("true\n"); else printf("false\n"); }     
                      | int_expression                              { printf("%d\n", $1); }
                      | string_expression                           { printf("%s\n", $1); }

                      | BOOL_VARIABLE '=' bool_expression           { $1->value = $3; }
                      | INT_VARIABLE '=' int_expression             { $1->value = $3; }
                      | STRING_VARIABLE '=' string_expression       { $1->value = $3; }

                      | NEW_VARIABLE '=' bool_expression            { createBoolVariable($1, $3); }
                      | NEW_VARIABLE '=' int_expression             { createIntVariable($1, $3); }
                      | NEW_VARIABLE '=' string_expression          { createStringVariable($1, $3); }

                      | int_expression '>' string_expression        { printf("mismatch type\n"); }
                      | int_expression '<' string_expression        { printf("mismatch type\n"); }
                      | string_expression '>' int_expression        { printf("mismatch type\n"); }
                      | string_expression '<' int_expression        { printf("mismatch type\n"); }

                      | int_expression '>' bool_expression          { printf("mismatch type\n"); }
                      | int_expression '<' bool_expression          { printf("mismatch type\n"); }

                      | string_expression '>' bool_expression       { printf("mismatch type\n"); }
                      | string_expression '<' bool_expression       { printf("mismatch type\n"); }

                      | string_expression '>' string_expression     { printf("Cannot compare strings\n"); }
                      | string_expression '<' string_expression     { printf("Cannot compare strings\n"); }
                      | FUNCTION                                    { ; }
                      ;

bool_expression :       BOOL                                        { $$ = $1; }
                      | BOOL_VARIABLE	                              { $$ = $1->value; }
                      | bool_expression '|' bool_expression         { $$ = $1 || $3; }
                      | bool_expression '&' bool_expression         { $$ = $1 && $3; }
                      | '(' bool_expression ')'                     { $$ = $2; }
                      | int_expression '>' int_expression           { if($1 > $3) $$ = true; else $$ = false; } 
                      | int_expression '<' int_expression           { if($1 < $3) $$ = true; else $$ = false; } 
                      ;

int_expression  :       INTEGER                                     { $$ = $1; }
                      | INT_VARIABLE                                { $$ = $1->value; }
                      | int_expression '+' int_expression           { $$ = $1 + $3; }
                      | int_expression '-' int_expression           { $$ = $1 - $3; }
                      | int_expression '*' int_expression           { $$ = $1 * $3; }
                      | int_expression '/' int_expression           { if($3 == 0) yyerror("divide by zero"); else $$ = $1 / $3;}
                      | '(' int_expression ')'                      { $$ = $2; }
                      ;

string_expression     : STRING                                      { $$ = $1; }
                      | STRING_VARIABLE	                            { $$ = $1->value; }
                      ;
