#include <stdio.h>
#include <stdlib.h>
#include "svdlib.h"

static char *default_filename = "sparse_text";

int main(int argc, char *argv[])
{
    int i,j,p=0;
    char *filename = default_filename;
    SMat sm = (SMat)malloc(sizeof(struct smat));
    if (argc == 2) {
	filename = argv[1];
    }
    sm = svdLoadSparseMatrix(filename, SVD_F_ST);

    printf("col: %ld\n", sm->cols);
    printf("row: %ld\n", sm->rows);
    printf("val: %ld\n", sm->vals);
    for (i=0;i<sm->cols;++i) {
	for (j=0;j<sm->rows;++j) {
	    if (sm->rowind[p] == j) {
		printf("%.4lf  ", sm->value[p++]);
	    }
	    else {
		printf("     0  ");
	    }
	}
	printf("\n");
    }
    free(sm);
    return 0;
}
