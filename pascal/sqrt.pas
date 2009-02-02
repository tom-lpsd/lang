program squareroot(input, output);
const eps = 1.0E-10;
var a,g,h : real;
begin
   read(a); write(a:6);
   g := 1.0; h := a/g;
   while abs(g-h) >= eps do
   begin
      g := (g+h)/2; h := a/g
   end;
   writeLn( (g+h)/2 )
end.