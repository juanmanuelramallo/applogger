module Presentable
  attr_reader :object

  delegate_missing_to :object

  def self.included(klass)
    klass.extend(ClassMethods)
  end

  module ClassMethods
    def all(collection)
      collection.map { |object| new(object) }
    end
  end

  def initialize(object)
    @object = object
  end
end
