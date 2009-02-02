*     output square sum and qube sum
      INTEGER N
      REAL Q,S
      PARAMETER (N=500)
      S=0.0
      Q=0.0
      DO 10 I=1,N
         S=S+I*I
         Q=Q+I*I*I
 10   CONTINUE
      WRITE(*,*) S,Q
      END
