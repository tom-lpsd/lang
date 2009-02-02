*     2-BUN HO

      REAL F,X,EPS,X1,X2,XM,Y
      PARAMETER (EPS=1.0E-6)

      F(X)=X*(X**2-1)-1
      
      X1=0
      X2=2
      Y=F(X1)

 10   CONTINUE
      XM=(X1+X2)/2
      IF(Y*F(XM).GT.0) THEN
         X1=XM
      ELSE
         X2=XM
      END IF
      IF(X2-X1 .GE. EPS) GO TO 10

      WRITE(6,200) 'X= ',XM
 200  FORMAT(' ',A,F9.6)
      END
