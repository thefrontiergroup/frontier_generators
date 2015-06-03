require 'spec_helper'

describe ModelConfiguration::Attribute do

  let(:attribute) { ModelConfiguration::Attribute.new(name, options) }
  let(:name) { "attribute_name" }
  let(:options) { {} }

  describe "#is_association?" do
    subject { attribute.is_association? }
    it { should eq(false) }
  end

end