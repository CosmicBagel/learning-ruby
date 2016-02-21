#integer numbers

=begin
  Useful methods include upto and downto, which iterate
  and take a 'do' block
  Times is useful for executing a block or command, when you
  don't need an iterator
  
  Integer has two subclasses, Fixnum and Bignum
  Fixnum has a range of 1 word minus 1 bit. This is dependent
  on the machine you are running on (32bit vs 64bit will 
  be different) 32,768 is the lowest I think
  Bignum basically lets you go until you use up ALL OF TEH RAMS
  
  you can declare numbers using hex, octo, binary, and deca
  
  0x1f = 31
  0d51 = 51
  0b101 = 5
  0o34 = 28
  034  another way to use octo numbers
  
  you can use underscores to make a numbmer more readable, much like
  you would use commas
  
  100_999
  0b1010_1111_0110
 
  
=end