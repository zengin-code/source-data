%w(lib ext test).each do |dir|
  $LOAD_PATH.unshift File.expand_path("../../#{dir}", __FILE__)
end
require 'oj'
require 'json'
 
Oj::Doc.open([{:name => "T-Shirt"}].to_json) do |doc|
  doc.each_child do |child|
    p child.fetch("name")
  end
end
