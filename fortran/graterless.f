*     OKIIMONO TO CHIISAIMONO O KAZOERU
      INTEGER DAI,SHO
      REAL KUGIRI,X

      READ(5,*) KUGIRI

*     SHOKICHI
      
      DAI=0
      SHO=0

*     KANJO

 10   READ(5,*,END=20) X
      IF(X.GE.KUGIRI) THEN
         DAI=DAI+1
      ELSE
         SHO=SHO+1
      END IF
      GO TO 10

*     KEKKA

 20   WRITE(6,*) 'OKIIMONO',DAI,'  CHIISAIMONO',SHO

      END
