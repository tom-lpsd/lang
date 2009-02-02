*     GOJOHO
      INTEGER A,B,M,N,L

      READ(*,*) A,B

      M=A
      N=B
 10   CONTINUE
      L=M-(M/N)*N
      IF(L.EQ.0) GO TO 20
      M=N
      N=L
      GO TO 10

 20   WRITE(*,*) A,B,N
      END
