%option noyywrap
%option yylineno

%{
#include "y.tab.h"
#include <stdio.h>
%}

%%

"number"        { return NUMBER; }
"decimal"       { return DECIMAL; }
"check"         { return CHECK; }
"otherwise"     { return OTHERWISE; }
"until"         { return UNTIL; }
"keepup"        { return KEEPUP; }
"done"          { return DONE; }
"skip"          { return SKIP; }
"getback"       { return GETBACK; }
"getin"         { return IN; }
"getout"        { return OUT; }

"isSame"        { return SAMEAS; }
"is"            { return IS; }

";"             { return SEMI; }
"{"             { return LBRACE; }
"}"             { return RBRACE; }
"("             { return LPAREN; }
")"             { return RPAREN; }

"+"             { return PLUS; }
"-"             { return MINUS; }

[0-9]*\.[0-9]+  { return FLOAT; }
[0-9]+          { return INTEGER; }

\"([^\\\"]|\\.)*\" { return STRING; }

[a-zA-Z_][a-zA-Z0-9_]* { return IDENTIFIER; }

\n              { /* yylineno auto */ }
[ \t\r]+        { /* ignore */ }

. {
    printf("Line %d: ERROR → %s (invalid symbol)\n", yylineno, yytext);
}

%%
