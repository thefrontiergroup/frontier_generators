require 'spec_helper'

describe Frontier::ControllerSpec::DestroyAction do

  describe "#to_s" do
    subject { index_action.to_s }
    let(:index_action) { Frontier::ControllerSpec::DestroyAction.new(model_configuration) }
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
describe 'DELETE destroy' do
  subject { delete :destroy, company_id: company.id, id: user.id }
  let(:company) { FactoryGirl.create(:company) }
  let(:user) { FactoryGirl.create(:user) }

  authenticated_as(:admin) do
    it "deletes the User" do
      subject
      expect(user.reload.deleted_at).to be_present
    end
    it { should redirect_to(company_users_path(company)) }
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
