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

  def error(message, line, column); p "ERROR: #{message}" end
end

handler = Handler.new
def handler.add_value(v)
  p v
end

Oj.sc_parse(handler, StringIO.new('{"a":"b","c":[1,2,{"d":"e"}]}[4,5,6]'))
