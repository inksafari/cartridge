# https://www.ruby-lang.org/
# The Greeter class
# 哈囉，你好!

中文測試

class Greeter
  def initialize(name)
    @name = name.capitalize
  end

  def salute
    puts "Hello #{@name}!"
  end
end

# Create a new object
g = Greeter.new("world")

# Output "Hello World!"
g.salute