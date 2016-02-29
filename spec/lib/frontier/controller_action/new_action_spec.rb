require 'spec_helper'

RSpec.describe Frontier::ControllerAction::NewAction do

  describe "#to_s" do
    subject { Frontier::ControllerAction::NewAction.new(model_configuration).to_s }
    let(:model_configuration) { build_model_configuration }

    let(:expected) do
      raw = <<-STRING
def new
  @test_model = TestModel.new
  authorize(TestModel)
end
STRING
      raw.rstrip
    end

    it { should eq(expected) }
  end

end
