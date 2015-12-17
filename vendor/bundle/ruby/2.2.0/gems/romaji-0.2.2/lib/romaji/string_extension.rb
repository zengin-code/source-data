# coding: utf-8
#
module Romaji
  module StringExtension
    def normalize
      Romaji.normalize(self)
    end

    def normalize!
      self.replace(self.normalize)
    end

    def kana
      Romaji.romaji2kana(self.normalize)
    end

    def kana!
      self.replace(self.kana)
    end

    def romaji
      Romaji.kana2romaji(self.normalize)
    end

    def romaji!
      self.replace(self.romaji)
    end
  end
end

