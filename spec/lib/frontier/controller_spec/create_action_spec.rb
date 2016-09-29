require 'spec_helper'

describe Frontier::ControllerSpec::CreateAction do

  describe "#to_s" do
    subject { index_action.to_s }
    let(:index_action) { Frontier::ControllerSpec::CreateAction.new(model) }
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

    context "without nested models" do
      let(:controller_prefixes) { [] }
      let(:expected) do
        raw = <<STRING
describe 'POST create' do
  subject { post :create, user: attributes }
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

      it { should redirect_to(users_path) }

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

    context "with nested models" do
      let(:controller_prefixes) { ["@company"] }
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

end
