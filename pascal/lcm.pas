program lcm(input, output);
var p,q,n,m,k: integer;
begin
  read(p,q);
  n := p; m := q;
  while m <> 0 do
    begin
      k := n mod m;
      n := m; 
      m := k;
    end;
  writeLn(p*q div n);
end.
