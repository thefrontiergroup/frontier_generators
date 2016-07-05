require 'spec_helper'

describe Frontier::ControllerSpec::DestroyAction do

  describe "#to_s" do
    subject { index_action.to_s }
    let(:index_action) { Frontier::ControllerSpec::DestroyAction.new(model_configuration) }
    let(:model_configuration) do
      Frontier::ModelConfiguration.new({
        user: {
          controller_prefixes: controller_prefixes,
          attributes: {
            name: {type: "string"}
          },
          soft_delete: soft_delete
        }
      })
    end
    let(:soft_delete) { true }

    context "with no nested models" do
      let(:controller_prefixes) { [] }

      context "using soft delete" do
        let(:expected) do
          raw = <<STRING
describe 'DELETE destroy' do
  subject { delete :destroy, id: user.id }
  let!(:user) { FactoryGirl.create(:user) }

  authenticated_as(:admin) do
    it "deletes the User" do
      subject
      expect(user.reload.deleted_at).to be_present
    end
    it { should redirect_to(users_path) }
  end

  it_behaves_like "action requiring authentication"
  it_behaves_like "action authorizes roles", [:admin]
end
STRING
          raw.rstrip
        end

        it { should eq(expected) }
      end

      context "not using soft delete" do
        let(:soft_delete) { false }
        let(:expected) do
          raw = <<STRING
describe 'DELETE destroy' do
  subject { delete :destroy, id: user.id }
  let!(:user) { FactoryGirl.create(:user) }

  authenticated_as(:admin) do
    it "deletes the User" do
      expect { subject }.to change { User.count }.by(-1)
    end
    it { should redirect_to(users_path) }
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

    context "with one nested model" do
      let(:controller_prefixes) { ["@company"] }
      let(:expected) do
        raw = <<STRING
describe 'DELETE destroy' do
  subject { delete :destroy, company_id: company.id, id: user.id }
  let!(:user) { FactoryGirl.create(:user, company: company) }
  let(:company) { FactoryGirl.create(:company) }

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

end
