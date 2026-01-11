%{
#include <stdio.h>
#include <stdlib.h>

extern int yylineno;
extern char* yytext;

int yylex(void);
void yyerror(const char *s);
%}

%token NUMBER DECIMAL
%token CHECK OTHERWISE UNTIL KEEPUP DONE
%token SKIP GETBACK IN OUT

%token IS SAMEAS
%token PLUS MINUS

%token LBRACE RBRACE LPAREN RPAREN SEMI

%token IDENTIFIER INTEGER FLOAT STRING

%%

program
    : KEEPUP block DONE
      {
        printf("Syntax analysis successful\n");
      }
    ;

block
    : LBRACE stmt_list RBRACE
    ;

stmt_list
    : stmt stmt_list
    | /* empty */
    ;

stmt
    : declaration
    | assignment
    | conditional
    | loop
    | output
    ;

declaration
    : NUMBER IDENTIFIER SEMI
    | DECIMAL IDENTIFIER SEMI
    ;

assignment
    : IDENTIFIER IS expr SEMI
    ;

conditional
    : CHECK LPAREN expr RPAREN block
    | CHECK LPAREN expr RPAREN block OTHERWISE block
    ;

loop
    : UNTIL LPAREN expr RPAREN block
    ;

output
    : OUT IDENTIFIER SEMI
    ;

expr
    : IDENTIFIER
    | INTEGER
    | FLOAT
    | expr PLUS expr
    | expr MINUS expr
    ;

%%

void yyerror(const char *s)
{
    printf("Line %d: Syntax Error → Found '%s'\n", yylineno, yytext);
}

int main(void)
{
    yyparse();
    return 0;
}
