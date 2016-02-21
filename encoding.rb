#!/usr/bin/ruby
#encoding: us-ascii
puts "abc".encoding #defaults to utf-8 when no encoding is declared

lander_count = 10
probe_count = 20
puts "Lander count: #{lander_count}"
puts "Total units: #{lander_count + probe_count}"
