# Arrayメソッド一覧

### Array.new(size, value) #=> array | valueをsize個持ったarrayオブジェクトを返す
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

### Array.new(size){|index| ... } #=> array | それぞれ違うオブジェクトのvalueをsize個持つarrayオブジェクトを返す
a = Array.new(3) {|index| index}
p a #=> [0,1,2]

b = Array.new(3) {"hoge"}
p b #=> ["hoge", "hoge", "hoge"]
c = b
b[0].upcase!
p b #=> ["HOGE", "hoge", "hoge"]

### Array.try_convert(obj) #=> (array || nil) | to_aryメソッドを使ってobjをarrayへの変換を試みている
# このメソッドは引数が配列がどうかを確かめるために使われている
p Array.try_convert([1]) #=> [1]
p Array.try_convert("a") #=> nil

