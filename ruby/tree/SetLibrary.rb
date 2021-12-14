#setはRuby標準ライブラリ
require 'set'

multiples_of_three = (1..100).select do |i|
  i % 3 == 0
end.to_set

multiples_of_five = (1..100).select do |i|
  i % 5 == 0
end.to_set

multiples_of_both = multiples_of_three & multiples_of_five

1.upto(100) do |i|
  case
  when multiples_of_both.include?(i)
    puts "FuzzBuzz"
  when multiples_of_five.include?(i)
    puts "Buzz"
  when multiples_of_three.include?(i)
    puts "Fizz"
  else
    puts i
  end
end

