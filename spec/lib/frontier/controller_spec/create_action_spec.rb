require 'spec_helper'

describe Frontier::ControllerSpec::CreateAction do

  describe "#to_s" do
    subject { index_action.to_s }
    let(:index_action) { Frontier::ControllerSpec::CreateAction.new(model_configuration) }
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
describe 'POST create' do
  subject { post :create, company_id: company.id, user: attributes }
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

      it "creates a User object with the given attributes" do
        subject

        user = User.order(:created_at).last
        expect(user).to be_present
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
      specify { expect { subject }.not_to change(User, :count) }
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
