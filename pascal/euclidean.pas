{ Euclidean algoithm }
program gcd(input, output);
var a,b,l,s,r: integer;
begin
  read(a,b); writeLn(a,b);
  if a > b then begin l:=a; s:=b end
  else begin l:=b; s:=a end;
  while s <> 0 do
    begin r:=l mod s; l:=s; s:=r end;
  write(l)
end.

