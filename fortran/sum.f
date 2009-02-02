*     output sumation from 1 to N
      INTEGER N,SUM
      SUM=0
      READ(*,*) N
      DO 10 I=1,N
         SUM=SUM+I
 10   CONTINUE

      WRITE(6,20) (N*(N+1)/2),SUM
 20   FORMAT(' ',I10,I10)
      END
