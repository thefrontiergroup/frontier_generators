require 'spec_helper'

describe Frontier::Views::Index::EmptyMessageAndCallToAction do

  describe "#to_s" do
    subject { empty_message.to_s }

    let(:empty_message) { Frontier::Views::Index::EmptyMessageAndCallToAction.new(model_configuration) }
    let(:model_configuration) do
      skip_ui_options = []
      skip_ui_options << "create" unless show_create

      Frontier::ModelConfiguration.new({
        user: {
          authorization: "cancancan",
          namespaces: ["admin"],
          skip_ui: skip_ui_options
        }
      })
    end

    context "when there is a new action" do
      let(:show_create) { true }
      let(:expected) do
        raw = <<-STRING
%p
  There are no users.
  - if can?(:new, User)
    = link_to("Create a user.", new_admin_user_path)
STRING
        raw.rstrip
end

      it { should eq(expected) }
    end

    context "when there is no new action" do
      let(:show_create) { false }
      let(:expected) { "%p There are no users." }

      it { should eq(expected) }
    end
  end

end
