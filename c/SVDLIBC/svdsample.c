#include <stdio.h>
#include <stdlib.h>
#include "svdlib.h"

char *default_filename = "sparse_text";

int main(int argc, char *argv[])
{
    int i, j;
    SMat sm;
    SVDRec r;
    char *filename = default_filename;
    
    if (argc == 2) {
	filename = argv[1];
    }

    sm = svdLoadSparseMatrix(filename, SVD_F_ST);
    r = svdLAS2A(sm, 0);
    
    printf("singulars:\n");
    for (i=0;i<r->d;++i) {
	printf("%lf\n", r->S[i]);
    }

    printf("\ntranspose of left vectors:\n");
    for (i=0;i<r->Ut->rows;++i) {
	for (j=0;j<r->Ut->cols;++j) {
	    printf("%lf ", r->Ut->value[i][j]);
	}
	printf("\n");
    }

    printf("\ntranspose of right vectors:\n");
    for (i=0;i<r->Vt->rows;++i) {
	for (j=0;j<r->Vt->cols;++j) {
	    printf("%lf ", r->Vt->value[i][j]);
	}
	printf("\n");
    }

    svdFreeSVDRec(r);
    svdFreeSMat(sm);
    return 0;
}
