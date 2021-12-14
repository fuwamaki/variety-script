#structはRuby標準ライブラリ

class Tree < Struct.new(:left, :value, :right)
  def visit
    left.visit if left
    puts value
    right.visit if right
  end
end

tree =
  Tree.new(
    Tree.new(
      Tree.new(nil, :a, nil),
      :b,
      Tree.new(
        Tree.new(nil, :c, nil),
        :d,
        Tree.new(nil, :e, nil)
      )
    ),
    :f,
    Tree.new(
      nil,
      :g,
      Tree.new(
        Tree.new(
          nil,
          :h,
          nil
        ),
        :i,
        nil
      )
    )
)

tree.visit
puts tree.dig(:left, :right, :value)

