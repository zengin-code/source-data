# coding: utf-8

require 'nkf'
require 'romaji/string_extension'
require 'romaji/constants'
require 'romaji/version'

module Romaji
  def self.romaji2kana(text, options = {})
    text = hira2kata(self.normalize(text))
    pos = 0
    k = nil
    kana = ''
    chars =  text.split(//u)
    while true
      # ン
      if chars[pos] == 'm' && ['p', 'b', 'm'].include?(chars[pos + 1])
        kana += 'ン'
        pos += 1
        next
      end

      # ッ
      if chars[pos] == chars[pos + 1] && !['a', 'i', 'u', 'e', 'o', 'n'].include?(chars[pos]) && chars[pos] =~ /[a-z]/
        kana += 'ッ'
        pos += 1
        next
      end

      ROMAJI_MAX_LENGTH.downto(1) do |t|
        substr = chars.slice(pos, t).join
        k = ROMAJI2KANA[substr]
        if k
          kana += k
          pos += t
          break
        end
      end
      unless k
        kana += chars.slice(pos, 1).join
        pos += 1
      end
      break if pos >= chars.size
    end

    kana_type = options[:kana_type] || :katakana
    kana = kata2hira(kana) if :hiragana == kana_type.to_sym
      
    return kana
  end

  def self.kana2romaji(text)
    text = hira2kata(self.normalize(text))
    pos = 0
    k = nil
    romaji = ''
    chars =  text.split(//u)
    while true
      # ン
      if chars[pos] == 'ン'
        next_char_romaji = KANA2ROMAJI[chars[pos + 1]]
        if next_char_romaji && ['p', 'b', 'm'].include?(next_char_romaji[0].slice(0,1))
          romaji += 'm'
        else
          romaji += 'n'
        end
        pos += 1
        next
      end

      # ッ
      if chars[pos] == 'ッ'
        next_char_romaji = KANA2ROMAJI[chars[pos + 1]]
        if ['a', 'i', 'u', 'e', 'o', 'n', nil].include?(chars[pos + 1]) || next_char_romaji.nil?
          romaji += 'xtsu'
        else
          romaji += (next_char_romaji[0].slice(0,1))
        end
        pos += 1
        next
      end

      ROMAJI_MAX_LENGTH.downto(1) do |t|
        substr = chars.slice(pos, t).join
        k = KANA2ROMAJI[substr]
        if k
          romaji += k[0]
          pos += t
          break
        end
      end
      unless k
        romaji += chars.slice(pos, 1).join
        pos += 1
      end
      break if pos >= chars.size
    end
    romaji
  end

  def self.hira2kata(text)
    NKF.nkf("--katakana -Ww", text)
  end

  def self.kata2hira(text)
    NKF.nkf("--hiragana -Ww", text)
  end

  def self.normalize(text)
    NKF.nkf('-mZ0Wwh0', text).downcase
  end
end
