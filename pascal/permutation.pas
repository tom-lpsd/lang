program permutation(input, output);
var a:array[1..9] of integer;
    N: 2..9;
    i,j: 1..9;
    x: integer;
begin
    readLn(N);
    for i:=1 to N do
        begin read(a[i]); write(a[i]) end;
    i:=N-1;
    while a[i] >= a[i+1] do i:=i-1;
    j:=N;
    while a[j] <= a[i] do j:=j-1;
    x:=a[j]; a[j]:=a[i]; a[i]:=x;
    i:=i+1; j:=N;
    while i<j do
        begin
            x:=a[j]; a[j]:=a[i]; a[i]:=x;
            i:=i+1; j:=j-1
        end;
    writeLn;
    for i:=1 to N do write(a[i]);
    writeLn;
end.

