*     SAKUHYOU
      INTEGER ID(1000),YEAR(1000),NO,L,H,S

      OPEN(10,FILE='SHAIN.TXT',STATUS='OLD')
      READ(10,100) ID(1),YEAR(1)
 100  FORMAT(I5,2X,I4)

      S=0
      N=1
 10   CONTINUE
      N=N+1
      READ(10,100,END=20) ID(N),YEAR(N)
      IF(ID(N-1).GE.ID(N)) THEN
         WRITE(6,*) 'OKASHII ',N,ID(N)
         S=1
      END IF
      GO TO 10
 20   CLOSE(10)
      N=N-1
      IF(S.EQ.1) STOP 'CHUSHI'

*     NIBUN-TANSAKU

 30   READ(5,*,END=50) NO
      IF(ID(1).LE.NO .AND. NO.LE.ID(N)) THEN
         L=1
         H=N
 40      IF(L.LE.H) THEN
            M=(L+H)/2
            IF(NO.EQ.ID(M)) THEN
               WRITE(6,200) ID(M),YEAR(M)
 200           FORMAT(' ',I5,2X,I5)
            ELSE
               IF(NO.LT.ID(M)) THEN
                  H=M-1
               ELSE
                  L=M+1
               END IF
               GO TO 40
            END IF
         ELSE
            WRITE(6,*) 'MITSUKARANAI ',NO
         END IF
      ELSE
         WRITE(6,*) 'HAN''IGAI ',NO
      END IF
      GO TO 30

 50   END
