require 'spec_helper'

describe Frontier::Views::Index::TableHeading do

  describe "#to_s" do
    subject { table_heading.to_s }

    let(:table_heading) { Frontier::Views::Index::TableHeading.new(attribute) }
    let(:model_configuration) do
      Frontier::ModelConfiguration.new({
        test_model: {
          attributes: {name: {sortable: sortable}}
        }
      })
    end
    let(:attribute) { model_configuration.attributes.first }

    context "sortable" do
      let(:sortable) { true }
      it { should eq("%th= sort_link(@ransack_query, :name, \"Name\")") }
    end

    context "not sortable" do
      let(:sortable) { false }
      it { should eq("%th Name") }
    end
  end

end
