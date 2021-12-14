#二分探索(binary search)

#square method
def square(x)
  x * x
end

#root method
def root(y)
  (0..Float::INFINITY).bsearch do |x|
    y < square(x)
  end
end

p root(2)
