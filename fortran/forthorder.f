*     4-JI SHIKI NO SUHYO

      INTEGER L,U,H
      PARAMETER (L=0,U=50,H=2)
      REAL X,Y

      OPEN(10,FILE='SUHYO.TXT', STATUS='NEW')

      WRITE(10,200)
 200  FORMAT(' ',3X,'X',8X,'Y')

      DO 10 I=L,U,H
         X=REAL(I)/10.0
         Y=(((1.5*X-0.8)*X+6.2)*X+0.5)*X+2.1
         WRITE(10,210) X,Y
 210     FORMAT(' ',F5.1,F10.2)
 10   CONTINUE

      CLOSE(10)

      END
