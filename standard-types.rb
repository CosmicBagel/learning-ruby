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

#strings

=begin
set encoding by declaring 
    #encoding: us-ascii
as the first line
default encoding is utf-8

use backslash to escape characters, functions as you'd expect from 
other languages

to declare a string literal, use %q[this_is_literal]
you can use any delimter you want, in this case I used '[' and ']'

common escape characters
\n newline
\t tab
\" double quote

octal code
\100 @
\x40 @

unicode
\u20ac


string embeded expressions aka interpolation
#{expression} can be use within a string

- more performant than concatonation since it doesn't create
  multiple string objects
- cleaner looking, though long complicated expressions will lead to
  messy code
  
strings can be accessed with [1] to get a specifc character, and substring [1,3]
common methods are
upcase
downcase
capitalize
gsub #replaces characters

throwing a ! at the end of these methods will apply the change to the 
original object
eg a.upcase! will change a, not just return a new string

can get arrays of chars, codepoints, and bytes
a.chars, a.bytes, as.codepoints

can easily iterate over a string using a.each_char {|c| puts c }
a.each_byte and a.each_codepoint are also available
see a.methods for a full list

"1 2 3".split will split by the space character by default

=end

#LETS TALK ABOUT REGEX

=begin
  /regexhere/ most common way to write a regex
  m = /(\d+):(\d+)/.match "Time is 12:13am"
  the match has a number of attributes
  m.pre_match = "Time is "
  m[0] = "12:13"
  m[1] = "12"
  m[2] = "13"
  m.post_match = "am"
  
  ruby sets these into some global vars
  $` = pre_match
  %& = m[0]
  $1, $2, ... = m[1], m[2], ...
  $' = post_match
  
=end