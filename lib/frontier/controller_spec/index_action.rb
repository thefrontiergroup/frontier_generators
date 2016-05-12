class Frontier::ControllerSpec::IndexAction < Frontier::ControllerSpec::CollectionAction

  def to_s
    raw = <<STRING
describe 'GET index' do
#{render_with_indent(1, render_setup)}

  authenticated_as(:admin) do
    it { should render_template(:index) }
  end

  it_behaves_like "action requiring authentication"
  it_behaves_like "action authorizes roles", [:admin]
end
STRING
    raw.rstrip
  end

private

  def subject_block
    Frontier::ControllerSpec::SubjectBlock.new(model_configuration, :get, :index).to_s
  end

end
