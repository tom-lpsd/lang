#
# DO NOT MODIFY!!!!
# This file is automatically generated by racc 1.4.5
# from racc grammer file "intp.y".
#

require 'racc/parser'


class IntpParser < Racc::Parser

module_eval <<'..end intp.y modeval..idf4056da2cc', 'intp.y', 43

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

..end intp.y modeval..idf4056da2cc

##### racc 1.4.5 generates ###

racc_reduce_table = [
 0, 0, :racc_error,
 0, 11, :_reduce_none,
 3, 11, :_reduce_none,
 1, 12, :_reduce_none,
 1, 12, :_reduce_none,
 4, 13, :_reduce_5,
 3, 13, :_reduce_6,
 1, 15, :_reduce_7,
 3, 15, :_reduce_8,
 3, 14, :_reduce_9,
 1, 16, :_reduce_10,
 1, 16, :_reduce_none,
 1, 16, :_reduce_none ]

racc_reduce_n = 13

racc_shift_n = 21

racc_action_table = [
    11,     9,    11,     8,    10,    15,    16,    15,    16,    11,
     2,    14,     7,     5,    15,    16,    18,    19 ]

racc_action_check = [
    19,     5,    10,     3,     5,    19,    19,    10,    10,     9,
     1,     9,     2,     1,     9,     9,    12,    12 ]

racc_action_pointer = [
   nil,    10,    12,     1,   nil,    -3,   nil,   nil,   nil,     6,
    -1,   nil,    11,   nil,   nil,   nil,   nil,   nil,   nil,    -3,
   nil ]

racc_action_default = [
    -1,   -13,   -13,   -13,    -3,   -13,    -4,    21,    -2,   -13,
   -13,   -10,   -13,    -7,    -6,   -11,   -12,    -9,    -5,   -13,
    -8 ]

racc_goto_table = [
    13,    17,     6,     4,     3,    12,     1,   nil,   nil,   nil,
    20 ]

racc_goto_check = [
     6,     6,     4,     3,     2,     5,     1,   nil,   nil,   nil,
     6 ]

racc_goto_pointer = [
   nil,     6,     3,     2,     1,    -4,    -9 ]

racc_goto_default = [
   nil,   nil,   nil,   nil,   nil,   nil,   nil ]

racc_token_table = {
 false => 0,
 Object.new => 1,
 :EOL => 2,
 :IDENT => 3,
 "(" => 4,
 ")" => 5,
 "," => 6,
 "=" => 7,
 :NUMBER => 8,
 :STRING => 9 }

racc_use_result_var = true

racc_nt_base = 10

Racc_arg = [
 racc_action_table,
 racc_action_check,
 racc_action_default,
 racc_action_pointer,
 racc_goto_table,
 racc_goto_check,
 racc_goto_default,
 racc_goto_pointer,
 racc_nt_base,
 racc_reduce_table,
 racc_token_table,
 racc_shift_n,
 racc_reduce_n,
 racc_use_result_var ]

Racc_token_to_s_table = [
'$end',
'error',
'EOL',
'IDENT',
'"("',
'")"',
'","',
'"="',
'NUMBER',
'STRING',
'$start',
'program',
'stmt',
'funcall',
'assign',
'args',
'primary']

Racc_debug_parser = false

##### racc system variables end #####

 # reduce 0 omitted

 # reduce 1 omitted

 # reduce 2 omitted

 # reduce 3 omitted

 # reduce 4 omitted

module_eval <<'.,.,', 'intp.y', 13
  def _reduce_5( val, _values, result )
              result = do_funcall(val[0], val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'intp.y', 17
  def _reduce_6( val, _values, result )
              retult = do_funcall(val[0], [])
   result
  end
.,.,

module_eval <<'.,.,', 'intp.y', 22
  def _reduce_7( val, _values, result )
              result = val
   result
  end
.,.,

module_eval <<'.,.,', 'intp.y', 26
  def _reduce_8( val, _values, result )
              result.push val[2]
   result
  end
.,.,

module_eval <<'.,.,', 'intp.y', 31
  def _reduce_9( val, _values, result )
              result = do_assign(val[0], val[2])
   result
  end
.,.,

module_eval <<'.,.,', 'intp.y', 36
  def _reduce_10( val, _values, result )
              result = do_varref(result)
   result
  end
.,.,

 # reduce 11 omitted

 # reduce 12 omitted

 def _reduce_none( val, _values, result )
  result
 end

end   # class IntpParser


parser = IntpParser.new
if ARGV[0] then
  File.open(ARGV[0]) do |f|
    parser.parse f
  end
else
  parser.parse $stdin
end

