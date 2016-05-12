class Frontier::ControllerSpec::UpdateAction

  include Frontier::ModelConfigurationProperty

  def to_s
    raw = <<STRING
describe 'POST update' do
#{render_with_indent(1, subject_block)}

  let(:attributes) { {} }
  let(#{model_configuration.as_symbol}) { FactoryGirl.create(#{model_configuration.as_symbol}) }

  authenticated_as(:admin) do

    context "with valid parameters" do
#{render_with_indent(3, Frontier::Spec::ObjectSetup.new(model_configuration).to_s)}

      it "updates the #{model_configuration.as_constant} object with the given attributes" do
        subject

        #{model_configuration.model_name}.reload
#{render_with_indent(4, Frontier::Spec::ObjectAttributesAssertion.new(model_configuration).to_s)}
      end

      it { should redirect_to(#{model_configuration.url_builder.index_path(show_nested_model_as_ivar: false)}) }

      it "sets a notice for the user" do
        subject
        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid parameters" do
      let(:attributes) { parameters_for(#{model_configuration.as_symbol}, :invalid) }

      it "doesn't update the #{model_configuration.as_constant}" do
        subject
        expect(#{model_configuration.model_name}.reload).not_to have_attributes(attributes)
      end
    end
  end

  it_behaves_like "action requiring authentication"
  it_behaves_like "action authorizes roles", [:admin]
end
STRING
    raw.rstrip
  end

private

  def subject_block
    Frontier::ControllerSpec::SubjectBlock.new(model_configuration, :post, :update, {id: "#{model_configuration.model_name}.id", model_configuration.model_name => "attributes"}).to_s
  end

end
