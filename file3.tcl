set x 10
set y 20
puts "x is $x"
puts "y is $x +$y"

puts "y is $y"
set y [expr $x + $y ]
puts "y is $y"
