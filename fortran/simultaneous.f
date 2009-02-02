*     3-GEN RENRITSU 1-JI HOUTEISHIKI

      INTEGER N
      PARAMETER (N=3)
      REAL A(N,N+1)

      READ(5,100) ((A(I,J),J=1,N+1), I=1,N)
 100  FORMAT(4F10.0)

      DO 40 K=1,N
         DO 10 J=K+1,N+1
            A(K,J) = A(K,J)/A(K,K)
 10      CONTINUE
         
         DO 30 I=1,N
            IF(I.NE.K) THEN
               DO 20 J=K+1,N+1
                  A(I,J)=A(I,J)-A(I,K)*A(K,J)
 20            CONTINUE
            END IF
 30      CONTINUE
 40   CONTINUE

      WRITE(6,200) ('X(',I,') =',A(I,N+1),I=1,N)
 200  FORMAT(' ',A,I1,A,F10.4)
      END
