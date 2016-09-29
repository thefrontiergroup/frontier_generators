require 'spec_helper'

describe Frontier::ControllerSpec::IndexAction do

  describe "#to_s" do
    subject { index_action.to_s }
    let(:index_action) { Frontier::ControllerSpec::IndexAction.new(model) }
    let(:model) do
      Frontier::Model.new({
        user: {
          controller_prefixes: controller_prefixes,
          attributes: {
            name: {type: "string"}
          }
        }
      })
    end

    context "with no nested models" do
      let(:controller_prefixes) { [] }
      let(:expected) do
        raw = <<STRING
describe 'GET index' do
  subject { get :index }

  authenticated_as(:admin) do
    it { should render_template(:index) }
  end

  it_behaves_like "action requiring authentication"
  it_behaves_like "action authorizes roles", [:admin]
end
STRING
        raw.rstrip
      end

      it { should eq(expected) }
    end

    context "with one nested model" do
      let(:controller_prefixes) { ["@company"] }
      let(:expected) do
        raw = <<STRING
describe 'GET index' do
  subject { get :index, company_id: company.id }
  let(:company) { FactoryGirl.create(:company) }

  authenticated_as(:admin) do
    it { should render_template(:index) }
  end

  it_behaves_like "action requiring authentication"
  it_behaves_like "action authorizes roles", [:admin]
end
STRING
        raw.rstrip
      end

      it { should eq(expected) }
    end
  end

end
