require_relative 'attribute.rb'

class Frontier::Input::Association < Frontier::Input::Attribute

  def to_s(options={})
    options = options.merge({collection: "#{association.association_class}.all"})
    super
  end

  alias association attribute

end