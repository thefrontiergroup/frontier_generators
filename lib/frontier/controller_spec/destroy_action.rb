class Frontier::ControllerSpec::DestroyAction

  include Frontier::ModelConfigurationProperty

  def to_s
    raw = <<STRING
describe 'DELETE destroy' do
#{render_with_indent(1, subject_block)}
#{render_with_indent(1, Frontier::FeatureSpec::TargetObjectLetStatement.new(model_configuration).to_s)}

  authenticated_as(:admin) do
    it "deletes the #{model_configuration.as_title}" do
      subject
      expect(#{model_configuration.model_name}.reload.deleted_at).to be_present
    end
    it { should redirect_to(#{model_configuration.url_builder.index_path(show_nested_model_as_ivar: false)}) }
  end

  it_behaves_like "action requiring authentication"
  it_behaves_like "action authorizes roles", [:admin]
end
STRING
    raw.rstrip
  end

private

  def subject_block
    Frontier::ControllerSpec::SubjectBlock.new(model_configuration, :delete, :destroy, {id: "#{model_configuration.model_name}.id"}).to_s
  end

end
