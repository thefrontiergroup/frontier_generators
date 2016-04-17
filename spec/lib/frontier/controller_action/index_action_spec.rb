require 'spec_helper'

RSpec.describe Frontier::ControllerAction::IndexAction do

  describe "#to_s" do
    subject { Frontier::ControllerAction::IndexAction.new(model_configuration).to_s }
    let(:model_configuration) do
      Frontier::ModelConfiguration.new({
        test_model: {
          attributes: {name: {sortable: sortable}}
        }
      })
    end

    context "without any sortable attributes" do
      let(:sortable) { false }
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

    context "with one or more sortable attributes" do
      let(:sortable) { true }
      let(:expected) do
        raw = <<-STRING
def index
  authorize(TestModel)
  @ransack_query = TestModel.ransack(params[:q])
  @test_models = TestModel.merge(@ransack_query.result)
                          .page(params[:page])
end
STRING
        raw.rstrip
      end

      it { should eq(expected) }

    end
  end

end
