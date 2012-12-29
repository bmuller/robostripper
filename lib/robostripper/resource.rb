require 'uri'
require 'set'

module Robostripper
  class Resource
    def initialize(source)
      @html = (source.is_a? String) ? HTTP.get(source) : source
      @cached = {}
      @attrs = Set.new
    end
    
    def encode(text)
      URI.encode(text)
    end
    
    def self.add_list(name, path, &block)
      define_method(name) {
        @cached[name] ||= @html.css(path).map { |result| 
          Resource.new(result).tap { |r| r.instance_eval &block }
        }
      }
    end

    def self.add_item(name, &block)
      define_method(name) {
        @cached[name] ||= Resource.new(@html).tap { |r| r.instance_eval &block }
      }
    end

    def method_missing(method, *args, &block)
      return super if method == :to_ary or (args.length == 0 and block.nil?)
      @attrs << method

      if block.nil? and args.length == 0
        block = lambda { nil }
      elsif block.nil?
        options = (args.length == 1) ? {} : args[1]
        block = lambda { scan(args.first, options) }
      end

      define_singleton_method(method, &block)
    end

    def scan(paths, options = {})
      result = @html
      paths = [ paths ] unless paths.is_a? Array
      paths.each { |path|
        result = result.search(path)
      }      

      if result.nil? or result.length == 0
        nil
      elsif options.fetch(:all, false)
        result
      elsif options.has_key? :nontext
        result.children.select(&:text?).map(&:text).join(options[:nontext])
      elsif options.has_key? :attribute
        result.first[options[:attribute]]
      else
        result.text
      end
    end

    def to_s
      attrs = @attrs.to_a.inject({}) { |h, attr| h[attr] = send(attr); h }
      "<#{self.class.name} #{attrs}>"
    end
  end
end
