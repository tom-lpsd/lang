*     SAIDAICHI TO SAISHOUCHI(1)
      REAL MAX,MIN,DATA
      INTEGER I,N

      READ(5,*) N

      READ(5,*,END=30) DATA
      I=1
      MAX=DATA
      MIN=DATA

 10   READ(5,*,END=20) DATA
      I=I+1
      IF(DATA.GT.MAX) THEN
         MAX=DATA
      ELSE IF(DATA.GE.MIN) THEN
         CONTINUE
      ELSE
         MIN=DATA
      ENDIF
      GO TO 10

 20   WRITE(6,*) 'N = ',I,' SAIDAICHI = ',MAX,
     -     ' SAISHOUCHI = ',MIN
      IF(I.NE.N) WRITE(6,*) 'KAZU GAWANAI ',
     -     'N = ',N,' I = ',I
      STOP
 30   WRITE(6,*) 'SUCHI GA NAI'
      END
