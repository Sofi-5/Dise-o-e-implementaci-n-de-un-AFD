%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX 100

char* estados[MAX]; int num_estados = 0;
char alfabeto[MAX]; int num_alfabeto = 0;
char* inicial;
char* finales[MAX]; int num_finales = 0;

typedef struct {
    char* origen;
    char simbolo;
    char* destino;
} Transicion;

Transicion transiciones[MAX];
int num_transiciones = 0;

void evaluar_cadenas(const char* archivo);
char* mover(char* estado, char simbolo);
int es_final(char* estado);


extern int yylex();
extern FILE* yyin;
int yyerror(const char* s);



%}

%union {
    char* str;
}

%token <str> ID
%token ESTADOS ALFABETO INICIAL FINALES TRANSICIONES
%token COMA

%%

config : ESTADOS lista_ids
       ALFABETO lista_chars
       INICIAL ID     { inicial = $6; }
       FINALES lista_finales
       TRANSICIONES lista_transiciones
       ;

lista_ids : ID        { estados[num_estados++] = $1; }
          | lista_ids COMA ID { estados[num_estados++] = $3; }
          ;

lista_chars : ID      { alfabeto[num_alfabeto++] = $1[0]; }
            | lista_chars COMA ID { alfabeto[num_alfabeto++] = $3[0]; }
            ;

lista_finales : ID    { finales[num_finales++] = $1; }
              | lista_finales COMA ID { finales[num_finales++] = $3; }
              ;

lista_transiciones : trans_line
                   | lista_transiciones trans_line
                   ;

trans_line : ID ',' ID ',' ID {
    transiciones[num_transiciones].origen = $1;
    transiciones[num_transiciones].simbolo = $3[0];
    transiciones[num_transiciones].destino = $5;
    num_transiciones++;
}
;

%%

int main() {
    FILE* f = fopen("conf.txt", "r");
    if (!f) {
        perror("conf.txt");
        return 1;
    }

    yyin = f;
    yyparse();
    fclose(f);

    evaluar_cadenas("cadenas.txt");
    return 0;
}

int yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
    return 1;
}

char* mover(char* estado, char simbolo) {
    for (int i = 0; i < num_transiciones; i++) {
        if (strcmp(transiciones[i].origen, estado) == 0 &&
            transiciones[i].simbolo == simbolo) {
            return transiciones[i].destino;
        }
    }
    return NULL;
}

int es_final(char* estado) {
    for (int i = 0; i < num_finales; i++) {
        if (strcmp(finales[i], estado) == 0)
            return 1;
    }
    return 0;
}

void evaluar_cadenas(const char* archivo) {
    FILE* f = fopen(archivo, "r");
    if (!f) {
        perror("cadenas.txt");
        return;
    }

    char cadena[100];
    printf("\nResultados:\n");

    while (fgets(cadena, sizeof(cadena), f)) {
        char estado_actual[50];
        strcpy(estado_actual, inicial);

        int len = strlen(cadena);
        if (cadena[len - 1] == '\n') cadena[len - 1] = '\0';

        int aceptada = 1;
        for (int i = 0; cadena[i]; i++) {
            char* nuevo_estado = mover(estado_actual, cadena[i]);
            if (!nuevo_estado) {
                aceptada = 0;
                break;
            }
            strcpy(estado_actual, nuevo_estado);
        }

        if (aceptada && es_final(estado_actual))
            printf("%s -> ACEPTADA\n", cadena);
        else
            printf("%s -> RECHAZADA\n", cadena);
    }

    fclose(f);
}


