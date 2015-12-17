#!/usr/bin/env ruby
# encoding: UTF-8

%w(lib ext).each do |dir|
  $LOAD_PATH.unshift File.expand_path("../../#{dir}", __FILE__)
end

require 'stringio'
require 'oj'


filename = File.join(File.dirname(__FILE__), 'day.json')
File.open(filename, "w") do |f|
  w = Oj::StreamWriter.new(f, :indent => -1)
  390.times do |i|
    w.push_object()
    w.push_value(12, 'msgType')
    w.push_value(1, 'version')
    w.push_value(1_400_074_200 + i * 60, 'bar')
    w.push_value('TBC', 'source')
    w.push_array('timebars')
    w.push_object()
    w.push_value('aapl_24', 'asset')
    w.push_value(91.87, 'close')
    w.pop()
    w.pop()
    w.pop()
  end
  f.write("\n")
end

