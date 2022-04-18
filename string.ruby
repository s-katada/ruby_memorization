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