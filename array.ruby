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

### self & other #=> array | 積集合 両方の配列に含まれる要素を新しい配列にして返す 重複する要素は取り除かれる
p [1,1,2,3] & [1,3] #=> [1, 3]

### self * times #=> array | selfをtimes回繰り返した配列を返す
a1 = [1, 2, 3]
p a2 = a1 * 3 #=> [1, 2, 3, 1, 2, 3, 1, 2, 3]

### self * sep #=> string | selfの各要素にsepを挟んだstringを返す joinメソッドと同じ
p [1,2,3] * "..." #=> "1...2...3"

### self + other #=> array | selfとotherを繋げる
a = [1,2,3]
b = [3,5,6]
p a + b #=> [1,2,3,3,5,6]

### self - other #=> array | selfからotherを取り除いた配列を返す
a = [1,1,2,3,4,4,4,5]
b = [3,5]
c = [1,4]
p a - b #=> [1,1,2,4,4,4]
p a - c #=> [2,3,5]

### self << obj #=> array | selfにobjを破壊的に追加する
a = ["hoge", "fugo"]
a << :poge
p a #=> ["hoge", "fugo", :poge]

### self <=> other #=> (-1 || 0 || 1 || nil) | selfがotherより小さければ-1、同じ時0、大きい時1、それ以外はnil
# 各要素を順番に見ていくらしい
p [ 1, 2, 3 ] <=> [ 1, 3, 2 ]       #=> -1
p [ 1, 2, 3 ] <=> [ 1, 2, 3 ]       #=> 0
p [ 1, 2, 3 ] <=> [ 1, 2 ]          #=> 1

### self == other #=> boolean | selfとotherをそれぞれ順番に見ていきすべてのvalueが同じ時trueを返す
p [1,2,3] == [1,2,3] #=> true
p [2,3] == [1] #=> false

