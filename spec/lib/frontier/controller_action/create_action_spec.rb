require 'spec_helper'

RSpec.describe Frontier::ControllerAction::CreateAction do

  describe "#to_s" do
    subject { Frontier::ControllerAction::CreateAction.new(model_configuration).to_s }
    let(:model_configuration) { build_model_configuration }

    let(:expected) do
      raw = <<-STRING
def create
  @test_model = TestModel.new(strong_params_for(TestModel))
  @test_model.save if authorize(TestModel)

  respond_with(@test_model, location: admin_test_models_path)
end
STRING
      raw.rstrip
    end

    it { should eq(expected) }
  end

end
