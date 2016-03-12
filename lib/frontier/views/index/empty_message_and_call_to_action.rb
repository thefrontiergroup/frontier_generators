class Frontier::Views::Index::EmptyMessageAndCallToAction

  include Frontier::ModelConfigurationProperty

  def to_s
    if model_configuration.show_create?
      empty_message_with_call_to_action
    else
      "%p #{empty_message_without_call_to_action}"
    end
  end

private

  def empty_message_with_call_to_action
    raw = <<-STRING
%p
  #{empty_message_without_call_to_action}
  - if #{Frontier::Authorization::Check.new(model_configuration, model_configuration.as_constant, :new)}
    = link_to(\"Click here to create one.\", #{model_configuration.url_builder.new_path})
STRING
    raw.rstrip
  end

  def empty_message_without_call_to_action
    "There are no #{model_pluralized}."
  end

  def model_pluralized
    model_configuration.as_title.pluralize.downcase
  end

end
