class Object
  def trace(name="", stream=STDERR)
    TracedObject.new(self, name, stream)
  end
end

class TracedObject
  instance_methods.each do |m|
    m = m.to_sym
    next if m == :object_id || m == :__id__ || m == :__send__
    undef_method m
  end

  def initialize(o, name, stream)
    @o = o
    @n = name
    @trace = stream
  end

  def method_missing(*args, &block)
    m = args.shift
    begin
      arglist = args.map {|a| a.inspect}.join(', ')
      @trace << "Invoking: #{@n}.#{m}(#{arglist}) at #{caller[0]}\n"
      r = @o.send m, *args, &block
      @trace << "Returning: #{r.inspect} from #{@n}.#{m} to #{caller[0]}\n"
      r
    rescue Exception => e
      @trace << "Raising: #{e.class}: #{e} from #{@n}.#{m}\n"
      raise
    end
  end

  def __delegate
    @o
  end
end
