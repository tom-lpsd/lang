*     SUCHI-SEKIBUN(SIMPSON)
      INTEGER M
      DOUBLE PRECISION FUNC,A,B,H,S,T,SUMO,SUME
      
      FUNC(T) = SQRT(4.0D0-T**2)

      READ(5,100) M,A,B
 100  FORMAT(I8,2D10.0)

      H=(B-A)/M
      SUMO=0
      SUME=0

      DO 10 I=1,M/2-1
         SUMO=SUMO+FUNC(A+H*(2*I-1))
         SUME=SUME+FUNC(A+H*(2*I))
 10   CONTINUE
      SUMO=SUMO+FUNC(B-H)
      S=(FUNC(A)+FUNC(B)+4*SUMO+2*SUME)*H/3

      WRITE(6,200) 'M =',M,' H =',H,' S =',S
 200  FORMAT(' ',A8,I8,A8,D24.16,A8,F22.15)
      END
