## Hashメソッド一覧ß

### self.eql?(other) #=> bool | 自信と同じkeyとvalueを持っていたらtrueを返す 等値、同値
h1 = {a: "hoge", b: "fugo"}
h2 = {a: "hoge", b: "fugo"}
p h1.eql?(h2) #=> true

### self > other #=> bool | otherがselfの上位集合の時の時trueを返す
h1 = {a:1, b:2}
h2 = {a:1, b:2, c:3}
p h2 > h1 #=> true

### self[key] #=> value | keyに対応するvalueを返す
h = {:ab => "some" , :cd => "all"}
p h[:ab] #=> some
p h[:ef] #=> nil

### self[key] = value || store(key, value) | keyに対してのvalueを設定する
h = {}
h[:key] = "value"
h.store(:store, "store")
p h[:key] #=> "value"
p h[:store] #=> "store"

### assoc(key) #=> (array | nil) | ハッシュが引数に渡したkeyを持つ時、[key, value]の形式かnilで帰ってくる
h = {"colors"  => ["red", "blue", "green"], "letters" => ["a", "b", "c" ]}
p h.assoc("letters") #=> ["letters", ["a", "b", "c"]]
p h.assoc("foo") #=> nil

### clear #=> {} | ハッシュの中身をクリアにする default値はクリアされない 破壊的
h = Hash.new("default value")
h[:some] = "some"
p h.clear #=> {}
p h.default #=> "default value"

### clone || dup #=> {} | selfと同じ内容を持つオブジェクトを返す
# 浅いコピー identityは違う(と思われる)
h1 = {"have" => "have a", "as" => "as a"}
h2 = h1.dup #=> h1
h2["have"] = "has"
p h2 #=> {"have"=>"has", "as"=>"as a"}
p h1 #=> {"have"=>"have a", "as"=>"as a"}

### compact #=> ({} | nil) | 自身からvalueがnilを除いたものを返す
hash = {a: 1, b: nil, c: 3}
p hash.compact  #=> {:a=>1, :c=>3}
p hash          #=> {:a=>1, :b=>nil, :c=>3}
hash.compact!
hash            #=> {:a=>1, :c=>3}
p hash.compact! #=>  nil

### compare_by_identity #=> {} | hashからkeyでvalueを取得する時に同値性ではなく同一性で判断するようになる
h1 = { "a" => 100, "b" => 200, :c => 400 }
p h1.compare_by_identity? #=> false
p h1["a"] #=> 100
hoge = h1.keys[0] #=> "a"
p h1[:c] #=> 400
h1.compare_by_identity
p h1["a"] #=> nil
p h1[hoge] #=> 100
p h1[:c] #=> 400

### compare_by_identity #=> bool | hashからkeyでvalueを取得する時に等価、同一性で判断しているかを確認するメソッド
h1 = { "a" => 100, "b" => 200, :c => 400 }
p h1.compare_by_identity? #=> false
h1.compare_by_identity
p h1.compare_by_identity? #=> true

### default #=> ({} || nil) | hashのdefault値を設定する
# Hash.newにブロックを渡すとselfとkeyをブロックに渡して評価する
h = Hash.new("default")
p h.default #=> "default"
p h.default(:some) #=> "default"
p h #=> {}

h = Hash.new{|hash, key| hash[key] = "default"}
p h.default #=> nil
p h.default(:some) #=> nil
p h #=> {:some => "default"}

h = Hash.new
p h.default #=> nil
p h.default = "default"
p h #=> {}

### default_proc #=> ({} || nil) | hashのdefault値を返すProcオブジェクトを生成し返す
# hashがProcオブジェクトのdefault値を返さない時nilを返す
h = Hash.new{|hash, key| "This is chodoii honda in order to #{hash[key]}"}
proc = h.default_proc #=> Procオブジェクト
p proc.yield({hoge: "hoge"}, :hoge) #=> "This is chodoii honda in order to hoge"

h = Hash.new("default")
p h.default_proc #=> nil

### default_proc=(value) #=> Proc | hashのdefault値をProcに変更する
# hashのdefault値はなんでも良い
h = {}
h.default_proc = proc do |hash, key|
  hash[key] = case
  when (key % 15).zero?
    "FizzBuzz"
  when (key % 5).zero?
    "Buzz"
  when (key % 3).zero?
    "Fizz"
  else
    key
  end
end
p h[15] #=> "FizzBuzz"

### delete(key) #=> (object || nil) | keyに対応するvalueを削除する
# ブロックはkeyに対するvalueが存在しなかった時に実行される 破壊的
h = {:ab => "some" , :cd => "all"}

p h.delete(:ab) #=> "some"
p h.delete(:ef) #=> nil
p h.delete(:ef) {|key|"#{key} Nothing"} #=> "ef Nothing"
p h #=> {:cd=>"all"}

### delete_if || reject #=> self || reject! #=> (self || nil) | keyとvalueをブロック引数としてブロック評価が真の要素をselfから削除する
h = { 2 => "8" ,4 => "6" ,6 => "4" ,8 => "2" }

p h.reject!{|key, value| key.to_i < value.to_i }   #=> { 6 => "4", 8 => "2" }
p h                                                #=> { 6 => "4", 8 => "2" }

p h.delete_if{|key, value| key.to_i < value.to_i } #=> { 6 => "4", 8 => "2" }
p h.reject!{|key, value| key.to_i < value.to_i }   #=> nil

### dig(key, key2, key3, ...) #=> (nil || object) #=> self以下のネストしたオブジェクトを再起的に参照する
# 途中のオブジェクトがnilの時nilを返す
h = { foo: {bar: {baz: 1}}}

p h.dig(:foo, :bar, :baz) # => 1
p h.dig(:foo, :zot, :xyz) # => nil

g = { foo: [10, 11, 12] }
p g.dig(:foo) #=> [10, 11, 12]
p g.dig(:foo, 1) # => 11

### each_key #=> object || Enumerator | hashのkeyを引数と取りブロックを評価する
# ブロックを渡さないとEnumratorが返される
h = {:a => "a", :b => "b"}
p h.each_key{|key| p key} #=> :a, :b

### each_value #=> object || Enumerator | hashのvalueを引数で取りブロックを評価する
# ブロックを渡さないとEnumeratorが返される
h = {:a => "a", :b => "b"}
p h.each_value{|value| p value} #=> "a", "b"

### empty? #=> boolean | hashがからの時trueを返す
h = {hoge: "hoge"}
p h.empty? #=> false
h2 = {}
p h2.empty? #=> true

### equal?(other) #=> boolean | selfとotherが等価、同一の時ttrueを返す
h1 = {hoge: "hoge"}
h2 = {hoge: "hoge"}
h3 = h1
p h1.equal?(h2) #=> false
p h1.equal?(h3)

### except(*keys) #=> object | 引数で指定されたkeyにマッチするもの以外のhashを返す
h = { a: 100, b: 200, c: 300 }
h.except(:a) #=> {b: 200, c: 300}

### fetch(key, default = nil) #=> value || nil | keyに関連づけられたvalueを返す 
# hashに初期設定されているdefault値は無視される
# 第二引数にdefault値を設定しておくとkeyに対するvalueが存在しない時第二引数であるdefault値を返す
# ブロックを渡しておくとkeyに対応するvalueがない時ブロックを実行する
h = {one: nil, two: "two"}
p h[:one], h[:two], h[:three] #=> nil, "two", nil
p h.fetch(:one), h.fetch(:two) #=> nil. "two"
# p h.fetch(:three) #=> error: key not found
p h.fetch(:three, "default") #=> "default"
p h.fetch(:three) {|key| "#{key} is not exist"}
p h.fetch(:three, "error"){|key| #=> "three not exist"
  "#{key} not exist"
}
h.default = "default"
# p h.fetch(:three) #=> error

### fetch_values(key, ...) #=> object | 引数で指定されたkeyに関連づけられたvalueの配列を返す
# keyに関連づいたvalueがない場合はブロックを評価して返す
# ブロックがない時はkeyErrorを返す
h = { "cat" => "feline", "dog" => "canine", "cow" => "bovine" }
p h.fetch_values("cat") #=> ["feline"]
# p h.fetch_values("hoge") #=> keyError
p h.fetch_values("hoge") {|key| "#{key} is not exist"} #=> ["hoge is not exist"]
p h.fetch_values("cow", "bird") {|key| key.upcase} #=> ["bovine", "BIRD"]

### select || filter #=> hash | ブロックで真と評価されたペアだけを含むhashを返す
h = { "a" => 100, "b" => 200, "c" => 300 }
p h.select {|key, value| key > "a"} #=> {"b" => 200, "c" => 300}
p h.select {|key, value| value < 200} #=> {"a" => 100}

### keep_if #=> self || select! #=> (nil | self) || filter! (nil | self) | keyとvalueを引数としたvalueを評価して真となった要素をselfに残す 破壊的
# select!とfilter!はselfに変更があればselfを返し、なければnilを返す
h = { "a" => 100, "b" => 200, "c" => 300 }
p h.keep_if {|key, value| key > "a"} #=> {"b"=>200, "c"=>300}
p h.select! {|key, value| key > "a"} #=> nil
p h.filter! {|key, value| value > 200} #=> {"c"=>300}

### flatten(lebel) #=> array | 自信を平坦化したarrayを返す
a =  {1=> "one", 2 => [2,"two"], 3 => "three"}
p a.flatten #=> [1, "one", 2, [2, "two"], 3, "three"]
p a.flatten(1) #=> [1, "one", 2, [2, "two"], 3, "three"]
p a.flatten(2) #=> [1, "one", 2, 2, "two", 3, "three"]
p a.flatten(0) #=> [[1, "one"], [2, [2, "two"]], [3, "three"]]
p a.flatten(-1) #=> [1, "one", 2, 2, "two", 3, "three"]

### has_key?(key) | include?(key) | key?(key) | member?(key) #=> boolean | selfが引数に指定したkeyを持っているかどうか
h = {hoge: "hoge", fugo: "fugo", nil: nil}
p h.has_key?(:hoge) #=> true
p h.key?("hoge") #=> false

### has_value?(value) | value?(value) #=> boolean | selfが引数に指定したvalueを持っているかどうか
h = {hoge: "hoge", poge: "poge", number: 123}
p h.has_value?("hoge") #=> true
p h.has_value?(123) #=> true
p h.value?(12) #=> false

### hash #=> integer | 自身が保持するkeyとvalueのハッシュ値を元にして算出した数値を返す
a = {}
p a.hash #=> -4345107025984234871
a[1] = :x
p a.hash #=> 3314123329268928184

### key(value) || index(value) #=> (object || nil) | valueに対するkeyを返す
# indexメソッドはレガシーなのでversionによっては使えない可能性がある
h = {:ab => "some" , :cd => "all" , :ef => "all"}
h.key("some") #=> :ab
h.key("hoge") #=> nil

### to_s || inspect #=> string | 人間が読みやすい文字列が帰ってくる
h = {hoge: "hoge", fugo: "fugo", poge: 123}
p h.to_s #=> "{:ab=>\"some\", :cb=>\"all\", :ef=>\"hoge\"}"
p h.inspect #=> "{:ab=>\"some\", :cb=>\"all\", :ef=>\"hoge\"}"

### invert #=> object | keyとvalueを入れ替えたhashを返す
# valueがかぶっている時は最後に定義されているものでhashが生成される
h = { "a" => 0, "b" => 100, "c" => 200, "d" => 300, "e" => 300 }
p h.invert #=> {0=>"a", 100=>"b", 200=>"c", 300=>"e"}

### keys #=> object | hashに存在するkeyで作られた配列を生成して返す
h1 = { "a" => 100, 2 => ["some"], :c => "c" }
p h1.keys #=> ["a", 2, :c]

### length || size #=> integer | hashのの要素の数を返す
h = { "d" => 100, "a" => 200, "v" => 300, "e" => 400 }
h.length      #=> 4
h.size        #=> 4
h.delete("a") #=> 200
h.length      #=> 3
h.size        #=> 3

### merge(*others) #=> hash || merge(*others) {|key, self_value, other_value| ... } #=> hash | selfとothersを~~~順番に~~~マージした結果を返す
# ブロックを追加するとkeyがダブった時の処理を加えることができる
# default値はselfのまま
h1 = { "a" => 100, "b" => 200 }
h2 = { "b" => 246, "c" => 300 }
h3 = { "b" => 357, "d" => 400 }
p h1.merge #=> {"a"=>100, "b"=>200}
p h1.merge(h2) #=> {"a"=>100, "b"=>246, "c"=>300}
p h1.merge(h2, h3) #=? { "a" => 100, "b" => 357, "c" => 300, "d" => 400 }
p h1.merge(h2, h3) {|key, old_value, new_value| new_value - old_value} #=> { "a" => 100, "b" => 311, "c" => 300, "d" => 400 }

### merge!(*others) || update(*others) #=> hash | mergeメソッドの破壊的メソッド
h1 = { "a" => 100, "b" => 200 }
h2 = { "b" => 246, "c" => 300 }
h3 = { "b" => 357, "d" => 400 }
p h1.merge!(h2) #=> {"a"=>100, "b"=>246, "c"=>300}
p h1 #=> {"a"=>100, "b"=>246, "c"=>300}
p h2.update(h3) #=> {"b"=>357, "c"=>300, "d"=>400}
p h2 #=> {"b"=>357, "c"=>300, "d"=>400}

### rassoc(value) #=> array || nil | hash内を検索して引数に渡したvalueと一致する組みを配列で返す
a = {1=> "one", 2 => "two", 3 => "three", "ii" => "two"}
p a.rassoc("one") #=> [2, "two"]
p a.rassoc("hoge") #=> nil

### rehash #=> self | keyのhash値を再計算する
# keyになっているオブジェクトが変化した時にrehashを使用しないとそのkeyに対するvalueを取り出すことができない
a = [ "a", "b" ]
h = { a => 100 }
p h[a]       #=> 100
a[0] = "z"
p h[a]       #=> nil
p h.rehash   #=> {["z", "b"] => 100}
p h[a]       #=> 100

### reject{|key, value| ... } #=> hash | selfを複製してブロックで評価した値が真になる要素を削除したhashを返す
h = { 2 =>"8" ,4 =>"6" ,6 =>"4" ,8 =>"2" }
p h.reject{ |key, value| key > value.to_i } #=> {2 => "8",  4 => "6"}