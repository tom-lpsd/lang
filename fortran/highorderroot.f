*     KOJI DAISU HOTEISHIKI

      INTEGER M,N
      REAL X0,X1,S,T,EPS
      PARAMETER (M=20,EPS=1.0E-6)
      REAL A(0:M)

      READ(5,100) N
 100  FORMAT(I2)
      READ(5,110) (A(I),I=N,0,-1)
 110  FORMAT(5F10.0)
      READ(5,110) X0

 10   CONTINUE
      S=0
      T=0

      DO 20 I=N,1,-1
         S=S*X0+A(I)
         T=T*X0+S
 20   CONTINUE

      S=S*X0+A(0)
      X1=X0-S/T

      IF(ABS((X1-X0)/X0).LT.EPS) GO TO 30
      X0 = X1
      GO TO 10

 30   WRITE(6,200) 'X =',X1
 200  FORMAT(' ',A,F10.5)
      END
