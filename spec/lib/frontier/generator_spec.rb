require 'spec_helper'

describe Frontier::Generator do

  let(:generator) { Frontier::Generator.new([file_path], {}) }

  describe "#initialize" do
    subject { generator }

    context "with a nil file_path" do
      let(:file_path) { nil }
      specify { expect { subject }.to raise_error(ArgumentError) }
    end

    context "with a file_path that does not correspond to a file" do
      let(:file_path) { "dongs.txt" }
      specify { expect { subject }.to raise_error(ArgumentError) }
    end

    context "with a valid file_path" do
      let(:file_path) { test_model_path }
      it { should be_kind_of(Frontier::Generator) }
    end
  end

end
