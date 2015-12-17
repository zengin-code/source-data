#!/usr/bin/env ruby
# encoding: UTF-8

$: << File.dirname(__FILE__)

require 'helper'

class Handler
  def initialize
    @state = []
  end

  def hash_start
    @state << {}
    @state.last
  end

  def hash_end
    @state.pop
  end

  def hash_set(h,k,v)
    h.store(k,v)
  end

  def array_start
    @state << []
    @state.last
  end


  def array_end
    @state.pop
  end

  def array_append(a,v)
    a << v
  end

  def add_value(v)
    p v
  end

  def error(message, line, column); p "ERROR: #{message}" end
end

$handler = Handler.new

IO.popen("cat tst") { |p| puts Oj.sc_parse($handler, p) }

#File.open('tst', 'r') { |file|  Oj.sc_parse($handler, file) }
