class Frontier::Views::Index::TableHeading

  attr_reader :attribute_or_association

  def initialize(attribute_or_association)
    @attribute_or_association = attribute_or_association
  end

  def to_s
    if attribute_or_association.sortable?
      "%th= sort_link(@ransack_query, #{attribute_or_association.as_symbol}, \"#{attribute_or_association.as_table_heading}\")"
    else
      "%th #{attribute_or_association.as_table_heading}"
    end
  end

end
