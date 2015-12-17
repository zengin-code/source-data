#!/usr/bin/env ruby

#!/usr/bin/env ruby
# encoding: UTF-8

$: << File.dirname(__FILE__)
%w(lib ext test).each do |dir|
  $LOAD_PATH.unshift File.expand_path("../../#{dir}", __FILE__)
end

require 'oj'
require 'stringio'

class Parser < Oj::Saj

  def parse(json)
    Oj.saj_parse(self, StringIO.new(json))
  end

  def hash_start(key)
    puts "START: #{key}"
  end

  def error(message, line, column)
    puts "Error callback: #{message}"
  end

end

parser = Parser.new

begin
  # truncated JSON, Oj.saj_parse raises, #error not called
  parser.parse('{"foo{"bar":')
rescue Exception => e
  puts "*** #{e.class}: #{e.message}"
end

puts "\n\n"

begin
  # invalid JSON, doesn't raise an error
  parser.parse('{"foo":{"bar":}')
rescue Exception => e
  puts "*** #{e.class}: #{e.message}"
end
