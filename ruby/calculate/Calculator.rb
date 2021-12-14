#起動時
puts "==========計算機 起動=========="

#入力させたいとき
#print "計算したい式："
#formula = gets.chomp

#テキストファイルから読み込みたいとき
formula = ""
File.open('sample_formula.txt') do |file|
         file.each_line do |sentence|
                 formula += sentence
         end
end


#<+,-,*,/,(,)>で文字分割
formula_list = formula.split(/\s*(\+|\-|\*|\/|\(|\)|\D|\s)\s*/)
	.reject{|w|
		w=="" or w==" "
	}

#不適切文字の確認
formula_list.each do |element|
	case element
		when /^(0|[1-9]\d*)$/, /(\+|\-|\*|\/)/, /(\(|\))/
			#puts "no problem"
		else
			#TODO: 問題があればbreak
			#puts "#{element} is problem"
	end
end

brackets_level = 0

brackets_range_start = []
brackets_range_end = []
brackets_range_level = []

#カッコの対応調査
formula_list.each_with_index do |value, orderNum|
	case value
		when /\(/
			brackets_range_start.push(orderNum)
			brackets_level += 1
			brackets_range_level.push(brackets_level)
		when /\)/
			brackets_range_end.push(orderNum)
			brackets_level -= 1
	end
end

brackets_range = [] #[startNum, endNum, level]
arraybox = []
formula_list.each_with_index do |value, orderNum|
	case value
		when /\(/
			arraybox.push(orderNum)
			brackets_level += 1
		when /\)/
			brackets_range.push([arraybox.pop, orderNum, brackets_level])
			brackets_level -= 1
	end
end
#print "#{brackets_range}"


#カッコ調査が合っているか確認
#i = 0
#while i < brackets_range_start.length do
#	puts "#{brackets_range_start[i]}~#{brackets_range_end[i]}: level#{brackets_range_level[i]}"
#	i += 1
#end

#計算する()の式を決定
n = 0
brackets_range_level.each_with_index do |w, orderNum|
	if w == brackets_range_level.max then
		n = orderNum
		break
	end
end

#先頭の配列取得
x = brackets_range.shift
calcurate_range = x[0]+1..x[1]-1
calcurate_range.each do |w|
	print formula_list[w]
end
print "\n"

#計算をする
answer = 0


#計算結果を表示
print "計算結果："
puts answer
print "==========計算機 終了=========="
