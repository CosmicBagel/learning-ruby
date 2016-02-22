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