class IntpParser
rule

  program :
          | program stmt EOL

  stmt    : funcall
          | assign

  funcall : IDENT '(' args ')'
            {
              result = do_funcall(val[0], val[2])
            }
          | IDENT '(' ')'
            {
              retult = do_funcall(val[0], [])
            }

  args    : primary
            {
              result = val
            }
          | args ',' primary
            {
              result.push val[2]
            }

  assign  : IDENT '=' primary
            {
              result = do_assign(val[0], val[2])
            }

  primary : IDENT
            {
              result = do_varref(result)
            }
          | NUMBER
          | STRING

end

---- inner

def do_funcall(func, args)
  recv = Object.new
  if recv.respond_to? func, true then
    ;
  elsif args[0] then
    recv = args.shift
  else
    recv = nil
  end

  recv.send func, *args
end

def initialize
  @vtable = {}
end

def do_assign(vname, val)
  @vtable[vname] = val
end

def do_varref(vname)
  @vtable[vname] or raise NameError,
                          "unknown variable #{vname}"
end

def parse(f)
  @q = []
  f.each do |line|
    until line.empty? do
      case line
      when /\A\s+/, /\A\#.*/
        ;
      when /\A[a-zA-Z_]\w*/
        @q.push [ :IDENT, $&.intern ]
      when /\A\d+/
        @q.push [ :NUMBER, $&.to_i ]
      when /\A"(?:[^"\\]+|\\.)*"/
        @q.push [ :STRING, eval($&) ]
      when /\A./
        @q.push [ $&, $&]
      else
        raise RuntimeError, 'must not happen'
      end
      line = $'
    end
    @q.push [ :EOL, nil ]
  end
  @q.push [ false, '$' ]
  do_parse
end

def next_token
  @q.shift
end

---- footer

parser = IntpParser.new
if ARGV[0] then
  File.open(ARGV[0]) do |f|
    parser.parse f
  end
else
  parser.parse $stdin
end

