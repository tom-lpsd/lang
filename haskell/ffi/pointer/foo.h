#ifndef FOO_H
#define FOO_H

typedef struct Foo {
    int x, y;
} Foo;

Foo *init(int, int);
void destroy(Foo *);

#endif /* FOO_H */
