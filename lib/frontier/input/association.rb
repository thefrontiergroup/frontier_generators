class Frontier::Input::Association < Frontier::Input

  def to_s(options={})
    if association.form_type == "inline"
      Frontier::Input::InlineFormAssociation.new(association).to_s(options)
    else
      Frontier::Input::SelectFormAssociation.new(association).to_s(options)
    end
  end

  alias association attribute

end
