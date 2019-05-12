#include <stdio.h>
#include <stdlib.h>

void mulMatrix64(double **matrix1, double **matrix2, double **matrix3, int a, int b, int c);


int main() {
	int a, b, c;
	double **matrix1;
	double **matrix2;
	double **matrix3;

	printf("Wpisz rozmiary: a, b, c (axb, bxc)\n");
	scanf("%d %d %d", &a, &b, &c);

	matrix1 = (double **)malloc(a * sizeof(double *));
	for (int i = 0; i < a; i++) {
		matrix1[i] = (double *)malloc(b * sizeof(double));
	}
	matrix2 = (double **)malloc(b * sizeof(double *));
	for (int i = 0; i < b; i++) {
		matrix2[i] = (double *)malloc(c * sizeof(double));
	}
	matrix3 = (double **)malloc(a * sizeof(double *));
	for (int i = 0; i < a; i++) {
		matrix3[i] = (double *)malloc(c * sizeof(double));
	}

	for (int i = 0; i < a; i++) {
		for (int j = 0; j < b; j++) {
			scanf("%lf", &matrix1[i][j]);
		}
	}
	for (int i = 0; i < b; i++) {
		for (int j = 0; j < c; j++) {
			scanf("%lf", &matrix2[i][j]);
		}
	}

	mulMatrix64(matrix1, matrix2, matrix3, a, b, c); //m1=8 m2=12  m3=16 a=20 b=24 c=28

	for (int i = 0; i < a; i++) {
		for (int j = 0; j < c; j++)
			printf("%lf ", matrix3[i][j]);
		printf("\n");
	}

	return 0;
}