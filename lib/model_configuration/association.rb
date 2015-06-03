require_relative "attribute.rb"

class ModelConfiguration
  class Association < Attribute

    # some_thing_id -> ":some_thing_id"
    # some_thing -> ":some_thing_id"
    def as_field_name
      if name =~ /_id\z/
        as_symbol
      else
        "#{as_symbol}_id"
      end
    end

    def association_implementation
      without_options = case properties[:type]
      when "belongs_to"
        "belongs_to #{as_symbol}"
      when "has_one"
        "has_one #{as_symbol}"
      when "has_many"
        "has_many #{as_symbol}"
      when "has_and_belongs_to_many"
        "has_and_belongs_to_many #{as_symbol}"
      end

      options = nil
      if properties[:class_name].present?
        options = "class_name: #{properties[:class_name]}"
      end
      with_options = [without_options, options].join(", ")
    end

    def is_association?
      true
    end

  end
end