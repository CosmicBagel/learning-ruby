#-----------Default Parameter Values---------------

def produce_spaceship(type = :freighter, size = :x1)
end

#default params can call other methods
def produce_spaceship(type = :freighter, size = calc_default_size(type))
end

#default params can contain conditional logic
def produce_spaceship(type = :freighter,
                        size = (type == :freighter ? :xl : :m))
end

#default values are calculated when the method is called, not when the method
#is interpreted and defined

def produce_spaceship(type = :freighter, size = :xl, engine_count)
end

#ruby will fill in the non-defaultable parameters first
factory.produce_spaceship(4) #sets engine_count to 4

#-----------Variable Length Parameters List---------------

def produce_fleet(days_to_complete, *types)
end

#the variable argument collects in a greedy style, leaving just enough 
#left over for the non-variable params in the method
produce_fleet(10, :freighter, :freighter, :explorer)


def produce_fleet(days_to_complete = 10, *types)
end

#variable params can have nothing passed
produce_fleet

#full set of params given, valid
produce_fleet(15, :freighter, :freighter, :explorer)

#this is not valid
produce_fleet(:freighter, :freighter, :explorer)
#the first :freighter will be passed to the days_to_complete param

ship_types = [:freighter, :freighter, :explorer]
produce_fleet(15, *ship_types)
#the splat *, will take the elements out of the array and pass as below
produce_fleet(15, :freighter, :freighter, :explorer)


#-----------Variable Length Parameters List---------------


produce_spaceship(:freighter, :m, 100, 4)

#example of keyword calling
produce_spaceship(type: :freighter, size: :m, fuel_tank_volume: 100,
                  engine_count: 4)

#example of keyword arg declaration                  
def produce_spaceship(type: :freighter, size: :xl, fuel_tank_volume: 400,
                      engine_count: 2)
end

#you can mix with regular params
def produce_spaceship(type = :freighter, size: :m, engine_count: 2)
end

#double splat ** will collect any keyword arguments not
#listed in the definition
def produce_spaceship(type = :freighter, size: :m, **custom_components)
    components = {engine:    :standard,
                  seats:     :standard,
                  subwoofer: :none}
    components.merge!(custom_components)
end

#example of calling with custom components
produce_spaceship(:yacht, size: :s, engine: :rolls_royce, seats: :leather)

#double splat also lets you use a hash
build_params = {size: :s, engine: :rolls_royce, seats: :leather}
produce_spaceship(:yachtm build_params)

custom_components = {seats: :leather}
produce_spaceship(:yacht, size: :s, **custom_components)

#-----------Method Alisasing---------------

class String
    def space_out
        chars.join(" ")
    end
    
    #this creates a copy of the current size method
    alias_method "original_size", "size"
    
    #now we can overwrite the size method and still access 
    #the original_size method
    def size
        original_size * 2 - 1
    end
end

puts "abc".space_out # "a b c"
puts "abc".size # 5

#-----------Operators---------------

#ruby lets you define your own, and override operators in your classes

#logical operators
# && || not and or ?:

#assignment operators
# = += -= *= /= %= **= &= |= ^= >>= <<= &&= ||=

class Spaceship
    attr_reader :name
    attr_reader :speed
    
    def initalize(name)
        @name = name
        @cargo = []
        @speed = 0
        @vessels = Hash.new { [] }
    end
    
    #index operator
    def [](type)
        @vessels[type]
    end
    
    #index assignment operator?
    def []=(type, vehicles)
        @vessels[type] = vehicles
    end
    
    def <<(cargo)
        @cargo << cargo
    end
    
    #the <=> aka spaceship operator, is used to make opjects sortable
    def <=>(other)
        name <=> other.name
    end
 end

ship1 = Spaceship.new("Serenity")

class Lander; end
ship1[:landers] = [Lander.new, Lander.new]
puts "Landers : #{ship1[:landers].inspect}"

class CargoPod; end
cargo_pod = CargoPod.new
ship1 << cargo_pod
p ship1

#sorting example
ship2 = Spaceship.new("Dreadnought")
ship3 = Spaceship.new("Tranquillity")

p [ship1, ship2, ship3].sort.map {|s| s.name}

#override these sparingly, you can quickly run into walls of complexity and 
#make your code much harder to understand

#-----------Method Calls as Messages---------------

# like in smalltalk, ruby sends a message to an object with a method name, and
# the specified parameters to go with it

# the object looks up the method, and if it finds it, attempts to execute it
# with the given parameters

# you can think of methods as message handlers
# sometimes they are called recivers