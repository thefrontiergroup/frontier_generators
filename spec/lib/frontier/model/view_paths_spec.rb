require 'spec_helper'

RSpec.describe Frontier::Model::ViewPaths do

  let(:view_paths) { Frontier::Model::ViewPaths.new(view_path_attributes) }

  describe "#index_path" do
    subject { view_paths.index_path }
    let(:view_path_attributes) { {index: index_path} }

    context "when no view paths are provided" do
      let(:view_path_attributes) { nil }
      it { should eq(nil) }
    end

    context "as nil" do
      let(:index_path) { nil }
      it { should eq(nil) }
    end

    context "as a valid path" do
      let(:index_path) { __FILE__ }
      it { should eq(index_path) }
    end

    context "as an invalid path" do
      let(:index_path) { "woogle" }

      it "raises an exception" do
        begin
          subject
        rescue ArgumentError => e
          expect(e.to_s).to eq("The following templates do not exist: index")
        end
      end
    end
  end

  describe "#new_path" do
    subject { view_paths.new_path }
    let(:view_path_attributes) { {new: new_path} }

    context "when no view paths are provided" do
      let(:view_path_attributes) { nil }
      it { should eq(nil) }
    end

    context "as nil" do
      let(:new_path) { nil }
      it { should eq(nil) }
    end

    context "as a valid path" do
      let(:new_path) { __FILE__ }
      it { should eq(new_path) }
    end

    context "as an invalid path" do
      let(:new_path) { "woogle" }

      it "raises an exception" do
        begin
          subject
        rescue ArgumentError => e
          expect(e.to_s).to eq("The following templates do not exist: new")
        end
      end
    end
  end

  describe "#edit_path" do
    subject { view_paths.edit_path }
    let(:view_path_attributes) { {edit: edit_path} }

    context "when no view paths are provided" do
      let(:view_path_attributes) { nil }
      it { should eq(nil) }
    end

    context "as nil" do
      let(:edit_path) { nil }
      it { should eq(nil) }
    end

    context "as a valid path" do
      let(:edit_path) { __FILE__ }
      it { should eq(edit_path) }
    end

    context "as an invalid path" do
      let(:edit_path) { "woogle" }

      it "raises an exception" do
        begin
          subject
        rescue ArgumentError => e
          expect(e.to_s).to eq("The following templates do not exist: edit")
        end
      end
    end
  end

  describe "#form_path" do
    subject { view_paths.form_path }
    let(:view_path_attributes) { {form: form_path} }

    context "when no view paths are provided" do
      let(:view_path_attributes) { nil }
      it { should eq(nil) }
    end

    context "as nil" do
      let(:form_path) { nil }
      it { should eq(nil) }
    end

    context "as a valid path" do
      let(:form_path) { __FILE__ }
      it { should eq(form_path) }
    end

    context "as an invalid path" do
      let(:form_path) { "woogle" }

      it "raises an exception" do
        begin
          subject
        rescue ArgumentError => e
          expect(e.to_s).to eq("The following templates do not exist: form")
        end
      end
    end
  end

end
