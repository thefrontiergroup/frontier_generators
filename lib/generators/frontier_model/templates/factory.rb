FactoryGirl.define do
  factory <%= model_configuration.as_symbol %> do
<% model_configuration.attributes.sort_by(&:name).each do |attribute| -%>
    <%= attribute.as_factory_declaration %>
<% end -%>

    trait :invalid do
<% model_configuration.attributes.sort_by(&:name).each do |attribute| -%>
      <%= attribute.name %> nil
<% end -%>
    end
  end
end
