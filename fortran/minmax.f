*     SAIDAICHI TO SAISHOCHI(2)

      REAL MAX,MIN,DATA
      INTEGER I,N

      OPEN(10,FILE='MAXMIN.TXT',STATUS='OLD')

      READ(10,*) N

      READ(10,*,END=30) DATA
      I=1
      MAX=DATA
      MIN=DATA

 10   READ(10,*,END=20) DATA
      I=I+1
      IF(DATA.GT.MAX) THEN
         MAX=DATA
      ELSE IF(DATA.GE.MIN) THEN
         CONTINUE
      ELSE
         MIN=DATA
      END IF
      GO TO 10

 20   CLOSE(10)
      WRITE(6,*) 'N = ',I,' SAIDAICHI = ',MAX,
     -     ' SAICHOCHI = ',MIN
      IF(I.NE.N) WRITE(6,*) 'KAZU GA AWANAI ',
     -     'N = ',N,' I = ',I
      STOP

 30   WRITE(6,*) 'SUCHI GA NAI'
      END
