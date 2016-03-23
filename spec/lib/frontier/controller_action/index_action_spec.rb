require 'spec_helper'

RSpec.describe Frontier::ControllerAction::IndexAction do

  describe "#to_s" do
    subject { Frontier::ControllerAction::IndexAction.new(model_configuration).to_s }
    let(:model_configuration) { build_model_configuration }

    let(:expected) do
      raw = <<-STRING
def index
  authorize(TestModel)
  @test_models = TestModel.page(params[:page])
end
STRING
      raw.rstrip
    end

    it { should eq(expected) }
  end

end
