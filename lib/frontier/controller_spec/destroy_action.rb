class Frontier::ControllerSpec::DestroyAction < Frontier::ControllerSpec::MemberAction

  def to_s
    raw = <<STRING
describe 'DELETE destroy' do
#{render_with_indent(1, render_setup)}

  authenticated_as(:admin) do
    it "deletes the #{model.name.as_title}" do
#{render_with_indent(3, successful_deletion_assertion)}
    end
    it { should redirect_to(#{model.url_builder.index_path(show_nested_model_as_ivar: false)}) }
  end

  it_behaves_like "action requiring authentication"
  it_behaves_like "action authorizes roles", [:admin]
end
STRING
    raw.rstrip
  end

private

  def successful_deletion_assertion
    if model.soft_delete
      "subject\nexpect(#{model.name.as_singular}.reload.deleted_at).to be_present"
    else
      "expect { subject }.to change { #{model.name.as_constant}.count }.by(-1)"
    end
  end

  def subject_block
    Frontier::ControllerSpec::SubjectBlock.new(model, :delete, :destroy, {id: "#{model.name.as_singular}.id"}).to_s
  end

end
