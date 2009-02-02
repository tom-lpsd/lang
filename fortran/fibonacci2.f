*     FIBONACCI SURETSU(DO)
      
      INTEGER N,OLD,LAST,NEW
      PARAMETER (N=40)

      OLD=0
      WRITE(6,*) OLD
      LAST=1
      WRITE(6,*) LAST
      
      DO 10 I=3,N
         NEW=OLD+LAST
         WRITE(6,*) NEW
         OLD=LAST
         LAST=NEW
 10   CONTINUE

      END
