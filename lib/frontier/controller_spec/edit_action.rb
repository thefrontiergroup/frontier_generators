class Frontier::ControllerSpec::EditAction

  include Frontier::ModelConfigurationProperty

  def to_s
    raw = <<STRING
describe 'GET edit' do
#{render_with_indent(1, subject_block)}
#{render_with_indent(1, Frontier::FeatureSpec::TargetObjectLetStatement.new(model_configuration).to_s)}

  authenticated_as(:admin) do
    it { should render_template(:edit) }
  end

  it_behaves_like "action requiring authentication"
  it_behaves_like "action authorizes roles", [:admin]
end
STRING
    raw.rstrip
  end

private

  def subject_block
    Frontier::ControllerSpec::SubjectBlock.new(model_configuration, :get, :edit, {id: "#{model_configuration.model_name}.id"}).to_s
  end

end
