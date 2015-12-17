#!/usr/bin/env ruby
# encoding: UTF-8

%w(lib ext test).each do |dir|
  $LOAD_PATH.unshift File.expand_path("../../#{dir}", __FILE__)
end

require 'oj'

def create_item(doc)
  #puts "#{doc.fetch('/id')}: #{doc.fetch('/labels/it/value')} - #{doc.fetch('/descriptions/it/value')}"
  doc.fetch('/id')
  doc.fetch('/labels/it/value')
  doc.fetch('/descriptions/it/value')
end

100.times { |i|
  File.open('dump_10k.json') { |f|
    f.each { |line|
      #Oj::Doc.open(line) { |doc|
      doc = Oj::Doc.open(line)
        begin
          create_item(doc) if doc.fetch('/type') == 'item'
        rescue Exception => e
          puts "*** #{e.class}: #{e.message}"
        end
      doc.close
      #}
    }
  }
  puts i
}
