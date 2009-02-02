*     HEIKIN TO HYOUJUNHENSA

      INTEGER N
      REAL X,T1,T2,M,SD

*     SHOKICHI

      N=0
      T1=0
      T2=0

*     RUISEKI

 10   READ(5,*,END=20) X
      N=N+1
      T1=T1+X
      T2=T2+X*X
      GO TO 10

*     MATOME

 20   IF(N.GE.2) THEN
         M=T1/N
         SD=SQRT((T2-T1*M)/(N-1))
         WRITE(6,*) 'N = ',N,' MEAN = ',M,
     -        ' SD = ',SD
      ELSE
         IF(N.EQ.1) THEN
            WRITE(6,*) 'N = ',N,' MEAN = ',T1
         ELSE
            WRITE(6,*) 'SUCHI GA NAI'
         END IF
      END IF

      END
