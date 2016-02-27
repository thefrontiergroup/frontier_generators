require 'rails_helper'

describe <%= controller_name %> do

<% if model_configuration.show_index? -%>
  describe 'GET index' do
    subject(:get_index) { get :index }

    authenticated_as(:admin) do
      it { should render_template(:index) }

      describe_assign(<%= model_configuration.as_symbol_collection %>) do
        subject(<%= model_configuration.as_symbol_collection %>) { get_index; assigns(<%= model_configuration.as_symbol_collection %>) }

        describe "sorting" do
          it "sorts by query parameters" do
            expect(RailsSort).to receive(:sort).with(instance_of(<%= model_configuration.as_constant %>::ActiveRecord_Relation), anything, anything).and_call_original
            subject
          end
        end
      end
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

<% end -%>
<% if model_configuration.show_create? -%>
  describe 'GET new' do
    subject { get :new }

    authenticated_as(:admin) do
      it { should render_template(:new) }
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

  describe 'POST create' do
    subject { post :create, <%= model_configuration.model_name %>: attributes }
    # params.require(<%= model_configuration.as_symbol %>) will raise an exception if the
    # attributes hash provided is blank, so we pass through a fake value to prevent this.
    let(:attributes) { {id: 666} }

    authenticated_as(:admin) do

      context "with valid parameters" do
<%= Frontier::RubyRenderer.new(Frontier::SpecSupport::ObjectSetup.new(model_configuration).to_s).render(4) %>

        it "creates a <%= model_configuration.as_constant %> object with the given attributes" do
          subject

          <%= model_configuration.model_name %> = <%= model_configuration.as_constant %>.order(:created_at).last
          expect(<%= model_configuration.model_name %>).to be_present
          expect(<%= model_configuration.model_name %>).to have_attributes(attributes)
        end

        it { should redirect_to(<%= model_configuration.url_builder.index_path %>) }

        it "sets a notice for the user" do
          subject
          expect(flash[:notice]).to be_present
        end
      end

      context "with invalid parameters" do
        let(:attributes) { parameters_for(<%= model_configuration.as_symbol %>, :invalid) }
        specify { expect { subject }.not_to change(<%= model_configuration.as_constant %>, :count) }
      end
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

<% end -%>
<% if model_configuration.show_update? -%>
  describe 'GET edit' do
    subject { get :edit, id: <%= model_configuration.model_name %>.id }
    let(<%= model_configuration.as_symbol %>) { FactoryGirl.create(<%= model_configuration.as_symbol %>) }

    authenticated_as(:admin) do
      it { should render_template(:edit) }
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

  describe 'POST update' do
    subject(:update_resource) { post :update, id: <%= model_configuration.model_name %>.id, <%= model_configuration.model_name %>: attributes }
    let(:attributes) { {id: <%= model_configuration.model_name %>.id} }
    let(<%= model_configuration.as_symbol %>) { FactoryGirl.create(<%= model_configuration.as_symbol %>) }

    authenticated_as(:admin) do

      context "with valid parameters" do
<%= Frontier::RubyRenderer.new(Frontier::SpecSupport::ObjectSetup.new(model_configuration).to_s).render(4) %>

        it "updates the <%= model_configuration.as_constant %> object with the given attributes" do
          update_resource
          expect(<%= model_configuration.model_name %>.reload).to have_attributes(attributes)
        end

        it { should redirect_to(<%= model_configuration.url_builder.index_path %>) }

        it "sets a notice for the user" do
          subject
          expect(flash[:notice]).to be_present
        end
      end

      context "with invalid parameters" do
        let(:attributes) { parameters_for(<%= model_configuration.as_symbol %>, :invalid) }

        it "doesn't update the <%= model_configuration.as_constant %>" do
          update_resource
          expect(<%= model_configuration.model_name %>.reload).not_to have_attributes(attributes)
        end
      end
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

<% end -%>
<% if model_configuration.show_delete? -%>
  describe 'DELETE destroy' do
    subject { delete :destroy, id: <%= model_configuration.model_name %>.id }
    let(<%= model_configuration.as_symbol %>) { FactoryGirl.create(<%= model_configuration.as_symbol %>) }

    authenticated_as(:admin) do
      it "deletes the <%= model_configuration.model_name %>" do
        subject
        expect(<%= model_configuration.model_name %>.reload.deleted_at).to be_present
      end
      it { should redirect_to(<%= model_configuration.url_builder.index_path %>) }
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

<% end -%>
end
