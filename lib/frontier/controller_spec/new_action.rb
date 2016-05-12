class Frontier::ControllerSpec::NewAction

  include Frontier::ModelConfigurationProperty

  def to_s
    raw = <<STRING
describe 'GET new' do
#{render_with_indent(1, render_setup)}

  authenticated_as(:admin) do
    it { should render_template(:new) }
  end

  it_behaves_like "action requiring authentication"
  it_behaves_like "action authorizes roles", [:admin]
end
STRING
    raw.rstrip
  end

private

  def render_setup
    [subject_block, nested_models_setup].select(&:present?).join("\n")
  end

  def subject_block
    Frontier::ControllerSpec::SubjectBlock.new(model_configuration, :get, :new).to_s
  end

  def nested_models_setup
    Frontier::Spec::NestedModelLetSetup.new(model_configuration).to_s
  end

end
