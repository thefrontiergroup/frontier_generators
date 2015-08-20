require_relative 'association.rb'
require_relative 'attribute.rb'

class Frontier::Input::Factory

  def self.build_for(attribute_or_association)
    case attribute_or_association
    when ModelConfiguration::Association
      Frontier::Input::Association.new(attribute_or_association)
    when ModelConfiguration::Attribute
      Frontier::Input::Attribute.new(attribute_or_association)
    else
      raise(ArgumentError, "Unhandled instance passed through: #{attribute_or_association}")
    end
  end

end