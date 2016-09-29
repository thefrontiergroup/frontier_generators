require 'spec_helper'

RSpec.describe Frontier::Model::ViewPaths do

  let(:view_paths) { Frontier::Model::ViewPaths.new(view_path_attributes) }

  [:index, :new, :edit, :form].each do |action|
    describe "##{action}_path" do
      subject { view_paths.public_send("#{action}_path") }
      let(:view_path_attributes) { {action => file_path} }

      context "when no view paths are provided" do
        let(:view_path_attributes) { nil }
        it { should eq(nil) }
      end

      context "as nil" do
        let(:file_path) { nil }
        it { should eq(nil) }
      end

      context "as a valid path" do
        let(:file_path) { __FILE__ }
        it { should eq(file_path) }
      end

      context "as an invalid path" do
        let(:file_path) { "woogle" }

        it "raises an exception" do
          begin
            subject
          rescue ArgumentError => e
            expect(e.to_s).to eq("The following templates do not exist: #{action}")
          end
        end
      end
    end
  end

end
