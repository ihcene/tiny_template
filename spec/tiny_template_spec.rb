require 'spec_helper'
require 'ostruct'

RSpec.describe TinyTemplate do
  before(:each) do
    @klass = Class.new do
      def hello
        TinyTemplate.parse(template, self)
      end

      def template
        "Hello {{client.name.upcase}} and welcome to {{configuration.title.capitalize}}. Your email is {{client.email.downcase.strip}}."
      end

      def client
        OpenStruct.new(name: 'John Doe', email: '  John@doe.com   ')
      end

      def configuration
        OpenStruct.new(title: 'my Fancy website')
      end
    end
  end

  it "should interpolate strings correctly" do
    result = @klass.new.hello

    expect(result).to match(/JOHN DOE/)
    expect(result).to match(/My fancy website/)
    expect(result).to match(/john@doe.com/)
  end

  it "should ignore non existing methods" do
    @klass.class_eval do
      def template
        "Hello {{client.name.inexisting_method}}"
      end
    end

    result = @klass.new.hello

    expect(result).to match(/\{\{client\.name\.inexisting_method\}\}/)
  end

  it "should find the context of caller when no context is passed" do
    @klass.class_eval do
      def hello
        TinyTemplate(template)
      end
    end

    result = @klass.new.hello

    expect(result).to match(/JOHN DOE/)
  end
end

