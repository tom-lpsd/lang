*     HISTOGRAM

      INTEGER N,KOSU,DOSU(100),ERROR
      REAL JOGEN,KAGEN,HABA,KUKAN

      DATA DOSU/100*0/

      OPEN(10,FILE='HISTF.TXT',STATUS='OLD')
      READ(10,*) KAGEN,JOGEN
      READ(5,*) HABA

      N=(JOGEN-KAGEN)/HABA+1
      IF((N.LT.1) .OR. (N.GT.100)) GO TO 40
      KOSU=0
      ERROR=0

 10   READ(10,*,END=20) X
      KOSU=KOSU+1
      IF((KAGEN.LE.X) .AND. (X.LE.JOGEN)) THEN
         I=(X-KAGEN)/HABA+1
         DOSU(I)=DOSU(I)+1
      ELSE
         ERROR=ERROR+1
      END IF
      GO TO 10

 20   WRITE(6,200) 'SUCHI NO KOSU =',KOSU,
     -     'SUCHI NO AYAMARI =',ERROR
 200  FORMAT(' ',A,I4/' ',A,I4/)

      DO 30 I=1,N
         KUKAN=KAGEN+HABA*(I-1)
         WRITE(6,210) KUKAN,' ----',KUKAN+HABA,
     -        DOSU(I),('*',K=1,DOSU(I))
 210     FORMAT(' ',F8.3,A5,F8.3,I5,3X,50A:/
     -        (T31,50A))
 30   CONTINUE
      CLOSE(10)
      STOP

 40   WRITE(6,*) 'PARAMETER GA OKASHII ',N
      CLOSE(10)
      END
