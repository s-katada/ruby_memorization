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

### assoc(key) #=> (array | nil) | ハッシュがkeyを持つ時、[key, value]の形式かnilで帰ってくる
h = {"colors"  => ["red", "blue", "green"], "letters" => ["a", "b", "c" ]}
p h.assoc("letters") #=> ["letters", ["a", "b", "c"]]
p h.assoc("foo") #=> nil

### clear #=> {} | ハッシュの中身をクリアにする default値はクリアされない
h = Hash.new("default value")
h[:some] = "some"
p h.clear #=> {}
p h.default #=> "default value"

### clone || dup #=> {} | selfと同じ内容を持つオブジェクトを返す 浅いコピー identityは違う(と思われる)
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

### compare_by_identity #=> bool | hashからkeyでvalueを取得する時に同一性で判断しているかを確認するメソッド
h1 = { "a" => 100, "b" => 200, :c => 400 }
p h1.compare_by_identity? #=> false
h1.compare_by_identity
p h1.compare_by_identity? #=> true

### default #=> ({} || nil) | hashのdefault値を設定する Hash.newにブロックを渡すとselfとkeyをブロックに渡して評価する
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

### default_proc #=> ({} || nil) | hashのdefault値を返すProcオブジェクトを生成し返す hashがProcオブジェクトのdefault値を返さない時nilを返す
h = Hash.new{|hash, key| "This is chodoii honda in order to #{hash[key]}"}
proc = h.default_proc #=> Procオブジェクト
p proc.yield({hoge: "hoge"}, :hoge) #=> "This is chodoii honda in order to hoge"

h = Hash.new("default")
p h.default_proc #=> nil

### default_proc=(value) #=> Proc | hashのdefault値をProcに変更する hashのdefault値はなんでも良い
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

### delete(key) #=> (object || nil) | keyに対応するvalueを削除する ブロックはkeyに対するvalueが存在しなかった時に実行される 破壊的
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

### dig(key, key2, key3, ...) #=> (nil || object) #=> 
h = { foo: {bar: {baz: 1}}}

p h.dig(:foo, :bar, :baz) # => 1
p h.dig(:foo, :zot, :xyz) # => nil

g = { foo: [10, 11, 12] }
p g.dig(:foo) #=> [10, 11, 12]
p g.dig(:foo, 1) # => 11

### each_key #=> object || Enumerator | hashのkeyを引数と取りブロックを評価する ブロックを渡さないとEnumratorが返される
h = {:a => "a", :b => "b"}
p h.each_key{|key| p key} #=> :a, :b

### each_value #=> object || Enumerator | hashのvalueを引数で取りブロックを評価する ブロックを渡さないとEnumeratorが返される
h = {:a => "a", :b => "b"}
p h.each_value{|value| p value} #=> "a", "b"

