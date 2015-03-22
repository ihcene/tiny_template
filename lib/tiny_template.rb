require "tiny_template/version"
require 'debug_inspector'
require "tiny_template/core_ext"

class TinyTemplate
  # You can construct by your sulf this class, but you wont benefict from the magic
  # of the context being automaticaly calculated with debug_inspector
  def initialize(str)
    self.str = str
  end

  # Context can be any object that you expect it will respond to methods on the template passed
  # to the constructor
  def parse(context)
    str.gsub(/\{\{\w+(\.\w+)*\}\}/) do |match|
      interpolate(match, context)
    end
  end

  # This is a facility class method aimed to simplify the construction
  def self.parse(str, context)
    new(str).parse(context)
  end

  private
    attr_accessor :str

    # Private method used to interpolate one single expression at a time
    def interpolate(match, context)
      match.gsub(/\{|\}/, '')
           .split('.')
           .inject(context){ |result, e| result.public_send(e) }

    rescue
      match
    end

  module Utils
    # Call this method with or without context. If no context is passed, the context of the caller
    # will be computed and passed to a new instance of the class TinyTemplate
    def TinyTemplate(str, context = nil)
      unless context
        RubyVM::DebugInspector.open do |inspector|
          context = eval('self', inspector.frame_binding(2))
        end
      end

      TinyTemplate.parse(str, context)
    end
  end
end

include TinyTemplate::Utils