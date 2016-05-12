require 'spec_helper'

describe Frontier::ControllerSpec::EditAction do

  describe "#to_s" do
    subject { index_action.to_s }
    let(:index_action) { Frontier::ControllerSpec::EditAction.new(model_configuration) }
    let(:model_configuration) do
      Frontier::ModelConfiguration.new({
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
describe 'GET edit' do
  subject { get :edit, id: user.id }
  let!(:user) { FactoryGirl.create(:user) }

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

    context "with nested models" do
      let(:controller_prefixes) { ["@company"] }

      let(:expected) do
        raw = <<STRING
describe 'GET edit' do
  subject { get :edit, company_id: company.id, id: user.id }
  let!(:user) { FactoryGirl.create(:user, company: company) }
  let(:company) { FactoryGirl.create(:company) }

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

end
