program CalcPi(output);
var n,S : real;
   i  : integer;
begin
   i:=0; n:=2; S:=sqrt(2);
   while i<10 do
   begin
      S:=sqrt(2-sqrt(4-sqr(S)));
      i:=i+1;
      n:=2*n
   end;
   writeLn(S*n)
end.
