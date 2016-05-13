class Frontier::ControllerSpec::CreateAction < Frontier::ControllerSpec::CollectionAction

  def to_s
    raw = <<STRING
describe 'POST create' do
#{render_with_indent(1, render_setup)}
  let(:attributes) { {} }

  authenticated_as(:admin) do

    context "with valid parameters" do
#{render_with_indent(3, Frontier::Spec::ObjectSetup.new(model_configuration).to_s)}

      it "creates a #{model_configuration.as_constant} object with the given attributes" do
        subject

        #{model_configuration.model_name} = #{model_configuration.as_constant}.order(:created_at).last
        expect(#{model_configuration.model_name}).to be_present
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
      specify { expect { subject }.not_to change(#{model_configuration.as_constant}, :count) }
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
    Frontier::ControllerSpec::SubjectBlock.new(model_configuration, :post, :create, {model_configuration.model_name => "attributes"}).to_s
  end

end
