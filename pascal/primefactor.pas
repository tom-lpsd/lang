program primeFactor(input, output);
var n,k: integer;
begin
    read(n); writeLn(n);
    k:=2;
    while k <= trunc(sqrt(n)) do
        begin
	    while (n mod k) = 0 do
	        begin write(k:4); n:= n div k end;
	    k:=k+2; if not odd(k) then k := k-1
	end;
    if n <> 1 then writeLn(n:4)
end.

