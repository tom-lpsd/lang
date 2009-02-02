program arithmeticOperation(input,output);
var m,n,s,d,p,q,r : integer;
begin
   read(m,n);writeLn(m:6,n:6);
   s:=m+n; d:=m-n; p:=m*n;
   q:=m div n; r:=m-n*q;
   writeLn( s:6, d:6, p:6, q:6, r:6)
end.