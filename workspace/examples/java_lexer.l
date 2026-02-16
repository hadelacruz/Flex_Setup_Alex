%{
#include <stdio.h>
#include <string.h>

int line_count = 1;
int char_count = 1;
int token_count = 0;

void print_token(const char* type, const char* value) {
    token_count++;
    printf("Token #%d: %-15s | Value: %-20s | Line: %d, Pos: %d\n", 
           token_count, type, value, line_count, char_count);
    char_count += strlen(value);
}
%}

LETTER          [a-zA-Z]
DIGIT           [0-9]
IDENTIFIER      ({LETTER}|_)({LETTER}|{DIGIT}|_)*
INTEGER         {DIGIT}+
FLOAT           {DIGIT}+\.{DIGIT}+
SCIENTIFIC      {DIGIT}+(\.{DIGIT}+)?[eE][+-]?{DIGIT}+
HEXADECIMAL     0[xX][0-9a-fA-F]+
WHITESPACE      [ \t]+

%x COMMENT_MULTILINE

%%

"//".*                  { /* Comentario de linea - se descarta */ }

"/*"                    { BEGIN(COMMENT_MULTILINE); }
<COMMENT_MULTILINE>"*/" { BEGIN(INITIAL); }
<COMMENT_MULTILINE>\n   { line_count++; char_count = 1; }
<COMMENT_MULTILINE>.    { /* Cualquier caracter dentro del comentario se ignora */ }

{HEXADECIMAL}           { print_token("HEXADECIMAL", yytext); }
{SCIENTIFIC}            { print_token("SCIENTIFIC", yytext); }
{FLOAT}                 { print_token("FLOAT", yytext); }
{INTEGER}               { print_token("INTEGER", yytext); }

{IDENTIFIER}            { print_token("IDENTIFIER", yytext); }

"+"                     { print_token("PLUS", yytext); char_count += yyleng; }
"-"                     { print_token("MINUS", yytext); char_count += yyleng; }
"*"                     { print_token("MULTIPLY", yytext); char_count += yyleng; }
"/"                     { print_token("DIVIDE", yytext); char_count += yyleng; }

"=="                    { print_token("EQUAL", yytext); char_count += yyleng; }
"!="                    { print_token("NOT_EQUAL", yytext); char_count += yyleng; }
"<="                    { print_token("LESS_EQUAL", yytext); char_count += yyleng; }
">="                    { print_token("GREATER_EQUAL", yytext); char_count += yyleng; }
"<"                     { print_token("LESS_THAN", yytext); char_count += yyleng; }
">"                     { print_token("GREATER_THAN", yytext); char_count += yyleng; }

"&&"                    { print_token("LOGICAL_AND", yytext); char_count += yyleng; }
"||"                    { print_token("LOGICAL_OR", yytext); char_count += yyleng; }
"!"                     { print_token("LOGICAL_NOT", yytext); char_count += yyleng; }

\"([^\\\"]|\\[ntr\"\\])*\"  { print_token("STRING_LITERAL", yytext); }

"="                     { print_token("ASSIGN", yytext); char_count += yyleng; }
"("                     { print_token("LPAREN", yytext); char_count += yyleng; }
")"                     { print_token("RPAREN", yytext); char_count += yyleng; }
"{"                     { print_token("LBRACE", yytext); char_count += yyleng; }
"}"                     { print_token("RBRACE", yytext); char_count += yyleng; }
";"                     { print_token("SEMICOLON", yytext); char_count += yyleng; }
","                     { print_token("COMMA", yytext); char_count += yyleng; }

{WHITESPACE}            { char_count += yyleng; }
\n                      { line_count++; char_count = 1; }

%%

int yywrap() {
    return 1;
}

void print_statistics() {
    printf("\n=== ESTADISTICAS DEL ANALISIS ===\n");
    printf("Total de tokens reconocidos: %d\n", token_count);
    printf("Total de lineas procesadas: %d\n", line_count);
    printf("==================================\n");
}

int main(int argc, char **argv) {
    printf("=== ANALIZADOR LEXICO COMPLETO ===\n");
    printf("Reconoce: Identificadores Java, Literales Numericos, Operadores, Comentarios, Cadenas\n");
    printf("======================================\n\n");
    
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            fprintf(stderr, "Error: No se puede abrir el archivo '%s'\n", argv[1]);
            return 1;
        }
        printf("Analizando archivo: %s\n\n", argv[1]);
    } else {
        printf("Leyendo desde entrada estandar (Ctrl+D para terminar):\n\n");
    }
    
    yylex();
    print_statistics();
    
    if (argc > 1 && yyin) {
        fclose(yyin);
    }
    
    return 0;
}