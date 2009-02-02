program sort(input, output);
const maxN = 1000;
var a: array[1..maxN] of integer;
    N: integer;
    i,j,k,max: integer;
begin
  readLn(N);
  for i:=1 to N do read(a[i]);
  for i:=1 to N-1 do
    begin
      k:=i; max:=a[i];
      for j:=i+1 to N do
        if max < a[j] then
          begin k:=j; max:=a[j] end;
      a[k]:=a[i]; a[i]:=max
    end;
  for i:=1 to N do
    begin
      write(a[i]:4);
      if (i mod 5) = 0 then writeLn
    end
end.

