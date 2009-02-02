let rec whle condition body =
  if condition () then
    begin body (); whle condition body end

let rec myfor init ends body =
  if init <= ends then
    begin
      body init;
      myfor (init + 1) ends body
    end
