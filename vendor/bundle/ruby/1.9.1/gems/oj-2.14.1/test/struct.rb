#!/usr/bin/env ruby
# encoding: UTF-8

# Ubuntu does not accept arguments to ruby when called using env. To get warnings to show up the -w options is
# required. That can be set in the RUBYOPT environment variable.
# export RUBYOPT=-w

$VERBOSE = true

$: << File.join(File.dirname(__FILE__), "../lib")
$: << File.join(File.dirname(__FILE__), "../ext")

require 'oj'

A = Struct.new(:a,:b,:c,:d)
B = Struct.new(:e,:f)

obj = [A.new(55, B.new(1, 'X'), B.new(2, 'Y'), 3)]

s = Oj.dump(obj, :mode => :object)

100000.times do
  Oj.load(s, :mode => :object)
  # ds = Oj.dump(o, :mode => :object)
  # if ds != s
  #   puts ds
  #   raise "holy crap"
  # end
end
