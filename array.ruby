# Arrayメソッド一覧

### Array.new(size, value) #=> array | valueを3つ持ったarrayオブジェクトを返す
# 全要素が同じオブジェクトを参照している
ary = Array.new(3, "hoge")
p ary #=> ["hoge", "hoge", "hoge"]
p ary[0].upcase! #=> "HOGE"
p ary #=> ["HOGE", "HOGE", "HOGE"]

### Array.new(ary) #=> array | 指定されたaryを複製する 浅い複製
p Array.new([1,2,3]) # => [1,2,3]
a = ["a", "b", "c"]
b = Array.new(a)
a.each{|value| value.upcase!}
p a #=> ["A", "B", "C"]
p b #=> ["A", "B", "C"]
