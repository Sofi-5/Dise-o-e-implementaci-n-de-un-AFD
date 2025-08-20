%{
#include "parser.tab.h"
#include <string.h>
%}

%%
"estados="          { return ESTADOS; }
"alfabeto="         { return ALFABETO; }
"inicial="          { return INICIAL; }
"finales="          { return FINALES; }
"transiciones="     { return TRANSICIONES; }
[a-zA-Z0-9]+        { yylval.str = strdup(yytext); return ID; }
","                 { return COMA; }
\n                  { /* ignorar */ }
.                   { return *yytext; }
%%

int yywrap() {
    return 1;
}



