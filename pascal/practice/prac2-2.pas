program menokoSqrt(input,output);
var a,cnt,j : longint;
begin
   read(a); write(a);
   j:=1; cnt:=-1;
   while a>=0 do
   begin
      a:=a-j;
      j:=j+2;
      cnt:=cnt+1
   end;
   writeLn(cnt:6)
end.