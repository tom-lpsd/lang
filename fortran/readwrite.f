*     read date files and format it
      INTEGER N,TN
      REAL AVE,TAVE,DATA
      
      N=0
      TN=0
      AVE=0.0
      TAVE=0.0

 10   READ(5,*,END=20) DATA
      N=N+1
      TN=TN+1
      AVE=AVE+DATA
      TAVE=TAVE+DATA
      IF((N-N/5*5).EQ.0) THEN
         WRITE(*,*) DATA,' ',AVE/N
         WRITE(*,*) ''
         N=0
         AVE=0.0
      ELSE
         WRITE(*,*) DATA
      END IF
      GO TO 10

 20   WRITE(*,200) AVE/N
 200  FORMAT('+',F10.5)
      WRITE(*,210) TN,TAVE/TN
 210  FORMAT(' ','N = ',I10,' HEIKIN = ',F10.5)
      END
