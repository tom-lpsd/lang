*     HEIHOUKON NO KEISAN
      
      INTEGER A,M,N
      REAL ROOTA,C,EPS
      PARAMETER (M=1,N=50,EPS=1.0E-6)

      DO 20 A=M,N
         ROOTA = 1
 10      CONTINUE
         C=0.5*(A/ROOTA-ROOTA)
         ROOTA=ROOTA+C
         IF(ABS(C)/ROOTA.GE.EPS) GO TO 10
         WRITE(6,200) A,ROOTA
 200     FORMAT(' ',I10,F15.5)
 20   CONTINUE

      END
