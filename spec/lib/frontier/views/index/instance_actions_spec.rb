require 'spec_helper'

describe Frontier::Views::Index::InstanceActions do

  let(:actions) { Frontier::Views::Index::InstanceActions.new(model) }
  let(:model) do
    skip_ui_options = []
    skip_ui_options << "update" unless show_update
    skip_ui_options << "delete" unless show_delete

    Frontier::Model.new({
      user: {
        authorization: "cancancan",
        skip_ui: skip_ui_options
      }
    })
  end

  context "requires an edit and a delete" do
    let(:show_update) { true }
    let(:show_delete) { true }

    describe '#has_actions?' do
      subject { actions.has_actions? }
      it { should eq(true) }
    end

    describe "#to_s" do
      subject { actions.to_s }
      let(:expected) do
        raw = <<-STRING
- if can?(:edit, user)
  = link_to("Edit", edit_user_path(user), class: "btn btn-small")
- if can?(:destroy, user)
  = link_to("Delete", user_path(user), method: :delete, data: {confirm: "Are you sure you want to delete this user?"}, class: "btn btn-small btn-danger")
STRING
        raw.rstrip
      end

      it { should eq(expected) }
    end
  end

  context "only requires an edit" do
    let(:show_update) { true }
    let(:show_delete) { false }

    describe '#has_actions?' do
      subject { actions.has_actions? }
      it { should eq(true) }
    end

    describe "#to_s" do
      subject { actions.to_s }
      let(:expected) do
        raw = <<-STRING
- if can?(:edit, user)
  = link_to("Edit", edit_user_path(user), class: "btn btn-small")
STRING
        raw.rstrip
      end

      it { should eq(expected) }
    end
  end

  context "only requires a delete" do
    let(:show_update) { false }
    let(:show_delete) { true }

    describe '#has_actions?' do
      subject { actions.has_actions? }
      it { should eq(true) }
    end

    describe "#to_s" do
      subject { actions.to_s }
      let(:expected) do
        raw = <<-STRING
- if can?(:destroy, user)
  = link_to("Delete", user_path(user), method: :delete, data: {confirm: "Are you sure you want to delete this user?"}, class: "btn btn-small btn-danger")
STRING
        raw.rstrip
      end

      it { should eq(expected) }
    end
  end

  context "doesn't require an edit or delete" do
    let(:show_update) { false }
    let(:show_delete) { false }

    describe '#has_actions?' do
      subject { actions.has_actions? }
      it { should eq(false) }
    end

    describe "#to_s" do
      subject { actions.to_s }
      it { should eq("") }
    end
  end


end
