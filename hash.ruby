## Hashメソッド一覧

### self.eql?(other) #=> bool | 自信と同じkeyとvalueを持っていたらtrueを返す
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
p h[:key] #=> "value"