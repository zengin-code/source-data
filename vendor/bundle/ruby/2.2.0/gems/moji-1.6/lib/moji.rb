# coding: utf-8

#このファイルの文字コードはUTF-8です。
#このファイルをUnicode非対応のエディタで編集してはいけません（〜が文字化ける）。

=begin

=Moji モジュール

日本語の文字種判定、文字種変換(半角→全角、ひらがな→カタカナなど)を行います。

==インストール:

以下のコマンドを実行してください。

  $ sudo gem install moji

==使い方:

Ruby 1.8: (({$KCODE})) を指定してから (({require "moji"})) してください。
Moji モジュールの関数に渡す文字列の文字コードは (({$KCODE})) と一致させてください。

Ruby 1.9: どの文字コードの文字列を渡しても大丈夫ですが、 String#encoding が正しく設定されている
必要があります。正規表現を返す関数( Moji.kata など)は Encoding.default_internal
(設定されてない場合はUTF-8)用の正規表現を返します。その他のエンコーディング用の正規表現は
Moji.kata(Encoding::SJIS) などで取得できます。

  $KCODE= "UTF8"                                       # Ruby 1.9では不要
  require "moji"
  
  #文字種判定。
  p Moji.type("漢")                                    # => Moji::ZEN_KANJI
  p Moji.type?("Ａ", Moji::ZEN)                        # => true
  
  #文字種変換。
  p Moji.zen_to_han("Ｒｕｂｙ")                        # => "Ruby"
  p Moji.upcase("Ｒｕｂｙ")                            # => "ＲＵＢＹ"
  p Moji.kata_to_hira("ルビー")                        # => "るびー"
  
  #文字種による正規表現。
  p /#{Moji.kata}+#{Moji.hira}+/ =~ "ぼくドラえもん"   # => 6
  p Regexp.last_match.to_s                             # => "ドラえもん"

==定数:

以下の定数は、文字種の一番細かい分類です。
(({Moji.type})) が返すのは、以下の定数のうちの1つです。

--- HAN_CONTROL
    制御文字。
--- HAN_ASYMBOL
    ASCIIに含まれる半角記号。
--- HAN_JSYMBOL
    JISに含まれるがASCIIには含まれない半角記号。
--- HAN_NUMBER
    半角数字。
--- HAN_UPPER
    半角アルファベット大文字。
--- HAN_LOWER
    半角アルファベット小文字。
--- HAN_KATA
    半角カタカナ。
--- ZEN_ASYMBOL
    JISの全角記号のうち、ASCIIに対応する半角記号があるもの。
--- ZEN_JSYMBOL
    JISの全角記号のうち、ASCIIに対応する半角記号がないもの。
--- ZEN_NUMBER
    全角数字。
--- ZEN_UPPER
    全角アルファベット大文字。
--- ZEN_LOWER
    全角アルファベット小文字。
--- ZEN_HIRA
    ひらがな。
--- ZEN_KATA
    全角カタカナ。
--- ZEN_GREEK
    ギリシャ文字。
--- ZEN_CYRILLIC
    キリル文字。
--- ZEN_LINE
    罫線のかけら。
--- ZEN_KANJI
    漢字。

以下の定数は、上の文字種の組み合わせと別名です。

--- HAN_SYMBOL
    JISに含まれる半角記号。(({HAN_ASYMBOL | HAN_JSYMBOL}))
--- HAN_ALPHA
    半角アルファベット。(({HAN_UPPER | HAN_LOWER}))
--- HAN_ALNUM
    半角英数字。(({HAN_ALPHA | HAN_NUMBER}))
--- HAN
    全ての半角文字。(({HAN_CONTROL | HAN_SYMBOL | HAN_ALNUM | HAN_KATA}))
--- ZEN_SYMBOL
    JISに含まれる全角記号。(({ZEN_ASYMBOL | ZEN_JSYMBOL}))
--- ZEN_ALPHA
    全角アルファベット。(({ZEN_UPPER | ZEN_LOWER}))
--- ZEN_ALNUM
    全角英数字。(({ZEN_ALPHA | ZEN_NUMBER}))
--- ZEN_KANA
    全角かな/カナ。(({ZEN_KATA | ZEN_HIRA}))
--- ZEN
    JISに含まれる全ての全角文字。(({ZEN_SYMBOL | ZEN_ALNUM | ZEN_KANA | ZEN_GREEK | ZEN_CYRILLIC | ZEN_LINE | ZEN_KANJI}))
--- ASYMBOL
    ASCIIに含まれる半角記号とその全角版。(({HAN_ASYMBOL | ZEN_ASYMBOL}))
--- JSYMBOL
    JISに含まれるが (({ASYMBOL})) には含まれない全角/半角記号。(({HAN_JSYMBOL | ZEN_JSYMBOL}))
--- SYMBOL 
    JISに含まれる全ての全角/半角記号。(({HAN_SYMBOL | ZEN_SYMBOL}))
--- NUMBER
    全角/半角数字。(({HAN_NUMBER | ZEN_NUMBER}))
--- UPPER
    全角/半角アルファベット大文字。(({HAN_UPPER | ZEN_UPPER}))
--- LOWER
    全角/半角アルファベット小文字。(({HAN_LOWER | ZEN_LOWER}))
--- ALPHA
    全角/半角アルファベット。(({HAN_ALPHA | ZEN_ALPHA}))
--- ALNUM
    全角/半角英数字。(({HAN_ALNUM | ZEN_ALNUM}))
--- HIRA
    (({ZEN_HIRA})) の別名。
--- KATA
    全角/半角カタカナ。(({HAN_KATA | ZEN_KATA}))
--- KANA
    全角/半角 かな/カナ。(({KATA | ZEN_HIRA}))
--- GREEK
    (({ZEN_GREEK})) の別名。
--- CYRILLIC
    (({ZEN_CYRILLIC})) の別名。
--- LINE
    (({ZEN_LINE})) の別名。
--- KANJI
    (({ZEN_KANJI})) の別名。
--- ALL
    上記全ての文字。

==モジュール関数:

--- Moji.type(ch)
    
    文字 ((|ch|)) の文字種を返します。
    
    「一番細かい分類」の((<定数|定数:>))のうち1つを返します。
    
    上の分類に当てはまらない文字(Unicodeのハングルなど)に対しては (({nil})) を返します。
    また、UnicodeのB面以降の文字に対しても (({nil})) を返します。
    
    文字が割り当てられていない文字コードに対する結果は不定です( (({nil})) を返す事もあります)。
    
      p Moji.type("漢")   # => Moji::ZEN_KANJI
    
--- Moji.type?(ch, type)
    
    文字 ((|ch|)) が文字種 ((|type|)) に含まれれば、 (({true})) を返します。
    
    ((|type|)) には全ての((<定数|定数:>))と、それらを (({|}))
    で結んだものを使えます。
    
      p Moji.type?("Ａ", Moji::ZEN)   # => true
    
--- Moji.regexp(type[, encoding])
    
    文字種 ((|type|)) の1文字を表す正規表現を返します。
    
    ((|type|)) には全ての((<定数|定数:>))と、それらを (({|}))
    で結んだものを使えます。
    
    Ruby 1.9では ((|encoding|)) に Encoding オブジェクトを渡すと、指定のエンコーディング用の
    正規表現を返します。
    省略すると Encoding.default_internal (指定されてない場合は Encoding::UTF_8 )とみなします。
    
      p Moji.regexp(Moji::HIRA)   # => /[ぁ-ん]/
    
--- Moji.zen_to_han(str[, type])
    
    文字列 ((|str|)) の全角を半角に変換して返します。
    
    ((|type|)) には、変換対象とする文字種を((<定数|定数:>))で指定します。
    デフォルトは (({ALL})) (全て)です。
    
      p Moji.zen_to_han("Ｒｕｂｙ！？")                # => "Ruby!?"
      p Moji.zen_to_han("Ｒｕｂｙ！？", Moji::ALPHA)   # => "Ruby！？"
    
--- Moji.han_to_zen(str[, type])
    
    文字列 ((|str|)) の半角を全角に変換して返します。
    
    ((|type|)) には、変換対象とする文字種を((<定数|定数:>))で指定します。
    デフォルトは (({ALL})) (全て)です。
    
      p Moji.han_to_zen("Ruby!?")                 # => "Ｒｕｂｙ！？"
      p Moji.han_to_zen("Ruby!?", Moji::SYMBOL)   # => "Ruby！？"
    
--- Moji.normalize_zen_han(str)
    
    文字列 ((|str|)) の大文字、小文字を一般的なものに統一します。
    
    具体的には、ASCIIに含まれる記号と英数字( (({ALNUM|ASYMBOL}))
    )を半角に、それ以外の記号とカタカナ( (({JSYMBOL|HAN_KATA})) )を全角に変換します。
    
--- Moji.upcase(str[, type])
    
    文字列 ((|str|)) の小文字を大文字に変換して返します。
    
    ((|type|)) には、変換対象とする文字種を((<定数|定数:>))で指定します。
    デフォルトは (({LOWER})) (全角/半角のアルファベット)です。
    ギリシャ文字、キリル文字には対応していません。
    
      p Moji.upcase("Ｒｕｂｙ")   # => "ＲＵＢＹ"
    
--- Moji.downcase(str[, type])
    
    文字列 ((|str|)) の小文字を大文字に変換して返します。
    
    ((|type|)) には、変換対象とする文字種を((<定数|定数:>))で指定します。
    デフォルトは (({UPPER})) (全角/半角のアルファベット)です。
    ギリシャ文字、キリル文字には対応していません。
    
      p Moji.downcase("Ｒｕｂｙ")   # => "ｒｕｂｙ"
    
--- Moji.kata_to_hira(str)
    
    文字列 ((|str|)) の全角カタカナをひらがなに変換して返します。
    
    半角カタカナは直接変換できません。 (({han_to_zen})) で全角にしてから変換してください。
    
      p Moji.kata_to_hira("ルビー")   # => "るびー"
    
--- Moji.hira_to_kata(str)
    
    文字列 ((|str|)) のひらがなを全角カタカナに変換して返します。
    
      p Moji.hira_to_kata("るびー")   # => "ルビー"
    
--- Moji.han_control([encoding])
--- Moji.han_asymbol([encoding])
--- ...
--- Moji.kana([encoding])
--- ...
    
    ((<定数|定数:>))それぞれに対応するメソッドが有り、
    それぞれの文字種の1文字を表す正規表現を返します。
    
    例えば、 (({Moji.kana})) は (({Moji.regexp(Moji::KANA)})) と同じです。
    
    Ruby 1.9では ((|encoding|)) に Encoding オブジェクトを渡すと、指定のエンコーディング用の
    正規表現を返します。
    省略すると Encoding.default_internal (指定されてない場合は Encoding::UTF_8 )とみなします。
    
    以下の例のように、文字クラスっぽく使えます。
      p /#{Moji.kata}+#{Moji.hira}+/ =~ "ぼくドラえもん"   # => 6
      p Regexp.last_match.to_s                             # => "ドラえもん"
    
==動作環境:

たぶんRuby 1.8以降。

Linux Ruby 1.8.7, 1.9.2にて動作確認しました。

==作者:

Gimite 市川 (連絡先: ((<URL:http://gimite.ddo.jp/bbs/tnote.cgi>)) )

==ライセンス:

Public Domainです。煮るなり焼くなりご自由に。

==Github:

((<URL:http://github.com/gimite/moji>))

==更新履歴:

2010/9/19 Ver.1.5
*Ruby 1.9に対応。

2008/8/30 Ver.1.4
*Moji.type("\n")がnilを返すバグを修正。(thanks to 橋爪さん)

2006/7/23 Ver.1.3
*半角中黒(･)の字種判別、全角中黒との相互変換ができていなかったのを修正。(thanks to xyzzyさん)

2006/10/5 Ver.1.2
*EUC 以外の文字コードにも対応し、ライブラリ名を Moji に変更。
*han_to_zen, zen_to_han の対象文字種のデフォルトを全て( (({ALL})) )に。
*normalize_zen_han 追加。

2005/1/3 Ver.1.1
*(({$KCODE})) が指定されていないとEUCUtil.typeが正常動作しない問題を修正。
*定数に (({ASYMBOL})) と (({JSYMBOL})) を追加。

2004/11/16 Ver.1.0
*EUCUtil 公開。

=end


if RUBY_VERSION < "1.9.0" && $KCODE=="NONE"
  warn("Warning: Set $KCODE before requiring 'moji' (UTF8 assumed)")
  $KCODE= "u"
end

require "enumerator"
require "flag_set_maker"
if RUBY_VERSION < "1.9.0"
  require "nkf"
  require "jcode"
end

nkf_kcode= RUBY_VERSION >= "1.9.0" ? nil : {"SJIS" => "s", "EUC" => "e"}[$KCODE]

script= <<'EOS'


module Moji
  
  extend(FlagSetMaker)
  
  module Detail
    
    HAN_ASYMBOL_LIST= ' !"#$%&\'()*+,-./:;<=>?@[\]^_`{|}~'
    ZEN_ASYMBOL_LIST= '　！”＃＄％＆’（）＊＋，－．／：；＜＝＞？＠［￥］＾＿‘｛｜｝￣'
    HAN_JSYMBOL1_LIST= '｡｢｣､ｰﾞﾟ･'
    ZEN_JSYMBOL1_LIST= '。「」、ー゛゜・'
    ZEN_JSYMBOL_LIST= '、。・゛゜´｀¨ヽヾゝゞ〃仝々〆〇ー―‐＼～〜∥…‥“〔〕〈〉《》「」『』【】'+
      '±×÷≠≦≧∞∴♂♀°′″℃￠￡§☆★○●◎◇◇◆□■△▲▽▼※〒→←↑↓〓'
    HAN_KATA_LIST= 'ﾊﾋﾌﾍﾎｳｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄｱｲｴｵﾅﾆﾇﾈﾉﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜｦﾝｧｨｩｪｫｬｭｮｯ'.split(//)
    HAN_VSYMBOLS= ['', 'ﾞ', 'ﾟ']
    ZEN_KATA_LISTS= [
      'ハヒフヘホウカキクケコサシスセソタチツテトアイエオ'+
        'ナニヌネノマミムメモヤユヨラリルレロワヲンァィゥェォャュョッ',
      'バビブベボヴガギグゲゴザジズゼゾダヂヅデド',
      'パピプペポ',
    ].map(){ |s| s.split(//) }
    
    if RUBY_VERSION >= "1.9.0"
      
      def self.convert_encoding(str, &block)
        orig_enc = str.encoding
        if orig_enc == Encoding::UTF_8
          # 無駄なコピーを避けるためにencodeを呼ばない。
          return yield(str)
        else
          result = yield(str.encode(Encoding::UTF_8))
          return result.is_a?(String) ? result.encode(orig_enc) : result
        end
      end
      
    else
      
      def self.convert_encoding(str, &block)
        return yield(str)
      end
      
    end
    
  end
  
  def self.uni_range(*args)
    if RUBY_VERSION >= "1.9.0"
      str= args.each_slice(2).map(){ |f, e| '\u%04x-\u%04x' % [f, e] }.join("")
      return /[#{str}]/
    elsif $KCODE=="UTF8"
      str= args.map(){ |n| NKF.nkf("-wW160x", [n].pack("n")) }.
        enum_slice(2).map(){ |f, e| "#{f}-#{e}" }.to_s()
      return /[#{str}]/u
    else
      return nil
    end
  end
  
  make_flag_set([
    :HAN_CONTROL, :HAN_ASYMBOL, :HAN_JSYMBOL, :HAN_NUMBER, :HAN_UPPER, :HAN_LOWER, :HAN_KATA,
    :ZEN_ASYMBOL, :ZEN_JSYMBOL, :ZEN_NUMBER, :ZEN_UPPER, :ZEN_LOWER, :ZEN_HIRA, :ZEN_KATA,
    :ZEN_GREEK, :ZEN_CYRILLIC, :ZEN_LINE, :ZEN_KANJI,
  ])
  
  HAN_SYMBOL= HAN_ASYMBOL | HAN_JSYMBOL
  HAN_ALPHA= HAN_UPPER | HAN_LOWER
  HAN_ALNUM= HAN_ALPHA | HAN_NUMBER
  HAN= HAN_CONTROL | HAN_SYMBOL | HAN_ALNUM | HAN_KATA
  ZEN_SYMBOL= ZEN_ASYMBOL | ZEN_JSYMBOL
  ZEN_ALPHA= ZEN_UPPER | ZEN_LOWER
  ZEN_ALNUM= ZEN_ALPHA | ZEN_NUMBER
  ZEN_KANA= ZEN_KATA | ZEN_HIRA
  ZEN= ZEN_SYMBOL | ZEN_ALNUM | ZEN_KANA | ZEN_GREEK | ZEN_CYRILLIC | ZEN_LINE | ZEN_KANJI
  ASYMBOL= HAN_ASYMBOL | ZEN_ASYMBOL
  JSYMBOL= HAN_JSYMBOL | ZEN_JSYMBOL
  SYMBOL= HAN_SYMBOL | ZEN_SYMBOL
  NUMBER= HAN_NUMBER | ZEN_NUMBER
  UPPER= HAN_UPPER | ZEN_UPPER
  LOWER= HAN_LOWER | ZEN_LOWER
  ALPHA= HAN_ALPHA | ZEN_ALPHA
  ALNUM= HAN_ALNUM | ZEN_ALNUM
  HIRA= ZEN_HIRA
  KATA= HAN_KATA | ZEN_KATA
  KANA= KATA | ZEN_HIRA
  GREEK= ZEN_GREEK
  CYRILLIC= ZEN_CYRILLIC
  LINE= ZEN_LINE
  KANJI= ZEN_KANJI
  ALL= HAN | ZEN
  
  CHAR_REGEXPS= {
    HAN_CONTROL => /[\x00-\x1f\x7f]/,
    HAN_ASYMBOL =>
      Regexp.new("["+Detail::HAN_ASYMBOL_LIST.gsub(/[\[\]\-\^\\]/){ "\\"+$& }+"]"),
    HAN_JSYMBOL => Regexp.new("["+Detail::HAN_JSYMBOL1_LIST+"]"),
    HAN_NUMBER => /[0-9]/,
    HAN_UPPER => /[A-Z]/,
    HAN_LOWER => /[a-z]/,
    HAN_KATA => /[ｦ-ｯｱ-ﾝ]/,
    ZEN_ASYMBOL => Regexp.new("["+Detail::ZEN_ASYMBOL_LIST+"]"),
    ZEN_JSYMBOL => Regexp.new("["+Detail::ZEN_JSYMBOL_LIST+"]"),
    ZEN_NUMBER => /[０-９]/,
    ZEN_UPPER => /[Ａ-Ｚ]/,
    ZEN_LOWER => /[ａ-ｚ]/,
    ZEN_HIRA => /[ぁ-ん]/,
    ZEN_KATA => /[ァ-ヶ]/,
    ZEN_GREEK => /[Α-Ωα-ω]/,
    ZEN_CYRILLIC => /[А-Яа-я]/,
    ZEN_LINE => uni_range(0x2570, 0x25ff) || /[─-╂]/,
    ZEN_KANJI => uni_range(0x3400, 0x4dbf, 0x4e00, 0x9fff, 0xf900, 0xfaff) || /[亜-瑤]/,
  }
  
  def type(ch)
    Detail.convert_encoding(ch) do |ch|
      ch= ch.slice(/\A./m)
      result = nil
      for tp, reg in CHAR_REGEXPS
        if ch=~reg
          result= tp
          break
        end
      end
      result
    end
  end
  
  def type?(ch, tp)
    Detail.convert_encoding(ch) do |ch|
      tp.include?(type(ch))
    end
  end
  
  def regexp(tp, encoding= nil)
    
    regs= []
    for tp2, reg in CHAR_REGEXPS
      regs.push(reg) if tp.include?(tp2)
    end
    reg= regs.size==1 ? regs[0] : Regexp.new(regs.join("|"))
    
    if RUBY_VERSION >= "1.9.0" && !encoding
      encoding= Encoding.default_internal || Encoding::UTF_8
    end
    if encoding && encoding != Encoding::UTF_8
      return Regexp.new(reg.to_s().encode(encoding))
    else
      return reg
    end
    
  end
  
  def zen_to_han(str, tp= ALL)
    Detail.convert_encoding(str) do |str|
      if tp.include?(ZEN_KATA)
        reg= Regexp.new("[%s]" % Detail::ZEN_KATA_LISTS.flatten().join(""))
        str= str.gsub(reg) do
          for i in 0...3
            pos= Detail::ZEN_KATA_LISTS[i].index($&)
            break Detail::HAN_KATA_LIST[pos]+Detail::HAN_VSYMBOLS[i] if pos
          end
        end
      end
      str= str.tr("ａ-ｚ", "a-z") if tp.include?(ZEN_LOWER)
      str= str.tr("Ａ-Ｚ", "A-Z") if tp.include?(ZEN_UPPER)
      str= str.tr("０-９", "0-9") if tp.include?(ZEN_NUMBER)
      str= str.tr(Detail::ZEN_ASYMBOL_LIST,
        Detail::HAN_ASYMBOL_LIST.gsub(/[\-\^\\]/){ "\\"+$& }) if tp.include?(ZEN_ASYMBOL)
      str= str.tr(Detail::ZEN_JSYMBOL1_LIST,
        Detail::HAN_JSYMBOL1_LIST) if tp.include?(ZEN_JSYMBOL)
      str
    end
  end
  
  def han_to_zen(str, tp= ALL)
    Detail.convert_encoding(str) do |str|
      #[半]濁音記号がJSYMBOLに含まれるので、KATAの変換をJSYMBOLより前にやる必要あり。
      if tp.include?(HAN_KATA)
        str= str.gsub(/(#{han_kata})([ﾞﾟ]?)/) do
          i= {""=>0, "ﾞ"=>1, "ﾟ"=>2}[$2]
          pos= Detail::HAN_KATA_LIST.index($1)
          s= Detail::ZEN_KATA_LISTS[i][pos]
          (!s || s=="") ? Detail::ZEN_KATA_LISTS[0][pos]+$2 : s
        end
      end
      str= str.tr("a-z", "ａ-ｚ") if tp.include?(HAN_LOWER)
      str= str.tr("A-Z", "Ａ-Ｚ") if tp.include?(HAN_UPPER)
      str= str.tr("0-9", "０-９") if tp.include?(HAN_NUMBER)
      str= str.tr(Detail::HAN_ASYMBOL_LIST.gsub(/[\-\^\\]/){ "\\"+$& },
        Detail::ZEN_ASYMBOL_LIST) if tp.include?(HAN_ASYMBOL)
      str= str.tr(Detail::HAN_JSYMBOL1_LIST,
        Detail::ZEN_JSYMBOL1_LIST) if tp.include?(HAN_JSYMBOL)
      str
    end
  end
  
  def normalize_zen_han(str)
    Detail.convert_encoding(str) do |str|
      zen_to_han(han_to_zen(str, HAN_JSYMBOL|HAN_KATA), ZEN_ALNUM|ZEN_ASYMBOL)
    end
  end
  
  def upcase(str, tp= LOWER)
    Detail.convert_encoding(str) do |str|
      str= str.tr("a-z", "A-Z") if tp.include?(HAN_LOWER)
      str= str.tr("ａ-ｚ", "Ａ-Ｚ") if tp.include?(ZEN_LOWER)
      str
    end
  end
  
  def downcase(str, tp= UPPER)
    Detail.convert_encoding(str) do |str|
      str= str.tr("A-Z", "a-z") if tp.include?(HAN_UPPER)
      str= str.tr("Ａ-Ｚ", "ａ-ｚ") if tp.include?(ZEN_UPPER)
      str
    end
  end
  
  def kata_to_hira(str)
    Detail.convert_encoding(str) do |str|
      str.tr("ァ-ン", "ぁ-ん")
    end
  end
  
  def hira_to_kata(str)
    Detail.convert_encoding(str) do |str|
      str.tr("ぁ-ん", "ァ-ン")
    end
  end
  
  module_function(
    :type, :type?, :regexp, :zen_to_han, :han_to_zen, :normalize_zen_han, :upcase, :downcase,
    :kata_to_hira, :hira_to_kata
  )
  
  def self.define_regexp_method(name, tp)
    define_method(name) do |*args|
      regexp(tp, *args)
    end
    module_function(name)
  end
  
  #han_control, han_asymbol, …などのモジュール関数を定義。
  for cons in constants
    val= const_get(cons)
    define_regexp_method(cons.downcase(), val) if val.is_a?(FlagSetMaker::Flags)
  end
  
  def self.test()
    orig_str= "ドラえもん(Doraemon)は、日本で1番有名な漫画だ。"
    for encoding in RUBY_VERSION >= "1.9.0" ? [Encoding::UTF_8, Encoding::SJIS] : [nil]
      str= encoding ? orig_str.encode(encoding) : orig_str
      str.each_char() do |ch|
        ch= ch.encode(Encoding::UTF_8) if encoding
        printf("%2s  %s\n", ch, Moji.type(ch))
      end
      str= Moji.zen_to_han(str, Moji::ALL)
      if encoding
        puts(str.encode(Encoding::UTF_8))
        puts(str.encoding)
      else
        puts(str)
      end
      str= Moji.han_to_zen(str, Moji::ALL)
      if encoding
        puts(str.encode(Encoding::UTF_8))
        puts(str.encoding)
      else
        puts(str)
      end
    end
  end
  
end

EOS

script= NKF.nkf("-#{nkf_kcode}Wx", script) if nkf_kcode
  #UTF-8の場合、nkfしてはいけない（～が〜になるので）。
eval(script, TOPLEVEL_BINDING)

if __FILE__==$0
  Moji.test()
end
