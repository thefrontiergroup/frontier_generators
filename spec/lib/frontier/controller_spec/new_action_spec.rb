require 'spec_helper'

describe Frontier::ControllerSpec::NewAction do

  describe "#to_s" do
    subject { index_action.to_s }
    let(:index_action) { Frontier::ControllerSpec::NewAction.new(model_configuration) }
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
describe 'GET new' do
  subject { get :new, company_id: company.id }
  let(:company) { FactoryGirl.create(:company) }

  authenticated_as(:admin) do
    it { should render_template(:new) }
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
