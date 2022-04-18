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
