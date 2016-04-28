require 'rails_helper'

describe <%= controller_name %> do

<% if model_configuration.show_index? -%>
<%= render_with_indent(1, Frontier::ControllerSpec::IndexAction.new(model_configuration).to_s) %>

<% end -%>
<% if model_configuration.show_create? -%>
<%= render_with_indent(1, Frontier::ControllerSpec::NewAction.new(model_configuration).to_s) %>

  describe 'POST create' do
<%= render_with_indent(2, Frontier::ControllerSpec::SubjectBlock.new(model_configuration, :post, :create, {model_configuration.model_name => "attributes"}).to_s) %>
    let(:attributes) { {} }

    authenticated_as(:admin) do

      context "with valid parameters" do
<%= render_with_indent(4, Frontier::SpecSupport::ObjectSetup.new(model_configuration).to_s) %>

        it "creates a <%= model_configuration.as_constant %> object with the given attributes" do
          subject

          <%= model_configuration.model_name %> = <%= model_configuration.as_constant %>.order(:created_at).last
          expect(<%= model_configuration.model_name %>).to be_present
<%= render_with_indent(5, Frontier::SpecSupport::ObjectAttributesAssertion.new(model_configuration).to_s) %>
        end

        it { should redirect_to(<%= model_configuration.url_builder.index_path(show_nested_model_as_ivar: false) %>) }

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
<%= render_with_indent(1, Frontier::ControllerSpec::EditAction.new(model_configuration).to_s) %>

  describe 'POST update' do
<%= render_with_indent(2, Frontier::ControllerSpec::SubjectBlock.new(model_configuration, :post, :update, {id: "#{model_configuration.model_name}.id", model_configuration.model_name => "attributes"}).to_s) %>

    let(:attributes) { {} }
    let(<%= model_configuration.as_symbol %>) { FactoryGirl.create(<%= model_configuration.as_symbol %>) }

    authenticated_as(:admin) do

      context "with valid parameters" do
<%= render_with_indent(4, Frontier::SpecSupport::ObjectSetup.new(model_configuration).to_s) %>

        it "updates the <%= model_configuration.as_constant %> object with the given attributes" do
          subject

          <%= model_configuration.model_name %>.reload
<%= render_with_indent(5, Frontier::SpecSupport::ObjectAttributesAssertion.new(model_configuration).to_s) %>
        end

        it { should redirect_to(<%= model_configuration.url_builder.index_path(show_nested_model_as_ivar: false) %>) }

        it "sets a notice for the user" do
          subject
          expect(flash[:notice]).to be_present
        end
      end

      context "with invalid parameters" do
        let(:attributes) { parameters_for(<%= model_configuration.as_symbol %>, :invalid) }

        it "doesn't update the <%= model_configuration.as_constant %>" do
          subject
          expect(<%= model_configuration.model_name %>.reload).not_to have_attributes(attributes)
        end
      end
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

<% end -%>
<% if model_configuration.show_delete? -%>
<%= render_with_indent(1, Frontier::ControllerSpec::DestroyAction.new(model_configuration).to_s) %>

<% end -%>
end
