class Frontier::ControllerSpec::NewAction

  include Frontier::ModelConfigurationProperty

  def to_s
    raw = <<STRING
describe 'GET new' do
#{render_with_indent(1, subject_block)}

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

  def subject_block
    Frontier::ControllerSpec::SubjectBlock.new(model_configuration, :get, :new).to_s
  end

end
