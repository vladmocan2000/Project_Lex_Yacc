#!/bin/bash

lex project.l
yacc -d project.y
gcc lex.yy.c  y.tab.c tablesOfVariables.c -ll
./a.out