class Frontier::ControllerSpec::UpdateAction < Frontier::ControllerSpec::MemberAction

  def to_s
    raw = <<STRING
describe 'POST update' do
#{render_with_indent(1, render_setup)}

  let(:attributes) { {} }

  authenticated_as(:admin) do

    context "with valid parameters" do
#{render_with_indent(3, Frontier::Spec::ObjectSetup.new(model).to_s)}

      it "updates the #{model.name.as_constant} object with the given attributes" do
        subject

        #{model.name.as_singular}.reload
#{render_with_indent(4, Frontier::Spec::ObjectAttributesAssertion.new(model).to_s)}
      end

      it { should redirect_to(#{model.url_builder.index_path(show_nested_model_as_ivar: false)}) }

      it "sets a notice for the user" do
        subject
        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid parameters" do
      let(:attributes) { parameters_for(#{model.name.as_symbol}, :invalid) }

      it "doesn't update the #{model.name.as_constant}" do
        subject
        expect(#{model.name.as_singular}.reload).not_to have_attributes(attributes)
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
    Frontier::ControllerSpec::SubjectBlock.new(model, :post, :update, {id: "#{model.name.as_singular}.id", model.name.as_singular => "attributes"}).to_s
  end

end
