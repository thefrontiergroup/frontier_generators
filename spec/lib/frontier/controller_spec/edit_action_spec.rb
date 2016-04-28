require 'spec_helper'

describe Frontier::ControllerSpec::EditAction do

  describe "#to_s" do
    subject { index_action.to_s }
    let(:index_action) { Frontier::ControllerSpec::EditAction.new(model_configuration) }
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
describe 'GET edit' do
  subject { get :edit, company_id: company.id, id: user.id }
  let(:company) { FactoryGirl.create(:company) }
  let(:user) { FactoryGirl.create(:user) }

  authenticated_as(:admin) do
    it { should render_template(:edit) }
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
