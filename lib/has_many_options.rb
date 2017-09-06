require_relative 'associatable_options'
require 'active_support/inflector'

class HasManyOptions < AssociatableOptions
  def initialize(name, self_class_name, options = {})
    default = {
      primary_key: :id,
      foreign_key: "#{self_class_name.downcase}_id".to_sym,
      class_name: name.to_s.singularize.camelcase
    }

    options = default.merge(options)

    @primary_key = options[:primary_key]
    @foreign_key = options[:foreign_key]
    @class_name = options[:class_name]
  end
end
