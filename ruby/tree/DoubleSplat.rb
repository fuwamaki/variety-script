#HashのDouble Splatを実現 -> **

#まず、Splatについて -> *

p "***splat 配列に変換！***"
symbol = *:symbol
p symbol #-> [:symbol]
hash = *{hash: nil}
p hash #-> [[:hash, nil]]
range = *(1..10)
p range #-> [1,2,3,4,5,6,7,8,9,10]

p "***splat 親クラスの引数を気にしない！***"
#class Child < Super
#  def initialize(*)
#    super
#  end
#end

p "***間にある引数をまとめられる！***"
list = [[:first, :second, :third, :fourth, :fifth]]
list.each do |first, *mid, last|
  p first #-> :first
  p mid #-> [:second, :third, :fourth]
  p last #-> :fifth
end
first, *other = [1,2,3]
p other #->[2,3]

p "***Double Splat***"
def zuttomo_3_energy_charges(kw)
  summer = {month_from: 7, month_to: 9}
  winter = {month_from: 10, month_to: 6}
  stage1 = {kwh_from: 0, kwh_to: kw * 130}
  stage2 = {kwh_from: kw * 130, kwh_to: nil}
  [
    {**summer, **stage1, rate: 16.91},
    {**summer, **stage2, rate: 18.37},
    {**winter, **stage1, rate: 16.37},
    {**winter, **stage2, rate: 18.26},
  ]
end


