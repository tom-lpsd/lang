      INTEGER I,J,K,L,M
      REAL A,B,C

      I=10/4*2
      J=10*2/4
      K=10.0/4*2.0
      L=10.0*2.0/4.0
      M=10**2/4

      WRITE(6,*) I,J,K,L,M

      A=1.2
      B=0.5
      C=1.4

      X=A+B*C
      WRITE(6,*) X
      X=(A+B)*C
      WRITE(6,*) X
      X=A-B/2.0
      WRITE(6,*) X
      X=A*B**2
      WRITE(6,*) X
      X=(A+B)**2
      WRITE(6,*) X

      END
