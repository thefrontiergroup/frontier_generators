require 'spec_helper'

RSpec.describe Frontier::ControllerAction::IndexAction do

  describe "#to_s" do
    subject { Frontier::ControllerAction::IndexAction.new(model).to_s }

    context "with no nested models" do
      let(:model) do
        Frontier::Model.new({
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
  @test_models = TestModel.all.merge(@ransack_query.result)
                              .page(params[:page])
end
STRING
          raw.rstrip
        end

        it { should eq(expected) }

      end
    end

    context "with nested models" do
      let(:model) do
        Frontier::Model.new({
          test_model: {
            attributes: {name: {sortable: sortable}},
            controller_prefixes: ["@cat"]
          }
        })
      end

      context "without any sortable attributes" do
        let(:sortable) { false }
        let(:expected) do
          raw = <<-STRING
def index
  authorize(TestModel)
  @test_models = @cat.test_models.page(params[:page])
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
  @test_models = @cat.test_models.merge(@ransack_query.result)
                                 .page(params[:page])
end
STRING
          raw.rstrip
        end

        it { should eq(expected) }

      end
    end
  end

end
