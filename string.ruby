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

### + self #=> (string || self) | selfがfreezeされていると文字列の場合は複製を返し、freezeしていない時はされていない場合はselfを返す
original_text = "hoge"
unfrozen_text = + original_text
p unfrozen_text.eql?(original_text) #=> true
p unfrozen_text.equal?(original_text) #=> true
original_text.freeze
frozen_text = + original_text
p frozen_text.eql?(original_text) #=> true
p frozen_text.equal?(original_text) #=> false
