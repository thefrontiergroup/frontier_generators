require 'spec_helper'

describe <%= policy_class_name %> do
  subject { policy }
  let(:policy) { <%= policy_class_name %>.new(user, <%= model_configuration.model_name %>) }
  let(<%= model_configuration.as_symbol %>) { FactoryGirl.create(<%= model_configuration.as_symbol %>) }

  describe <%= policy_class_name %>::Scope do
    let(:policy_scope) { <%= policy_class_name %>::Scope.new(user, scope) }
    let(:scope) { <%= model_configuration.as_constant %>.all }

    describe "#resolve" do
      subject { policy_scope.resolve }

      context "for an anonymous user" do
        let(:user) { nil }

        it "cannot see any users" do
          should be_empty
        end
      end

      context "for an admin" do
        let(:user) { FactoryGirl.build(:user, :admin) }

        it { should include(FactoryGirl.create(<%= model_configuration.as_symbol %>)) }
      end

      context "for a member" do
        let(:user) { FactoryGirl.build(:user, :member) }

        it { should include(FactoryGirl.create(<%= model_configuration.as_symbol %>)) }
      end
    end
  end

  shared_examples_for "Policy without access to CRUD actions" do
    it { should_not permit_access_to(:index) }
    it { should_not permit_access_to(:new) }
    it { should_not permit_access_to(:create) }
    it { should_not permit_access_to(:edit) }
    it { should_not permit_access_to(:update) }
    it { should_not permit_access_to(:destroy) }
  end

  context "for an anonymous user" do
    let(:user) { nil }

    describe '#permitted_attributes' do
      subject { policy.permitted_attributes }
      it { should be_empty }
    end

    it_behaves_like "Policy without access to CRUD actions"
  end

  context "for an admin" do
    let(:user) { FactoryGirl.build(:user, :admin) }

    describe '#permitted_attributes' do
      subject { policy.permitted_attributes }
<% model_configuration.attributes.each do |attribute| -%>
      it { should include(<%= attribute.as_symbol %>) }
<% end -%>
    end

    # CRUD actions
    it { should permit_access_to(:index) }
    it { should permit_access_to(:new) }
    it { should permit_access_to(:create) }
    it { should permit_access_to(:edit) }
    it { should permit_access_to(:update) }
    it { should permit_access_to(:destroy) }
  end

  context "for a member" do
    let(:user) { FactoryGirl.build(:user, :member) }

    describe '#permitted_attributes' do
      subject { policy.permitted_attributes }
<% model_configuration.attributes.each do |attribute| -%>
      it { should include(<%= attribute.as_symbol %>) }
<% end -%>
    end

    it_behaves_like "Policy without access to CRUD actions"
  end
end