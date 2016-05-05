require 'spec_helper'

describe Frontier::ControllerSpec::IndexAction do

  describe "#to_s" do
    subject { index_action.to_s }
    let(:index_action) { Frontier::ControllerSpec::IndexAction.new(model_configuration) }
    let(:model_configuration) do
      Frontier::ModelConfiguration.new({
        user: {
          controller_prefixes: ["@company"],
          attributes: {
            name: {type: "string"}
          }
        }
      })
    end

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
