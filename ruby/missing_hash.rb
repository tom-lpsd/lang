class Hash
  def method_missing(key, *args)
    puts key
    text = key.to_s
    if text[-1,1] == '='
      self[text.chop.to_sym] = args[0]
    else
      self[key]
    end
  end
end

h = {}
h.one = 1
puts h.one
