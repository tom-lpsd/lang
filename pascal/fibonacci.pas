program fibonacciSequence( output );
var old,last,new,i :  integer;
begin
   old:=0; last:=1; write(old:6,last:6);
   for i:= 3 to 20 do
   begin
      new := old+last;
      write(new:6);
      old:=last; last:=new
   end
end.