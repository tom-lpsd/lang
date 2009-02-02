let rec downto1 n = if n < 1 then [] else n :: downto1 (n - 1);;

downto1 10
