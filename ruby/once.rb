#!/usr/local/bin/ruby
class ExampleDate
  def ExampleDate.once(*ids)
    for id in ids
      module_eval <<-"end_eval"
        alias_method :__#{id.to_i}__, #{id.inspect}
        def #{id.id2name}(*args, &block)
          def self.#{id.id2name}(*args, &block)
            @__#{id.to_i}__
          end
          @__#{id.to_i}__=__#{id.to_i}__(*args,&block)
        end
      end_eval
    end
  end
  def asString(a)
    a*100
  end
  once :asString
end

a = ExampleDate.new()
puts a.asString(2)
puts a.asString(4)
