class Table
  def initialize(array)
    @table = array.dup
  end
  # 指定したindex要素取り出し
  def [](index)
    @table[index-1]
  end
  # 指定したindexの位置に要素を代入
  def []=(index,value)
    @table[index-1] = value
  end
  # わかりやすい形で出力
  def inspect
    @table
  end
end

# main
array = [1,2,3,4]
table = Table.new(array)
p table[1]
table[2] = 3
p table
