class Frontier::ControllerSpec::EditAction < Frontier::ControllerSpec::MemberAction

  def to_s
    raw = <<STRING
describe 'GET edit' do
#{render_with_indent(1, render_setup)}

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
    Frontier::ControllerSpec::SubjectBlock.new(model, :get, :edit, {id: "#{model.model_name}.id"}).to_s
  end

end
