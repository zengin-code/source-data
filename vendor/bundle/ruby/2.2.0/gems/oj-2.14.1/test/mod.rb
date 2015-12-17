#!/usr/bin/env ruby
# encoding: UTF-8

%w(lib ext test).each do |dir|
  $LOAD_PATH.unshift File.expand_path("../../#{dir}", __FILE__)
end

require 'oj'


Thread.new do
  string_io = StringIO.new('{"foo":"bar"}')
  Oj.load(string_io)
  string_io.rewind
  puts string_io.read
end.join
