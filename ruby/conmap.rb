module Enumerable
  def conmap(&block)
    threads = []
    self.each do |item|
      threads << Thread.new { block.call(item) }
    end
    threads.map {|t| t.value }
  end

  def concurrently
    map {|item| Thread.new { yield item }}.each {|t| t.join }
  end
end
