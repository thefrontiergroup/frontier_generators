require 'rails_helper'

describe ModelConfiguration::Attribute::MigrationComponent do

  describe "#to_s" do
    subject { ModelConfiguration::Attribute::MigrationComponent.new(attribute).to_s }
    let(:attribute) { ModelConfiguration::Attribute.new(name, options) }
    let(:name)      { "field_name" }
    let(:options)   { {type: type} }
    let(:type)      { "string" }

    context "type is an enum" do
      let(:type) { "enum" }
      it { should eq("field_name:integer") }
    end

    context "requiring an index" do
      let(:options) { {type: type}.merge(index_options) }

      context "due to being searchable" do
        let(:index_options) { {searchable: true} }
        it { should eq("field_name:string:index") }
      end

      context "due to being sortable" do
        let(:index_options) { {sortable: true} }
        it { should eq("field_name:string:index") }
      end

      context "because index was specified" do
        context "and index is specified as uniq" do
          let(:index_options) { {index: "uniq"} }
          it { should eq("field_name:string:uniq") }
        end

        context "and index is specified as true" do
          let(:index_options) { {index: true} }
          it { should eq("field_name:string:index") }
        end
      end
    end

    context "not requiring an index" do
      it "renders is a `rails g migration` friendly string" do
        should eq("field_name:string")
      end
    end

  end

end