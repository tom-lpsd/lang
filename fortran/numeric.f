      INTEGER M,N,WA,SA,SEKI,SHO,AMARI
      READ(*,*) M,N
      WA=M+N
      SA=M-N
      SEKI=M*N
      SHO=M/N
      AMARI=M-N*SHO
      WRITE(*,*) M,N,WA,SA,SEKI,SHO,AMARI
      STOP
      END
