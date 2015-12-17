#!/usr/bin/env ruby
# encoding: UTF-8

%w(lib ext test).each do |dir|
  $LOAD_PATH.unshift File.expand_path("../../#{dir}", __FILE__)
end

require 'oj'

def create_item(doc)
  item_id = doc['source']
  # ...
  puts item_id
end

File.open('log.json') { |f|
  Oj::load(f, mode: :compat) { |doc|
    begin
      create_item(doc) if doc['msgType'] == 1
    rescue Exception => e
      puts "*** #{e.class}: #{e.message}"
    end
  }
}
