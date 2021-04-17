require "doko/version"

module Doko
  class Error < StandardError; end
  # Your code goes here...

  class Proxy
    def initialize(obj)
      @obj = obj
    end

    def method_missing(name, *args)
      caller_snapshot = caller
      pp method_inspect(name, args, caller_snapshot)
      @obj.__send__(name, *args)
    end

    def method_inspect(name, args, caller_snapshot)
      source_location = @obj.method(name).source_location
      {
        reciever_class: @obj.class.to_s,
        method_name: name.to_s,
        args: args,
        source_location: source_location || 'native_method',
        call_line: caller.last
      }
    end

    def respond_missing?(sym, include_private)
      @obj.respond_missing?(sym, include_private)
    end
  end
end
class BasicObject
  def doko
    ::Doko::Proxy.new(self)
  end
end
