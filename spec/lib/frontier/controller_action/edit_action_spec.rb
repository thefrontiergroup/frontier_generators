require 'spec_helper'

RSpec.describe Frontier::ControllerAction::EditAction do

  describe "#to_s" do
    subject { Frontier::ControllerAction::EditAction.new(model_configuration).to_s }
    let(:model_configuration) { build_model_configuration }

    let(:expected) do
      raw = <<-STRING
def edit
  @test_model = find_test_model
  authorize(TestModel)
end
STRING
      raw.rstrip
    end

    it { should eq(expected) }
  end

end
