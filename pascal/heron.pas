program triangle(input, output);
var a,b,c,s,area :  real;
begin
   read(a,b,c); writeLn(a:6,b:6,c:6);
   s:=(a+b+c)/2.0;
   area:=sqrt( s*(s-a)*(s-b)*(s-c) );
   writeLn(area)
end.
