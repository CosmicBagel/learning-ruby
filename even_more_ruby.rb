#---------------Overview--------------

# Blocks, procs, and lambdas
# Constants
# Modules

#---------------Blocks--------------

# do ... end block
[1, 2, 3].each do
    puts "This is Serenity, please respond"
end

# { |var| expression } curly brace single line block
ships = Spaceship.all
ships.each { |ship| puts ship.name }

#Invoking blocks

class Spaceship
    def debug_only
        return nil unless @debug     #debug mode only
        return nil unles block_given? #checks to ensure we have a block to execute
        puts "Running debug code..."
        yield #yielding will execute the block 
    end
end

ship.debug_only do |attrs|
    puts "Debug attr values: #{attrs.inspect}"
end

#Block arguments

# like normal arguments you can have default values, keyword arguments,
# array arguments (with the splat)

#example

def produce
    yield :spaceship, :freighter, :yacht, size: :s, seats: :leather
end

produce do |what = :spaceship, *types,
            size: :m, engine_count: 2, **custom_components|
  puts "Producing #{what}"
  print "Types: "
  p types
  puts "Size: #{size}"
  puts "Engine count: #{engine_count}"
  print "Custom components: "
  p custom_components
end

#---------------Block Local Variables--------------

# Block arguments shadow same name variables in outer scope
# Variables defined in block body don't shadow outer scope
# Block local variables solve this problem

do |input_var, local_var_to_be_set| #that's it
  local_var_to_be_set = "anything you want"
  #...
end

#---------------Blocks Are Closures--------------(sort of)

#Blocks carry thier context with them, this includes
# local variables, class variables, constants, and 'self'

#Since blocks carry thier context, they'll hang on to references,
#this can create situations of excess memeory use

#Limitations:
# - Can only pass one block into a method
# - Blocks can't be passed around between methods
# - Passing the same block to several methods isn't DRY

#---------------Procs--------------

def debug_only (param = nil, &block)
  puts "Param class: #{param.class}"
  puts "Block class: #{block.class}" if block_given?
end

debug_only {}
puts "---"

###Proc declaration
p = Proc.new {|bla| puts "I'm a proc that says #{bla}!"}
#or you can use the alias
p = proc {|bla| puts "I'm a proc that says #{bla}!"}

#calling is varied
p.call "yay!"
p.yield "wow!"
p.("nothing")
p["hello"]

debug_only(p)
puts "---"
debug_only(&p)


#---------------Lambda--------------

# the lambda method takes a block and converts it into a proc object,
# though it behaves in a different way

lmb = lambda {|bla| puts "I'm a proc that says #{bla}!"}

also_lmb ->(bla) { "I'm also a proc, and I say #{bla}!"}

#Procs and lambdas compared
# Procs are like blocks, lambdas are like anonymous methods
# Lambdas are strict about thier arguments
# return and break behave differently in procs and lambdas
# however, next behaves the same

#Differences in Argument Handling
# Lambdas: too many or too few arguments cause an exception
# Procs: extra arguments are discarded, missing arguments set to nil

#Differences in return and break Handling
# Procs: return is executed in the scope where the block was defined
# Procs: break ins't allowed outside a loop
#   Generally should avoid using return and break in procs, 
#   best to avoid return in blocks as well since the context they're called
#   in may not exist anymore
# Lambdas: break and return both return control to the caller, in these
# cases, lambda behaves much like a method

#---------------Using Procs and Lambdas--------------

#arity method on a proc returns the number of arguments
#in the case of optional arguments, it returns the
#required number + 1, and as a negative number
proc {|a,b|}.arity        # 2
proc {|a, *b, c| }.arity  # -3

# === operator runs the proc, useful for if statements and case statments
weekend = proc {|time| time.saturday? || time.sunday?}
weekday = proc {|time| time.wday < 6 }

case Time.now
  when weekend then puts "Wake up at 8:00"
  when weekday then puts "Wake up at 7:00"
else puts "No wake up calls outside of time"
end

# You can convert a Symbol to a Proc

#the symbol class has a to_proc method on it

names = ["flying dutchman", "viking", "vagabond"]
upper_names = names.map { |name| name.upcase } #the way we already know

upper_name = names.map(&:upcase) #to_proc is called on the symbol

#just passing in a method
def debug_only(param = nil, &block)
  puts "Param class: #{param.class}"
  puts "Block class: #{block.class}" if block_given?
end

debug_only(p) #param == p
debug_only(&p) # param == nil, block == p

#---------------Constants--------------

#Similar to a var in taht it's also a reference to an object
#typical naming scheme is all uppercase with underscores,
#just by following this scheme, ruby will identify your var as
#constant
MAX_SPEED = 1000

#if you change a constant you'll get a warning, but it won't halt the
#program
MAX_SPEED = 100

# you can change the object the var refers to without a warning
TYPES = []
TYPES << "freighter"

#you can prevent this by using the freeze method
TYPES.freeze
#attempts to change will result in a runtime error
#once an object is frozen, you can't change it
TYPES << "freighter" #runtime error

TYPES.frozen? #check if it's frozen

#again the objects it refers are still maliable
TYPES[0].upcase! #modified without error or warning

# the scope resolution operator ::
class A; MIN_SPEED = 0; end
p MIN_SPEED #error
p A::MIN_SPEED #prints MIN_SPEED
# can also use the scope resolution operator to ADD a constant to a class
A::MAX_SPEED = 100
p A::MAX_SPEED

#You can not define constants inside a method, only at the class level