require 'spec_helper'

RSpec.describe Frontier::FactoryGirlSupport::AttributesFor do

  describe '#to_s' do
    subject { Frontier::FactoryGirlSupport::AttributesFor.new(model_or_association).to_s }
    let(:model_or_association) { build_model_configuration }

    it { should eq("FactoryGirl.attributes_for(:test_model)") }
  end

end
