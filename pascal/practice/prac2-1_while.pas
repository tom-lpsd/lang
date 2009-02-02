program kashi_to_sesshi(output);
var i : integer;
begin
   i:=0;
   while i<>210 do
   begin
      writeLn(i:4,(i-32)*5/9);
      i:=i+10
   end
end.