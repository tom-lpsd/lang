*     FIBONACCI SURETSU(IF)

      INTEGER N,OLD,LAST,NEW
      PARAMETER (N=40)

      OLD=0
      WRITE(6,*) OLD
      LAST=1
      WRITE(6,*) LAST
      I=3

 10   IF(I.LE.N) THEN
         NEW=OLD+LAST
         WRITE(6,*) NEW
         OLD=LAST
         LAST=NEW
         I=I+1
         GO TO 10
      END IF
      END
