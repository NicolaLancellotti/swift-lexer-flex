%{
#include "tokenKind.h"
%}

delim   [ \t\n]
ws      {delim}+
letter  [A-Za-z]
digit   [0-9]
id      {letter}({letter}|{digit})*

integer {digit}+
float   {digit}+(\.{digit}+)?(E[+-]?{digit}+)?

%%

"("         { return TOKEN_L_PAREN; }
")"         { return TOKEN_R_PAREN; }
"["         { return TOKEN_L_SQUARE; }
"]"         { return TOKEN_R_SQUARE; }
","         { return TOKEN_COMMA; }
";"         { return TOKEN_SEMI; }

"<"         { return TOKEN_OP_REL_LT; }
"<="        { return TOKEN_OP_REL_LE; }
"="         { return TOKEN_OP_REL_EQ; }
"<>"        { return TOKEN_OP_REL_NE; }
">"         { return TOKEN_OP_REL_GT; }
">="        { return TOKEN_OP_REL_GE; }

if          { return TOKEN_IF; }
then        { return TOKEN_THEN; }
else        { return TOKEN_ELSE; }
while       { return TOKEN_WHILE; }
for         { return TOKEN_FOR; }

{id}        { return TOKEN_ID; }

{integer}   { return TOKEN_NCONST; }
{float}     { return TOKEN_FCONST; }
{ws}        {}

.           {return TOKEN_ERROR; }
<<EOF>>     {return TOKEN_EOF; }

%%
