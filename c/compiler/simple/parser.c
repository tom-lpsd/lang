#include "global.h"

int lookahead;

void parse(void)
{
    lookahead = lexan();
    while (lookahead != DONE) {
	expr(); match(';');
    }
}

void expr(void)
{
    int t;
    term();
    while (1) {
	switch (lookahead) {
	case '+': case '-':
	    t = lookahead;
	    match(lookahead); term(); emit(t, NONE);
	    continue;
	default:
	    return;
	}
    }
}

void term(void)
{
    int t;
    factor();
    while (1) {
	switch (lookahead) {
	case '*': case '/': case DIV: case MOD:
	    t = lookahead;
	    match(lookahead); factor(); emit(t, NONE);
	    continue;
	default:
	    return;
	}
    }
}

void factor(void)
{
    switch(lookahead) {
    case '(':
	match('('); expr(); match(')'); break;
    case NUM:
	emit(NUM, tokenval); match(NUM); break;
    case ID:
	emit(ID, tokenval); match(ID); break;
    defalut:
	error("syntax error");
    }
}

void match(int t)
{
    if (lookahead == t)
	lookahead = lexan();
    else
	error("syntax error");
}
