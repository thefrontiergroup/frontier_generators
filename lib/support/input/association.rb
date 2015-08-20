class Frontier::Input::Association < Frontier::Input

  def to_s(options={})
    options = options.merge({collection: "#{association.association_class}.all"})
    # Should convert attribute "state" into:
    #   f.association :state_id, collection: State.all
    # With additional options as above you'd get:
    #   f.association :state_id, abacus: 666, collection: State.all, one: :two
    ["f.association #{attribute.as_field_name}", *input_options(options)].join(", ")
  end

  alias association attribute

end