require 'spec_helper'

describe Frontier::ControllerSpec::UpdateAction do

  describe "#to_s" do
    subject { index_action.to_s }
    let(:index_action) { Frontier::ControllerSpec::UpdateAction.new(model) }
    let(:model) do
      Frontier::Model.new({
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
describe 'POST update' do
  subject { post :update, company_id: company.id, id: user.id, user: attributes }
  let!(:user) { FactoryGirl.create(:user, company: company) }
  let(:company) { FactoryGirl.create(:company) }

  let(:attributes) { {} }

  authenticated_as(:admin) do

    context "with valid parameters" do
      let(:user_attributes) { FactoryGirl.attributes_for(:user) }
      let(:attributes) do
        {
          name: user_attributes[:name]
        }
      end

      it "updates the User object with the given attributes" do
        subject

        user.reload
        expect(user.name).to eq(user_attributes[:name])
      end

      it { should redirect_to(company_users_path(company)) }

      it "sets a notice for the user" do
        subject
        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid parameters" do
      let(:attributes) { parameters_for(:user, :invalid) }

      it "doesn't update the User" do
        subject
        expect(user.reload).not_to have_attributes(attributes)
      end
    end
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
