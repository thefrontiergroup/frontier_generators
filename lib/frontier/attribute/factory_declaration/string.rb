class Frontier::Attribute::FactoryDeclaration::String

  attr_reader :attribute

  def initialize(attribute)
    @attribute = attribute
  end

  def to_s
    if attribute.name =~ /city/
      "FFaker::AddressAU.city"
    elsif attribute.name =~ /email/
      "FFaker::Internet.email"
    elsif attribute.name =~ /line_1/
      "FFaker::AddressAU.street_address"
    elsif attribute.name =~ /line_2/
      "FFaker::AddressAU.secondary_address"
    elsif attribute.name =~ /first_name/
      "FFaker::Name.first_name"
    elsif attribute.name =~ /last_name/
      "FFaker::Name.last_name"
    elsif attribute.name =~ /name/
      "FFaker::Name.name"
    # Guessing since this is a string, it would be phone_number or mobile_number
    elsif attribute.name =~ /number/
      "FFaker::PhoneNumberAU.phone_number"
    elsif attribute.name =~ /postcode/ || attribute.name =~ /post_code/
      "FFaker::AddressAU.postcode"
    elsif attribute.name =~ /suburb/
      "FFaker::AddressAU.suburb"
    else
      "FFaker::Company.bs"
    end
  end

end
