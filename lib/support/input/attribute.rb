require_relative '../input.rb'

class Frontier::Input::Attribute < Frontier::Input

  def to_s(options={})
    ["f.input #{attribute.as_field_name}", *input_options(options)].join(", ")
  end

end