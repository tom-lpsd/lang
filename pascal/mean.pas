program meanAndStandardDeviation(input, output);
var N,i			: integer;
   x,sum,square,mean,sd	: real;
begin
   readLn(N);
   sum:=0; square:=0; i:=0;
   repeat
      read(x);
      sum:=sum+x; square:=square+sqr(x);
      i:=i+1
   until i=N;
   mean:=sum/N;
   sd:=sqrt( (square-sum*mean)/(N-1) );
   writeLn(N:6,mean,sd);
end.