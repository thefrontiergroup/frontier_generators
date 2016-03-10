class Frontier::Input::Attribute < Frontier::Input

  def to_s(options={})
    ["= #{form_name(options)}.input #{attribute.as_field_name}", *input_options(options)].join(", ")
  end

end
