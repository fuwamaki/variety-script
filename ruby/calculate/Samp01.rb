#コメントアウト：#を用いるか、下記のようにbeginとendを用いる
=begin
コメントを
いくつか明記
=end

#each文
list = ["a", "b", "c"]
list.each{|num|
	puts num
}
list.each do |n|
	puts n
end

#case文
str = "c"
case str
when "a"
	puts "#{str}でした"
when "b"
	puts "なんでbなんだよ"
else
	puts "ちがいました"
end

formula = ["あ","い","う","え", "お"]
formula.each_with_index do |value, num|
	puts "数が#{num}で、値が#{value}"
end

text = ""
File.open('sample_formula.txt') do |file|
	file.each_line do |sentence|
		text += sentence
	end
end
puts text


listbox = []
val1 = 9
val2 = 20
val3 = 2
3.times do
	listbox << [val1,val2,val3]
	val1 += 1
	val2 -= 1
	val3 *= 2
end

puts listbox.pop
print "#{listbox}"
