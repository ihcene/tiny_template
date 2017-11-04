# TinyTemplate

This is a very simple template engine that allows you to interpolate method chains without passing it any data. TinyTemplate will use the `self` of the caller when no context is passed.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tiny_template'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tiny_template

## Usage

You just have to prepend your strings with the ~ operator to parse them with the methods of the current self :

```ruby
class Greeting
  def hello
    ~"Hello {{client.name.upcase}} and welcome to {{configuration.title.capitalize}}.
      Your email is {{client.email.downcase.strip}}."
  end

  def client
    OpenStruct.new(name: 'John Doe', email: 'John@doe.com')
  end

  def configuration
    OpenStruct.new(title: 'my fancy website')
  end
end

Greeting.new.hello

# => "Hello JOHN DOE and welcome to My fancy website. Your email is john@doe.com."
```



If you don't like the binding magic used here, you can use TinyTemplate with the classic syntax :

```ruby
template = "Hello {{client.name.upcase}} and welcome to {{configuration.title.capitalize}}.
            Your email is {{client.email.downcase.strip}}."

TinyTemplate.parse(template, self)
````

If your interpreted string comes from a non-trusted source (user inpur for instance), you can secure it by providing a white list of method chains.

```ruby
TinyTemplate.secure(['client.name', 'configuration.email']) do
  ~my_template
  TinyTemplate.parse(my_template)
end
````

## Contributing

1. Fork it ( https://github.com/[my-github-username]/tiny_template/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
