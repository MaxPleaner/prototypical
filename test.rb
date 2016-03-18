require 'byebug'

class ParentClass
  def self.inherited(child)
    parent_class = self
    child.class_eval do
        parent_class.column_names.each { |attr| attr_accessor attr.to_sym }
    end
  end
  def self.column_names
    [:foo, :bar]
  end
end

class ChildClass < ParentClass
  def initialize
  end
end

child = ChildClass.new
child.foo = "bar"
puts child.foo
# => "bar"