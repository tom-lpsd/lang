program gaussianElimination(input, output);
const maxN = 50; maxN1 = 51;
var a: array[1..maxN, 1..maxN1] of real;
    x: array[1..maxN] of real;
    i,j,k,max,N : integer;
    t : real;
begin
    readLn(N);
    for i:=1 to N do
        begin
            for j:=1 to N+1 do read(a[i,j]);
            readLn;
        end;
    for i:=1 to N-1 do
        begin
            max:=i;
	    for j:=i+1 to N do
		if abs(a[j,i]) > abs(a[max,i]) then max:=j;
	    for k:=i to N+1 do
		begin
		    t:=a[i,k];
		    a[i,k]:=a[max,k];
		    a[max,k]:=t;
		end;
	    for j:=i+1 to N do
		for k:=N+1 downto i do
		    a[j,k] := a[j,k] - a[i,k]*a[j,i]/a[i,i]
        end;
    for i:=N downto 1 do
        begin
            t:=0.0;
            for j:=i+1 to N do t:=t+a[i,j]*x[j];
            x[i]:=(a[i,N+1]-t)/a[i,i]
        end;
    for i:=1 to N do writeLn(x[i])
end.

