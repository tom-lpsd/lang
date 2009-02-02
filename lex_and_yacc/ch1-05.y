%{
/*
 * A lexer for the basic grammer to use for recognizing English sentences.
 */
#include <stdio.h>
%}

%token NOUN PRONOUN VERB ADVERB ADJECTIVE PREPOSITION CONJUNCTION

%%

sentence: subject VERB object { printf("Sentence is valid.\n"); }
;

subject: NOUN | PRONOUN
;

object:   NOUN
;

%%

extern FILE *yyin;

int main(void)
{
    do {
	yyparse();
    } while (!feof(yyin));
}

void yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
}
