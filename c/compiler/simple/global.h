#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#define BSIZE 128
#define NONE -1
#define EOS '\0'

#define NUM 256
#define DIV 257
#define MOD 258
#define ID 259
#define DONE 260

extern int tokenval;
extern int lineno;

struct entry {
    char *lexptr;
    int token;
};

extern struct entry symtable[];

int lexan(void);
void error(char *);
void parse(void);
void expr(void);
void term(void);
void factor(void);
void match(int);
void init(void);
