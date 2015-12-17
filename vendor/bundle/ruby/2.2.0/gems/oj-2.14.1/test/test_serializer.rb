#!/usr/bin/env ruby
# encoding: UTF-8

$: << File.dirname(__FILE__)

%w(lib ext test).each do |dir|
  $LOAD_PATH.unshift File.expand_path("../../#{dir}", __FILE__)
end

require 'minitest'
require 'minitest/autorun'
require 'oj'

Oj.mimic_JSON

require 'rails/all'
require 'active_model'
require 'active_model_serializers'
require 'active_support/json'

#Oj.mimic_JSON

class Category
  include ActiveModel::Model
  include ActiveModel::SerializerSupport

  attr_accessor :id, :name

  def initialize(id, name)
    @id   = id
    @name = name
  end
end

class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name
end

class MimicRails < Minitest::Test

  def test_dump_object
    Oj.default_options= {:indent => 0}
    category = Category.new(1, 'test')
    serializer = CategorySerializer.new(category)

    json = serializer.to_json()
    puts "*** serializer.to_json() #{serializer.to_json()}"
    assert_equal(%|{"category":{"id":1,"name":"test"}}|, json)

    json = serializer.as_json()
    puts "*** serializer.as_json() #{serializer.as_json()}"
    assert_equal({"category" => {:id => 1, :name => "test"}}, json)

    json = JSON.dump(serializer)
    puts "*** JSON.dump(serializer) #{JSON.dump(serializer)}"
    assert_equal(%|{"category":{"id":1,"name":"test"}}|, json)
  end

end # MimicRails
