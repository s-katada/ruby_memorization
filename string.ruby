# Stringメソッド一覧

### tyr_convert(object) #=> (string || nil) | objectをstringへ変換を試みる
# 何らかの理由で変換できない時はnilを返す
# objectがstringかどうか確認するためのメソッドだと思われる
p String.try_convert("hoge") #=> "hoge"
p String.try_convert({hoge: "hoge"}) #=> nil

### self % args #=> string | printfと同じ規則でargsをフォーマット化して表示する
# argsが配列であればself % *argsと同じになる
p "i : %d" % 23 #=> "i : 23"
p "%d月%d日" % [11, 28] #=> "11月28日"

### self * times #=> string | selfをtimes回繰り返した新しい文字列を返す
p "hoge"  * 4 #=> "hogehogehogehoge"
p "hoge" * 0 #=> ""

### self + other #=> string | selfとotherが連結した新しい文字列を返す
p "hoge" + "fugo" #=> "hogefugo"
# p "hoge" + nil #=> "error"

### + self #=> (string || self) | selfがfreezeされている文字列の場合は複製を返し、freezeされていない場合はselfを返す
# 複製された文字列はfreezeしていない
original_text = "hoge"
unfrozen_text = + original_text
p unfrozen_text.eql?(original_text) #=> true
p unfrozen_text.equal?(original_text) #=> true
original_text.upcase!
p unfrozen_text #=> "HOGE"
original_text.freeze
frozen_text = + original_text
p frozen_text.eql?(original_text) #=> true
p frozen_text.equal?(original_text) #=> false

### - self #=> (self || string) | selfがfreezeされている文字列の場合はselfを返し、freezeされていない場合は元の文字列を返す
# + selfの逆
original_text = "hoge"
unfrozen_text = - original_text
p original_text.eql?(unfrozen_text) #=> true
p original_text.equal?(unfrozen_text) #=> false
original_text.freeze
frozen_text = - original_text
p frozen_text.eql?(original_text) #=> true
p frozen_text.equal?(original_text) #=> true

### self << other || concat(other) #=> self | selfとotherを破壊的に連結したselfを返す
a = "hoge"
a << "fugo"
p a #=> "hogefugo"
a.concat("poge")
p a #=> "hogefugopoge"

### concat(*arguments) #=> self | selfに複数の文字列を破壊的に連結したselfを返す
a = "hoge"
a.concat("fugo", "poge")
p a #=> "hogefugopoge"
a.concat(*%w(lal fajo jofa))
p a #=> "hogefugopogelalfajojofa"

### self <=> other #=> (-1 || 0 || 1) | selfとotherをASCIIコード順で比較してselfが大きい時は1を返して同じ時は0、小さい時は-1を返す
a = "hoge"
b = "hoge"
c = "ioge"
d = "fa"
p a <=> b #=> 0
p a <=> c #=> -1
p a <=> d #=> 1

### self == other #=> boolean | selfとotherを比較して結果を返す
# 文字列でない時に何か処理が走るっぽい
p "hoge" == "hoge" #=> true
p "hoge" == "fugo" #=> false
p "hoge" == :hoge #=> false

### self =~ other #=> (integer || nil) | 正規表現otherとマッチしたindex番号を返す
# マッチしない時はnilを返す
a = "hoge"
p a =~ /hoge/ #=> 0
p a =~ /ge/ #=> 2
p a =~ /geho/ #=> nil

### self[index] || slice(index) #=> (string || nil) #=> index番目の文字列を返す
# indexが範囲を超える場合はnilを返す
a = "hoge"
p a[1] #=> "o"
p a.slice(1) #=> "o"
p a.slice(100) #=> nil

### self[index, length] || slice[index, length] #=> (string || nil) | selfのindex番目からlengthこの要素の文字列を返す
# indexが範囲を超える場合はnilを返す
a = "hogefugopoge"
p a[4, 4] #=> "fugo"
p a.slice(8, 4) #=> "poge"

### self[substr] || slice(substr) #=> (string || nil) | selfとsubstrを比較して一致した文字列を返す
# 一致しなかった場合nilを返す
p "string"["str"] #=> "str"
p "string".slice("ing") #=> "ing"
p "string".slice("sing") #=> nil

### self[regexp, index] || slice(regexp, index) #=> (string || nil) | 正規表現regexpにマッチする最初の部分文字列を返す
# indexを省略したときや0の時はマッチした部分文字列全体を返す
# マッチしない時はnilを返す
# よくわからない
p "hoge hogef"[/hoge/, 1] #=> nil

### self[regexp, name] || slice(regexp, name) #=> string | 正規表現regexpのnameで指定した名前付きキャプチャにマッチする最初の部分文字列を返す
# マッチする文字列がない場合はnilを返す
p "hogefugo"[/(?<hoge>....)(?<fugo>....)/] #=> "hogefugo"
p "hogefugo"[/(?<hoge>....)(?<fugo>....)/, "hoge"] #=> "hoge"
p "hogefugo"[/(?<hoge>....)(?<fugo>....)/, "fugo"] #=> "fugo"

### self[range] || slice[range] #=> string | rangeで指定したindexの範囲に含まれる部分文字列を返す
p "hoge"[0..2] #=> "hog"
p "fugo".slice(0..1) #=> "fu"
p "hoge".slice(4..10) #=> ""

### self[index] = value | selfのindex番号目をvalueで置き換える
a = "hoge"
a[2] = "n"
p a #=> "hone"
a [0] = "!!!"
p a #=> "!!!one"

### self[index, length] =  value | selfのindex番号目からlength個の文字をvalueに置き換える
a = "hogefugo"
a[0,4] = "poge"
p a #=> "pogefugo"
a[8, 4] = "hoge"
p a #=> "pogefugohoge"

### self[substr] = value #=> substrにマッチした文字列をvalueに置き換える
# selfが部分文字列substrを含まない時はerrorが吐き出される
buf = "string"
buf["trin"] = "!!"
p buf   # => "s!!g"

### self[regexp, index] = value | 正規表現regexpのindex番目に最初の部分文字列をvalueで置き換える
buf = "def exec(cmd)"
buf[/def\s+(\w+)/, 1] = "preprocess"
p buf    # => "def preprocess(cmd)"

### self[regexp, name] = value | 正規表現regexpのnameで指定した名前付きキャプチャにマッチする最初の部分文字列をvalueで置き換える
s = "FooBar"
s[/(?<foo>[A-Z]..)(?<bar>[A-Z]..)/, "foo"] = "Baz"
p s # => "BazBar"

### self[regexp] = value | 正規表現regexpにマッチした部分文字列をvalueで置き換える
s = "hoge"
s[/hoge/] = "HOGE"
p s #=> "HOGE"

### self[range] = value | rangeで指定した範囲の文字列をvalueで置き換える
s = "hoge"
s[3..7] = "fugo"
p s #=> "hogefugo"

### ascii_only? #=> boolean | selfが全てASCII文字で構成されていたらtrueを返しそれ以外はfalseを返す
p "hoge".ascii_only? #=> true
p "ほげほげ".ascii_only? #=> false

### capitalize(*options) #=> string | 文字列先頭の文字を大文字にして残りは小文字にする
# 様々なオプションが存在する String#downcaseを参照する
# capitalize!は破壊的
s = "hoge"
p s.capitalize  #=> "Hoge"

### casecmp(other) #=> (-1 || 0 || 1) | <=>を使ってselfとotherを比較するが、大文字小文字の区別はしない
p "abcd".casecmp("ABCD") #=> 0
p "abcd".casecmp("A") #=> -1

### casecmp?(other) #=> boolean | casecmpメソッドの返り値がbooleanになった版
p "abcd".casecmp?("AbCd") #=> true
p "abcd".casecmp?("a") #=> false